#include "fine_channelizer.hpp"
#include "dds.h"
#include <iostream>
#include "hls_math.h"
#include "ap_fixed.h"
using namespace std;

const int n_res_group=N_RES_GROUPS;

void dds(dds_words_t dds, dds_complex_t &ddsv) {
#pragma HLS INLINE
	dds_t i,r;
#pragma HLS BIND_OP variable=i op=add
#pragma HLS BIND_OP variable=i op=sub
#pragma HLS BIND_OP variable=r op=add
#pragma HLS BIND_OP variable=r op=sub
	r=dds.cos_word - dds.sin_word * dds.fine_word;
	i=dds.sin_word + dds.cos_word * dds.fine_word;
	ddsv.real(r);
	ddsv.imag(i);
}


void cmpysub(sample_complex_t iq, sample_complex_t center, dds_complex_t dds, sampleout_complex_t& p_product) {
#pragma HLS INLINE

	sampleout_t r,i;
#pragma HLS BIND_OP variable=i op=add
#pragma HLS BIND_OP variable=i op=sub
#pragma HLS BIND_OP variable=r op=add
#pragma HLS BIND_OP variable=r op=sub
	ap_fixed<34, 2, AP_RND_CONV, AP_SAT_SYM> ac, ad;

	ac=iq.real()*dds.real();
	ad=iq.real()*dds.imag();
	r=ac-iq.imag()*dds.imag()-center.real();
	i=ad+iq.imag()*dds.real()-center.imag();
	p_product.real(r);
	p_product.imag(i);
//#ifndef __SYNTHESIS__
//	cout<<"-----\nIQ * DDS - Center = result"<<endl;
//	cout<<iq<<" * "<<dds<<" - "<<center<<" = "<<p_product<<endl;
//	cout<<"ac: "<<ac<<" bd: "<<iq.imag()*dds.imag()<<" r:"<<ac-iq.imag()*dds.imag()-center.real()<<endl;
//
//	cout<<"IQ: "<<iq.real().range().to_int()<<" DDS: "<<dds.real().range().to_int()<<" Ctr:"<<center.real().range().to_int()<<endl;
//	cout<<"ac: "<<ac.range().to_int64()<<" bd: "<<(iq.imag()*dds.imag()).range().to_int64()<<" r: "<<r.range().to_int64()<<endl;
//	cout<<"Result: "<<p_product.real().range().to_int()<<"\n-----"<<endl;
//#endif

}


void _ddsddc(acc_t acc, sample_complex_t iq, loopcenter_t center, sampleout_complex_t &iqout) {
#pragma HLS INLINE
	sampleout_complex_t tmp;
	dds_words_t ddsv;
	dds_complex_t dds_sincos;
	phase_sincos_LUT(acc, ddsv);
	dds(ddsv, dds_sincos);
	cmpysub(iq, center, dds_sincos, iqout);
}


void memory_fetcher(hls::stream<axisdata_t> &res_in, loopcenter_group_t centergroups[N_RES_GROUPS], tonegroup_t tones[N_RES_GROUPS],
		hls::stream<iqgroup_uint_t> &iq, hls::stream<loopcenter_group_t> &centergroup, hls::stream<tonegroup_t> &tonegroup
		//,hls::stream<group_t> &groupout, hls::stream<bool> &done
		) {

//	inrun: while(!res_in.empty()) {
	fetchsamp: for (int _samp=0;_samp<N_CYCLES;_samp++) {
//#pragma HLS PIPELINE II=n_res_group REWIND
	fetchrun: for (int group=0;group<N_RES_GROUPS;group++) {
#pragma HLS PIPELINE II=1 REWIND
		axisdata_t data_in;
		res_in.read(data_in);
		centergroup.write(centergroups[group]);//data_in.user]);
		tonegroup.write(tones[group]);//data_in.user]);
		iq.write(data_in.data);
		//groupout.write(i);//data_in.user);
//		done.write(false);
	}
	}
//	done.write(true);
}


