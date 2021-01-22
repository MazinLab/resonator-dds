#include "fine_channelizer.hpp"
#include "dds.h"
#include <iostream>
using namespace std;


void cmpy(iq_t a, ddsiq_t b, iqout_t &o) {
#pragma HLS INLINE
      o.i=a.i*b.i-a.q*b.q;
      o.q=a.i*b.q+a.q*b.i;
}

void accumulate(group_t group, tonegroup_t tonesgroup, accgroup_t &accv){
#pragma HLS PIPELINE II=1
//#pragma HLS DATA_PACK variable=tonesgroup
	static accgroup_t accumulator[N_RES_GROUPS], acc;
	accumulator[group_t(group-1)]=acc;
	acc=accumulator[group];
	incp: for (int i=0; i<N_RES_PCLK; i++) {
		acc_t tmp=acc.range(NBITS*(i+1)-1, NBITS*i);
		accv.range(NBITS*(i+1)-1, NBITS*i) = (tmp+tonesgroup.phase0[i]).range();
		acc.range(NBITS*(i+1)-1, NBITS*i) = (tmp+tonesgroup.inc[i]).range();
	}
}

void get_dds(accgroup_t accg, iqgroup_uint_t &ddsg) {
#pragma HLS PIPELINE II=1
	p2sc: for (int i=0; i<N_RES_PCLK; i++) {
		acc_t acc;
		ddsiq32_t ddsv;
		acc.range()=accg.range(NBITS*(i+1)-1, NBITS*i);
		phase_to_sincos_wLUT(acc, ddsv);
		ddsg.range(32*(i+1)-1, 32*i)=ddsv.range();
	}
}

void ddc(iqgroup_uint_t in, iqgroup_uint_t ddsgroup, iqgroup_uint_t &out){
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

void resonator_dds(axisdata_t &res_in, axisdata_t &res_out,
				   tonegroup_t tones[N_RES_GROUPS], bool generate_tlast) {
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE ap_ctrl_none port=return bundle=control
#pragma HLS INTERFACE s_axilite port=tones bundle=control clock=s_axi_clk
#pragma HLS DATA_PACK variable=tones
#pragma HLS INTERFACE axis port=res_in register
#pragma HLS INTERFACE axis port=res_out register
#pragma HLS INTERFACE ap_stable port=generate_tlast

	static group_t cycle;
	group_t group;
	tonegroup_t tonesgroup;
//#pragma HLS DATA_PACK variable=tonesgroup
	axisdata_t data_in, data_out;

	//-----------
	//Tone and accumulator fetching
	//-----------
	data_in=res_in;
	group = cycle; //generate_tlast ? group_t(cycle) : group_t(data_in.user);
	tonesgroup=tones[group];
	//--------
	//Compute phase value
	//--------
	accgroup_t accg;
	accumulate(group, tonesgroup, accg);
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


	data_out.data = out;
	data_out.last = group == N_RES_GROUPS-1;
	data_out.user = group;
	res_out=data_out;

//	#ifndef __SYNTHESIS__
//	if (group%8==1){
//		int i=0;
//		cout<<"Core: g"<<group<<" gin"<<data_in.user<<" Res "<<group*8+i<<"\n";
//		cout<<" Tone: "<<tonesgroup.inc[i]<<" "<<tonesgroup.phase0[i]<<" Accum: "<<accgroup.phases[i]<<"\n";
//		cout<<" DDS: ("<<ddsgroup.i[i]<<","<<ddsgroup.q[i]<<")";
//		cout<<" with IQ ("<<data_in.data[2*i]<<","<<data_in.data[2*i+1]<<") -> ";
//		cout<<" ("<<data_out.data[2*i]<<","<<data_out.data[2*i+1]<<")\n";
//	}
//	if (group==255) cout<<"==========\n=============\n========\n";
//	#endif

	cycle++;
}
