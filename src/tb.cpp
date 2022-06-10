#include "fine_channelizer.hpp"
#include <stdio.h>
#include <math.h>
#include <complex.h>
#include <fstream>
using namespace std;

#define N_CYCLES 4
#define TOL 2.5e-5 //1.99031e-005
//Phase increments properly, when it reaches 1 it wraps from -1 e.g. 1.2 would be -0.8

complex<sample_t> genIQ(unsigned int sample, int freq_n, double phase0) {
	/*
	 *  Generate a sinusoid sampled at 2MHz with a frequency of +- n* 4.096e9/(262144*16) in the interval (-1,+1] MHz
	 *  and an amplitude that uses up most of the range of  ap_fixed<16, -9>?
	 *
	 *  freq_n should be in range -64,64
	 */

	double inc = freq_n*4.096e9/262144.0/1e6; // unitless
	double amp = 0.98/sqrt(2);  //~ 2^-9
	double phase = sample*inc + phase0;
	return complex<sample_t>(amp*cos(M_PI*phase), amp*sin(M_PI*phase));
}


int main(){

	toneinc_t toneinc[N_RES_GROUPS][N_RES_PCLK];
	phase_t phase0[N_RES_GROUPS][N_RES_PCLK];
	tonegroup_t tones[N_RES_GROUPS];
	bool fail=false;
	bool mismatch=false;
	double maxerror=0;

	/*
	 * The tone and phase offsets used by the core are +/- 1 with wrapping
	 * and get combined to form the phase with range +/-1 corresponding to +/- pi
	 * So a tone increment of +1 corresponds to Fs/2 (1MHz for a 2MHz sample rate)
	 * The DAC replay table is quantized @ 4.096e9 Hz/4194304 so there are only 2048
	 * true positions for tones in a channel each at n*4.096e9/4194304 Hz where i goes from
	 * -1023 to 1024. Thus the tone increment then for 1024*4.096e9/4194304 would be 1, more generally
	 * tone = n/1024.0;
	 * will be
	 */

	double PHASE0 = .24;  //initial phase


	//Load in tone-bin center offsets and bin IQ values
	for (int i=0; i<N_RES_GROUPS*N_RES_PCLK; i++){
		int group, lane;
		group=i/N_RES_PCLK;
		lane=i%N_RES_PCLK;
		toneinc[group][lane] = toneinc_t(-(i%128 -64)/64.0);
		phase0[group][lane] = phase_t(-PHASE0);
		tones[group].range(N_TONEBITS*(lane+1)-1, N_TONEBITS*lane)=toneinc[group][lane].range();
		tones[group].range(N_P0BITS*(lane+1)-1+N_TONEBITS*N_RES_PCLK, N_P0BITS*lane+N_TONEBITS*N_RES_PCLK)=phase0[group][lane].range();
	}

	//Run the DDS
	hls::stream<axisdata_t> res_in_stream, res_out_stream;
	for (int i=0; i<N_CYCLES;i++) { // Go through more than once to see the phase increment
		//Run the DDS on the data
		for (int j=0;j<N_RES_GROUPS;j++){
			axisdata_t in;
			in.last = j==N_RES_GROUPS-1;
			in.user=j;

			for (int lane=0;lane<N_RES_PCLK;lane++){
				complex<sample_t> iq = genIQ(i, (j*N_RES_PCLK+lane)%128-64, PHASE0);
				in.data.range(32*(lane+1)-1-16, 32*lane)=iq.real().range();
				in.data.range(32*(lane+1)-1, 32*lane+16)=iq.imag().range();
			}
			res_in_stream.write(in);
		}
	}


	resonator_dds(res_in_stream, res_out_stream, tones);


	//Check results

	resgroupout_t out;
    ofstream myfile;
  	myfile.open("result16_8_17.txt");
	for (int i=0; i<N_CYCLES;i++) { // Go through more than once to see the phase increment
		cout<<"Cycle "<<i<<endl;
		myfile<<"#Cycle "<<i<<endl;
		for (int j=0;j<N_RES_GROUPS;j++) { //takes N_RES_GROUPS cycles to get through each resonator once
			if (res_out_stream.empty()){
				cout<<"premature empty "<<j<<endl;
				return 1;
			}

			//Parse data
			axisdata_t tmpout=res_out_stream.read();
			for (int ii=0;ii<N_RES_PCLK;ii++){
				out.data[ii].real().range()=tmpout.data.range(32*(ii+1)-1-16, 32*ii);
				out.data[ii].imag().range()=tmpout.data.range(32*(ii+1)-1, 32*ii+16);
			}
			out.last=tmpout.last;
			out.user=tmpout.user;

//			if (j!=33) continue;

			//Check user and last
			if (out.user!=j) {
				cout<<"User Mismatch at "<<i<<","<<j<<": "<<j<<"!="<<out.user<<endl;
				fail|=true;
			}
			if (out.last!= (j==N_RES_GROUPS-1)) {
				cout<<"Last Mismatch at "<<i<<","<<j<<": "<<j<<". last="<<out.last<<endl;
				fail|=true;
			}

			//Compare the result
			for (int k=0;k<N_RES_PCLK;k++) {
				complex<double> dds_val, bin_iq, ddcd;
				complex<sample_t> bin_iq_fix;
				double phase, inc, diff_i, diff_q; //0-1, increments by the tone increment each cycle

				//Compute the sin cosine value for the time step
				int tone_id=(j*N_RES_PCLK+k)%128-64;
				inc = tone_id*4.096e9/262144.0/1e6;
				phase = i*inc + PHASE0;
				dds_val = complex<double>(cos(-M_PI*phase), sin(-M_PI*phase));

				//Complex multiply with the bin
				bin_iq_fix=genIQ(i, tone_id, PHASE0);
				bin_iq=complex<double>(bin_iq_fix.real().to_double(), bin_iq_fix.imag().to_double());
				ddcd = dds_val*bin_iq;


				//Look for loss of bitwidth
//				sample_complex_t rangetst;
//				rangetst.real().range()=out.data[k].real().range();
//				rangetst.imag().range()=out.data[k].imag().range();
//				cout<<rangetst.real();

				//Compare
				diff_i=out.data[k].real().to_double()-ddcd.real();
				diff_q=out.data[k].imag().to_double()-ddcd.imag();

				maxerror = max(max(abs(diff_i),abs(diff_q)), maxerror);

				bool mismatch = abs(diff_i)>TOL || abs(diff_q)>TOL;

				if (k==1 && j==33) {
					cout<<"Mixing DDS "<<phase<<"="<<dds_val<<", inc "<<inc<<" with IQ "<<bin_iq<<" -> "<<ddcd<<endl;
					cout<<" IQfp="<<sample_t(bin_iq.real())<<","<<sample_t(bin_iq.imag())<<endl;
					cout<<" Core gives: "<<out.data[k]<<endl;
					cout<<" Delta: ("<<diff_i<<","<<diff_q<<")"<<endl;
					if (mismatch) cout<<endl<<"MISMATCH: cycle="<<i<<" group="<<j<<" res="<<k<<endl<<endl;
				}
				fail|=mismatch;

				myfile<<j*N_RES_PCLK+k<<", "<<setprecision(numeric_limits<double>::digits10 + 1)<<inc<<", "<<bin_iq<<","<<dds_val<<","<<ddcd<<","<<out.data[k]<<endl;
			}
		}
	}
	myfile.close();
	if (fail) cout <<"FAILED. Max error:"<<maxerror<<"\n";
	else cout<<"PASS! Max error:"<<maxerror<<"\n";
	return fail;

}
