#include "fine_channelizer.hpp"
#include <iostream>
using namespace std;

//TODO try using DATA_PACK in more places (e.g. on more phase_t phases[N_RES_PCLK])

void fetch_tones(group_t group_ndx, toneinc_t toneinc[N_RES_GROUPS][N_RES_PCLK], phase_t phase0[N_RES_GROUPS][N_RES_PCLK],
				 tone_t tones[N_RES_PCLK]){
	tonetable: for (int i=0; i<N_RES_PCLK; i++) {
		//cout<<"Fetched "<<dec<<tone_inc_table[group_ndx][i].to_double()<<" for "<<group_ndx.to_int()<<", "<<i<<endl;
		tones[i].inc=toneinc[group_ndx][i];
		tones[i].phase=phase0[group_ndx][i];
	}
}

//1024 LUT
//#include "ap_shift_reg.h"
//void increment_phases(toneinc_t tones[N_RES_PCLK], phase_t phases[N_RES_PCLK]) {
//	static ap_shift_reg<phasegroup_t, N_RES_GROUPS> phase_shifter;
//	phasegroup_t cache=phase_shifter.read(255);
//	phaseincsr: for (int i=0; i<N_RES_PCLK; i++) {
//#pragma HLS UNROLL
//		cache.phases[i]+=tones[i];
//		phases[i]=cache.phases[i];
//	}
//	phase_shifter.shift(cache);
//}

//4BRAM
void increment_phases(group_t group_ndx, tone_t tones[N_RES_PCLK], phase_t phases[N_RES_PCLK]) {
	//Use a cache round robin
	static phasegroup_t phases_delay_line[N_RES_GROUPS];
	phasegroup_t cache;
    #pragma HLS DATA_PACK variable=phases_delay_line	//Doing this gives a slight resource savings
	#pragma HLS DATA_PACK variable=cache
    #pragma HLS DEPENDENCE variable=phases_delay_line  //dependence is true but with a distance=N_RES_GROUPS, so ignore

	cache=phases_delay_line[group_ndx];
	phaseinc: for (int i=0; i<N_RES_PCLK; i++) {
		cache.phases[i]+=tones[i].inc;
		phases[i]=cache.phases[i]+tones[i].phase;
	}
	phases_delay_line[group_ndx]=cache;
}

void init_sincostable(iq_t lut[LUT_LENGTH]) {
	// Populate the SINCOS LUT, will be synthesized away
	//#pragma HLS DATA_PACK variable=lut
	iq_t v;
    //#pragma HLS DATA_PACK variable=v
	double f;
	populatelut: for (unsigned int i=0; i<LUT_LENGTH;i++){
		f=M_PI/2.0*((double)i)/(LUT_LENGTH-1);
		v.i=cos(f);
		v.q=sin(f);
		lut[i]=v;
	}
}

void sincoslut_query(unsigned int intphase, iq_t &lutv) {
	static iq_t lut[LUT_LENGTH];
	#pragma HLS DATA_PACK variable=lut
    #pragma HLS DATA_PACK variable=lutv
	init_sincostable(lut);
	lutv=lut[intphase];
}

