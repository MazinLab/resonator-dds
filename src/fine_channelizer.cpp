#include "fine_channelizer.hpp"
#include "dds.h"
#include <iostream>
#include "hls_math.h"
#include "ap_fixed.h"
using namespace std;


void dds(dds_words_t dds, dds_complex_t &ddsv) {
#pragma HLS INLINE
//	dds_t i,r;
//	r=dds.cos_word - dds.sin_word * dds.fine_word;
//	i=dds.sin_word + dds.cos_word * dds.fine_word;
//	ddsv.real(r);
//	ddsv.imag(i);
	ddsv.real(dds.cos_word - dds.sin_word * dds.fine_word);
	ddsv.imag(dds.sin_word + dds.cos_word * dds.fine_word);
}


void cmpysub(sample_complex_t iq, sample_complex_t center, dds_complex_t dds, sampleout_complex_t& p_product) {
#pragma HLS INLINE

	sampleout_t r,i;
	ap_fixed<34, 2, AP_RND_CONV, AP_SAT_SYM> ac, ad, bd, bc;

//	ac=iq.real()*dds.real();
//	ad=iq.real()*dds.imag();
//	bd=iq.imag()*dds.imag();
//	bc=iq.imag()*dds.real();
//	r=(ac-bd)-center.real();
//	i=(ad+bc)-center.imag();
//	p_product.real(r);
//	p_product.imag(i);
//	p_product.real(iq.real()*dds.real()-iq.imag()*dds.imag()-center.real());
//	p_product.imag(iq.real()*dds.imag()+iq.imag()*dds.real()-center.imag());
	dds_complex_t iq18, c18;
	iq18.real(iq.real());
	iq18.imag(iq.imag());
	c18.real(center.real());
	c18.imag(center.imag());

	p_product = iq18*dds - c18;
//#ifndef __SYNTHESIS__
//	cout<<"-----\nIQ * DDS - Center = result"<<endl;
//	cout<<iq<<" * "<<dds<<" - "<<center<<" = "<<p_product<<endl;
//	cout<<"ac: "<<ac<<" bd: "<<iq.imag()*dds.imag()<<" r:"<<ac-iq.imag()*dds.imag()-center.real()<<endl;
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


void isolated_accumulator(hls::stream<axisdata_t> &res_in,
		loopcenter_group_t centergroups[N_RES_GROUPS], tonegroup_t tones[N_RES_GROUPS],
		hls::stream<axisdata_t> &res_out, hls::stream<accgroup_t> &accout, hls::stream<loopcenter_group_t> &centergroup) {
#pragma HLS INTERFACE mode=axis register_mode=off port=res_in
#pragma HLS INTERFACE mode=axis register_mode=off port=accout
#pragma HLS INTERFACE mode=axis register_mode=off port=centergroup
#pragma HLS INTERFACE mode=axis register_mode=off port=res_out
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS INTERFACE s_axilite port=tones
#pragma HLS INTERFACE s_axilite port=centergroups
#pragma HLS PIPELINE II=1 REWIND

	static accgroup_t accumulator[N_RES_GROUPS], acc;

	axisdata_t data_in;
	res_in.read(data_in);

	group_t group, lgroup;
	group=data_in.user;
	lgroup=group-1;
	centergroup.write(centergroups[group]);

	tonegroup_t tonesgroup;
	tonesgroup = tones[group];
	res_out.write(data_in);

	accgroup_t _accv,_acc;

	accumulator[lgroup]=acc;
	_acc=accumulator[group];

	incp: for (int i=0; i<N_RES_PCLK; i++) {
		phase_t phase0;
		toneinc_t inc;
		acc_t tmp;

		inc.range()=tonesgroup.range(N_TONEBITS*(i+1)-1, N_TONEBITS*i);
		phase0.range()=tonesgroup.range(N_P0BITS*(i+1)-1+N_TONEBITS*N_RES_PCLK,N_P0BITS*i+N_TONEBITS*N_RES_PCLK);

		tmp.range()=_acc.range(NBITS*(i+1)-1, NBITS*i);
		_accv.range(NBITS*(i+1)-1, NBITS*i) = acc_t(tmp+phase0).range();
		_acc.range(NBITS*(i+1)-1, NBITS*i) = acc_t(tmp+inc).range();
	}

//	acc=_acc;

	static ap_uint<2> rst;
	static group_t last_group;
	acc = rst>0 ? accgroup_t(0): _acc;

	if (last_group!=lgroup) rst=2;
	else if (data_in.last) rst=rst>>1;

	last_group=group;


	accout.write(_accv);

}


void isolated_ddsddc(
		hls::stream<axisdata_t> &res_in,
		hls::stream<accgroup_t> &accgs,
		hls::stream<loopcenter_group_t> &centergroup,
		hls::stream<axisdata_t> &res_out) {
#pragma HLS INTERFACE mode=axis register_mode=off port=res_in
#pragma HLS INTERFACE mode=axis register_mode=off port=accgs
#pragma HLS INTERFACE mode=axis register_mode=off port=centergroup
#pragma HLS INTERFACE mode=axis register_mode=off port=res_out
//#pragma HLS INTERFACE mode=ap_ctrl_none port=return

	while (true){
	#pragma HLS PIPELINE II=1 REWIND
			iqgroup_uint_t _out;
			accgroup_t accg;
			loopcenter_group_t centergroupv;
			axisdata_t data_out, data_in;

//			res_in.read(data_in);
			if(!res_in.read_nb(data_in)) break;
			accgs.read(accg);
			centergroup.read(centergroupv);


			ddc: for (int i=0; i<N_RES_PCLK; i++) {
				sampleout_complex_t iqout;
				acc_t acc;
				sample_complex_t iq;
				loopcenter_t center;

				acc.range()=accg.range(NBITS*(i+1)-1, NBITS*i);

				iq.real().range()=data_in.data.range(32*(i+1)-16-1, 32*i);
				iq.imag().range()=data_in.data.range(32*(i+1)-1, 32*i+16);

				center.real().range()=centergroupv.range(32*(i+1)-16-1, 32*i);
				center.imag().range()=centergroupv.range(32*(i+1)-1, 32*i+16);

				_ddsddc(acc, iq, center, iqout);

				_out.range(32*(i+1)-16-1, 32*i)=iqout.real().range();
				_out.range(32*(i+1)-1, 32*i+16)=iqout.imag().range();
			}

			data_out.data = _out;
			data_out.last = data_in.last;
			data_out.user = data_in.user;
			res_out.write(data_out);
	}
}
