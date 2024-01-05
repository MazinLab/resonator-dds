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
}


void ddsddc(acc_t acc, sample_complex_t iq, loopcenter_t center, sampleout_complex_t &iqout) {
#pragma HLS INLINE
	sampleout_complex_t tmp;
	dds_words_t ddsv;
	dds_complex_t dds_sincos;
	phase_sincos_LUT(acc, ddsv);
	dds(ddsv, dds_sincos);
	cmpysub(iq, center, dds_sincos, iqout);
}


void resonator_ddc_control(hls::stream<axisdata_t> &res_in, tonegroup_t tones[N_RES_GROUPS], loopcenter_group_t centers[N_RES_GROUPS],
		hls::stream<axisdata_acc_center_combo_t> &out, bool clear_accumulator) {
#pragma HLS INTERFACE mode=axis register_mode=off port=res_in
#pragma HLS INTERFACE mode=axis port=out register_mode=both
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS INTERFACE s_axilite port=tones
#pragma HLS INTERFACE s_axilite port=centers
#pragma HLS INTERFACE s_axilite port=clear_accumulator
#pragma HLS PIPELINE II=1

	static accgroup_t accumulator[N_RES_GROUPS], accg;
	static bool clear=false;

	axisdata_t data_in;
	group_t group;
	tonegroup_t tonesgroup;
	accgroup_t _accg, _phaseacc;

	res_in.read(data_in);

	group=data_in.user;

	tonesgroup = tones[group];

	accumulator[group_t(group-1)]=accg;
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


	axisdata_acc_center_combo_t _output;
	_output.data.range(SAMPLE_GROUP_BITS-1,0)=data_in.data.range();
	_output.data.range(ACC_GROUP_BITS+SAMPLE_GROUP_BITS-1, SAMPLE_GROUP_BITS)=_phaseacc.range();
	_output.data.range(ACC_GROUP_BITS+SAMPLE_GROUP_BITS+SAMPLE_GROUP_BITS-1, ACC_GROUP_BITS+SAMPLE_GROUP_BITS)=centers[group].range();
	_output.user=data_in.user;
	_output.last=data_in.last;
	out.write(_output);

	accg = clear ? accgroup_t(0): _accg;
	if (clear_accumulator)
		clear=true;
	else if (data_in.last)
		clear=false;

}


void resonator_ddc_control_mem(hls::stream<axisdata_t> &res_in, tones_and_centers_t tones_and_centers[N_RES_GROUPS],
		hls::stream<axisdata_acc_center_combo_t> &out){
bool clear_accumulator=false;
#pragma HLS INTERFACE mode=bram port=tones_and_centers storage_type=ram_s2p latency=3
#pragma HLS INTERFACE mode=axis register_mode=off port=res_in
#pragma HLS INTERFACE mode=axis port=out register_mode=both
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS PIPELINE II=1

	static accgroup_t accumulator[N_RES_GROUPS], accg;
	static bool clear=false;

	axisdata_t data_in;
	group_t group;
	tonegroup_t tonesgroup;
	loopcenter_group_t centers;
	tones_and_centers_t tone_and_center;
	accgroup_t _accg, _phaseacc;

	res_in.read(data_in);

	group=data_in.user;

	tone_and_center = tones_and_centers[group];

	tonesgroup.range() = tone_and_center.range(255,0);
	centers.range() = tone_and_center.range(511,256);

	accumulator[group_t(group-1)]=accg;
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

	axisdata_acc_center_combo_t _output;
	_output.data.range(SAMPLE_GROUP_BITS-1,0)=data_in.data.range();
	_output.data.range(ACC_GROUP_BITS+SAMPLE_GROUP_BITS-1, SAMPLE_GROUP_BITS)=_phaseacc.range();
	_output.data.range(ACC_GROUP_BITS+SAMPLE_GROUP_BITS+SAMPLE_GROUP_BITS-1, ACC_GROUP_BITS+SAMPLE_GROUP_BITS)=centers.range();
	_output.user=data_in.user;
	_output.last=data_in.last;
	out.write(_output);

	accg = clear ? accgroup_t(0): _accg;
	if (clear_accumulator)
		clear=true;
	else if (data_in.last)
		clear=false;

}

void dds_ddc_center(hls::stream<axisdata_acc_center_combo_t> &ddc_control_out,
		hls::stream<axisdata_t> &res_out) {
#pragma HLS INTERFACE mode=axis register_mode=both port=ddc_control_out
#pragma HLS INTERFACE mode=axis port=res_out //register_mode=off
#pragma HLS INTERFACE mode=ap_ctrl_none port=return
#pragma HLS PIPELINE II=1
	iqgroup_uint_t _out;
	accgroup_t accg;
	loopcenter_group_t centergroupv;
	axisdata_t data_out, data_in;

	axisdata_acc_center_combo_t _input;
	ddc_control_out.read(_input);
	data_in.data.range()=_input.data.range(SAMPLE_GROUP_BITS-1,0);
	data_in.user=_input.user;
	data_in.last=_input.last;
	accg.range()=_input.data.range(ACC_GROUP_BITS+SAMPLE_GROUP_BITS-1, SAMPLE_GROUP_BITS);
	centergroupv.range()=_input.data.range(ACC_GROUP_BITS+SAMPLE_GROUP_BITS+SAMPLE_GROUP_BITS-1, ACC_GROUP_BITS+SAMPLE_GROUP_BITS);

	ddc: for (int i=0; i<N_RES_PCLK; i++) {
		sampleout_complex_t iqout;
		acc_t acc;
		sample_complex_t iq;
		loopcenter_t lcenter;

		acc.range()=accg.range(NBITS*(i+1)-1, NBITS*i);

		iq.real().range()=data_in.data.range(32*(i+1)-16-1, 32*i);
		iq.imag().range()=data_in.data.range(32*(i+1)-1, 32*i+16);

		lcenter.real().range()=centergroupv.range(32*(i+1)-16-1, 32*i);
		lcenter.imag().range()=centergroupv.range(32*(i+1)-1, 32*i+16);

		ddsddc(acc, iq, lcenter, iqout);

		_out.range(32*(i+1)-16-1, 32*i)=iqout.real().range();
		_out.range(32*(i+1)-1, 32*i+16)=iqout.imag().range();
	}

	data_out.data = _out;
	data_out.last = data_in.last;
	data_out.user = data_in.user;
	res_out.write(data_out);
}
