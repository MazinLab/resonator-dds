#define N_RES_PCLK 8

typedef ap_fixed<16, -9, AP_RND_CONV, AP_SAT_SYM> sample_t;

typedef complex<sample_t> iq_t;

typedef struct {
	sample_t i;
	sample_t q;
} iqOK_t;

typedef struct {
	iqstruct_t iq[N_RES_PCLK];
} iqgroupBAD_t;

typedef struct {
	sample_t i[N_RES_PCLK];
	sample_t q[N_RES_PCLK];
} iqgroupOK_t;

typedef struct {
	complexiq_t iq[N_RES_PCLK];
} iqgroupIDEAL_t;

typedef struct {
	sample_t data[2*N_RES_PCLK];
	ap_uint<1> last;
	ap_uint<8> user;
} axisOK_t;

typedef struct {
	iqgroupBAD_t data;
	ap_uint<1> last;
	ap_uint<8> user;
} axisBAD_t;

typedef struct {
	complexiq_t data[N_RES_PCLK];
	bool last;
	ap_uint<8> user;
} idealaxis_v1_t;

typedef struct {
	complexiq_t data[N_RES_PCLK];
	bool last;
	ap_uint<8> user;
} idealaxis_v2_t;

typedef hls::stream<idealaxis_t> idealin_t;

void resonator_dds(axisOK_t &res_in, resgroupout_t &res_out,
