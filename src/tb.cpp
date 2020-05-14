#include "fine_channelizer.hpp"
#include <stdio.h>
#include <math.h>
using namespace std;

#define N_CYCLES 2
#define TOL 7e-8
//Phase increments properly, when it reaches 1 it wraps from -1 e.g. 1.2 would be -0.8



int main(){

	resgroup_t in;
	resgroupout_t out[N_CYCLES][N_RES_GROUPS];
	toneinc_t toneinc[N_RES_GROUPS][N_RES_PCLK];
	phase_t phase0[N_RES_GROUPS][N_RES_PCLK];
	bool fail=false;
	bool mismatch=false;
	double maxerror=0;
	bool tone_test=false;


	//Load in tone-bin center offsets and bin IQ values
	for (int i=0; i<N_RES_GROUPS*N_RES_PCLK; i++){
		int group, lane;
		group=i/N_RES_PCLK;
		lane=i%N_RES_PCLK;
		toneinc[group][lane] = toneinc_t(0);
		phase0[group][lane] = phase_t(.25);
	}

	//Run the DDS
	for (int i=0; i<N_CYCLES;i++) { // Go through more than once to see the phase increment

		//Run the DDS on the data
		for (int j=0;j<N_RES_GROUPS;j++){

			in.last = j==N_RES_GROUPS-1;
			in.user=j;
			for (int k=0;k<N_RES_PCLK;k++) {
				in.data.iq[k].i.range()=0;
				in.data.iq[k].q.range()=8192;
			}

			resgroupout_t tmpout;
			resonator_dds(in, tmpout, toneinc, phase0, true);

			out[i][j]=tmpout;
			if (out[i][j].user!=in.user)
				cout<<"Mismatch at "<<i<<","<<j<<": "<<in.user<<"!="<<out[i][j].user<<endl;
		}
	}

	for (int i=0; i<N_CYCLES;i++) { // Go through more than once to see the phase increment
		for (int j=0;j<N_RES_GROUPS;j++) { //takes N_RES_GROUPS cycles to get through each resonator once

			//Compare the result
			for (int k=0;k<N_RES_PCLK;k++) {
				complex<double> dds_val, bin_iq, ddcd;
				double phase, diff_i, diff_q; //0-1, increments by the tone increment each cycle
				//Compute the sin cosine value for the time step


				if (tone_test) {
					phase = i*(j>200)*.025 + (j>128 ? 0.5:1.0);
				} else {
					phase = i*toneinc[j][k]+phase0[j][k];
				}

				dds_val.real(cos(M_PI*phase));
				dds_val.imag(sin(M_PI*phase));
				//Complex multiply with the bin
				sample_t foo;
				foo.range()=8192;
				bin_iq=complex<double>(0,foo);
				ddcd = dds_val*bin_iq;

				//Compare
				diff_i=out[i][j].data.iq[k].i.to_double()-ddcd.real();
				diff_q=out[i][j].data.iq[k].q.to_double()-ddcd.imag();

				maxerror = max(max(abs(diff_i),abs(diff_i)), maxerror);
				if (abs(diff_i)>TOL || abs(diff_q)>TOL) {
					cout<<"MISMATCH: ";
					cout<<"cycle="<<i<<" group="<<j<<" res="<<k<<endl;
					cout<<"Mixing DDS "<<phase<<"="<<dds_val<<", inc "<<toneinc[j][k].to_double()<<" with IQ "<<bin_iq<<" -> ";
					cout<<ddcd<<"\n";
					cout<<"Core gives: ("<<out[i][j].data.iq[k].i.to_double()<<","<<out[i][j].data.iq[k].q.to_double()<<")";
					cout<<" Int: ("<<out[i][j].data.iq[k].i.V<<","<<out[i][j].data.iq[k].q.V<<")."<<endl;
					cout<<"Delta of ("<<diff_i<<","<<diff_q<<")"<<endl;

					cout<<endl;
					fail|=true;
				}
			}
		}
	}
	if (fail) cout <<"FAILED. Max error:"<<maxerror<<"\n";
	else cout<<"PASS! Max error:"<<maxerror<<"\n";
	return fail;

}
