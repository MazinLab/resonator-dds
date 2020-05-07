#include "fine_channelizer.hpp"
#include <stdio.h>
#include <math.h>
using namespace std;

#define N_CYCLES 2
#define TOL 5e-7
//Phase increments properly, when it reaches 1 it wraps from -1 e.g. 1.2 would be -0.8



int main(){

	resgroup_t in[N_RES_GROUPS];
	resgroupout_t out[N_CYCLES][N_RES_GROUPS];
	toneinc_t toneinc[N_RES_GROUPS][N_RES_PCLK];
	phase_t phase0[N_RES_GROUPS][N_RES_PCLK];
	complex<double> res_bin_iqs[N_CYCLES][N_RES_GROUPS][N_RES_PCLK];
	bool fail=false;
	bool mismatch=false;
	double maxerror=0;

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
		toneinc[group][lane] = inc/1.0e6; //TODO the input file has frequencies in HZ
		phase0[group][lane] = 0.1;
	}
	fclose(fp);
	fp=fopen("resiqs.dat", "r");
	for (int i=0; i<N_RES_GROUPS*N_RES_PCLK; i++){
		fscanf(fp, "%lf %lf", &qval, &ival); //sin cos in python
		group=i/N_RES_PCLK;
		lane=i%N_RES_PCLK;
		for (int j=0;j<N_CYCLES;j++) {
			res_bin_iqs[j][group][lane].real(ival);
			res_bin_iqs[j][group][lane].imag(qval);
		}
	}
	fclose(fp);

	//Run the DDS
	for (int i=0; i<N_CYCLES;i++) { // Go through more than once to see the phase increment
		for (int j=0;j<N_RES_GROUPS;j++) { //takes N_RES_GROUPS cycles to get through each resonator once
			//Load the data
			in[j].last = j==N_RES_GROUPS-1;
			for (int k=0;k<N_RES_PCLK;k++) {
				in[j].data.iq[k].i=res_bin_iqs[i][j][k].real();
				in[j].data.iq[k].q=res_bin_iqs[i][j][k].imag();
				in[j].user=j;
			}
		}
		//Run the DDS on the data
		for (int j=0;j<N_RES_GROUPS;j++){
			resonator_dds(in[j], out[i][j], toneinc, phase0, &mismatch);
			if (mismatch) cout<<"mismatch on "<<i<<" "<<j<<endl;
		}
	}

	for (int i=0; i<N_CYCLES;i++) { // Go through more than once to see the phase increment
		for (int j=0;j<N_RES_GROUPS;j++) { //takes N_RES_GROUPS cycles to get through each resonator once

			//Compare the result
			for (int k=0;k<N_RES_PCLK;k++) {
				complex<double> dds_val;
				complex<double> bin_iq;
				complex<double> downshifted;
				iqout_t downshifted_fp;
				double phase, diff_i, diff_q; //0-1, increments by the tone increment each cycle
				//Compute the sin cosine value for the time step
				phase = i*toneinc[j][k]+phase0[j][k];
				dds_val.real(cos(M_PI*phase));
				dds_val.imag(sin(M_PI*phase));
				//Complex multiply with the bin
				bin_iq=complex<double>(sample_t(res_bin_iqs[i][j][k].real()).to_double(),
									   sample_t(res_bin_iqs[i][j][k].imag()).to_double());
				downshifted = dds_val*bin_iq;
				//Compare
				downshifted_fp.i=downshifted.real();
				downshifted_fp.q=downshifted.imag();

				diff_i=out[i][j].data.iq[k].i-downshifted_fp.i;
				diff_q=out[i][j].data.iq[k].q-downshifted_fp.q;

				maxerror = max(max(abs(diff_i),abs(diff_i)), maxerror);
				if (abs(diff_i)>TOL || abs(diff_q)>TOL) {
					cout<<"MISMATCH: cycle="<<i<<" group="<<j<<" res="<<k<<endl;
					cout<<"Mixing DDS "<<phase<<"="<<dds_val<<", inc "<<toneinc[j][k].to_double()<<" with IQ "<<bin_iq<<" -> ";
					cout<<downshifted<<", ("<<downshifted_fp.i<<","<<downshifted_fp.q<<") quantized.\n";
					cout<<"Core gives: ("<<out[i][j].data.iq[k].i<<","<<out[i][j].data.iq[k].q<<")."<<endl;
					cout<<"Delta of ("<<diff_i<<","<<diff_q<<")"<<endl;

					cout<<endl;
					fail|=true;
				}
			}
		}
	}
	if (fail) cout <<"FAILED.\n";
	else cout<<"PASS! Max error:"<<maxerror<<"\n";
	return fail;

}
