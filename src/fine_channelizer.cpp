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
				   tonegroup2_t tones[N_RES_GROUPS],
				   resgroup_t lastpacketin[N_RES_GROUPS],
				   resgroupout_t lastpacket[N_RES_GROUPS],
				   accgroup_t lastaccum[N_RES_GROUPS],
				   ddsgroup_t lastdds[N_RES_GROUPS],
				   tonegroup_t lasttone[N_RES_GROUPS],
//				   volatile phase_t phase0[N_RES_GROUPS][N_RES_PCLK],
				   bool generate_tlast){//, bool test_tones)  {
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE ap_ctrl_none port=return bundle=control
#pragma HLS INTERFACE s_axilite port=tones bundle=control clock=s_axi_clk
#pragma HLS INTERFACE s_axilite port=lastpacket bundle=control clock=s_axi_clk
#pragma HLS INTERFACE s_axilite port=lastpacketin bundle=control clock=s_axi_clk
#pragma HLS INTERFACE s_axilite port=lastaccum bundle=control clock=s_axi_clk
#pragma HLS INTERFACE s_axilite port=lastdds bundle=control clock=s_axi_clk
#pragma HLS INTERFACE s_axilite port=lasttone bundle=control clock=s_axi_clk
#pragma HLS DATA_PACK variable=tones
#pragma HLS DATA_PACK variable=lastpacket
#pragma HLS DATA_PACK variable=lastpacketin
#pragma HLS DATA_PACK variable=lastaccum
#pragma HLS DATA_PACK variable=lastdds
#pragma HLS DATA_PACK variable=lasttone

//#pragma HLS INTERFACE s_axilite port=toneinc bundle=control clock=s_axi_clk
//#pragma HLS INTERFACE s_axilite port=phase0 bundle=control
//#pragma HLS ARRAY_RESHAPE variable=toneinc complete dim=2
//#pragma HLS ARRAY_RESHAPE variable=phase0 complete dim=2
#pragma HLS INTERFACE axis port=res_in register reverse
#pragma HLS INTERFACE axis port=res_out register forward
#pragma HLS INTERFACE ap_stable port=generate_tlast

	static group_t cycle;
	group_t group;
	static accgroup_t accumulator[N_RES_GROUPS];
#pragma HLS DATA_PACK variable=accumulator
	static accgroup_t acc;
#pragma HLS DATA_PACK variable=acc
	tonegroup2_t tonestemp;
	resgroup_t resdat;
	resgroupout_t outtemp;

	//Read in the resonator group and make sure we are aligned
	resdat=res_in;
	group = generate_tlast ? group_t(cycle) : group_t(resdat.user);

	lastpacketin[group]=resdat;

	//Fetch the tones
	tonestemp=tones[group];

	accumulator[group_t(group-1)]=acc;
	acc=accumulator[group];

	//Do the DDC
//	#ifndef __SYNTHESIS__
	ddsgroup_t ddsgroup;
	tonegroup_t tonegroup;

//	#endif
	accgroup_t accgroup;
	ddsx8: for (int i=0; i<N_RES_PCLK; i++) {
		ddsiq_t ddsv;
		acc_t accv;
		tone_t tone;
		tone.inc = tonestemp.inc[i];
		tone.phase0 = tonestemp.phase0[i];
		accv=acc.phases[i]+tone.phase0;
		phase_to_sincos_wLUT(accv, &ddsv);
		cmpy(resdat.data.iq[i], ddsv, outtemp.data.iq[i]);
		acc.phases[i]+=tone.inc;
//		#ifndef __SYNTHESIS__
		tonegroup.tones[i]=tone;
//		#endif
		accgroup.phases[i]=accv;
		ddsgroup.iq[i]=ddsv;

	}
	lastaccum[group]=accgroup;
	lasttone[group]=tonegroup;
	lastdds[group]=ddsgroup;
	outtemp.last = group == N_RES_GROUPS-1;
	outtemp.user = group;
	lastpacket[group]=outtemp;
	res_out=outtemp;

	#ifndef __SYNTHESIS__
	if (group%8==1){
		int i=0;
		cout<<"Core: g"<<group<<" gin"<<resdat.user<<" Res "<<group*8+i<<"\n";
		cout<<" Tone: "<<tonegroup.tones[i].inc<<" "<<tonegroup.tones[i].phase0<<" Accum: "<<accgroup.phases[i]<<"\n";
		cout<<" DDS: ("<<ddsgroup.iq[i].i<<","<<ddsgroup.iq[i].q<<")";
		cout<<" with IQ ("<<resdat.data.iq[i].i<<","<<resdat.data.iq[i].q<<") -> ";
		cout<<" ("<<outtemp.data.iq[i].i<<","<<outtemp.data.iq[i].q<<")\n";
	}
	if (group==255) cout<<"==========\n=============\n========\n";
	#endif

	cycle++;// = cycle==255 ? group_t(0):group_t(cycle+1);
}
