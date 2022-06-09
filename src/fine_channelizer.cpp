#include "fine_channelizer.hpp"
#include "dds.h"
#include <iostream>
//#include "hls_math.h"
using namespace std;


void cmpy(const iq_t a, const ddsiq_t b, iqout_t &o) {
#pragma HLS INLINE
      o.i=a.i*b.i-a.q*b.q;
      o.q=a.i*b.q+a.q*b.i;
}

void cmpy(sample_complex_t p_complexOp1, dds_complex_t p_complexOp2,
				dds_complex_t& p_product) {
#pragma HLS INLINE // recursive
    p_product.real(p_complexOp1.real() * p_complexOp2.real() - p_complexOp1.imag() * p_complexOp2.imag());
    p_product.imag(p_complexOp1.real() * p_complexOp2.imag() + p_complexOp1.imag() * p_complexOp2.real());
}

//void cmpy(sample_complex_t p_complexOp1, dds18_complex_t p_complexOp2,
//		sampleout_complex_t& p_product) {
//#pragma HLS PIPELINE II=1
//#pragma HLS INTERFACE mode=ap_ctrl_none port=return
////#pragma HLS INLINE // recursive
//    p_product.real(p_complexOp1.real() * p_complexOp2.real() - p_complexOp1.imag() * p_complexOp2.imag());
//    p_product.imag(p_complexOp1.real() * p_complexOp2.imag() + p_complexOp1.imag() * p_complexOp2.real());
//}

