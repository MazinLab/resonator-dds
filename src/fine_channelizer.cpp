#include "fine_channelizer.hpp"
#include "dds.h"
#include <iostream>
#include "hls_math.h"
#include "ap_fixed.h"
using namespace std;


void dds(dds_words_t dds, dds_complex_t &ddsv) {
//#pragma HLS PIPELINE II=1
//#pragma HLS INTERFACE mode=ap_ctrl_none port=return
#pragma HLS INLINE
	dds_t i,r;
#pragma HLS BIND_OP variable=i op=add
#pragma HLS BIND_OP variable=i op=sub
#pragma HLS BIND_OP variable=r op=add
#pragma HLS BIND_OP variable=r op=sub
	r=dds.cos_word - dds.sin_word * dds.fine_word;
	i=dds.sin_word + dds.cos_word * dds.fine_word;
	ddsv.real(r);
	ddsv.imag(i);
}


void cmpydds(sample_complex_t iq, dds_words_t dds, sampleout_complex_t& p_product) {
//#pragma HLS PIPELINE II=1
//#pragma HLS INTERFACE mode=ap_ctrl_none port=return
#pragma HLS INLINE
	sample_t a,b;
	dds_t c,d;

	a=iq.real();
	b=iq.imag();
	c=dds.cos_word - dds.sin_word * dds.fine_word;
	d=dds.sin_word + dds.cos_word * dds.fine_word;
	p_product.real(a*c-b*d);
	p_product.imag(a*d+b*c);

}


void cmpy(sample_complex_t iq, dds_complex_t dds, sampleout_complex_t& p_product) {
//#pragma HLS PIPELINE II=1
//#pragma HLS INTERFACE mode=ap_ctrl_none port=return
#pragma HLS INLINE

	sampleout_t r,i;
#pragma HLS BIND_OP variable=i op=add
#pragma HLS BIND_OP variable=i op=sub
#pragma HLS BIND_OP variable=r op=add
#pragma HLS BIND_OP variable=r op=sub
	ap_fixed<34, 2, AP_RND_CONV, AP_SAT_SYM> ac, ad;

	ac=iq.real()*dds.real();
	ad=iq.real()*dds.imag();
	r=ac-iq.imag()*dds.imag();
	i=ad+iq.imag()*dds.real();
	p_product.real(r);
	p_product.imag(i);

}

void accumulate(const group_t group, tonegroup_t tones[N_RES_GROUPS], accgroup_t &accv, group_t &cycle_out){
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE mode=ap_ctrl_none port=return
	static group_t cycle;
	tonegroup_t tonesgroup;
	cycle_out=cycle;
	tonesgroup=tones[cycle++];

	static accgroup_t accumulator[N_RES_GROUPS], acc;
	accumulator[group_t(group-1)]=acc;
	acc=accumulator[group];
	incp: for (int i=0; i<N_RES_PCLK; i++) {
		phase_t phase0;
		toneinc_t inc;
		acc_t tmp;
		inc.range()=tonesgroup.range(N_TONEBITS*(i+1)-1, N_TONEBITS*i);
		phase0.range()=tonesgroup.range(N_P0BITS*(i+1)-1+N_TONEBITS*N_RES_PCLK,N_P0BITS*i+N_TONEBITS*N_RES_PCLK);
		tmp.range()=acc.range(NBITS*(i+1)-1, NBITS*i);
		accv.range(NBITS*(i+1)-1, NBITS*i) = acc_t(tmp+phase0).range();
		acc.range(NBITS*(i+1)-1, NBITS*i) = acc_t(tmp+inc).range();
	}
}


void ddsddc(const accgroup_t accg, loopcenter_group_t centergroups[], group_t group, const iqgroup_uint_t in, iqgroup_uint_t &out){
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE mode=ap_ctrl_none port=return

	loopcenter_group_t centergroup;
	centergroup=centergroups[group];
	ddc: for (int i=0; i<N_RES_PCLK; i++) {
		dds_words_t ddsv;
		dds_complex_t dds_sincos;
		sampleout_complex_t iqout;
		acc_t acc;
		sample_complex_t iq;
		loopcenter_t center;

		acc.range()=accg.range(NBITS*(i+1)-1, NBITS*i);
		iq.real().range()=in.range(32*(i+1)-16-1, 32*i);
		iq.imag().range()=in.range(32*(i+1)-1, 32*i+16);
		center.real().range()=centergroup.range(32*(i+1)-16-1, 32*i);
		center.imag().range()=centergroup.range(32*(i+1)-1, 32*i+16);

		phase_sincos_LUT(acc, ddsv);
		dds(ddsv, dds_sincos);
		cmpy(iq, dds_sincos, iqout);
		iqout-=center;

		out.range(32*(i+1)-16-1, 32*i)=iqout.real().range();
		out.range(32*(i+1)-1, 32*i+16)=iqout.imag().range();

	}
}


void resonator_dds(hls::stream<axisdata_t> &res_in, hls::stream<axisdata_t> &res_out,
				   tonegroup_t tones[N_RES_GROUPS], loopcenter_group_t centers[N_RES_GROUPS]) {
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS INTERFACE s_axilite port=tones
#pragma HLS INTERFACE s_axilite port=centers
#pragma HLS INTERFACE axis port=res_in register
#pragma HLS INTERFACE axis port=res_out register


//	while (!res_in.empty()) {  //For csim
#pragma HLS PIPELINE II=1

//	static group_t cycle;
	group_t group;
	axisdata_t data_in, data_out;

	//-----------
	//Tone and accumulator fetching
	//-----------
	res_in.read(data_in);

	//--------
	//Compute phase value
	//--------
	accgroup_t accg;
	accumulate(group, tones, accg, group);

	//For csim (optional, reduce TDM penalty)
//	if (group!=33) {
//		res_out.write(data_out);
//		cycle++;
//		continue;
//	}

	//--------
	//Perform the DDC
	//--------
	iqgroup_uint_t out;
	ddsddc(accg, centers, group, data_in.data, out);


	//--------
	//Output
	//--------
	data_out.data = out;
	data_out.last = group == N_RES_GROUPS-1;
	data_out.user = group;
	res_out.write(data_out);

//	} //For csim

}
