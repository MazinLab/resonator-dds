#ifndef DDS_H_
#define DDS_H_
#include "ap_fixed.h"
#include "hls_math.h"


// phase accumulator 
#define NBITS 21  //must be no less than NLUT+NFINE+2

//typedef ap_fixed<NBITS,1> incr_t;  // s.xxxx, +/- 1 = +/- pi = +fs/2 to -fs/2
typedef ap_fixed<NBITS,1> acc_t;   // s.xxxx, +/- 1 = +/- pi = +fs/2 to -fs/2


//NB cos table bits is LUTSIZE*17 so up to 1024 will be only one bram and the fine table is similar
// so we dont save by going smaller

// cos lut address, word size
const int NLUT     = 10;               // bitwidth for cos lut address, covers one quadrant
const int LUTSIZE  = 1024;             // 2^NLUT

// fine lut address, word size
const int NFINE     = 9;               // bitwidth for fine lut address, covers one quadrant
const int FINESIZE  = 512;             // 2^NFINE

const double DELTA = M_PI/(2*LUTSIZE*FINESIZE); // fine lut resolution, range covers 0 to pi/(2*LUTSIZE)

typedef ap_uint<NLUT+2> lut_adr_t;     // covers 4 quadrant
typedef ap_uint<NLUT>   quad_adr_t;    // covers 1 quadrant
typedef ap_uint<NFINE>  fine_adr_t;    // covers 4 quadrant

// rounding makes huge difference in the noise floor
typedef ap_fixed<18,1,AP_RND_CONV,AP_SAT_SYM> lut_word_t;
typedef ap_fixed<18,-7> fine_word_t;


typedef struct {
	lut_word_t cos_word;
	lut_word_t sin_word;
	fine_word_t fine_word;
} dds_words_t;

void phase_sincos_LUT(acc_t acc, dds_words_t &out);
void phase_sincos_LUT_wstatic(acc_t acc, dds_words_t &out);
#endif

/************************************************
Copyright (c) 2016, Xilinx, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors
may be used to endorse or promote products derived from this software
without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
************************************************/
