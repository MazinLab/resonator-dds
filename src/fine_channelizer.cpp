#include "fine_channelizer.hpp"
#include "dds.h"
#include <iostream>
using namespace std;


void cmpy(const iq_t a, const ddsiq_t b, iqout_t &o) {
#pragma HLS INLINE
      o.i=a.i*b.i-a.q*b.q;
      o.q=a.i*b.q+a.q*b.i;
}

void accumulate(const group_t group, const tonegroup_t tonesgroup, accgroup_t &accv){
#pragma HLS PIPELINE II=1
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

void get_dds(const accgroup_t accg, iqgroup_uint_t &ddsg) {
#pragma HLS PIPELINE II=1
	p2sc: for (int i=0; i<N_RES_PCLK; i++) {
		acc_t acc;
		ddsiq32_t ddsv;
		acc.range()=accg.range(NBITS*(i+1)-1, NBITS*i);
		phase_to_sincos_wLUT(acc, ddsv);
		ddsg.range(32*(i+1)-1, 32*i)=ddsv.range();
	}
}

void ddc(const iqgroup_uint_t in, const iqgroup_uint_t ddsgroup, iqgroup_uint_t &out){
#pragma HLS PIPELINE II=1
	ddc: for (int i=0; i<N_RES_PCLK; i++) {
		iqout_t iqout;
		iq_t iq;
		ddsiq_t ddsv;
		iq.i.range()=in.range(32*(i+1)-1-16, 32*i);
		iq.q.range()=in.range(32*(i+1)-1, 32*i+16);
		ddsv.i.range()=ddsgroup.range(32*(i+1)-1-16, 32*i);
		ddsv.q.range()=ddsgroup.range(32*(i+1)-1, 32*i+16);
		cmpy(iq, ddsv, iqout);
		out.range(32*(i+1)-1-16, 32*i)=iqout.i.range();
		out.range(32*(i+1)-1, 32*i+16)=iqout.q.range();
	}
}

void resonator_dds(hls::stream<axisdata_t> &res_in, hls::stream<axisdata_t> &res_out,
				  tonegroup_t tones[N_RES_GROUPS]) {

#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS INTERFACE s_axilite port=tones
#pragma HLS INTERFACE axis port=res_in register
#pragma HLS INTERFACE axis port=res_out register

//	while (true) {
#pragma HLS PIPELINE II=1

	static group_t cycle;
	group_t group;
	axisdata_t data_in, data_out;

	//-----------
	//Tone and accumulator fetching
	//-----------
	res_in.read(data_in);
	group = cycle;
	//--------
	//Compute phase value
	//--------
	accgroup_t accg;
	accumulate(group, tones[group], accg);
	//--------
	//Convert phase to sincos
	//--------
	iqgroup_uint_t ddsg;
	get_dds(accg, ddsg);
	//--------
	//Perform the DDC
	//--------
	iqgroup_uint_t out;
	ddc(data_in.data, ddsg, out);
	//--------
	//Output
	//--------
	data_out.data = out;
	data_out.last = group == N_RES_GROUPS-1;
	data_out.user = group;
	res_out.write(data_out);

	cycle++;
}
