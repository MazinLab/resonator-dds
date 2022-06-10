#include "fine_channelizer.hpp"
#include "dds.h"
#include <iostream>
#include "hls_math.h"
#include "ap_fixed.h"
using namespace std;


void cmpydds(sample_complex_t iq, dds_words_t dds, sampleout_complex_t& p_product, int res) {
	sample_t a,b;
	dds18_t c,d;
	lut_word_t cos_word;
	lut_word_t sin_word;
	fine_word_t fine_word;

	//#pragma HLS BIND_OP variable=c op=mul impl=dsp
//#pragma HLS BIND_OP variable=c op=add impl=dsp
//#pragma HLS BIND_OP variable=c op=sub impl=dsp
//
//#pragma HLS BIND_OP variable=d op=add impl=dsp
//#pragma HLS BIND_OP variable=d op=sub impl=dsp
//#pragma HLS BIND_OP variable=d op=mul impl=dsp

//#pragma HLS BIND_OP variable=sin_word op=mul impl=dsp
//#pragma HLS BIND_OP variable=sin_word op=add impl=dsp
//#pragma HLS BIND_OP variable=sin_word op=sub impl=dsp
//#pragma HLS BIND_OP variable=cos_word op=mul impl=dsp
//#pragma HLS BIND_OP variable=cos_word op=add impl=dsp
//#pragma HLS BIND_OP variable=cos_word op=sub impl=dsp
//#pragma HLS BIND_OP variable=fine_word op=mul impl=dsp
//#pragma HLS BIND_OP variable=fine_word op=add impl=dsp
//#pragma HLS BIND_OP variable=fine_word op=sub impl=dsp
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE mode=ap_ctrl_none port=return
//#pragma HLS INLINE

	a=iq.real();
	b=iq.imag();

//	c=dds.cos_word - dds.sin_word * dds.fine_word;
//	d=dds.sin_word + dds.cos_word * dds.fine_word;

	cos_word=dds.cos_word;
	sin_word=dds.sin_word;
	fine_word=dds.fine_word;
	c=cos_word - sin_word * fine_word;
	d=sin_word + cos_word * fine_word;
	dds18_t ac, ad, bd, bc;
	sampleout_t r,i;
//#pragma HLS BIND_OP variable=ab op=add impl=dsp
//#pragma HLS BIND_OP variable=ac op=add impl=dsp
//#pragma HLS BIND_OP variable=bd op=add impl=dsp
//#pragma HLS BIND_OP variable=i op=add impl=dsp
	ac=a*c;
	bd=b*d;
	ad=a*d;
	bc=b*c;
	r=ac-bd;
	i=ad+bc;

	p_product.real(r);
	p_product.imag(i);

//	p_product.real(dds18_t(a*c)-dds18_t(b*d));
//	p_product.imag(dds18_t(a*d)+dds18_t(b*c));

//	p_product.real(a*(dds.cos_word - dds.sin_word * dds.fine_word)-b*(dds.sin_word + dds.cos_word * dds.fine_word));
//	p_product.imag(a*(dds.sin_word + dds.cos_word * dds.fine_word)+b*(dds.cos_word - dds.sin_word * dds.fine_word));

//	p_product.real(a*(cos_word - sin_word * fine_word)-b*(sin_word + cos_word * fine_word));
//	p_product.imag(a*(sin_word + cos_word * fine_word)+b*(cos_word - sin_word * fine_word));


//	if (res==1) {
//		dds18_complex_t ddsv;
//		ddsv.real(c);
//		ddsv.imag(d);
//		complex<double> x,y,z, iqd,ddsd, resd;
//		x.real(dds.cos_word.to_double() - dds.sin_word.to_double() * dds.fine_word.to_double());
//		x.imag(dds.sin_word.to_double() - dds.cos_word.to_double() * dds.fine_word.to_double());
//		y.real(dds.cos_word - dds.sin_word * dds.fine_word);
//		y.imag(dds.sin_word - dds.cos_word * dds.fine_word);
//		iqd.real(a);
//		iqd.imag(b);
//		resd=x*iqd;
////		cout<<endl<<"DoubleDDS "<<x<<" y="<<y<<endl;
//		cout<<" DDS: "<<ddsv<<" IQ:"<<iq<<"  ="<<p_product<<" gold:"<<resd<<endl;
//		cout<<"  Bits: "<<std::hex<<" DDS="<<
//				ddsv.real().range().to_uint()<<", "<<
//				ddsv.imag().range().to_uint()<<" IQ:"<<
//				iq.real().range().to_uint()<<", "<<
//				iq.imag().range().to_uint()<<" IQout:"<<
//				p_product.real().range().to_uint()<<", "<<
//				p_product.imag().range().to_uint()<<endl;
//	}

}

