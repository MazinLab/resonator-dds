#ifndef __fine_channelizer_h__
#define __fine_channelizer_h__

#include "ap_int.h"
#include "hls_stream.h"
#include "ap_fixed.h"
#include <complex>
#include "hls_dsp.h"
#include <math.h>
#include "ap_shift_reg.h"
#include "dds.h"

#define N_RES_GROUPS 256
#define N_RES_PCLK 8

typedef ap_uint<3> lane_t;
typedef ap_uint<8> group_t;
typedef ap_fixed<16, -9, AP_RND_CONV, AP_SAT_SYM> sample_t;
typedef ap_fixed<16, -7, AP_RND_CONV, AP_SAT_SYM> sampleout_t;
typedef ap_fixed<16, 1, AP_RND_CONV, AP_WRAP> toneinc_t;
typedef ap_fixed<16, 1, AP_RND_CONV, AP_WRAP> phase_t; //0-1 wrap

typedef struct {
	sample_t i;
	sample_t q;
} iq_t;

typedef struct {
	sampleout_t i;
	sampleout_t q;
} iqout_t;

typedef struct {
	sample_t i[N_RES_PCLK];
	sample_t q[N_RES_PCLK];
} iqgroup_t;

typedef struct {
	dds_t i[N_RES_PCLK];
	dds_t q[N_RES_PCLK];
} ddsgroup_t;

typedef struct {
	sampleout_t i[N_RES_PCLK];
	sampleout_t q[N_RES_PCLK];
} iqgroupout_t;

typedef struct {
	sample_t data[2*N_RES_PCLK];
	ap_uint<1> last;
	group_t user;
} resgroup_t;

typedef struct {
	sampleout_t data[2*N_RES_PCLK];
	ap_uint<1> last;
	group_t user;
} resgroupout_t;

typedef struct {
	toneinc_t inc;
	phase_t phase0;
} tone_t;

typedef struct {
	toneinc_t inc[N_RES_PCLK];
	phase_t phase0[N_RES_PCLK];
} tonegroup_t;

typedef struct {
	acc_t phases[N_RES_PCLK];
} accgroup_t;

void resonator_dds(resgroup_t &res_in, resgroupout_t &res_out,
		tonegroup_t tones[N_RES_GROUPS], bool generate_tlast);
#endif
