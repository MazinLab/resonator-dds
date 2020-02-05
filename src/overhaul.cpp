//#ifndef __fine_channelizer_h__
//#define __fine_channelizer_h__
//
//#include "ap_int.h"
//#include "hls_stream.h"
//#include "ap_fixed.h"
//#include <complex>
//#include "hls_dsp.h"
//#include <math.h>
//#include "ap_shift_reg.h"
//
//#define N_GROUPS 256
//#define N_RES_PCLK 8
//#define LUT_LENGTH 16384
//#define N_RES 2048
//
//
//
//typedef ap_fixed<16, 1, AP_RND_CONV, AP_WRAP> toneinc_t;
//typedef ap_ufixed<16, 0, AP_RND_CONV, AP_WRAP> phase_t; //0-1 wrap
//typedef ap_fixed<16, 1, AP_RND_CONV, AP_SAT> sample_t;
//typedef std::complex<sample_t> iq_t;
//
//typedef ap_uint<8> group_t;
//
//typedef struct {
//	iq_t iq[N_RES_PCLK];
//} iqgroup_t;
//
//typedef struct {
//	iq_t data[N_RES_PCLK];
//	ap_uint<1> last;
//} resstream_t;
//
//typedef struct {
//	phase_t phase0;
//	toneinc_t inc;
//} tonedat_t;
//
//typedef struct {
//	phase_t phases[N_RES_PCLK];
//} phasegroup_t;
//
//void fine_channelizer(resstream_t &res_in, resstream_t &res_out, toneinc_t tone_inc_table[N_RES], phase_t phase0[N_RES]);
//
//#endif
//
//
//#include "fine_channelizer.hpp"
//#include <iostream>
//using namespace std;
//
//
//
////TODO try using DATA_PACK in more places (e.g. on more phase_t phases[N_RES_PCLK])
//
//void fetch_tones(resstream_t &input, toneinc_t tone_inc[N_RES], phase_t phase0[N_RES], tonedat_t tone[N_RES_PCLK], resstream_t &resdat){
//
//	static group_t group;
//	resdat=input;
//
////	toneinc_t cache[N_RES_PCLK];
////	memcpy(cache, tone_inc+group*N_RES_PCLK, N_RES_PCLK*sizeof(toneinc_t));
////	for (int i=0; i<N_RES_PCLK; i++) cache[i]=tone_inc[i+group*N_RES_PCLK];
//
//	tonetable: for (int i=0; i<N_RES_PCLK; i++) {
//#pragma HLS UNROLL
//		tone[i].inc=tone_inc[i+group*N_RES_PCLK];
//		tone[i].phase0=phase0[i+group*N_RES_PCLK];
//		#ifndef __SYNTHESIS__
//		cout<<"Fetched "<<dec<<tone[i].inc.to_double()<<","<<dec<<tone[i].phase0.to_double()<<" for "<<group.to_int()<<":"<<i<<endl;
//		#endif
//	}
//
//	group = resdat.last ? group_t(0) : group_t(group+1);
//}
//
//#include "ap_shift_reg.h"
//void increment_phases_sreg(tonedat_t tones[N_RES_PCLK], phase_t phases[N_RES_PCLK]) {
//	static ap_shift_reg<phasegroup_t, N_GROUPS> phase_shifter;
//	phasegroup_t cache=phase_shifter.read(255);
//	phaseincsr: for (int i=0; i<N_RES_PCLK; i++) {
//#pragma HLS UNROLL
//		cache.phases[i]+=tones[i].inc;
//		phases[i]=cache.phases[i]+tones[i].phase0;
//	}
//	phase_shifter.shift(cache);
//}
//
////void increment_phases(group_t group, tonedat_t tones[N_RES_PCLK], phase_t phases[N_RES_PCLK]) {
////	//Use a cache round robin
////
////	static phasegroup_t phases_delay_line[N_GROUPS];
////#pragma HLS DATA_PACK variable=phases_delay_line	//Doing this gives a slight resource savings
//////#pragma HLS DEPENDENCE variable=phases_delay_line  //dependence is true but with a distance=N_RES_GROUPS, so ignore
////
////	phasegroup_t cache=phases_delay_line[group];
////
////	phaseinc: for (int i=0; i<N_RES_PCLK; i++) {
////#pragma HLS UNROLL
////		cache.phases[i]+=tones[i].inc;
////		phases[i]=cache.phases[i]+tones[i].phase0;
////	}
////	phases_delay_line[group]=cache;
////}
//
//
//
//void init_sincostable(sample_t lut[LUT_LENGTH][2]) {
//	// Populate the SINCOS LUT, will be synthesized away
//	double f;
//	populatelut: for (unsigned int i=0; i<LUT_LENGTH;i++){
//		f=M_PI/2.0*((double)i)/(LUT_LENGTH-1);
//		lut[i][0]=cos(f);
//		lut[i][1]=sin(f);
//	}
//}
//
//void sincoslut_query(unsigned int intphase, iq_t &lutv) {
//	static sample_t lut[LUT_LENGTH][2];
//#pragma HLS ARRAY_PARTITION variable=lut complete dim=2
//// #pragma HLS RESOURCE variable=lut core=ROM_2P
//	#pragma HLS DATA_PACK variable=lut
//	init_sincostable(lut);
//	lutv=iq_t(lut[intphase][0], lut[intphase][0]);
//}
//
//void phase_to_sincos(phase_t phases[N_RES_PCLK], iq_t sincosines[N_RES_PCLK]) {
//	//Convert a phase value to a sine,cosine value
//	phase2sincos: for (int i=0; i<N_RES_PCLK; i++) {
//#pragma HLS UNROLL
//		phase_t phase=phases[i];
//		iq_t lutv;
////		unsigned int intphase = (ap_fixed<32, 16>(phase)*4*(LUT_LENGTH-1)).to_uint();
//		unsigned int intphase = (phase*(4*(LUT_LENGTH-1))).to_uint();
//
//		#ifndef __SYNTHESIS__
//		cout<<"Converted phase "<<phase.to_double()<<" to "<<intphase;
//		#endif
//
//		if (intphase>=LUT_LENGTH && intphase<=2*(LUT_LENGTH-1)) { //Q2 intphase in LUT_LENGTH-2*LUT_LENGTH
//			sincoslut_query(2*(LUT_LENGTH-1)-intphase, lutv);
//			lutv.real()*=-1;
//
//			#ifndef __SYNTHESIS__
//			cout<<" (Q2). Found "<<lutv<<"."<<endl;
//			#endif
//
//		} else if (intphase>2*(LUT_LENGTH-1) && intphase<3*(LUT_LENGTH-1)) { //Q3 intphase in 2*LUT_LENGTH-3*LUT_LENGTH
//			sincoslut_query(intphase-2*(LUT_LENGTH-1), lutv);
//			lutv.real()*=-1;
//			lutv.imag()*=-1;
//
//			#ifndef __SYNTHESIS__
//			cout<<" (Q3). Found "<<lutv<<"."<<endl;
//			#endif
//
//		} else if (intphase>=3*(LUT_LENGTH-1)) { //Q4
//			sincoslut_query(4*(LUT_LENGTH-1)-intphase, lutv);
//			lutv.imag()*=-1;
//
//			#ifndef __SYNTHESIS__
//			cout<<" (Q4). Found "<<lutv<<"."<<endl;
//			#endif
//
//		} else {
//			sincoslut_query(intphase, lutv);
//
//			#ifndef __SYNTHESIS__
//			cout<<" (Q1). Found "<<lutv<<"."<<endl;
//			#endif
//
//		}
//		sincosines[i]=lutv;
//	}
//}
//
//
//void downconvert(resstream_t resdat, iq_t sincosines[N_RES_PCLK], resstream_t &output) {
//	//ROUND_MODE Values : AP_RND, AP_RND_ZERO, AP_RND_MIN_INF, AP_RND_INF, AP_RND_CONV, AP_TRN, AP_TRN_ZERO
//	//OVERFLOW_MODE Values : AP_SAT, AP_SAT_ZERO, AP_SAT_SYM, AP_WRAP, AP_WRAP_SM
//
//	iq_t iq_out[N_RES_PCLK];
//	ddsx8: for (int i=0; i<N_RES_PCLK; i++){
//#pragma HLS UNROLL
//		hls::cmpy<hls::CmpyFourMult, 16, 1, AP_RND_CONV, AP_SAT, 0, 16, 1, AP_RND_CONV, AP_SAT, 0>
//			(resdat.data[i], sincosines[i], iq_out[i]);
//	}
//
//	copyout: for (int i=0; i<N_RES_PCLK; i++) output.data[i]=iq_out[i];
//	output.last=resdat.last;
//}
//
//
//void resonator_dds(resstream_t &res_in, resstream_t &res_out, toneinc_t tonetable[N_RES], phase_t phase0[N_RES])  {
//#pragma HLS PIPELINE II=1
//#pragma HLS INTERFACE axis port=res_in
//#pragma HLS INTERFACE axis port=res_out
//#pragma HLS DATA_PACK variable=res_in
//#pragma HLS DATA_PACK variable=res_out
//#pragma HLS INTERFACE s_axilite port=tonetable bundle=tone_data
//#pragma HLS INTERFACE s_axilite port=phase0 bundle=tone_data
//#pragma HLS ARRAY_RESHAPE variable=tonetable cyclic factor=8 dim=1
//#pragma HLS ARRAY_RESHAPE variable=phase0 cyclic factor=8 dim=1
////#pragma HLS INTERFACE ap_ctrl_none port=return
//
//	tonedat_t tones[N_RES_PCLK];
//	phase_t phases[N_RES_PCLK];
//	iq_t sincosines[N_RES_PCLK];
//	resstream_t temp_in;
//
//	fetch_tones(res_in, tonetable, phase0, tones, temp_in);
//	increment_phases_sreg(tones, phases);
//	phase_to_sincos(phases, sincosines);
//	downconvert(temp_in, sincosines, res_out);
//
//}
