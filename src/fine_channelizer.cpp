#include "fine_channelizer.hpp"
#include "dds.h"
#include <iostream>
using namespace std;

void fetch_tones(resgroup_t &input, toneinc_t toneinc[N_RES_GROUPS][N_RES_PCLK], phase_t phase0[N_RES_GROUPS][N_RES_PCLK],
				 tone_t tones[N_RES_PCLK], group_t &group, resgroup_t &resdat){
#pragma HLS PIPELINE ii=1
	static group_t _group;

	resdat=input;
	group=_group;

	fetchtones: for (int i=0; i<N_RES_PCLK; i++) {
		//cout<<"Fetched "<<dec<<tone_inc_table[group_ndx][i]<<" for "<<group_ndx.to_int()<<", "<<i<<endl;
		tones[i].inc=toneinc[_group][i];
		tones[i].phase=phase0[_group][i];
	}

	_group = resdat.last ? group_t(0) : group_t(_group+1);
}

void increment_phases(group_t group, tone_t tones[N_RES_PCLK], acc_t phases[N_RES_PCLK]) {
#pragma HLS PIPELINE ii=1
	//Use a cache round robin
	static accgroup_t phase_cache[N_RES_GROUPS];
	static accgroup_t temp;
    #pragma HLS DATA_PACK variable=phase_cache	//Doing this gives a slight resource savings
	#pragma HLS DATA_PACK variable=temp
//    #pragma HLS DEPENDENCE variable=phase_cache  //dependence is true but with a distance=N_RES_GROUPS, so ignore

//	phase_cache[group-1]=temp;
	temp=phase_cache[group];
	incphase: for (int i=0; i<N_RES_PCLK; i++) {
		phases[i]=temp.phases[i]+tones[i].phase;
		temp.phases[i]+=tones[i].inc;
	}
	phase_cache[group]=temp;
}



void aphase_to_sincos(acc_t phases[N_RES_PCLK], iq_t sincosines[N_RES_PCLK]) {
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
		phase_to_sincos(phases[i], cos_lut, fine_lut, &c, &s);
		iq.i=c;
		iq.q=s;
		sincosines[i]=iq;
	}
}

//void complexmult(iq_t a, iq_t b, sample_t &pr, sample_t &pi) {
//#pragma HLS PIPELINE II=1
//      sample_t in[2][2];
////      ap_fixed<32,2, AP_RND_CONV, AP_SAT> m[2][2]; // multiplier bitgrowth
//      double m[2][2];
//
//      in[0][0] = a.i;
//      in[0][1] = b.i;
//      in[1][0] = a.q;
//      in[1][1] = b.q;
//
//      complexmult_outer : for (int i=0; i<2; i++) {
//    	  complexmult_inner : for (int j=0; j<2; j++) {
//          m[i][j] = in[i][0] * in[j][1];
//        }
//      }
//      pr = m[0][0] - m[1][1];
//      pi = m[1][0] + m[0][1];
//}

void downconvert(resgroup_t resdat, iq_t sincosines[N_RES_PCLK], resgroup_t &output) {
	//ROUND_MODE Values : AP_RND, AP_RND_ZERO, AP_RND_MIN_INF, AP_RND_INF, AP_RND_CONV, AP_TRN, AP_TRN_ZERO
	//OVERFLOW_MODE Values : AP_SAT, AP_SAT_ZERO, AP_SAT_SYM, AP_WRAP, AP_WRAP_SM
#pragma HLS pipeline ii=1
	iq_t iq_out[N_RES_PCLK];
	ddsx8: for (int i=0; i<N_RES_PCLK; i++){
		//complexmult(resdat.data.iq[i],sincosines[i], iq_out[i].i, iq_out[i].q);
		hls::cmpy<hls::CmpyThreeMult,
				  //W1, I1, Q1, O1, N1
				  16, 1, AP_RND_CONV, AP_SAT_SYM, 0,
		          16, 1, AP_RND_CONV, AP_SAT_SYM, 0>(resdat.data.iq[i].i, resdat.data.iq[i].q, sincosines[i].i, sincosines[i].q, iq_out[i].i, iq_out[i].q);
		//cout<<"DDS: ("<<sincosines[i].i<<","<<sincosines[i].q<<") IQ: ("<<res_iq[i].i<<","<<res_iq[i].q<<")";
		//cout<<" Prod: ("<<iq_out[i].i<<","<<iq_out[i].q<<")"<<endl;
	}
	//  hls::cmpy<ARCH>(a, b, p);

	output.last = resdat.last;
	outcopy: for (int i=0; i<N_RES_PCLK; i++) output.data.iq[i]=iq_out[i];

}


void resonator_dds(resgroup_t &res_in, resgroup_t &res_out,
				   toneinc_t toneinc[N_RES_GROUPS][N_RES_PCLK],
				   phase_t phase0[N_RES_GROUPS][N_RES_PCLK])  {
//#pragma HLS RESOURCE variable=toneinc core=RAM_2P_BRAM latency=1
//#pragma HLS RESOURCE variable=phase0 core=RAM_2P_BRAM latency=1
#pragma HLS INTERFACE s_axilite port=toneinc bundle=control
#pragma HLS INTERFACE s_axilite port=phase0 bundle=control
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE axis port=res_in
#pragma HLS INTERFACE axis port=res_out
#pragma HLS ARRAY_RESHAPE variable=toneinc complete dim=2
#pragma HLS ARRAY_RESHAPE variable=phase0 complete dim=2
#pragma HLS INTERFACE s_axilite port=return bundle=control

	tone_t tones[N_RES_PCLK];
	acc_t phases[N_RES_PCLK];
	iq_t sincosines[N_RES_PCLK];
	resgroup_t resdat;
	group_t group;

	fetch_tones(res_in, toneinc, phase0, tones, group, resdat);
	increment_phases(group, tones, phases);
	aphase_to_sincos(phases, sincosines);
	downconvert(resdat, sincosines, res_out);

#ifndef __SYNTHESIS__
	if (0){
	cout<<"Core:\n";
	cout<<" Tone: "<<tones[0].inc.to_double()<<" "<<tones[0].phase.to_double()<<"\n";
	cout<<" Phase: "<<phases[0]<<"=("<<sincosines[0].i.to_double()<<","<<sincosines[0].q.to_double()<<")";
	cout<<" with IQ ("<<resdat.data.iq[0].i.to_double()<<","<<resdat.data.iq[0].q.to_double()<<") -> ";
	cout<<" ("<<res_out.data.iq[0].i.to_double()<<","<<res_out.data.iq[0].q.to_double()<<")\n";
	}
#endif


}