void cmpy(sample_complex_t p_complexOp1, dds18_complex_t p_complexOp2,
		sampleout_complex_t& p_product) {
	sample_t a,b;
	dds18_t c,d;
//	sampleout_t i,q;
#pragma HLS BIND_OP variable=a op=add impl=dsp
#pragma HLS BIND_OP variable=b op=add impl=dsp
#pragma HLS BIND_OP variable=c op=add impl=dsp
#pragma HLS BIND_OP variable=d op=add impl=dsp
#pragma HLS BIND_OP variable=a op=sub impl=dsp
#pragma HLS BIND_OP variable=b op=sub impl=dsp
#pragma HLS BIND_OP variable=c op=sub impl=dsp
#pragma HLS BIND_OP variable=d op=sub impl=dsp
#pragma HLS BIND_OP variable=a op=mul impl=dsp
#pragma HLS BIND_OP variable=b op=mul impl=dsp
#pragma HLS BIND_OP variable=c op=mul impl=dsp
#pragma HLS BIND_OP variable=d op=mul impl=dsp
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE mode=ap_ctrl_none port=return
//#pragma HLS INLINE

	a.range()=p_complexOp1.real().range();
	b.range()=p_complexOp1.imag().range();
	c.range()=p_complexOp2.real().range();
	d.range()=p_complexOp2.imag().range();

	p_product.real().range()=a*c-b*d;
	p_product.imag().range()=a*d+b*c;
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

void get_dds(const accgroup_t accg, iqgroup_uint_t &ddsg) {
#pragma HLS PIPELINE II=1
	p2sc: for (int i=0; i<N_RES_PCLK; i++) {
		acc_t acc;
		ddsiq32_t ddsv;
		acc.range()=accg.range(NBITS*(i+1)-1, NBITS*i);
		phase_to_sincos_wLUT(acc, ddsv);
		ddsg.range(32*(i+1)-1, 32*i)=ddsv.range();
	}
}


void ddc(const iqgroup_uint_t in, const iqgroup_uint_t ddsgroup, iqgroup_uint_t &out){
#pragma HLS PIPELINE II=1
	ddc: for (int i=0; i<N_RES_PCLK; i++) {
		sampleout_complex_t iqout;
//		iq_t iq;
//		ddsiq_t ddsv;
		dds_complex_t ddsv, tmp;
		sample_complex_t iq;
		iq.real().range()=in.range(32*(i+1)-1-16, 32*i);
		iq.imag().range()=in.range(32*(i+1)-1, 32*i+16);
//		iq.i.range()=in.range(32*(i+1)-1-16, 32*i);
//		iq.q.range()=in.range(32*(i+1)-1, 32*i+16);
		ddsv.real().range()=ddsgroup.range(32*(i+1)-1-16, 32*i);
		ddsv.imag().range()=ddsgroup.range(32*(i+1)-1, 32*i+16);
//		cmpy(iq, ddsv, iqout);
//		double>
		cmpy(iq, ddsv, tmp);
		iqout=tmp;
		out.range(32*(i+1)-1-16, 32*i)=iqout.real().range();
		out.range(32*(i+1)-1, 32*i+16)=iqout.imag().range();
	}
}


void ddsddc(const accgroup_t accg, const iqgroup_uint_t in, iqgroup_uint_t &out){
#pragma HLS PIPELINE II=1
	ddc: for (int i=0; i<N_RES_PCLK; i++) {

		acc_t acc;
		ddsiq32_t ddsv1;
		sampleout_complex_t iqout;

		dds_complex_t ddsv, tmp;
		sample_complex_t iq;
		acc.range()=accg.range(NBITS*(i+1)-1, NBITS*i);
		phase_to_sincos_wLUT(acc, ddsv1);


		iq.real().range()=in.range(32*(i+1)-1-16, 32*i);
		iq.imag().range()=in.range(32*(i+1)-1, 32*i+16);
		ddsv.real().range()=ddsv1.range(15, 0);
		ddsv.imag().range()=ddsv1.range(31, 16);
		cmpy(iq, ddsv, tmp);
		iqout=tmp;
		out.range(32*(i+1)-1-16, 32*i)=iqout.real().range();
		out.range(32*(i+1)-1, 32*i+16)=iqout.imag().range();
	}
}

void ddsddc2(const accgroup_t accg, const iqgroup_uint_t in, iqgroup_uint_t &out){
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE mode=ap_ctrl_none port=return
	acc_t acc[N_RES_PCLK];
	sample_complex_t iq[N_RES_PCLK];


#pragma HLS ARRAY_PARTITION variable=acc type=complete
#pragma HLS ARRAY_PARTITION variable=iq type=complete
//	dds18_complex_t ddsv1[N_RES_PCLK];
//	dds_complex_t ddsv[N_RES_PCLK];

//	dds_complex_t tmp[N_RES_PCLK];
//	sampleout_complex_t iqout[N_RES_PCLK];

//#pragma HLS ARRAY_PARTITION variable=ddsv1 type=complete
//#pragma HLS ARRAY_PARTITION variable=ddsv type=complete

//#pragma HLS ARRAY_PARTITION variable=iqout type=complete
//#pragma HLS ARRAY_PARTITION variable=tmp type=complete
	ddc: for (int i=0; i<N_RES_PCLK; i++) {

		dds18_complex_t ddsv;
		sampleout_complex_t iqout;
		acc[i].range()=accg.range(NBITS*(i+1)-1, NBITS*i);

//		acc[i]=.5;


		phase_to_sincos_wLUT(acc[i], ddsv);

		iq[i].real().range()=in.range(32*(i+1)-1-16, 32*i);
		iq[i].imag().range()=in.range(32*(i+1)-1, 32*i+16);

//		iq[i].real().range()=0x7fff;
//		iq[i].imag().range()=0;
		cmpy(iq[i], ddsv, iqout);

//		if (i==0) {
//			cout<<"Acc: "<<acc[i]<<" DDS: "<<ddsv<<" IQ:"<<iq[i]<<"  ="<<iqout[i]<<endl;
//			cout<<"  Bits: "<<std::hex<<acc[i].range().to_uint()<<" DDS.r="<<
//					ddsv.real().range().to_uint()<<", "<<
//					ddsv.imag().range().to_uint()<<" IQ:"<<
//					iq[i].real().range().to_uint()<<", "<<
//					iq[i].imag().range().to_uint()<<" IQout:"<<
//					iqout[i].real().range().to_uint()<<", "<<
//					iqout[i].imag().range().to_uint()<<endl;
//		}
		out.range(32*(i+1)-1-16, 32*i)=iqout.real().range();
		out.range(32*(i+1)-1, 32*i+16)=iqout.imag().range();
	}
}


void resonator_dds(hls::stream<axisdata_t> &res_in, hls::stream<axisdata_t> &res_out,
				  tonegroup_t tones[N_RES_GROUPS]) {

#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS INTERFACE s_axilite port=tones
#pragma HLS INTERFACE axis port=res_in register
#pragma HLS INTERFACE axis port=res_out register


//	while (!res_in.empty()) {
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
	//--------
	//Convert phase to sincos
	//--------
//	iqgroup_uint_t ddsg;   //alternative 1
//	get_dds(accg, ddsg);   //alternative 1
	//--------
	//Perform the DDC
	//--------
	iqgroup_uint_t out;
//	ddc(data_in.data, ddsg, out);   //alternative 1

	ddsddc2(accg, data_in.data, out);  //alternative 2

	//--------
	//Output
	//--------
	data_out.data = out;
	data_out.last = group == N_RES_GROUPS-1;
	data_out.user = group;
//#ifndef __SYNTHESIS__
//	double a,b,c,d;
//	a=data_in.data.range(15, 0).to_int();
//	b=data_in.data.range(31, 16).to_int();
//	c=data_out.data.range(15, 0).to_int();
//	d=data_out.data.range(31, 16).to_int();
//
//	cout<<"In mag:"<<sqrt(a*a+b*b)<<" Out mag:"<<sqrt(c*c+d*d)<<endl;
//#endif
	res_out.write(data_out);

	cycle++;
}
