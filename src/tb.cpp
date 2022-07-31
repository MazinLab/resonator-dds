#include "fine_channelizer.hpp"
#include <stdio.h>
#include <math.h>
#include <complex.h>
#include <fstream>
using namespace std;

#define TOL 1.9e-5 //1.99031e-005


complex<double> center_for(unsigned int chan) {
	return complex<double>(sample_t(1.5*chan/(N_RES_GROUPS*N_RES_PCLK)-.75).to_double(),
						   sample_t(-1.5*chan/(N_RES_GROUPS*N_RES_PCLK)-.75).to_double());
}

double amplitude_for(unsigned int chan) {
	return sample_t(0.06).to_double();
}

double phase0_for(unsigned int chan) {
	return phase_t(.85*(2.0*chan/(N_RES_GROUPS*N_RES_PCLK)-.85/2)).to_double();
}

double toneinc_for(unsigned int chan) {  //Tones are center relative  ±1 MHZ 1 MHz will repeat every two samples e.g 1, 0, 1, 0, ....
	return toneinc_t(2.0*chan/(N_RES_GROUPS*N_RES_PCLK)-1.0).to_double();
}

double phasequant_for(unsigned int chan, unsigned int sample) {
    //Compute the sin cosine value for the time step
    return phase_t(phase_t(-toneinc_for(chan)*sample).to_double()+ -phase0_for(chan)).to_double();
}

complex<double> ddsquant_for(unsigned int chan, unsigned int sample) {
    //Compute the sin cosine value for the time step
    acc_t acc;
    acc.range()=phase_t(phasequant_for(chan, sample)).range();
	dds_words_t ddsv;
	dds_complex_t dds_sincos;
	phase_sincos_LUT_wstatic(acc, ddsv);
	dds(ddsv, dds_sincos);
    return complex<double>(dds_sincos.real().to_double(), dds_sincos.imag().to_double());
}

complex<double> dds_for(unsigned int chan, unsigned int sample) {
    //Compute the sin cosine value for the time step
    double phase;
    phase = -(toneinc_for(chan)*sample+phase0_for(chan))*M_PI;
    return complex<double>(cos(phase), sin(phase));
}

complex<double> ddsquant_for(unsigned int chan, unsigned int sample, acc_t phase_values[N_CYCLES][N_RES_GROUPS*N_RES_PCLK]) {
    //Compute the sin cosine value for the time step
    acc_t acc=phase_values[sample][chan];
	dds_words_t ddsv;
	dds_complex_t dds_sincos;
	phase_sincos_LUT_wstatic(acc, ddsv);
	dds(ddsv, dds_sincos);
    return complex<double>(dds_sincos.real().to_double(), dds_sincos.imag().to_double());
}

complex<double> dds_for(unsigned int chan, unsigned int sample, acc_t phase_values[N_CYCLES][N_RES_GROUPS*N_RES_PCLK]) {
    //Compute the sin cosine value for the time step
    double phase=phase_values[sample][chan].to_double()*M_PI;
    return complex<double>(cos(phase), sin(phase));
}

complex<double> iq_for(unsigned int chan, unsigned int sample) {
    /* Compute sinusoid value for channel at sample */
    double phase, amp;
    amp=amplitude_for(chan);
    phase=(toneinc_for(chan)*sample+phase0_for(chan))*M_PI;
	return complex<double>(amp*cos(phase), amp*sin(phase));
}

complex<double> iqquant_for(unsigned int chan, unsigned int sample) {

    complex<double> iq;
    complex<sample_t> out;
    iq=iq_for(chan, sample);
    out.real(iq.real());
    out.imag(iq.imag());
    return complex<double>(out.real().to_double(), out.imag().to_double());

}

