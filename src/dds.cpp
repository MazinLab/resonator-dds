#include "dds.h"


static void init_cos_lut( lut_word_t cos_lut[LUTSIZE], const int LUTSIZE ){
	double cos_double;
	for (int i=0;i<LUTSIZE;i++) {
		cos_double = hls::cordic::cos(2*M_PI*(0.0+(double)i)/(4*LUTSIZE));
		cos_lut[i] = cos_double;
	}
}


static void init_fine_lut( fine_word_t fine_lut[FINESIZE], const int FINESIZE, const double delta ) {
	double sine_double;
	for (int i=0;i<FINESIZE;i++) {
		sine_double = hls::cordic::sin(delta*(double)i);
		fine_lut[i] = sine_double;
	}
}


void phase_sincos_LUT(acc_t acc, dds_words_t &out) {
#pragma HLS INTERFACE mode=ap_ctrl_none port=return
#pragma HLS AGGREGATE variable=out
#pragma HLS PIPELINE II=1

	//Init LUTs
	lut_word_t cos_lut[LUTSIZE];
	fine_word_t fine_lut[FINESIZE];
	init_cos_lut( cos_lut, LUTSIZE );
	init_fine_lut( fine_lut, FINESIZE, DELTA );


	fine_adr_t fine_adr;
	fine_word_t fine_word;

	lut_adr_t  full_adr;         // cover full quadrant
	quad_adr_t lsb;              // cover 1/4 quadrant
	quad_adr_t cos_adr, sin_adr;

	ap_uint<2>  msb;             // specify which quadrant
	lut_word_t  cos_lut_word;
	lut_word_t  sin_lut_word;

	// look up cos/sine table
	full_adr = acc(NBITS-1, NBITS-NLUT-2);  //12 bits  21,10
	fine_adr = acc(NBITS-NLUT-3, NBITS-NLUT-NFINE-2);  //9 bits  9, 0

	msb      = full_adr(NLUT+1, NLUT); //2 bits
	lsb      = full_adr(NLUT-1,0); //10 bits, quadrant ndx

    // right top
    if (msb==0) {
       cos_adr      = lsb;
       cos_lut_word = cos_lut[cos_adr];

       if (lsb==0) sin_lut_word = 0;
       else {
         sin_adr      = -lsb;
         sin_lut_word =  cos_lut[sin_adr];
       }

    // left top
    } else if (msb==1) {
       if (lsb==0) cos_lut_word = 0;
       else {
         cos_adr      = -lsb;
         cos_lut_word = -cos_lut[cos_adr];
       }

       sin_adr      = lsb;
       sin_lut_word = cos_lut[sin_adr];

    // right bot
    } else if (msb==3) {
       if (lsb==0) cos_lut_word = 0;
       else {
         cos_adr      = -lsb;
         cos_lut_word =  cos_lut[cos_adr];
       }
         sin_adr      =  lsb;
         sin_lut_word = -cos_lut[sin_adr];

    // left bot
    } else             {
         cos_adr      =  lsb;
         cos_lut_word = -cos_lut[cos_adr];

       if (lsb==0) sin_lut_word = 0;
       else {
         sin_adr      = -lsb;
         sin_lut_word = -cos_lut[sin_adr];
       }
    }

    fine_word = fine_lut[fine_adr];

    dds_words_t tout;
    tout.cos_word=cos_lut_word;
    tout.sin_word=sin_lut_word;
    tout.fine_word=fine_word;
    out=tout;
//    out.real(cos_lut_word - sin_lut_word * fine_word);
//    out.imag(sin_lut_word + cos_lut_word * fine_word);

}





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


//______________________________________________________________________________
// dds.cpp:
// - barebone direct digital synthesizer
//
//
// a. paek, sep 2013
//______________________________________________________________________________


