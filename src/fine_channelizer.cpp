#include "fine_channelizer.hpp"
#include "dds.h"
#include <iostream>
#include "hls_math.h"
#include "ap_fixed.h"
using namespace std;


void dds(dds_words_t dds, dds_complex_t &ddsv) {
#pragma HLS INLINE
	ddsv.real(dds.cos_word - dds.sin_word * dds.fine_word);
	ddsv.imag(dds.sin_word + dds.cos_word * dds.fine_word);
}


void cmpysub(sample_complex_t iq, sample_complex_t center, dds_complex_t dds, sampleout_complex_t& p_product) {
#pragma HLS INLINE
	p_product.real(iq.real()*dds.real()-iq.imag()*dds.imag()-center.real());
	p_product.imag(iq.real()*dds.imag()+iq.imag()*dds.real()-center.imag());
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


void isolated_accumulator(hls::stream<axisdata_t> &res_in, loopcenter_group_t centergroups[N_RES_GROUPS], tonegroup_t tones[N_RES_GROUPS],
		hls::stream<axisdata_t> &res_out, hls::stream<accgroup_t> &accout, hls::stream<loopcenter_group_t> &centergroup) {
#pragma HLS INTERFACE mode=axis register_mode=off port=res_in
#pragma HLS INTERFACE mode=axis register_mode=off port=accout
#pragma HLS INTERFACE mode=axis register_mode=off port=centergroup
#pragma HLS INTERFACE mode=axis register_mode=off port=res_out
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS INTERFACE s_axilite port=tones
#pragma HLS INTERFACE s_axilite port=centergroups
#pragma HLS PIPELINE II=1

	static accgroup_t accumulator[N_RES_GROUPS], accg;

	axisdata_t data_in;
	res_in.read(data_in);

	group_t group, lgroup;
	group=data_in.user;
	lgroup=group-1;

	centergroup.write(centergroups[group]);

	tonegroup_t tonesgroup;
	tonesgroup = tones[group];
	res_out.write(data_in);

	accgroup_t _accg,_phaseacc;

	accumulator[lgroup]=accg;
	_accg=accumulator[group];

	incp: for (int i=0; i<N_RES_PCLK; i++) {
		phase_t phase0, tmp;
		toneinc_t inc;

		inc.range()=tonesgroup.range(N_TONEBITS*(i+1)-1, N_TONEBITS*i);
		phase0.range()=tonesgroup.range(N_P0BITS*(i+1)-1+N_TONEBITS*N_RES_PCLK,N_P0BITS*i+N_TONEBITS*N_RES_PCLK);

		tmp.range()=_accg.range(NBITS*(i+1)-1, NBITS*i);

		_phaseacc.range(NBITS*(i+1)-1, NBITS*i) = phase_t(tmp+phase0).range();
		_accg.range(NBITS*(i+1)-1, NBITS*i) = phase_t(tmp+inc).range();
	}

//	accg=_accg;

	static ap_uint<2> rst;
	static group_t last_group=N_RES_GROUPS-1;
	accg = rst>0 ? accgroup_t(0): _accg;

	if (last_group!=lgroup) rst=2;
	else if (data_in.last) rst=rst>>1;

	last_group=group;

	accout.write(_phaseacc);

}



void isolated_center(hls::stream<axisdata_t> &res_in, loopcenter_group_t centergroups[N_RES_GROUPS],  hls::stream<axisdata_t> &res_out) {
#pragma HLS INTERFACE mode=axis register_mode=off port=res_in
#pragma HLS INTERFACE mode=axis register_mode=off port=res_out
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS INTERFACE s_axilite port=centergroups
#pragma HLS PIPELINE II=1
	axisdata_t data_in;
	iqgroup_uint_t _out;
	res_in.read(data_in);

	group_t group;
	group=data_in.user;

	loopcenter_group_t centergroupv;
	centergroupv = centergroups[group];

	incp: for (int i=0; i<N_RES_PCLK; i++) {
		sampleout_complex_t iqout;
		sample_complex_t iq;
		loopcenter_t center;
		iq.real().range()=data_in.data.range(32*(i+1)-16-1, 32*i);
		iq.imag().range()=data_in.data.range(32*(i+1)-1, 32*i+16);

		center.real().range()=centergroupv.range(32*(i+1)-16-1, 32*i);
		center.imag().range()=centergroupv.range(32*(i+1)-1, 32*i+16);

		iqout.real(iq.real()-center.real());
		iqout.imag(iq.real()-center.imag());

		_out.range(32*(i+1)-16-1, 32*i)=iqout.real().range();
		_out.range(32*(i+1)-1, 32*i+16)=iqout.imag().range();
	}

	data_in.data=_out;
	res_out.write(data_in);

}


void isolated_ddsddc(hls::stream<axisdata_t> &res_in, hls::stream<accgroup_t> &accgs, hls::stream<loopcenter_group_t> &centergroup,
		hls::stream<axisdata_t> &res_out) {
#pragma HLS INTERFACE mode=axis register_mode=off port=res_in
#pragma HLS INTERFACE mode=axis register_mode=off port=accgs
#pragma HLS INTERFACE mode=axis register_mode=off port=centergroup
#pragma HLS INTERFACE mode=axis register_mode=off port=res_out
#pragma HLS INTERFACE mode=ap_ctrl_none port=return

//	while (true){
#pragma HLS PIPELINE II=1 REWIND
		iqgroup_uint_t _out;
		accgroup_t accg;
		loopcenter_group_t centergroupv;
		axisdata_t data_out, data_in;

		res_in.read(data_in);
//		if(!res_in.read_nb(data_in)) break;

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
	//}
}