int main(){

	tonegroup_t tones[N_RES_GROUPS];
	acc_t phase_values[N_CYCLES][N_RES_GROUPS*N_RES_PCLK];
	loopcenter_group_t centergroups[N_RES_GROUPS];
	bool fail=false;
	bool mismatch=false;
	double maxerror=0, maxerror_i=0, maxerror_q=0, maxerror_p=0;
	double maxqerror=0, maxqerror_i=0, maxqerror_q=0;

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

	//Load in tone-bin center offsets and bin IQ values
	for (int i=0; i<N_RES_GROUPS*N_RES_PCLK; i++){
        int lane, group;
		lane=i%N_RES_PCLK;
		group=i/N_RES_PCLK;
		tones[group].range(N_TONEBITS*(lane+1)-1, N_TONEBITS*lane)=toneinc_t(-toneinc_for(i)).range();
		tones[group].range(N_P0BITS*(lane+1)-1+N_TONEBITS*N_RES_PCLK, N_P0BITS*lane+N_TONEBITS*N_RES_PCLK)=phase_t(-phase0_for(i)).range();

		complex<double> c=center_for(i);
		centergroups[group].range(32*(lane+1)-16-1, 32*lane)=center_t(c.real()).range();
		centergroups[group].range(32*(lane+1)-1, 32*lane+16)=center_t(c.imag()).range();
	}

	//Run the DDS
	hls::stream<axisdata_t> res_in_stream, res_out_stream;

	for (int i=0; i<N_CYCLES;i++) { // Go through more than once to see the phase increment
		//Run the DDS on the data
		for (int j=0;j<N_RES_GROUPS;j++){
			axisdata_t in;

			for (int lane=0;lane<N_RES_PCLK;lane++){
				complex<double> iqquant=iqquant_for(j*N_RES_PCLK+lane, i);
				in.data.range(32*(lane+1)-1-16, 32*lane)=sample_t(iqquant.real()).range();
				in.data.range(32*(lane+1)-1, 32*lane+16)=sample_t(iqquant.imag()).range();
			}
			in.last=j==(N_RES_GROUPS-1);
			in.user=j;
			res_in_stream.write(in);
		}
	}

	resonator_ddc(res_in_stream, res_out_stream, tones, centergroups);


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
				complex<double> dds_val, bin_iq, ddcd, ddcdq, centerv, dds_val_fix, bin_iq_fix;
				double phase, inc, diff_i, diff_q, diffq_i, diffq_q; //0-1, increments by the tone increment each cycle


				inc=toneinc_for(j*N_RES_PCLK+k);
				phase = phasequant_for(j*N_RES_PCLK+k, i);
                dds_val = dds_for(j*N_RES_PCLK+k, i);
                bin_iq=iq_for(j*N_RES_PCLK+k, i);
                dds_val_fix = ddsquant_for(j*N_RES_PCLK+k, i);
                bin_iq_fix = iqquant_for(j*N_RES_PCLK+k, i);
				centerv=center_for(j*N_RES_PCLK+k);

				ddcd = (dds_val*bin_iq) - centerv;
				ddcdq = (dds_val_fix*bin_iq_fix) - centerv;

				//Compare
				diff_i=out.data[k].real().to_double()-sampleout_t(ddcd.real()).to_double();
				diff_q=out.data[k].imag().to_double()-sampleout_t(ddcd.imag()).to_double();

				maxerror_i=max(abs(diff_i), maxerror_i);
				maxerror_q=max(abs(diff_q), maxerror_q);
				maxerror=max(maxerror_q,maxerror_i);

				diffq_i=out.data[k].real().to_double()-sampleout_t(ddcdq.real()).to_double();
				diffq_q=out.data[k].imag().to_double()-sampleout_t(ddcdq.imag()).to_double();

				maxqerror_i=max(abs(diffq_i), maxqerror_i);
				maxqerror_q=max(abs(diffq_q), maxqerror_q);
				maxqerror=max(maxqerror_q,maxqerror_i);

				bool mismatch = max(abs(diffq_i),abs(diffq_q))>TOL;

				if (mismatch || k==1 && j==33) {
					cout<<"Phase: "<<phase<<endl;
					cout<<"Mixing IQ*DDS - center:"<<endl;
					cout<<"Float: "<<bin_iq<<" * "<<dds_val<<" - "<<centerv<<" = "<<ddcd<<endl;
					cout<<"Fixed: "<<bin_iq_fix<<" * "<<dds_val_fix<<" - "<<centerv<<" = "<<ddcdq<<endl;
					cout<<"Core: "<<out.data[k]<<endl;
					cout<<"Delta (float): ("<<diff_i<<","<<diff_q<<")"<<endl;
					cout<<"Delta (fixed): ("<<diffq_i<<","<<diffq_q<<")"<<endl;
					if (mismatch) cout<<endl<<"MISMATCH: cycle="<<i<<" group="<<j<<" res="<<k<<endl<<endl;
				}
				fail|=mismatch;

				myfile<<j*N_RES_PCLK+k<<", "<<setprecision(numeric_limits<double>::digits10 + 1)<<inc<<", "<<bin_iq<<","<<dds_val<<","<<ddcd<<","<<out.data[k]<<endl;
			}
		}
	}
	myfile.close();
	if (fail) cout <<"FAILED.";
	else cout<<"PASS!";
	cout<<endl<<" Max error phase: "<<maxerror_p<<endl;
	cout<<" Max error float: "<<maxerror_i<<", "<<maxerror_q<<"\n";
	cout<<" Max error fixed: "<<maxqerror_i<<", "<<maxqerror_q<<"\n";
	return fail;

}
