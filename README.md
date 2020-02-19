# resonator-dds
Center and zero resonator IQ values

Git:  [resonator-dds](https://github.com/MazinLab/resonator-dds)

Inputs:
- 1 288bit AXI4S of 8 36 bit complex numbers (IQ streams), equipped with TLAST
- AXI-Lite control port bundling:
 - increment port (256x8 ap_fixed<16, 1, AP_RND_CONV, AP_WRAP> array).
 - phase offset port (256x8 ap_ufixed<16, 1, AP_RND_CONV, AP_WRAP> array).

Outputs:
- 1 288bit AXI4S of 8 36 bit complex numbers (IQ streams), equipped with TLAST

Interface:

    void resonator_dds(resgroup_t &res_in, resgroupusr_t &res_out,
                       toneinc_t toneinc[N_RES_GROUPS][N_RES_PCLK],
                       phase_t phase0[N_RES_GROUPS][N_RES_PCLK])  {
    #pragma HLS INTERFACE ap_ctrl_none port=return
    #pragma HLS INTERFACE s_axilite port=toneinc bundle=control
    #pragma HLS INTERFACE s_axilite port=phase0 bundle=control
    #pragma HLS INTERFACE s_axilite port=rest_phase bundle=control
    #pragma HLS DATA_PACK variable=res_out
    #pragma HLS INTERFACE axis port=res_in
    #pragma HLS INTERFACE axis port=res_out
    #pragma HLS ARRAY_RESHAPE variable=toneinc complete dim=2
    #pragma HLS ARRAY_RESHAPE variable=phase0 complete dim=2
    #pragma HLS PIPELINE  II=1


This block uses direct digital sysnthesis of a complex sinusid to digitally down convert each of the 
ingested raw resonator IQ values. This is accomplished by maintaining an internal LUT with a  phase offset 
and phase increment for each resonator, a coarse and fine cosine LUT, and a bank of accumulated 
phases (one per resonator).

The core is designed as a pipleline of four functions in a top level function that calls them an increments a 
counter to keep track of which group the core is presently processing.

    1. fetch_tones
    2. increment_phases
    3. aphase_to_sincos
    4. downconvert

The first function fetches the 8 tone increments and 8 phase offsets from memory and bundles them into a 
tonegroup_t struct, which consists of an array of 8 tone_t structs (consisting for a tone increment and a phase

    typedef struct {
        toneinc_t inc;
        phase_t phase;
    } tone_t;

    typedef struct {
        tone_t tones[N_RES_PCLK];
    } tonegroup_t;

This tonegroup is returned (it is a pass-by-reference argument) and pased on to increment_phases. At the time of 
writing datapack is not applied to this struct, allowing HLS to choose how many and how wide the registers are used for the components.

Increment_phases takes uses the group counter to retrieve a group of 8 accumulated phases from internal 
static memory, it increments these phases by the corresponding phase increment of the tonegroup and both 
places the result in a register for writing back to memory next cycle and uses the incremented phase added 
with the appropriate phase offset from the tonegroup to return a group of 8 accumulated phases of 21 bits each.

    #define NBITS 21
    typedef ap_fixed<NBITS+1,1> acc_t;   // s.xxxx, +/- 1 = +/- pi = +fs/2 to -fs/2
    typedef struct {
        acc_t phases[N_RES_PCLK];
    } accgroup_t;

Next the accumulated phases are converted to sine and cosine values via a lightly modified copy of Xilinx's HLS  DDS
example code. This code uses the high two bits of the accumulated phase to determine a quadrant, the next lower 10
bits  to index a cosine LUT at two different addresses to retrieve corse values, and the final 9 bits to index a
fine LUT which it combines with corse LUT results to generate the output value. This approach uses 16 BRAM 18K and
16 DSP48s. The Xilinx code also supports a dithered approach whihc raises the noise floor in exchange for fewer resources.

The final function, downconvert, performs a complex multiply between each of the resonator IW values and their
corresponding DDS IQ value and places the results into the output axi stream. The current group is placed into
the output user stream and last is passed through. This is implemented usign a total of 24 DSP48s (3 per multiply))

Finally the group counter is incremented. At present, an incomming TLAST does not force the group counter to reset
, allowing a misalignment to be detected by comparing the TUSER value of the beat with TLAST (it should always be 255)

As presently implemented the downconverted tones appear to have a stability better that 0.035 degrees of phase and
an amplitude accuracy of 0.05%.

Possible Enhancements:
 - Output a group mismatch interrupt
 - Add an accumulated phase reset

The resonator map can be programmed directly from PYNQ using mkidgen3.blocks.ResonatorDDS (see
[mkidgen3](https://github.com/MazinLab/MKIDGen3), eventually). An example block diagram and jupyter  notebook for
testing the core are contained in [gen3-reschan](https://github.com/MazinLab/gen3-reschan)
