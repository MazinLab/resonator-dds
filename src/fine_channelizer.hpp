#ifndef __fine_channelizer_h__
#define __fine_channelizer_h__

#include "ap_int.h"
#include "hls_stream.h"
#include "ap_fixed.h"
#include <complex>
#include "hls_dsp.h"
#include <math.h>
#include "ap_shift_reg.h"

#define N_RES_GROUPS 256
#define N_RES_PCLK 8
#define LUT_LENGTH 16384

typedef ap_fixed<16, 1, AP_RND_CONV, AP_SAT> sample_t;
typedef struct {
	sample_t i;
	sample_t q;
} iq_t;

typedef ap_uint<8> group_t;

typedef struct {
	iq_t iq[N_RES_PCLK];
} iqgroup_t;

typedef struct {
	iqgroup_t data;
	group_t user;
} resgroup_t;


typedef ap_fixed<16, 1, AP_RND_CONV, AP_WRAP> toneinc_t;
typedef ap_ufixed<16, 0, AP_RND_CONV, AP_WRAP> phase_t; //0-1 wrap

typedef struct {
	toneinc_t inc;
	phase_t phase;
} tone_t;

typedef struct {
	phase_t phases[N_RES_PCLK];
} phasegroup_t;

void resonator_dds(resgroup_t &res_in, resgroup_t &res_out, toneinc_t tone_inc_table[N_RES_GROUPS][N_RES_PCLK]);

#endif