void accumulate(//hls::stream<bool> &stop, hls::stream<group_t> &groupin,
		hls::stream<tonegroup_t> &tones, hls::stream<accgroup_t> &accv//, hls::stream<group_t> &groupout, hls::stream<bool> &done
		){

//#pragma HLS INTERFACE mode=ap_ctrl_none port=return

	static accgroup_t accumulator[N_RES_GROUPS];
#pragma HLS DEPENDENCE dependent=true direction=RAW distance=256 type=inter variable=accumulator

//	for (int i=0;i<N_RES_GROUPS;i++) accumulator[i]=0;

//	accrun: while (!stop.read()) {
	accsamp: for (int _samp=0;_samp<N_CYCLES;_samp++) {
//#pragma HLS PIPELINE II=n_res_group REWIND
	acc: for (int group=0;group<N_RES_GROUPS;group++) {
#pragma HLS PIPELINE II=1 REWIND

		accgroup_t _accv,_acc;
		tonegroup_t tonesgroup;
		accgroup_t acc;

//		group_t group;
//		groupin.read(group);
		tones.read(tonesgroup);
		acc=accumulator[group];

		incp: for (int i=0; i<N_RES_PCLK; i++) {
			phase_t phase0;
			toneinc_t inc;
			acc_t tmp;
			inc.range()=tonesgroup.range(N_TONEBITS*(i+1)-1, N_TONEBITS*i);
			phase0.range()=tonesgroup.range(N_P0BITS*(i+1)-1+N_TONEBITS*N_RES_PCLK,N_P0BITS*i+N_TONEBITS*N_RES_PCLK);
			tmp.range()=acc.range(NBITS*(i+1)-1, NBITS*i);
			_accv.range(NBITS*(i+1)-1, NBITS*i) = acc_t(tmp+phase0).range();
			_acc.range(NBITS*(i+1)-1, NBITS*i) = acc_t(tmp+inc).range();
		}

		accumulator[group]=_acc;
		accv.write(_accv);
//		groupout.write(group);
//		done.write(false);
	}
	}
//	done.write(true);
}


void ddsddc(//hls::stream<bool> &done, hls::stream<group_t> &groupin,
		hls::stream<accgroup_t> &accgs, hls::stream<iqgroup_uint_t> &in,
		hls::stream<loopcenter_group_t> &centergroup,
		hls::stream<axisdata_t> &res_out) {

//#pragma HLS INTERFACE mode=ap_ctrl_none port=return


//	ddsrun: while (!done.read()) {
	ddssamp: for (int _samp=0;_samp<N_CYCLES;_samp++) {
//#pragma HLS PIPELINE II=n_res_group REWIND
	ddsrun: for (int group=0;group<N_RES_GROUPS;group++) {
#pragma HLS PIPELINE II=1 REWIND
		iqgroup_uint_t inv, _out;
		accgroup_t accg;
		loopcenter_group_t centergroupv;
		axisdata_t data_out;

//		group_t group;
//		groupin.read(group);
		accgs.read(accg);
		centergroup.read(centergroupv);
		in.read(inv);

		ddc: for (int i=0; i<N_RES_PCLK; i++) {
			sampleout_complex_t iqout;
			acc_t acc;
			sample_complex_t iq;
			loopcenter_t center;

			acc.range()=accg.range(NBITS*(i+1)-1, NBITS*i);

			iq.real().range()=inv.range(32*(i+1)-16-1, 32*i);
			iq.imag().range()=inv.range(32*(i+1)-1, 32*i+16);

			center.real().range()=centergroupv.range(32*(i+1)-16-1, 32*i);
			center.imag().range()=centergroupv.range(32*(i+1)-1, 32*i+16);

			_ddsddc(acc, iq, center, iqout);

			_out.range(32*(i+1)-16-1, 32*i)=iqout.real().range();
			_out.range(32*(i+1)-1, 32*i+16)=iqout.imag().range();
		}

		data_out.data = _out;
		data_out.last = group == N_RES_GROUPS-1;
		data_out.user = group;
		res_out.write(data_out);
	}
	}
}


void resonator_ddc(hls::stream<axisdata_t> &res_in, hls::stream<axisdata_t> &res_out,
				   tonegroup_t tones[N_RES_GROUPS], loopcenter_group_t centers[N_RES_GROUPS]) {
//#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS INTERFACE s_axilite port=tones
#pragma HLS INTERFACE s_axilite port=centers
#pragma HLS INTERFACE mode=axis register_mode=off port=res_in
#pragma HLS INTERFACE mode=axis register_mode=off port=res_out

#pragma HLS DATAFLOW


	hls::stream<iqgroup_uint_t> iq;
	hls::stream<bool> done, done2;
	hls::stream<loopcenter_group_t> centergroup;
	hls::stream<tonegroup_t> tonegroup;
	hls::stream<group_t> group, group2;
	hls::stream<accgroup_t> accg;
#pragma HLS STREAM variable=iq depth=16
#pragma HLS STREAM variable=done depth=10
#pragma HLS STREAM variable=done2 depth=2 //1
#pragma HLS STREAM variable=centergroup depth=16
#pragma HLS STREAM variable=tonegroup depth=10
#pragma HLS STREAM variable=group depth=10
#pragma HLS STREAM variable=group2 depth=3
#pragma HLS STREAM variable=accg depth=3


	//Fetch incoming values and data from bram
	memory_fetcher(res_in, centers, tones, iq, centergroup, tonegroup);
		//, group, done);

	//Compute phase value
	accumulate(//done, group,
			tonegroup, accg);
			//, group2, done2);

	//Compute DDS from phase accumulator, DDC, and center
	ddsddc(//done2, group2,
			accg, iq, centergroup, res_out);

}