void accumulate(const group_t group, const tonegroup_t tonesgroup, accgroup_t &accv){
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE mode=ap_ctrl_none port=return
	static accgroup_t accumulator[N_RES_GROUPS], acc;
	accumulator[group_t(group-1)]=acc;
	acc=accumulator[group];
	incp: for (int i=0; i<N_RES_PCLK; i++) {
		phase_t phase0;
		toneinc_t inc;
		acc_t tmp;
		inc.range()=tonesgroup.range(N_TONEBITS*(i+1)-1, N_TONEBITS*i);
		phase0.range()=tonesgroup.range(N_P0BITS*(i+1)-1+N_TONEBITS*N_RES_PCLK,N_P0BITS*i+N_TONEBITS*N_RES_PCLK);
		tmp.range()=acc.range(NBITS*(i+1)-1, NBITS*i);
		accv.range(NBITS*(i+1)-1, NBITS*i) = acc_t(tmp+phase0).range();
		acc.range(NBITS*(i+1)-1, NBITS*i) = acc_t(tmp+inc).range();
	}
}


void ddsddc(const accgroup_t accg, const iqgroup_uint_t in, iqgroup_uint_t &out){
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE mode=ap_ctrl_none port=return

	ddc: for (int i=0; i<N_RES_PCLK; i++) {
		dds_words_t ddsv;
		sampleout_complex_t iqout;
		acc_t acc;
		sample_complex_t iq;

		acc.range()=accg.range(NBITS*(i+1)-1, NBITS*i);
//		acc=.5;

		phase_to_sincos_wLUT(acc, ddsv);

		iq.real().range()=in.range(32*(i+1)-16-1, 32*i);
		iq.imag().range()=in.range(32*(i+1)-1, 32*i+16);
//		if (i==1) {
//			cout<<"Acc: "<<acc;
//		}

//		iq[i].real().range()=0x7fff;
//		iq[i].imag().range()=0;
		cmpydds(iq, ddsv, iqout, i);
		out.range(32*(i+1)-16-1, 32*i)=iqout.real().range();
		out.range(32*(i+1)-1, 32*i+16)=iqout.imag().range();

	}
}


void resonator_dds(hls::stream<axisdata_t> &res_in, hls::stream<axisdata_t> &res_out,
				  tonegroup_t tones[N_RES_GROUPS]) {

#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS INTERFACE s_axilite port=tones
#pragma HLS INTERFACE axis port=res_in register
#pragma HLS INTERFACE axis port=res_out register


	while (!res_in.empty()) {  //For csim
#pragma HLS PIPELINE II=1

	static group_t cycle;
	group_t group;
	axisdata_t data_in, data_out;

	//-----------
	//Tone and accumulator fetching
	//-----------
	res_in.read(data_in);
	group = cycle;


	//--------
	//Compute phase value
	//--------
	accgroup_t accg;
	accumulate(group, tones[group], accg);

//	if (group!=33) {
//		res_out.write(data_out);
//		cycle++;
//		continue;
//	}

	//--------
	//Perform the DDC
	//--------
	iqgroup_uint_t out;
	ddsddc(accg, data_in.data, out);

	//--------
	//Output
	//--------
	data_out.data = out;
	data_out.last = group == N_RES_GROUPS-1;
	data_out.user = group;
	res_out.write(data_out);

	//Increment cycle
	cycle++;

	//#ifndef __SYNTHESIS__
	//	double a,b,c,d;
	//	a=data_in.data.range(15, 0).to_int();
	//	b=data_in.data.range(31, 16).to_int();
	//	c=data_out.data.range(15, 0).to_int();
	//	d=data_out.data.range(31, 16).to_int();
	//
	//	cout<<"In mag:"<<sqrt(a*a+b*b)<<" Out mag:"<<sqrt(c*c+d*d)<<endl;
	//#endif

	}

}
