# resonator-dds
Center and zero resonator IQ values

Git:  [resonator-dds](https://github.com/MazinLab/resonator-dds)

Inputs:
- 1 256/288bit AXI4S of 8 32/36 bit complex numbers (IQ streams), equipped with TLAST (1b) and TUSER (8b)
- AXI-Lite control port of tonegroup_t tones[256] (256 32 byte records)
- Constant boolean input to enable generation of TLAST ever 256 outputs.

tones is formatted as inc0 - inc7 offset0 - offset7 inc8 - inc15 offset8 - offset15 ...

Both toneinc_t and phase_t are of type ap_fixed<16, 1, AP_RND_CONV, AP_WRAP>.

Outputs:
- 1 256/288bit AXI4S of 8 32/36 bit complex numbers (IQ streams), equipped with TLAST (1b) and TUSER (8b)

Interface:

    void resonator_dds(resgroup_t &res_in, resgroupusr_t &res_out,
                       tonegroup_t tones[N_RES_GROUPS], bool generate_tlast)  {
    #pragma HLS INTERFACE ap_ctrl_none port=return
    #pragma HLS INTERFACE s_axilite port=tones bundle=control
    #pragma HLS INTERFACE axis port=res_in
    #pragma HLS INTERFACE axis port=res_out
    #pragma HLS INTERFACE ap_stable port=generate_tlast
    #pragma HLS PIPELINE  II=1


This block uses direct digital sysnthesis of a complex sinusid to digitally down convert each of the 
ingested raw resonator IQ values. This is accomplished by maintaining internal LUT with a phase offset 
and phase increment for each resonator, a coarse and fine cosine LUT, and a bank of accumulated 
phases (one per resonator).

The core is a fairly simple top level function that increments a 
counter to keep track of which group the core is presently processing. The flow is roughly

    1. fetch_tones
    2. increment_phases
    3. fetch sine cosine values
    4. downconvert via complex multiply

The first step fetches the 8 tone increments and 8 phase offsets from memory as a 
tonegroup_t struct, 

    typedef struct {
	toneinc_t inc[N_RES_PCLK];
	phase_t phase0[N_RES_PCLK];
   } tonegroup_t;

Similarly a group of 8 accumulated phases is retireved from internal static memory: 

    #define NBITS 21
    typedef ap_fixed<NBITS+1,1> acc_t;   // s.xxxx, +/- 1 = +/- pi = +fs/2 to -fs/2
    typedef struct {
        acc_t phases[N_RES_PCLK];
    } accgroup_t;

These phases summed with the phase0 for each resonator to fetch the appropriate value from the DDS LUT.
The accumulator values are incremented and the result stored in a register for dumping to memory next clock.

The sine and cosine values are determined by a modified copy of Xilinx's HLS  DDS
example code. This code uses the high two bits of the accumulated phase to determine a quadrant, the next lower 10
bits  to index a cosine LUT at two different addresses to retrieve corse values, and the final 9 bits to index a
fine LUT which it combines with corse LUT results to generate the output value. This approach uses 16 BRAM 18K and
16 DSP48s. The Xilinx code also supports a dithered approach whihc raises the noise floor in exchange for fewer resources.

The final step performs downconversion via a complex multiply between each of the resonator IQ values and their
corresponding DDS IQ value and places the results into the output axi stream. The current group is placed into
the output user stream and last is passed through (or generated if generate_tlast is tied high). 
This is implemented usign a total of 32 DSP48s (4 per multiply).

Finally the group counter is incremented. The group used to retrieve the values from internal memory and output on 
TUSER is determined by generate_tlast. If generate_tlast is tied low then the input TUSER bits are both used to load 
memories and passed through. If tied high the internal cycle counter is used.

The resonator map can be programmed directly from PYNQ using mkidgen3.blocks.ResonatorDDS (see
[mkidgen3](https://github.com/MazinLab/MKIDGen3), eventually). An example block diagram and jupyter notebook for
testing the core are contained in [gen3-vivado-top](https://github.com/MazinLab/gen3-vivado-top)
