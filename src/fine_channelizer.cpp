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
			 		    toneinc_t toneinc[N_RES_GROUPS][N_RES_PCLK],
			 		    phase_t phase0[N_RES_GROUPS][N_RES_PCLK],
					    bool *event_group_misalign)  {
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS INTERFACE s_axilite port=toneinc bundle=control clock=s_axi_clk
#pragma HLS INTERFACE s_axilite port=phase0 bundle=control clock=s_axi_clk
#pragma HLS DATA_PACK variable=res_out
#pragma HLS INTERFACE axis port=res_in register reverse
#pragma HLS INTERFACE axis port=res_out register forward
#pragma HLS ARRAY_RESHAPE variable=toneinc complete dim=2
#pragma HLS ARRAY_RESHAPE variable=phase0 complete dim=2
//#pragma HLS INTERFACE s_axilite port=event_group_misalign bundle=control clock=s_axi_clk
#pragma HLS INTERFACE ap_none port=event_group_misalign

	static group_t group;
	static accgroup_t accumulator[N_RES_GROUPS];
#pragma HLS DATA_PACK variable=accumulator
	static accgroup_t acc;
#pragma HLS DATA_PACK variable=acc
	tonegroup_t tones;
	resgroup_t resdat;
	resgroupout_t outtemp;
	bool out_of_sync;
//	static bool out_of_sync_last;

	//coarse table
	lut_word_t cos_lut[LUTSIZE];
	init_cos_lut( cos_lut, LUTSIZE );

	// fine table related
	fine_word_t fine_lut[FINESIZE];
	init_fine_lut( fine_lut, FINESIZE, DELTA );

	//Read in the resonator group and make sure we are aligned
	resdat=res_in;
	out_of_sync=group!=resdat.user;
	*event_group_misalign=out_of_sync;

	//Fetch the tones
	fetchtones: for (int i=0; i<N_RES_PCLK; i++) {
		tones.tones[i].inc=toneinc[group][i];
		tones.tones[i].phase0=phase0[group][i];
	}
	//if (!out_of_sync_last)
	accumulator[group-1]=acc;
	acc=accumulator[group];

	//Do the DDC
	#ifndef __SYNTHESIS__
	ddsgroup_t ddsgroup;
	#endif
	ddsx8: for (int i=0; i<N_RES_PCLK; i++) {
		ddsiq_t ddsv;
		acc_t accv;
		accv=acc.phases[i]+tones.tones[i].phase0;
		phase_to_sincos(accv, cos_lut, fine_lut, &ddsv);
		cmpy(resdat.data.iq[i], ddsv, outtemp.data.iq[i]);
		acc.phases[i]+=tones.tones[i].inc;
		#ifndef __SYNTHESIS__
		ddsgroup.iq[i]=ddsv;
		#endif
	}
	outtemp.last = group == N_RES_GROUPS-1;
	outtemp.user = group;
	res_out=outtemp;

	#ifndef __SYNTHESIS__
	if (group%8==1){
		int i=0;
		cout<<"Core: g"<<group<<" gin"<<res_in.user<<" Mismatch? "<<*event_group_misalign<<" Res "<<group*8+i<<"\n";
		cout<<" Tone: "<<tones.tones[i].inc<<" "<<tones.tones[i].phase0<<" Accum: "<<acc.phases[i]+tones.tones[i].phase0<<"\n";
		cout<<" DDS: ("<<ddsgroup.iq[i].i<<","<<ddsgroup.iq[i].q<<")";
		cout<<" with IQ ("<<resdat.data.iq[i].i<<","<<resdat.data.iq[i].q<<") -> ";
		cout<<" ("<<res_out.data.iq[i].i<<","<<res_out.data.iq[i].q<<")\n";
	}
	if (group==255) cout<<"==========\n=============\n========\n";
	#endif

//	out_of_sync_last=out_of_sync;
	group=group+1;// out_of_sync ? resdat.user+1: group+1;
}
