#include "dds.h"

#ifdef __SYNTHESIS__
#include <iostream>
using namespace std;
#endif

void phase_to_sincos_wLUT(acc_t acc, ddsiq_t* out) {
	#pragma HLS PIPELINE

	//Init LUTs
	static lut_word_t cos_lut[LUTSIZE];
	static fine_word_t fine_lut[FINESIZE];
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

//________________ look up cos/sine table
	full_adr = acc(NBITS, NBITS-NLUT-1);  //12 bits
	fine_adr = acc(NBITS-NLUT-2, NBITS-NLUT-NFINE-1);  //9 bits

	msb      = full_adr(NLUT+1,NLUT); //2 bits
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

    ddsiq_t tmpout;
    tmpout.i = cos_lut_word - sin_lut_word * fine_word;
    tmpout.q = sin_lut_word + cos_lut_word * fine_word;

    *out=tmpout;

}


void phase_to_sincos(acc_t acc, lut_word_t cos_lut[LUTSIZE], fine_word_t fine_lut[FINESIZE],
					 ddsiq_t* out) {
#pragma HLS PIPELINE
	fine_adr_t fine_adr;
	fine_word_t fine_word;

	lut_adr_t  full_adr;         // cover full quadrant
	quad_adr_t lsb;              // cover 1/4 quadrant
	quad_adr_t cos_adr, sin_adr;

	ap_uint<2>  msb;             // specify which quadrant
	lut_word_t  cos_lut_word;
	lut_word_t  sin_lut_word;

//________________ look up cos/sine table
	full_adr = acc(NBITS, NBITS-NLUT-1);  //12 bits
	fine_adr = acc(NBITS-NLUT-2, NBITS-NLUT-NFINE-1);  //9 bits

	msb      = full_adr(NLUT+1,NLUT); //2 bits
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

    ddsiq_t tmpout;
    tmpout.i = cos_lut_word - sin_lut_word * fine_word;
    tmpout.q = sin_lut_word + cos_lut_word * fine_word;

    *out=tmpout;

}


//______________________________________________________________________________ 
void init_cos_lut( lut_word_t cos_lut[LUTSIZE], const int LUTSIZE ){

	double cos_double;

	// #define FULL
	//________________________________
	#ifdef MIDPOINT
	// store single quadrant
	  for (int i=0;i<LUTSIZE;i++) {
		  //cos_double = cos(2*M_PI*(0.0+(double)i)/(4*LUTSIZE));
		  cos_double = cos(2*M_PI*(0.5+(double)i)/(4*LUTSIZE));
		  cos_lut[i] = cos_double;
		  fp_dout << scientific << cos_double <<endl;
	  }


	#ifdef FULL
	// store full quadrant
	ofstream fp_ideal ("ideal.txt");
	  for (int i=0;i<4*LUTSIZE;i++) {
		  cos_double = cos(2*M_PI*(0.5+(double)i)/(4*LUTSIZE));
		  fp_ideal << scientific << cos_double <<endl;
	  }
	#endif

	//________________________________
	// not the mid point
	#else
	// store single quadrant
	  for (int i=0;i<LUTSIZE;i++) {
		  cos_double = cos(2*M_PI*(0.0+(double)i)/(4*LUTSIZE));
		  cos_lut[i] = cos_double;
		  //fp_dout << scientific << cos_double <<endl;
	  }

	#ifdef FULL
	// store full quadrant
	ofstream fp_ideal ("ideal.txt");
	  for (int i=0;i<4*LUTSIZE;i++) {
		  cos_double = cos(2*M_PI*(0.0+(double)i)/(4*LUTSIZE));
		  fp_ideal << scientific << cos_double <<endl;
	  }
	#endif


	#endif
}




void init_fine_lut( fine_word_t fine_lut[FINESIZE], 
                    const int FINESIZE, const double delta ) {

	//double fine_double;
	double sine_double;
	//ofstream fp_dout ("fine.txt");

	  for (int i=0;i<FINESIZE;i++) {
		  //fine_double = cos(delta*(double)i);
		  sine_double = sin(delta*(double)i);
		  fine_lut[i] = sine_double;
		  //fp_dout << scientific << fine_double <<", " << scientific << sine_double <<endl;
	  }
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


