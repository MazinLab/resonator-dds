#include "fine_channelizer.hpp"
#include "dds.h"
#include <iostream>
using namespace std;

void fetch_tones(resgroup_t &input, toneinc_t toneinc[N_RES_GROUPS][N_RES_PCLK], phase_t phase0[N_RES_GROUPS][N_RES_PCLK],
		group_t _group, tonegroup_t &tones, resgroup_t &resdat){
#pragma HLS PIPELINE II=1
	resdat=input;
	static tonegroup_t foo;
	tonegroup_t bar;
	//tones=foo;
	fetchtones: for (int i=0; i<N_RES_PCLK; i++) {
		bar.tones[i].inc=toneinc[_group][i];
		bar.tones[i].phase=phase0[_group][i];
	}
	foo=bar;
	tones=bar;
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


void aphase_to_sincos(accgroup_t phases, iqgroup_t &sincosines, resgroup_t dummyin, resgroup_t &dummyout) {
#pragma HLS PIPELINE ii=1
	//Convert a phase value to a sine,cosine value
	lut_word_t cos_lut[LUTSIZE];
	init_cos_lut(cos_lut, LUTSIZE );

	// fine table related
	fine_word_t fine_lut[FINESIZE];
	init_fine_lut(fine_lut, FINESIZE, DELTA );

	phase2sincos: for (int i=0; i<N_RES_PCLK; i++) {
		dds_t s, c;
		iq_t iq;
		phase_to_sincos(phases.phases[i], cos_lut, fine_lut, &c, &s);
		iq.i=c;
		iq.q=s;
		sincosines.iq[i]=iq;
	}

	dummyout=dummyin;
}

void downconvert(resgroup_t resdat, iqgroup_t sincosines, resgroupusr_t &output, group_t group) {
	//ROUND_MODE Values : AP_RND, AP_RND_ZERO, AP_RND_MIN_INF, AP_RND_INF, AP_RND_CONV, AP_TRN, AP_TRN_ZERO
	//OVERFLOW_MODE Values : AP_SAT, AP_SAT_ZERO, AP_SAT_SYM, AP_WRAP, AP_WRAP_SM
#pragma HLS PIPELINE ii=1
	iq_t iq_out[N_RES_PCLK];
	ddsx8: for (int i=0; i<N_RES_PCLK; i++){
		hls::cmpy<hls::CmpyThreeMult,
				  //W1, I1, Q1, O1, N1
				  16, 1, AP_RND_CONV, AP_SAT_SYM, 0,
		          16, 1, AP_RND_CONV, AP_SAT_SYM, 0>(resdat.data.iq[i].i, resdat.data.iq[i].q,
		        		  	  	  	  	  	  	  	 sincosines.iq[i].i, sincosines.iq[i].q,
													 iq_out[i].i, iq_out[i].q);
	}
	//  hls::cmpy<ARCH>(a, b, p);

	resgroupusr_t outtemp;
	outtemp.last = resdat.last;
	outtemp.user=group;
	outcopy: for (int i=0; i<N_RES_PCLK; i++) outtemp.data.iq[i]=iq_out[i];
	output=outtemp;

}


void resonator_dds(resgroup_t &res_in, resgroupusr_t &res_out,
				   toneinc_t toneinc[N_RES_GROUPS][N_RES_PCLK],
				   phase_t phase0[N_RES_GROUPS][N_RES_PCLK])  {
//#pragma HLS RESOURCE variable=toneinc core=RAM_1P_BRAM latency=1
//#pragma HLS RESOURCE variable=phase0 core=RAM_1P_BRAM latency=1
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS INTERFACE s_axilite port=toneinc bundle=control
#pragma HLS INTERFACE s_axilite port=phase0 bundle=control
#pragma HLS DATA_PACK variable=res_out
#pragma HLS INTERFACE axis port=res_in
#pragma HLS INTERFACE axis port=res_out
#pragma HLS ARRAY_RESHAPE variable=toneinc complete dim=2
#pragma HLS ARRAY_RESHAPE variable=phase0 complete dim=2
#pragma HLS PIPELINE  II=1

		static group_t group;

		tonegroup_t tones;
		accgroup_t phases;
		iqgroup_t sincosines;
		resgroup_t resdat, resdatB, resdatC;
//#pragma HLS DATA_PACK variable=tones
//#pragma HLS DATA_PACK variable=phases
//#pragma HLS DATA_PACK variable=sincosines
//#pragma HLS DATA_PACK variable=resdat

		fetch_tones(res_in, toneinc, phase0, group, tones, resdat);
		increment_phases(group, tones, phases, resdat, resdatB);
		aphase_to_sincos(phases, sincosines, resdatB, resdatC);
		downconvert(resdatC, sincosines, res_out, group);
		group++;
		#ifndef __SYNTHESIS__
			if (1){
				int i=1;
			cout<<"Core: "<<group<<"\n";
			cout<<" Tone: "<<tones.tones[i].inc.to_double()<<" "<<tones.tones[i].phase.to_double()<<"\n";
			cout<<" Phase: "<<phases.phases[i]<<"=("<<sincosines.iq[i].i.to_double()<<","<<sincosines.iq[i].q.to_double()<<")";
			cout<<" with IQ ("<<resdat.data.iq[i].i.to_double()<<","<<resdat.data.iq[i].q.to_double()<<") -> ";
			cout<<" ("<<res_out.data.iq[i].i.to_double()<<","<<res_out.data.iq[i].q.to_double()<<")\n";
			}
		#endif
}