void phase_to_sincos(phase_t phases[N_RES_PCLK], iq_t sincosines[N_RES_PCLK]) {
	//Convert a phase value to a sine,cosine value
	phase2sincos: for (int i=0; i<N_RES_PCLK; i++) {
		phase_t phase=phases[i];
		iq_t lutv;
		#pragma HLS DATA_PACK variable=lutv
		unsigned int intphase = (ap_fixed<32, 16>(phase)*4*(LUT_LENGTH-1)).to_uint();
		cout<<"Converted phase "<<phase.to_double()<<" to "<<intphase;
		if (intphase>=LUT_LENGTH && intphase<=2*(LUT_LENGTH-1)) { //Q2 intphase in LUT_LENGTH-2*LUT_LENGTH
			sincoslut_query(2*(LUT_LENGTH-1)-intphase, lutv);
			lutv.i=-lutv.i;
			cout<<" (Q2). Found "<<lutv.i.to_double()<<", "<<lutv.q.to_double()<<"."<<endl;
		} else if (intphase>2*(LUT_LENGTH-1) && intphase<3*(LUT_LENGTH-1)) { //Q3 intphase in 2*LUT_LENGTH-3*LUT_LENGTH
			sincoslut_query(intphase-2*(LUT_LENGTH-1), lutv);
			lutv.i=-lutv.i;
			lutv.q=-lutv.q;
			cout<<" (Q3). Found "<<lutv.i.to_double()<<", "<<lutv.q.to_double()<<"."<<endl;
		} else if (intphase>=3*(LUT_LENGTH-1)) { //Q4
			sincoslut_query(4*(LUT_LENGTH-1)-intphase, lutv);
			lutv.q=-lutv.q;
			cout<<" (Q4). Found "<<lutv.i.to_double()<<", "<<lutv.q.to_double()<<"."<<endl;
		} else {
			sincoslut_query(intphase, lutv);
			cout<<" (Q1). Found "<<lutv.i.to_double()<<", "<<lutv.q.to_double()<<"."<<endl;
		}
		sincosines[i]=lutv;
	}
}


void downconvert(iq_t res_iq[N_RES_PCLK], iq_t sincosines[N_RES_PCLK], iq_t iq_out[N_RES_PCLK]) {
	//ROUND_MODE Values : AP_RND, AP_RND_ZERO, AP_RND_MIN_INF, AP_RND_INF, AP_RND_CONV, AP_TRN, AP_TRN_ZERO
	//OVERFLOW_MODE Values : AP_SAT, AP_SAT_ZERO, AP_SAT_SYM, AP_WRAP, AP_WRAP_SM
#pragma HLS pipeline ii=1
	ddsx8: for (int i=0; i<N_RES_PCLK; i++){
		hls::cmpy<hls::CmpyFourMult,
				  //W1, I1, Q1, O1, N1
				  16, 1, AP_RND_CONV, AP_SAT, 0,
		          16, 1, AP_RND_CONV, AP_SAT, 0>(res_iq[i].i, res_iq[i].q, sincosines[i].i, sincosines[i].q, iq_out[i].i, iq_out[i].q);
		cout<<"DDS: ("<<sincosines[i].i.to_double()<<","<<sincosines[i].q.to_double()<<") IQ: ("<<res_iq[i].i.to_double()<<","<<res_iq[i].q.to_double()<<")";
		cout<<" Prod: ("<<iq_out[i].i.to_double()<<","<<iq_out[i].q.to_double()<<")"<<endl;
	}
	//  hls::cmpy<ARCH>(a, b, p);
}


void resonator_dds(resgroup_t &res_in, resgroup_t &res_out,
				   toneinc_t toneinc[N_RES_GROUPS][N_RES_PCLK],
				   phase_t phase0[N_RES_GROUPS][N_RES_PCLK])  {
#pragma HLS INTERFACE axis port=res_in
#pragma HLS INTERFACE axis port=res_out
#pragma HLS PIPELINE II=1
#pragma HLS ARRAY_PARTITION variable=toneinc complete dim=2
#pragma HLS ARRAY_PARTITION variable=phase0 complete dim=2
#pragma HLS INTERFACE ap_ctrl_none port=return

	tone_t tones[N_RES_PCLK];
	phase_t phases[N_RES_PCLK];
	iq_t sincosines[N_RES_PCLK], iq_out[N_RES_PCLK], iq_in[N_RES_PCLK];


	group_t groupid=res_in.user;
	incopy: for (int i=0; i<N_RES_PCLK; i++) iq_in[i]=res_in.data.iq[i];

	fetch_tones(groupid, toneinc, phase0, tones);
	increment_phases(groupid, tones, phases);
	phase_to_sincos(phases, sincosines);
	downconvert(iq_in, sincosines, iq_out);

	res_out.user = groupid;
	outcopy: for (int i=0; i<N_RES_PCLK; i++) res_out.data.iq[i]=iq_out[i];

}
