#include "fine_channelizer.hpp"
#include "dds.h"
#include <iostream>
using namespace std;

void fetch_tones(resgroup_t &input, toneinc_t toneinc[N_RES_GROUPS][N_RES_PCLK], phase_t phase0[N_RES_GROUPS][N_RES_PCLK],
		group_t _group, tonegroup_t &tones, resgroup_t &resdat, volatile bool *event_group_misalign){
#pragma HLS PIPELINE II=1
	resdat=input;

	*event_group_misalign=_group!=resdat.user;

//	static tonegroup_t foo;
	tonegroup_t tempgroup;
	//tones=foo;
	fetchtones: for (int i=0; i<N_RES_PCLK; i++) {
		tempgroup.tones[i].inc=toneinc[_group][i];
		tempgroup.tones[i].phase=phase0[_group][i];
	}
//	foo=bar;
	tones=tempgroup;
}

void increment_phases(group_t group, tonegroup_t tones, accgroup_t &phasesout, resgroup_t dummyin, resgroup_t &dummyout) {
#pragma HLS PIPELINE ii=1
	//Use a cache round robin
	static accgroup_t phase_cache[N_RES_GROUPS];
#pragma HLS RESOURCE variable=phase_cache core=RAM_2P_BRAM latency=1
#pragma HLS DATA_PACK variable=phase_cache	//Doing this gives a slight resource savings

	static accgroup_t last;
	accgroup_t phases, temp;

	phase_cache[group-1]=last;
	temp=phase_cache[group];
	incphase: for (int i=0; i<N_RES_PCLK; i++) {
		phases.phases[i]=temp.phases[i]+tones.tones[i].phase;
		temp.phases[i]+=tones.tones[i].inc;
	}
	last=temp;
	phasesout=phases;
	dummyout=dummyin;
}


void aphase_to_sincos(accgroup_t phases, ddsgroup_t &ddsv, resgroup_t dummyin, resgroup_t &dummyout) {
#pragma HLS PIPELINE ii=1
	//Convert a phase value to a sine,cosine value
	lut_word_t cos_lut[LUTSIZE];
	init_cos_lut(cos_lut, LUTSIZE);

	// fine table related
	fine_word_t fine_lut[FINESIZE];
	init_fine_lut(fine_lut, FINESIZE, DELTA);

	phase2sincos: for (int i=0; i<N_RES_PCLK; i++) {
		ddsiq_t iq;
		phase_to_sincos(phases.phases[i], cos_lut, fine_lut, &iq);
		ddsv.iq[i]=iq;
	}

	dummyout=dummyin;
}

void complexmult(iq_t a, ddsiq_t b, iqout_t &o) {
#pragma HLS PIPELINE II=1
      o.i=a.i*b.i-a.q*b.q;
      o.q=a.i*b.q+a.q*b.i;
}


void downconvert(resgroup_t resdat, ddsgroup_t ddsv, resgroupout_t &output, group_t group) {

	//ROUND_MODE Values : AP_RND, AP_RND_ZERO, AP_RND_MIN_INF, AP_RND_INF, AP_RND_CONV, AP_TRN, AP_TRN_ZERO
	//OVERFLOW_MODE Values : AP_SAT, AP_SAT_ZERO, AP_SAT_SYM, AP_WRAP, AP_WRAP_SM
#pragma HLS PIPELINE ii=1
	iqout_t iq_out[N_RES_PCLK];

	ddsx8: for (int i=0; i<N_RES_PCLK; i++){
		complexmult(resdat.data.iq[i], ddsv.iq[i], iq_out[i]);
	}

	resgroupout_t outtemp;
	outtemp.last = group==N_RES_GROUPS-1;
	outtemp.user = group;
	outcopy: for (int i=0; i<N_RES_PCLK; i++) outtemp.data.iq[i]=iq_out[i];
	output=outtemp;

}


void resonator_dds(resgroup_t &res_in, resgroupout_t &res_out,
				   toneinc_t toneinc[N_RES_GROUPS][N_RES_PCLK],
				   phase_t phase0[N_RES_GROUPS][N_RES_PCLK],
				   volatile bool *event_group_misalign)  {
//#pragma HLS RESOURCE variable=toneinc core=RAM_1P_BRAM latency=1
//#pragma HLS RESOURCE variable=phase0 core=RAM_1P_BRAM latency=1
#pragma HLS PIPELINE II=1
//#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS INTERFACE s_axilite port=toneinc bundle=control clock=S_AXI_CLK
#pragma HLS INTERFACE s_axilite port=phase0 bundle=control clock=S_AXI_CLK
#pragma HLS DATA_PACK variable=res_out
#pragma HLS INTERFACE axis port=res_in register reverse
#pragma HLS INTERFACE axis port=res_out register forward
#pragma HLS ARRAY_RESHAPE variable=toneinc complete dim=2
#pragma HLS ARRAY_RESHAPE variable=phase0 complete dim=2
#pragma HLS INTERFACE s_axilite port=event_group_misalign bundle=control clock=S_AXI_CLK
//#pragma HLS INTERFACE ap_none port=event_group_misalign

		static group_t group;

		tonegroup_t tones;
		accgroup_t phases;
		ddsgroup_t ddsv;
		resgroup_t resdat, resdatB, resdatC;
//#pragma HLS DATA_PACK variable=tones
//#pragma HLS DATA_PACK variable=phases
//#pragma HLS DATA_PACK variable=sincosines
//#pragma HLS DATA_PACK variable=resdat

		fetch_tones(res_in, toneinc, phase0, group, tones, resdat, event_group_misalign);
		increment_phases(group, tones, phases, resdat, resdatB);
		aphase_to_sincos(phases, ddsv, resdatB, resdatC);
		downconvert(resdatC, ddsv, res_out, group);

		#ifndef __SYNTHESIS__
//			if (group%8==0){
//				int i=0;
//			cout<<"Core: g"<<group<<" gin"<<res_in.user<<" Mismatch? "<<*event_group_misalign<<" Res "<<group*8+i<<"\n";
//			cout<<" Tone: "<<tones.tones[i].inc<<" "<<tones.tones[i].phase<<"\n";
//			cout<<" Phase: "<<phases.phases[i]<<"=("<<ddsv.iq[i].i<<","<<ddsv.iq[i].q<<")";
//			cout<<" with IQ ("<<resdat.data.iq[i].i<<","<<resdat.data.iq[i].q<<") -> ";
//			cout<<" ("<<res_out.data.iq[i].i<<","<<res_out.data.iq[i].q<<")\n";
//
//			}
//			if (group==255) cout<<"==========\n=============\n========\n";

		#endif

		group++;
}
