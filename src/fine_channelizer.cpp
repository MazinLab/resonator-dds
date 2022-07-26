#include "fine_channelizer.hpp"
#include "dds.h"
#include <iostream>
#include "hls_math.h"
#include "ap_fixed.h"
using namespace std;


void dds(dds_words_t dds, dds_complex_t &ddsv) {
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



void cmpysub(sample_complex_t iq, sample_complex_t center, dds_complex_t dds, sampleout_complex_t& p_product) {
#pragma HLS INLINE

	sampleout_t r,i;
#pragma HLS BIND_OP variable=i op=add
#pragma HLS BIND_OP variable=i op=sub
#pragma HLS BIND_OP variable=r op=add
#pragma HLS BIND_OP variable=r op=sub
	ap_fixed<34, 2, AP_RND_CONV, AP_SAT_SYM> ac, ad;


	ac=iq.real()*dds.real();
	ad=iq.real()*dds.imag();
	r=ac-iq.imag()*dds.imag()-center.real();
	i=ad+iq.imag()*dds.real()-center.imag();
	p_product.real(r);
	p_product.imag(i);
//#ifndef __SYNTHESIS__
//
//	cout<<"-----\nIQ: "<<iq.real()<<" DDS: "<<dds.real()<<" Ctr:"<<center.real()<<endl;
//	cout<<"ac: "<<ac<<" bd: "<<(iq.imag()*dds.imag())<<" rval:"<<ac-iq.imag()*dds.imag()-center.real()<<" r: "<<r<<endl;
//	cout<<"Result: "<<p_product.real()<<endl;
//
//	cout<<"IQ: "<<iq.real().range().to_int()<<" DDS: "<<dds.real().range().to_int()<<" Ctr:"<<center.real().range().to_int()<<endl;
//	cout<<"ac: "<<ac.range().to_int64()<<" bd: "<<(iq.imag()*dds.imag()).range().to_int64()<<" r: "<<r.range().to_int64()<<endl;
//	cout<<"Result: "<<p_product.real().range().to_int()<<"\n-----"<<endl;
//#endif

}


void _ddsddc(acc_t acc, sample_complex_t iq, loopcenter_t center, sampleout_complex_t &iqout) {
#pragma HLS INLINE
	sampleout_complex_t tmp;
	dds_words_t ddsv;
	dds_complex_t dds_sincos;
	phase_sincos_LUT(acc, ddsv);
	dds(ddsv, dds_sincos);
	cmpysub(iq, center, dds_sincos, iqout);
}


void accumulate(group_t groupin, tonegroup_t tones[N_RES_GROUPS], hls::stream<accgroup_t> &accv){
#pragma HLS PIPELINE II=1
//#pragma HLS INTERFACE mode=ap_ctrl_none port=return
	tonegroup_t tonesgroup;
	static accgroup_t accumulator[N_RES_GROUPS], acc;

	accgroup_t _accv,_acc;
	tonesgroup=tones[groupin];
	accumulator[group_t(groupin-1)]=acc;
	acc=accumulator[groupin];

	incp: for (int i=0; i<N_RES_PCLK; i++) {
		phase_t phase0;
		toneinc_t inc;
		acc_t tmp;
		inc.range()=tonesgroup.range(N_TONEBITS*(i+1)-1, N_TONEBITS*i);
		phase0.range()=tonesgroup.range(N_P0BITS*(i+1)-1+N_TONEBITS*N_RES_PCLK,N_P0BITS*i+N_TONEBITS*N_RES_PCLK);
		tmp.range()=acc.range(NBITS*(i+1)-1, NBITS*i);
		_accv.range(NBITS*(i+1)-1, NBITS*i) = acc_t(tmp+phase0).range();
		_acc.range(NBITS*(i+1)-1, NBITS*i) = acc_t(tmp+inc).range();
	}
	accv.write(_accv);
	acc=_acc;
}


void ddsddc(hls::stream<accgroup_t> &accgs, loopcenter_group_t centergroups[N_RES_GROUPS], group_t group, iqgroup_uint_t in, hls::stream<axisdata_t> &res_out){
#pragma HLS PIPELINE II=1
//#pragma HLS INTERFACE mode=ap_ctrl_none port=return
	iqgroup_uint_t _out;

	accgroup_t accg;
	accg=accgs.read();
	loopcenter_group_t centergroup;
	centergroup=centergroups[group];
	ddc: for (int i=0; i<N_RES_PCLK; i++) {

		sampleout_complex_t iqout;
		acc_t acc;
		sample_complex_t iq;
		loopcenter_t center;

		acc.range()=accg.range(NBITS*(i+1)-1, NBITS*i);
		iq.real().range()=in.range(32*(i+1)-16-1, 32*i);
		iq.imag().range()=in.range(32*(i+1)-1, 32*i+16);
		center.real().range()=centergroup.range(32*(i+1)-16-1, 32*i);
		center.imag().range()=centergroup.range(32*(i+1)-1, 32*i+16);

		_ddsddc(acc, iq, center, iqout);

		_out.range(32*(i+1)-16-1, 32*i)=iqout.real().range();
		_out.range(32*(i+1)-1, 32*i+16)=iqout.imag().range();

	}
//	out=_out;
	axisdata_t data_out;
	data_out.data = _out;
	data_out.last = group == N_RES_GROUPS-1;
	data_out.user = group;
	res_out.write(data_out);
}


void resonator_ddc(hls::stream<axisdata_t> &res_in, hls::stream<axisdata_t> &res_out,
				   tonegroup_t tones[N_RES_GROUPS], loopcenter_group_t centers[N_RES_GROUPS]) {
//#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS INTERFACE s_axilite port=tones
#pragma HLS INTERFACE s_axilite port=centers
#pragma HLS INTERFACE mode=axis register_mode=off port=res_in
#pragma HLS INTERFACE mode=axis register_mode=off port=res_out


	while (!res_in.empty()) {  //For csim
#pragma HLS PIPELINE II=1

		hls::stream<accgroup_t> accg;
	#pragma HLS STREAM variable=accg depth=4
//	static group_t group;

//	iqgroup_uint_t out;
	axisdata_t data_in;
	res_in.read(data_in);
//	group=group

	//--------
	//Compute phase value
	//--------
	accumulate(data_in.user, tones, accg);


	//--------
	//Perform the DDC
	//--------
	ddsddc(accg, centers, data_in.user, data_in.data, res_out);

//	//Output
//	data_out.data = out;
//	data_out.last = group == N_RES_GROUPS-1;
//	data_out.user = group;//data_in.user;
//	res_out.write(data_out);

//	group++;
	} //For csim

}
