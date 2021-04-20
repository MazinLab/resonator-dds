#ifndef __fine_channelizer_h__
#define __fine_channelizer_h__

#include "ap_int.h"
#include "hls_stream.h"
#include "ap_fixed.h"
#include <complex>
#include "hls_dsp.h"
#include "hls_math.h"
#include "ap_shift_reg.h"
#include "dds.h"
#include "axi.h"

#define N_RES_GROUPS 256
#define N_RES_PCLK 8
#define N_TONEBITS 11
#define N_P0BITS 21

typedef ap_uint<8> group_t;
typedef ap_fixed<16, -9, AP_RND_CONV, AP_SAT_SYM> sample_t;  //-9
typedef ap_fixed<16, -7, AP_RND_CONV, AP_SAT_SYM> sampleout_t; //-7
typedef ap_fixed<N_TONEBITS, 1, AP_RND_CONV, AP_WRAP> toneinc_t;
typedef ap_fixed<N_P0BITS, 1, AP_RND_CONV, AP_WRAP> phase_t; //-1-1 wrap
typedef ap_uint<256> iqgroup_uint_t;

typedef struct {
	sample_t i;
	sample_t q;
} iq_t;

typedef ap_uint<32> iq32_t;

typedef struct {
	sampleout_t i;
	sampleout_t q;
} iqout_t;

typedef struct {
	complex<sampleout_t> data[N_RES_PCLK];
	bool last;
	group_t user;
} resgroupout_t;

typedef struct {
	toneinc_t inc;
	phase_t phase0;
} tone_t;

typedef ap_axiu<256,8,0,0> axisdata_t;

typedef ap_uint<(N_P0BITS+N_TONEBITS)*N_RES_PCLK> tonegroup_t;

typedef ap_uint<NBITS*N_RES_PCLK> accgroup_t;

void resonator_dds(hls::stream<axisdata_t> &res_in, hls::stream<axisdata_t> &res_out,
		tonegroup_t tones[N_RES_GROUPS]);
#endif
