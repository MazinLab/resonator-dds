#include "fine_channelizer.hpp"
#include <stdio.h>
using namespace std;

#define N_CYCLES 10

int main(){

	resgroup_t in, out;
	toneinc_t tone_inc_table[N_RES_GROUPS][N_RES_PCLK];
	complex<double> res_bin_iqs[N_CYCLES*N_RES_GROUPS][N_RES_PCLK];

	FILE *fp;
	double inc, ival, qval;
	int group, lane;
	//Load in tone-bin center offsets and bin IQ values
	fp=fopen("toneoffsets.dat", "r");
	if (fp==NULL) cout<<"Null file"<<endl;
	for (int i=0; i<N_RES_GROUPS*N_RES_PCLK; i++){
		fscanf(fp, "%lf", &inc);
		group=i/N_RES_PCLK;
		lane=i%N_RES_PCLK;
		tone_inc_table[group][lane] = inc/2.048e6; //TODO the input file has frequencies in HZ
	}
	fclose(fp);
	fp=fopen("resiqs.dat", "r");
	for (int i=0; i<N_RES_GROUPS*N_RES_PCLK*N_CYCLES; i++){
		fscanf(fp, "%lf %lf", &qval, &ival); //sin cos in python
		group=i/N_RES_PCLK;
		lane=i%N_RES_PCLK;
		res_bin_iqs[group][lane].real(ival);
		res_bin_iqs[group][lane].imag(qval);
	}
	fclose(fp);

	//Run the DDS
	for (int i=0; i<N_CYCLES;i++) { // Go through more than once to see the phase increment
		for (int j=0;j<N_RES_GROUPS;j++) { //takes N_RES_GROUPS cycles to get through each resonator once
			//Load the data
			in.user = j;
			for (int k=0;k<N_RES_PCLK;k++) {
				in.data.iq[k].i=res_bin_iqs[j+i*N_RES_GROUPS][k].real();
				in.data.iq[k].q=res_bin_iqs[j+i*N_RES_GROUPS][k].imag();
			}

			//Run the DDS on the data
			fine_channelizer(in, out, tone_inc_table);

			//Compare the result
			for (int k=0;k<N_RES_PCLK;k++) {
				complex<double> dds_val, bin_iq, downshifted;
				iq_t downshifted_fp;
				double phase, diff_i, diff_q; //0-1, increments by the tone increment each cycle
				//Compute the sin cosine value for the time step
				phase = (2*M_PI*(i+1))*tone_inc_table[j][k].to_double();
				dds_val.real(cos(phase));
				dds_val.imag(sin(phase));
				//Complex multiply with the bin
				bin_iq=res_bin_iqs[j+i*N_RES_GROUPS][k];
				downshifted = dds_val*bin_iq;
				//Compare
				downshifted_fp.i=downshifted.real();
				downshifted_fp.q=downshifted.imag();
				diff_i=out.data.iq[k].i.to_double()-downshifted_fp.i.to_double();
				diff_q=out.data.iq[k].q.to_double()-downshifted_fp.q.to_double();
				cout<<"Direct DDS of "<<dds_val<<" with IQ "<<bin_iq<<" yields "<<downshifted<<" which quantizes to ("<<downshifted_fp.i.to_double()<<","<<downshifted_fp.q.to_double()<<")";
				cout<<". Core: ("<<out.data.iq[k].i.to_double()<<","<<out.data.iq[k].q.to_double()<<")."<<endl;
				cout<<"Difference of ("<<diff_i<<","<<diff_q<<")"<<endl;
				if (abs(diff_i)>7e-5 || abs(diff_q)>7e-5) {
					cout<<"MISMATCH MISMATCH MISMATCH: "<<i<<" "<<j<<" "<<k<<endl;
					cout<<endl;
//					return 1;
				}
			}
		}
	}

	return 0;

}
