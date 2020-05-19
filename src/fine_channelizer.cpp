#include "fine_channelizer.hpp"
#include "dds.h"
#include <iostream>
using namespace std;


void cmpy(iq_t a, ddsiq_t b, iqout_t &o) {
#pragma HLS INLINE
      o.i=a.i*b.i-a.q*b.q;
      o.q=a.i*b.q+a.q*b.i;
}

void resonator_dds(resgroup_t &res_in, resgroupout_t &res_out,
				   tonegroup_t tones[N_RES_GROUPS], bool generate_tlast) {
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE ap_ctrl_none port=return bundle=control
#pragma HLS INTERFACE s_axilite port=tones bundle=control clock=s_axi_clk
#pragma HLS DATA_PACK variable=tones
#pragma HLS INTERFACE axis port=res_in register reverse
#pragma HLS INTERFACE axis port=res_out register forward
#pragma HLS INTERFACE ap_stable port=generate_tlast

	static group_t cycle;
	group_t group;
	static accgroup_t accumulator[N_RES_GROUPS];
#pragma HLS DATA_PACK variable=accumulator
	static accgroup_t acc;
#pragma HLS DATA_PACK variable=acc
	tonegroup_t tonesgroup;
	resgroup_t data_in;
	resgroupout_t data_out;

	//Read in the resonator group and make sure we are aligned
	data_in=res_in;
	group = generate_tlast ? group_t(cycle) : group_t(data_in.user);

	//Fetch the tones, store last cycles phase, load this cycles phase
	tonesgroup=tones[group];

	accumulator[group_t(group-1)]=acc;
	acc=accumulator[group];

	//Do the DDC
	#ifndef __SYNTHESIS__
	ddsgroup_t ddsgroup;
	accgroup_t accgroup;
	#endif
	ddsx8: for (int i=0; i<N_RES_PCLK; i++) {
		ddsiq_t ddsv;
		acc_t accv;
		tone_t tone;
		iq_t iq;
		iqout_t iqout;
		tone.inc = tonesgroup.inc[i];
		tone.phase0 = tonesgroup.phase0[i];
		accv=acc.phases[i]+tone.phase0;
		acc.phases[i]+=tone.inc;
		phase_to_sincos_wLUT(accv, &ddsv);
		iq.i=data_in.data[2*i];
		iq.q=data_in.data[2*i+1];
		cmpy(iq, ddsv, iqout);
		data_out.data[2*i]=iqout.i;
		data_out.data[2*i+1]=iqout.q;
		#ifndef __SYNTHESIS__
		accgroup.phases[i]=accv;
		ddsgroup.i[i]=ddsv.i;
		ddsgroup.q[i]=ddsv.q;
		#endif
	}
	data_out.last = group == N_RES_GROUPS-1;
	data_out.user = group;
	res_out=data_out;

	#ifndef __SYNTHESIS__
	if (group%8==1){
		int i=0;
		cout<<"Core: g"<<group<<" gin"<<data_in.user<<" Res "<<group*8+i<<"\n";
		cout<<" Tone: "<<tonesgroup.inc[i]<<" "<<tonesgroup.phase0[i]<<" Accum: "<<accgroup.phases[i]<<"\n";
		cout<<" DDS: ("<<ddsgroup.i[i]<<","<<ddsgroup.q[i]<<")";
		cout<<" with IQ ("<<data_in.data[2*i]<<","<<data_in.data[2*i+1]<<") -> ";
		cout<<" ("<<data_out.data[2*i]<<","<<data_out.data[2*i+1]<<")\n";
	}
	if (group==255) cout<<"==========\n=============\n========\n";
	#endif

	cycle++;
}
