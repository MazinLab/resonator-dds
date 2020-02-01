#include "fine_channelizer.hpp"
#include <iostream>
using namespace std;

void fetch_tones(resgroup_t &input, toneinc_t toneinc[N_RES_GROUPS][N_RES_PCLK], phase_t phase0[N_RES_GROUPS][N_RES_PCLK],
				 tone_t tones[N_RES_PCLK], group_t &group, resgroup_t &resdat){
#pragma HLS PIPELINE ii=1
	static group_t _group;

	resdat=input;
	group=_group;

	fetchtones: for (int i=0; i<N_RES_PCLK; i++) {
		//cout<<"Fetched "<<dec<<tone_inc_table[group_ndx][i].to_double()<<" for "<<group_ndx.to_int()<<", "<<i<<endl;
		tones[i].inc=toneinc[_group][i];
		tones[i].phase=phase0[_group][i];
	}

	_group = resdat.last ? group_t(0) : group_t(_group+1);
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
#pragma HLS PIPELINE ii=1
	static phasegroup_t phase_cache[N_RES_GROUPS];
	phasegroup_t temp;
    #pragma HLS DATA_PACK variable=phase_cache	//Doing this gives a slight resource savings
	#pragma HLS DATA_PACK variable=temp
    #pragma HLS DEPENDENCE variable=phase_cache  //dependence is true but with a distance=N_RES_GROUPS, so ignore

	temp=phase_cache[group_ndx];
	phaseinc: for (int i=0; i<N_RES_PCLK; i++) {
		temp.phases[i]+=tones[i].inc;
		phases[i]=temp.phases[i]+tones[i].phase;
	}
	phase_cache[group_ndx]=temp;
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
#pragma HLS PIPELINE ii=1
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

//void complexmult(iq_t a, iq_t b, sample_t &pr, sample_t &pi) {
//#pragma HLS PIPELINE II=1
//      sample_t in[2][2];
//      ap_fixed<32,2, AP_RND_CONV, AP_SAT> m[2][2]; // multiplier bitgrowth
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
//		complexmult(resdat.data.iq[i],sincosines[i], iq_out[i].i, iq_out[i].q);
		hls::cmpy<hls::CmpyThreeMult,
				  //W1, I1, Q1, O1, N1
				  16, 1, AP_RND_CONV, AP_SAT, 0,
		          16, 1, AP_RND_CONV, AP_SAT, 0>(resdat.data.iq[i].i, resdat.data.iq[i].q, sincosines[i].i, sincosines[i].q, iq_out[i].i, iq_out[i].q);
		//cout<<"DDS: ("<<sincosines[i].i.to_double()<<","<<sincosines[i].q.to_double()<<") IQ: ("<<res_iq[i].i.to_double()<<","<<res_iq[i].q.to_double()<<")";
		//cout<<" Prod: ("<<iq_out[i].i.to_double()<<","<<iq_out[i].q.to_double()<<")"<<endl;
	}
	//  hls::cmpy<ARCH>(a, b, p);

	output.last = resdat.last;
	outcopy: for (int i=0; i<N_RES_PCLK; i++) output.data.iq[i]=iq_out[i];

}


void resonator_dds(resgroup_t &res_in, resgroup_t &res_out,
				   toneinc_t toneinc[N_RES_GROUPS][N_RES_PCLK],
				   phase_t phase0[N_RES_GROUPS][N_RES_PCLK])  {
#pragma HLS RESOURCE variable=toneinc core=RAM_2P_BRAM latency=1
#pragma HLS RESOURCE variable=phase0 core=RAM_2P_BRAM latency=1
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE axis port=res_in
#pragma HLS INTERFACE axis port=res_out
#pragma HLS ARRAY_RESHAPE variable=toneinc complete dim=2
#pragma HLS ARRAY_RESHAPE variable=phase0 complete dim=2
#pragma HLS INTERFACE ap_ctrl_none port=return

	tone_t tones[N_RES_PCLK];
	phase_t phases[N_RES_PCLK];
	iq_t sincosines[N_RES_PCLK];
	resgroup_t resdat;
	group_t group;

	fetch_tones(res_in, toneinc, phase0, tones, group, resdat);
	increment_phases(group, tones, phases);
	phase_to_sincos(phases, sincosines);
	downconvert(resdat, sincosines, res_out);

}
