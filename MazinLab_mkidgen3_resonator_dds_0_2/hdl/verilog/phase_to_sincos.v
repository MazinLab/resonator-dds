// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2019.2.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module phase_to_sincos (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        ap_ce,
        acc_V,
        ap_return_0,
        ap_return_1
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input   ap_ce;
input  [21:0] acc_V;
output  [15:0] ap_return_0;
output  [15:0] ap_return_1;

reg ap_done;
reg ap_idle;
reg ap_ready;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
wire    ap_block_pp0_stage0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_enable_reg_pp0_iter3;
reg    ap_enable_reg_pp0_iter4;
reg    ap_enable_reg_pp0_iter5;
reg    ap_enable_reg_pp0_iter6;
reg    ap_enable_reg_pp0_iter7;
reg    ap_enable_reg_pp0_iter8;
reg    ap_enable_reg_pp0_iter9;
reg    ap_enable_reg_pp0_iter10;
reg    ap_enable_reg_pp0_iter11;
reg    ap_enable_reg_pp0_iter12;
reg    ap_enable_reg_pp0_iter13;
reg    ap_idle_pp0;
reg    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
wire    ap_block_state3_pp0_stage0_iter2;
wire    ap_block_state4_pp0_stage0_iter3;
wire    ap_block_state5_pp0_stage0_iter4;
wire    ap_block_state6_pp0_stage0_iter5;
wire    ap_block_state7_pp0_stage0_iter6;
wire    ap_block_state8_pp0_stage0_iter7;
wire    ap_block_state9_pp0_stage0_iter8;
wire    ap_block_state10_pp0_stage0_iter9;
wire    ap_block_state11_pp0_stage0_iter10;
wire    ap_block_state12_pp0_stage0_iter11;
wire    ap_block_state13_pp0_stage0_iter12;
wire    ap_block_state14_pp0_stage0_iter13;
reg    ap_block_pp0_stage0_11001;
wire   [9:0] cos_lut_address0;
reg    cos_lut_ce0;
wire   [16:0] cos_lut_q0;
wire   [9:0] cos_lut_address1;
reg    cos_lut_ce1;
wire   [16:0] cos_lut_q1;
wire   [8:0] fine_lut_address0;
reg    fine_lut_ce0;
wire   [15:0] fine_lut_q0;
reg   [8:0] p_Result_s_reg_892;
reg   [8:0] p_Result_s_reg_892_pp0_iter1_reg;
reg   [8:0] p_Result_s_reg_892_pp0_iter2_reg;
reg   [8:0] p_Result_s_reg_892_pp0_iter3_reg;
reg   [1:0] msb_V_reg_897;
reg   [1:0] msb_V_reg_897_pp0_iter1_reg;
reg   [1:0] msb_V_reg_897_pp0_iter2_reg;
reg   [1:0] msb_V_reg_897_pp0_iter3_reg;
wire   [9:0] lsb_V_fu_150_p4;
reg   [9:0] lsb_V_reg_904;
wire   [9:0] sin_adr_V_fu_160_p2;
reg   [9:0] sin_adr_V_reg_910;
wire   [0:0] icmp_ln879_1_fu_170_p2;
reg   [0:0] icmp_ln879_1_reg_920;
reg   [0:0] icmp_ln879_1_reg_920_pp0_iter2_reg;
reg   [0:0] icmp_ln879_1_reg_920_pp0_iter3_reg;
reg   [0:0] icmp_ln879_1_reg_920_pp0_iter4_reg;
reg   [16:0] cos_lut_word_V_3_reg_934;
reg   [16:0] sin_lut_word_V_reg_939;
reg   [16:0] sin_lut_word_V_reg_939_pp0_iter3_reg;
reg   [16:0] sin_lut_word_V_reg_939_pp0_iter4_reg;
wire   [17:0] zext_ln203_fu_179_p1;
reg   [17:0] zext_ln203_reg_945;
reg   [17:0] zext_ln203_reg_945_pp0_iter4_reg;
wire   [17:0] zext_ln203_1_fu_182_p1;
reg   [17:0] zext_ln203_1_reg_952;
reg   [17:0] zext_ln203_1_reg_952_pp0_iter4_reg;
wire   [17:0] r_V_fu_185_p2;
reg   [17:0] r_V_reg_957;
wire   [16:0] trunc_ln790_fu_191_p1;
reg   [16:0] trunc_ln790_reg_962;
wire   [17:0] r_V_1_fu_195_p2;
reg   [17:0] r_V_1_reg_967;
wire   [16:0] trunc_ln790_1_fu_201_p1;
reg   [16:0] trunc_ln790_1_reg_972;
wire   [0:0] icmp_ln879_fu_205_p2;
reg   [0:0] icmp_ln879_reg_977;
wire   [0:0] icmp_ln879_2_fu_210_p2;
reg   [0:0] icmp_ln879_2_reg_985;
wire   [0:0] icmp_ln879_3_fu_215_p2;
reg   [0:0] icmp_ln879_3_reg_991;
wire   [17:0] select_ln340_fu_225_p3;
reg   [17:0] select_ln340_reg_997;
wire   [17:0] cos_lut_word_V_fu_237_p3;
reg   [17:0] cos_lut_word_V_reg_1003;
wire  signed [17:0] p_Val2_s_fu_347_p3;
reg  signed [17:0] p_Val2_s_reg_1015;
reg  signed [17:0] p_Val2_s_reg_1015_pp0_iter6_reg;
reg  signed [17:0] p_Val2_s_reg_1015_pp0_iter7_reg;
wire  signed [17:0] sin_lut_word_V_5_fu_382_p3;
reg  signed [17:0] sin_lut_word_V_5_reg_1021;
reg  signed [17:0] sin_lut_word_V_5_reg_1021_pp0_iter6_reg;
reg  signed [17:0] sin_lut_word_V_5_reg_1021_pp0_iter7_reg;
reg  signed [17:0] sin_lut_word_V_5_reg_1021_pp0_iter8_reg;
reg   [15:0] fine_word_V_reg_1027;
wire   [6:0] trunc_ln1192_fu_389_p1;
reg   [6:0] trunc_ln1192_reg_1032;
reg   [6:0] trunc_ln1192_reg_1032_pp0_iter6_reg;
reg   [6:0] trunc_ln1192_reg_1032_pp0_iter7_reg;
reg   [6:0] trunc_ln1192_reg_1032_pp0_iter8_reg;
wire   [33:0] zext_ln1118_fu_396_p1;
wire  signed [43:0] grp_fu_874_p3;
reg  signed [43:0] ret_V_reg_1053;
reg  signed [43:0] ret_V_reg_1053_pp0_iter9_reg;
reg   [0:0] p_Result_s_17_reg_1060;
reg   [0:0] p_Result_s_17_reg_1060_pp0_iter9_reg;
reg   [0:0] p_Result_s_17_reg_1060_pp0_iter10_reg;
reg   [0:0] p_Result_s_17_reg_1060_pp0_iter11_reg;
wire   [25:0] trunc_ln718_fu_420_p1;
reg   [25:0] trunc_ln718_reg_1068;
reg   [0:0] p_Result_1_reg_1073;
reg   [0:0] p_Result_1_reg_1073_pp0_iter9_reg;
reg   [0:0] p_Result_1_reg_1073_pp0_iter10_reg;
reg   [0:0] p_Result_1_reg_1073_pp0_iter11_reg;
wire  signed [33:0] grp_fu_885_p2;
reg  signed [33:0] r_V_3_reg_1079;
wire   [31:0] trunc_ln1192_1_fu_430_p1;
reg   [31:0] trunc_ln1192_1_reg_1084;
wire   [0:0] r_1_fu_433_p2;
reg   [0:0] r_1_reg_1089;
wire   [43:0] ret_V_1_fu_459_p2;
reg   [43:0] ret_V_1_reg_1094;
reg   [43:0] ret_V_1_reg_1094_pp0_iter10_reg;
reg   [0:0] p_Result_3_reg_1100;
reg   [0:0] p_Result_3_reg_1100_pp0_iter10_reg;
reg   [0:0] p_Result_3_reg_1100_pp0_iter11_reg;
reg   [0:0] p_Result_3_reg_1100_pp0_iter12_reg;
wire   [31:0] add_ln713_fu_473_p2;
reg   [31:0] add_ln713_reg_1108;
reg   [31:0] add_ln713_reg_1108_pp0_iter10_reg;
wire   [25:0] trunc_ln718_1_fu_478_p1;
reg   [25:0] trunc_ln718_1_reg_1113;
reg   [0:0] p_Result_4_reg_1118;
reg   [0:0] p_Result_4_reg_1118_pp0_iter10_reg;
reg   [0:0] p_Result_4_reg_1118_pp0_iter11_reg;
reg   [0:0] p_Result_4_reg_1118_pp0_iter12_reg;
wire   [15:0] p_Val2_8_fu_528_p2;
reg   [15:0] p_Val2_8_reg_1124;
reg   [15:0] p_Val2_8_reg_1124_pp0_iter11_reg;
reg   [0:0] tmp_5_reg_1130;
reg   [0:0] tmp_5_reg_1130_pp0_iter11_reg;
reg   [0:0] p_Result_2_reg_1136;
reg   [0:0] p_Result_2_reg_1136_pp0_iter11_reg;
wire   [14:0] trunc_ln790_2_fu_550_p1;
reg   [14:0] trunc_ln790_2_reg_1142;
wire   [0:0] r_2_fu_554_p2;
reg   [0:0] r_2_reg_1147;
wire   [0:0] icmp_ln790_fu_559_p2;
reg   [0:0] icmp_ln790_reg_1152;
wire   [15:0] p_Val2_13_fu_602_p2;
reg   [15:0] p_Val2_13_reg_1157;
reg   [15:0] p_Val2_13_reg_1157_pp0_iter12_reg;
reg   [0:0] tmp_11_reg_1163;
reg   [0:0] tmp_11_reg_1163_pp0_iter12_reg;
reg   [0:0] p_Result_5_reg_1169;
reg   [0:0] p_Result_5_reg_1169_pp0_iter12_reg;
wire   [14:0] trunc_ln790_3_fu_624_p1;
reg   [14:0] trunc_ln790_3_reg_1175;
wire   [15:0] cos_dds_V_fu_735_p3;
reg   [15:0] cos_dds_V_reg_1180;
wire   [0:0] icmp_ln790_1_fu_743_p2;
reg   [0:0] icmp_ln790_1_reg_1185;
reg    ap_block_pp0_stage0_subdone;
wire   [63:0] zext_ln544_fu_166_p1;
wire   [63:0] zext_ln544_1_fu_175_p1;
wire   [63:0] zext_ln544_2_fu_244_p1;
wire   [0:0] underflow_fu_220_p2;
wire   [0:0] underflow_1_fu_232_p2;
wire   [16:0] select_ln879_1_fu_254_p3;
wire   [0:0] xor_ln879_fu_264_p2;
wire   [0:0] and_ln879_fu_269_p2;
wire   [0:0] xor_ln879_1_fu_280_p2;
wire   [0:0] and_ln879_1_fu_285_p2;
wire   [17:0] select_ln879_fu_248_p3;
wire   [17:0] select_ln879_2_fu_274_p3;
wire   [0:0] and_ln879_2_fu_298_p2;
wire   [17:0] select_ln879_3_fu_290_p3;
wire   [0:0] or_ln879_fu_309_p2;
wire   [0:0] or_ln879_1_fu_313_p2;
wire   [0:0] xor_ln879_2_fu_318_p2;
wire   [0:0] and_ln879_3_fu_324_p2;
wire   [17:0] select_ln879_4_fu_302_p3;
wire   [0:0] xor_ln879_3_fu_336_p2;
wire   [0:0] and_ln879_4_fu_342_p2;
wire   [17:0] zext_ln879_fu_260_p1;
wire   [17:0] select_ln879_5_fu_329_p3;
wire   [17:0] sin_lut_word_V_1_fu_355_p3;
wire   [0:0] or_ln879_2_fu_368_p2;
wire   [17:0] sin_lut_word_V_2_fu_361_p3;
wire   [17:0] sin_lut_word_V_3_fu_374_p3;
wire  signed [42:0] lhs_V_fu_402_p3;
wire   [42:0] lhs_V_1_fu_438_p3;
wire  signed [43:0] rhs_V_1_fu_449_p1;
wire  signed [43:0] sext_ln728_1_fu_445_p1;
wire   [31:0] trunc_ln1_fu_452_p3;
wire   [0:0] tmp_2_fu_499_p3;
wire   [0:0] tmp_4_fu_511_p3;
wire   [0:0] or_ln412_fu_506_p2;
wire   [0:0] and_ln415_fu_518_p2;
wire   [15:0] zext_ln415_fu_524_p1;
wire   [15:0] p_Val2_6_fu_490_p4;
wire   [0:0] tmp_8_fu_573_p3;
wire   [0:0] tmp_10_fu_585_p3;
wire   [0:0] r_fu_580_p2;
wire   [0:0] and_ln415_1_fu_592_p2;
wire   [15:0] zext_ln415_1_fu_598_p1;
wire   [15:0] p_Val2_12_fu_564_p4;
wire   [0:0] xor_ln416_fu_628_p2;
wire   [0:0] carry_1_fu_633_p2;
wire   [0:0] xor_ln779_fu_638_p2;
wire   [0:0] xor_ln781_2_fu_650_p2;
wire   [0:0] xor_ln785_fu_660_p2;
wire   [0:0] or_ln785_fu_665_p2;
wire   [0:0] deleted_ones_fu_643_p3;
wire   [0:0] and_ln786_fu_676_p2;
wire   [0:0] xor_ln786_fu_681_p2;
wire   [0:0] empty_fu_687_p2;
wire   [0:0] or_ln781_fu_655_p2;
wire   [0:0] tmp_fu_692_p2;
wire   [0:0] underflow_2_fu_698_p2;
wire   [0:0] overflow_fu_670_p2;
wire   [0:0] xor_ln340_fu_709_p2;
wire   [0:0] or_ln340_fu_703_p2;
wire   [0:0] or_ln340_1_fu_715_p2;
wire   [15:0] select_ln340_2_fu_721_p3;
wire   [15:0] select_ln388_fu_728_p3;
wire   [0:0] xor_ln416_1_fu_748_p2;
wire   [0:0] carry_3_fu_753_p2;
wire   [0:0] xor_ln779_1_fu_758_p2;
wire   [0:0] xor_ln781_fu_770_p2;
wire   [0:0] xor_ln785_1_fu_780_p2;
wire   [0:0] or_ln785_1_fu_785_p2;
wire   [0:0] deleted_ones_1_fu_763_p3;
wire   [0:0] and_ln786_1_fu_796_p2;
wire   [0:0] xor_ln786_1_fu_801_p2;
wire   [0:0] empty_18_fu_807_p2;
wire   [0:0] or_ln781_1_fu_775_p2;
wire   [0:0] tmp46_fu_812_p2;
wire   [0:0] underflow_3_fu_818_p2;
wire   [0:0] overflow_1_fu_790_p2;
wire   [0:0] xor_ln340_1_fu_829_p2;
wire   [0:0] or_ln340_2_fu_823_p2;
wire   [0:0] or_ln340_3_fu_835_p2;
wire   [15:0] select_ln340_4_fu_841_p3;
wire   [15:0] select_ln388_1_fu_848_p3;
wire   [15:0] sin_dds_V_fu_855_p3;
wire   [15:0] grp_fu_874_p0;
wire   [15:0] grp_fu_885_p0;
reg    grp_fu_874_ce;
reg    grp_fu_885_ce;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to12;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ap_enable_reg_pp0_iter3 = 1'b0;
#0 ap_enable_reg_pp0_iter4 = 1'b0;
#0 ap_enable_reg_pp0_iter5 = 1'b0;
#0 ap_enable_reg_pp0_iter6 = 1'b0;
#0 ap_enable_reg_pp0_iter7 = 1'b0;
#0 ap_enable_reg_pp0_iter8 = 1'b0;
#0 ap_enable_reg_pp0_iter9 = 1'b0;
#0 ap_enable_reg_pp0_iter10 = 1'b0;
#0 ap_enable_reg_pp0_iter11 = 1'b0;
#0 ap_enable_reg_pp0_iter12 = 1'b0;
#0 ap_enable_reg_pp0_iter13 = 1'b0;
end

phase_to_sincos_ccud #(
    .DataWidth( 17 ),
    .AddressRange( 1024 ),
    .AddressWidth( 10 ))
cos_lut_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(cos_lut_address0),
    .ce0(cos_lut_ce0),
    .q0(cos_lut_q0),
    .address1(cos_lut_address1),
    .ce1(cos_lut_ce1),
    .q1(cos_lut_q1)
);

phase_to_sincos_fdEe #(
    .DataWidth( 16 ),
    .AddressRange( 512 ),
    .AddressWidth( 9 ))
fine_lut_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(fine_lut_address0),
    .ce0(fine_lut_ce0),
    .q0(fine_lut_q0)
);

resonator_dds_maceOg #(
    .ID( 1 ),
    .NUM_STAGE( 3 ),
    .din0_WIDTH( 16 ),
    .din1_WIDTH( 18 ),
    .din2_WIDTH( 43 ),
    .dout_WIDTH( 44 ))
resonator_dds_maceOg_U24(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(grp_fu_874_p0),
    .din1(sin_lut_word_V_5_reg_1021),
    .din2(lhs_V_fu_402_p3),
    .ce(grp_fu_874_ce),
    .dout(grp_fu_874_p3)
);

resonator_dds_mulfYi #(
    .ID( 1 ),
    .NUM_STAGE( 3 ),
    .din0_WIDTH( 16 ),
    .din1_WIDTH( 18 ),
    .dout_WIDTH( 34 ))
resonator_dds_mulfYi_U25(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(grp_fu_885_p0),
    .din1(p_Val2_s_reg_1015),
    .ce(grp_fu_885_ce),
    .dout(grp_fu_885_p2)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter1 <= ap_start;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter10 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter10 <= ap_enable_reg_pp0_iter9;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter11 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter11 <= ap_enable_reg_pp0_iter10;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter12 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter12 <= ap_enable_reg_pp0_iter11;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter13 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter13 <= ap_enable_reg_pp0_iter12;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter3 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter3 <= ap_enable_reg_pp0_iter2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter4 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter4 <= ap_enable_reg_pp0_iter3;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter5 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter5 <= ap_enable_reg_pp0_iter4;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter6 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter6 <= ap_enable_reg_pp0_iter5;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter7 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter7 <= ap_enable_reg_pp0_iter6;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter8 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter8 <= ap_enable_reg_pp0_iter7;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter9 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter9 <= ap_enable_reg_pp0_iter8;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_ce) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        add_ln713_reg_1108 <= add_ln713_fu_473_p2;
        add_ln713_reg_1108_pp0_iter10_reg <= add_ln713_reg_1108;
        cos_dds_V_reg_1180 <= cos_dds_V_fu_735_p3;
        cos_lut_word_V_reg_1003 <= cos_lut_word_V_fu_237_p3;
        fine_word_V_reg_1027 <= fine_lut_q0;
        icmp_ln790_1_reg_1185 <= icmp_ln790_1_fu_743_p2;
        icmp_ln790_reg_1152 <= icmp_ln790_fu_559_p2;
        icmp_ln879_1_reg_920_pp0_iter2_reg <= icmp_ln879_1_reg_920;
        icmp_ln879_1_reg_920_pp0_iter3_reg <= icmp_ln879_1_reg_920_pp0_iter2_reg;
        icmp_ln879_1_reg_920_pp0_iter4_reg <= icmp_ln879_1_reg_920_pp0_iter3_reg;
        icmp_ln879_2_reg_985 <= icmp_ln879_2_fu_210_p2;
        icmp_ln879_3_reg_991 <= icmp_ln879_3_fu_215_p2;
        icmp_ln879_reg_977 <= icmp_ln879_fu_205_p2;
        msb_V_reg_897_pp0_iter2_reg <= msb_V_reg_897_pp0_iter1_reg;
        msb_V_reg_897_pp0_iter3_reg <= msb_V_reg_897_pp0_iter2_reg;
        p_Result_1_reg_1073 <= grp_fu_874_p3[32'd42];
        p_Result_1_reg_1073_pp0_iter10_reg <= p_Result_1_reg_1073_pp0_iter9_reg;
        p_Result_1_reg_1073_pp0_iter11_reg <= p_Result_1_reg_1073_pp0_iter10_reg;
        p_Result_1_reg_1073_pp0_iter9_reg <= p_Result_1_reg_1073;
        p_Result_2_reg_1136 <= p_Val2_8_fu_528_p2[32'd15];
        p_Result_2_reg_1136_pp0_iter11_reg <= p_Result_2_reg_1136;
        p_Result_3_reg_1100 <= ret_V_1_fu_459_p2[32'd43];
        p_Result_3_reg_1100_pp0_iter10_reg <= p_Result_3_reg_1100;
        p_Result_3_reg_1100_pp0_iter11_reg <= p_Result_3_reg_1100_pp0_iter10_reg;
        p_Result_3_reg_1100_pp0_iter12_reg <= p_Result_3_reg_1100_pp0_iter11_reg;
        p_Result_4_reg_1118 <= ret_V_1_fu_459_p2[32'd42];
        p_Result_4_reg_1118_pp0_iter10_reg <= p_Result_4_reg_1118;
        p_Result_4_reg_1118_pp0_iter11_reg <= p_Result_4_reg_1118_pp0_iter10_reg;
        p_Result_4_reg_1118_pp0_iter12_reg <= p_Result_4_reg_1118_pp0_iter11_reg;
        p_Result_5_reg_1169 <= p_Val2_13_fu_602_p2[32'd15];
        p_Result_5_reg_1169_pp0_iter12_reg <= p_Result_5_reg_1169;
        p_Result_s_17_reg_1060 <= grp_fu_874_p3[32'd43];
        p_Result_s_17_reg_1060_pp0_iter10_reg <= p_Result_s_17_reg_1060_pp0_iter9_reg;
        p_Result_s_17_reg_1060_pp0_iter11_reg <= p_Result_s_17_reg_1060_pp0_iter10_reg;
        p_Result_s_17_reg_1060_pp0_iter9_reg <= p_Result_s_17_reg_1060;
        p_Result_s_reg_892_pp0_iter2_reg <= p_Result_s_reg_892_pp0_iter1_reg;
        p_Result_s_reg_892_pp0_iter3_reg <= p_Result_s_reg_892_pp0_iter2_reg;
        p_Val2_13_reg_1157 <= p_Val2_13_fu_602_p2;
        p_Val2_13_reg_1157_pp0_iter12_reg <= p_Val2_13_reg_1157;
        p_Val2_8_reg_1124 <= p_Val2_8_fu_528_p2;
        p_Val2_8_reg_1124_pp0_iter11_reg <= p_Val2_8_reg_1124;
        p_Val2_s_reg_1015 <= p_Val2_s_fu_347_p3;
        p_Val2_s_reg_1015_pp0_iter6_reg <= p_Val2_s_reg_1015;
        p_Val2_s_reg_1015_pp0_iter7_reg <= p_Val2_s_reg_1015_pp0_iter6_reg;
        r_1_reg_1089 <= r_1_fu_433_p2;
        r_2_reg_1147 <= r_2_fu_554_p2;
        r_V_1_reg_967 <= r_V_1_fu_195_p2;
        r_V_3_reg_1079 <= grp_fu_885_p2;
        r_V_reg_957 <= r_V_fu_185_p2;
        ret_V_1_reg_1094 <= ret_V_1_fu_459_p2;
        ret_V_1_reg_1094_pp0_iter10_reg <= ret_V_1_reg_1094;
        ret_V_reg_1053_pp0_iter9_reg <= ret_V_reg_1053;
        select_ln340_reg_997 <= select_ln340_fu_225_p3;
        sin_lut_word_V_5_reg_1021 <= sin_lut_word_V_5_fu_382_p3;
        sin_lut_word_V_5_reg_1021_pp0_iter6_reg <= sin_lut_word_V_5_reg_1021;
        sin_lut_word_V_5_reg_1021_pp0_iter7_reg <= sin_lut_word_V_5_reg_1021_pp0_iter6_reg;
        sin_lut_word_V_5_reg_1021_pp0_iter8_reg <= sin_lut_word_V_5_reg_1021_pp0_iter7_reg;
        sin_lut_word_V_reg_939_pp0_iter3_reg <= sin_lut_word_V_reg_939;
        sin_lut_word_V_reg_939_pp0_iter4_reg <= sin_lut_word_V_reg_939_pp0_iter3_reg;
        tmp_11_reg_1163 <= p_Val2_13_fu_602_p2[32'd15];
        tmp_11_reg_1163_pp0_iter12_reg <= tmp_11_reg_1163;
        tmp_5_reg_1130 <= p_Val2_8_fu_528_p2[32'd15];
        tmp_5_reg_1130_pp0_iter11_reg <= tmp_5_reg_1130;
        trunc_ln1192_1_reg_1084 <= trunc_ln1192_1_fu_430_p1;
        trunc_ln1192_reg_1032 <= trunc_ln1192_fu_389_p1;
        trunc_ln1192_reg_1032_pp0_iter6_reg <= trunc_ln1192_reg_1032;
        trunc_ln1192_reg_1032_pp0_iter7_reg <= trunc_ln1192_reg_1032_pp0_iter6_reg;
        trunc_ln1192_reg_1032_pp0_iter8_reg <= trunc_ln1192_reg_1032_pp0_iter7_reg;
        trunc_ln718_1_reg_1113 <= trunc_ln718_1_fu_478_p1;
        trunc_ln718_reg_1068 <= trunc_ln718_fu_420_p1;
        trunc_ln790_1_reg_972 <= trunc_ln790_1_fu_201_p1;
        trunc_ln790_2_reg_1142 <= trunc_ln790_2_fu_550_p1;
        trunc_ln790_3_reg_1175 <= trunc_ln790_3_fu_624_p1;
        trunc_ln790_reg_962 <= trunc_ln790_fu_191_p1;
        zext_ln203_1_reg_952[16 : 0] <= zext_ln203_1_fu_182_p1[16 : 0];
        zext_ln203_1_reg_952_pp0_iter4_reg[16 : 0] <= zext_ln203_1_reg_952[16 : 0];
        zext_ln203_reg_945[16 : 0] <= zext_ln203_fu_179_p1[16 : 0];
        zext_ln203_reg_945_pp0_iter4_reg[16 : 0] <= zext_ln203_reg_945[16 : 0];
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_ce) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        cos_lut_word_V_3_reg_934 <= cos_lut_q0;
        sin_lut_word_V_reg_939 <= cos_lut_q1;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_ce) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln879_1_reg_920 <= icmp_ln879_1_fu_170_p2;
        lsb_V_reg_904 <= {{acc_V[19:10]}};
        msb_V_reg_897 <= {{acc_V[21:20]}};
        msb_V_reg_897_pp0_iter1_reg <= msb_V_reg_897;
        p_Result_s_reg_892 <= {{acc_V[9:1]}};
        p_Result_s_reg_892_pp0_iter1_reg <= p_Result_s_reg_892;
        sin_adr_V_reg_910 <= sin_adr_V_fu_160_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_ce) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter8 == 1'b1))) begin
        ret_V_reg_1053 <= grp_fu_874_p3;
    end
end

always @ (*) begin
    if ((((1'b1 == ap_ce) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter13 == 1'b1)) | ((ap_start == 1'b0) & (1'b0 == ap_block_pp0_stage0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (ap_idle_pp0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter13 == 1'b0) & (ap_enable_reg_pp0_iter12 == 1'b0) & (ap_enable_reg_pp0_iter11 == 1'b0) & (ap_enable_reg_pp0_iter10 == 1'b0) & (ap_enable_reg_pp0_iter9 == 1'b0) & (ap_enable_reg_pp0_iter8 == 1'b0) & (ap_enable_reg_pp0_iter7 == 1'b0) & (ap_enable_reg_pp0_iter6 == 1'b0) & (ap_enable_reg_pp0_iter5 == 1'b0) & (ap_enable_reg_pp0_iter4 == 1'b0) & (ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter12 == 1'b0) & (ap_enable_reg_pp0_iter11 == 1'b0) & (ap_enable_reg_pp0_iter10 == 1'b0) & (ap_enable_reg_pp0_iter9 == 1'b0) & (ap_enable_reg_pp0_iter8 == 1'b0) & (ap_enable_reg_pp0_iter7 == 1'b0) & (ap_enable_reg_pp0_iter6 == 1'b0) & (ap_enable_reg_pp0_iter5 == 1'b0) & (ap_enable_reg_pp0_iter4 == 1'b0) & (ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0_0to12 = 1'b1;
    end else begin
        ap_idle_pp0_0to12 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_ce) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (ap_idle_pp0_0to12 == 1'b1))) begin
        ap_reset_idle_pp0 = 1'b1;
    end else begin
        ap_reset_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_ce) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        cos_lut_ce0 = 1'b1;
    end else begin
        cos_lut_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_ce) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        cos_lut_ce1 = 1'b1;
    end else begin
        cos_lut_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_ce) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter4 == 1'b1))) begin
        fine_lut_ce0 = 1'b1;
    end else begin
        fine_lut_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_ce) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        grp_fu_874_ce = 1'b1;
    end else begin
        grp_fu_874_ce = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_ce) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        grp_fu_885_ce = 1'b1;
    end else begin
        grp_fu_885_ce = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln713_fu_473_p2 = (trunc_ln1_fu_452_p3 + trunc_ln1192_1_reg_1084);

assign and_ln415_1_fu_592_p2 = (tmp_10_fu_585_p3 & r_fu_580_p2);

assign and_ln415_fu_518_p2 = (tmp_4_fu_511_p3 & or_ln412_fu_506_p2);

assign and_ln786_1_fu_796_p2 = (p_Result_5_reg_1169_pp0_iter12_reg & deleted_ones_1_fu_763_p3);

assign and_ln786_fu_676_p2 = (p_Result_2_reg_1136_pp0_iter11_reg & deleted_ones_fu_643_p3);

assign and_ln879_1_fu_285_p2 = (xor_ln879_1_fu_280_p2 & icmp_ln879_2_reg_985);

assign and_ln879_2_fu_298_p2 = (icmp_ln879_reg_977 & icmp_ln879_1_reg_920_pp0_iter4_reg);

assign and_ln879_3_fu_324_p2 = (xor_ln879_2_fu_318_p2 & icmp_ln879_1_reg_920_pp0_iter4_reg);

assign and_ln879_4_fu_342_p2 = (xor_ln879_3_fu_336_p2 & icmp_ln879_3_reg_991);

assign and_ln879_fu_269_p2 = (xor_ln879_fu_264_p2 & icmp_ln879_reg_977);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_start == 1'b0) & (ap_start == 1'b1));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((1'b0 == ap_ce) | ((ap_start == 1'b0) & (ap_start == 1'b1)));
end

assign ap_block_state10_pp0_stage0_iter9 = ~(1'b1 == 1'b1);

assign ap_block_state11_pp0_stage0_iter10 = ~(1'b1 == 1'b1);

assign ap_block_state12_pp0_stage0_iter11 = ~(1'b1 == 1'b1);

assign ap_block_state13_pp0_stage0_iter12 = ~(1'b1 == 1'b1);

assign ap_block_state14_pp0_stage0_iter13 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = (ap_start == 1'b0);
end

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state3_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_block_state4_pp0_stage0_iter3 = ~(1'b1 == 1'b1);

assign ap_block_state5_pp0_stage0_iter4 = ~(1'b1 == 1'b1);

assign ap_block_state6_pp0_stage0_iter5 = ~(1'b1 == 1'b1);

assign ap_block_state7_pp0_stage0_iter6 = ~(1'b1 == 1'b1);

assign ap_block_state8_pp0_stage0_iter7 = ~(1'b1 == 1'b1);

assign ap_block_state9_pp0_stage0_iter8 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start;

assign ap_return_0 = cos_dds_V_reg_1180;

assign ap_return_1 = sin_dds_V_fu_855_p3;

assign carry_1_fu_633_p2 = (xor_ln416_fu_628_p2 & p_Result_1_reg_1073_pp0_iter11_reg);

assign carry_3_fu_753_p2 = (xor_ln416_1_fu_748_p2 & p_Result_4_reg_1118_pp0_iter12_reg);

assign cos_dds_V_fu_735_p3 = ((or_ln340_1_fu_715_p2[0:0] === 1'b1) ? select_ln340_2_fu_721_p3 : select_ln388_fu_728_p3);

assign cos_lut_address0 = zext_ln544_fu_166_p1;

assign cos_lut_address1 = zext_ln544_1_fu_175_p1;

assign cos_lut_word_V_fu_237_p3 = ((underflow_1_fu_232_p2[0:0] === 1'b1) ? 18'd131073 : r_V_1_reg_967);

assign deleted_ones_1_fu_763_p3 = ((carry_3_fu_753_p2[0:0] === 1'b1) ? xor_ln779_1_fu_758_p2 : p_Result_3_reg_1100_pp0_iter12_reg);

assign deleted_ones_fu_643_p3 = ((carry_1_fu_633_p2[0:0] === 1'b1) ? xor_ln779_fu_638_p2 : p_Result_s_17_reg_1060_pp0_iter11_reg);

assign empty_18_fu_807_p2 = (xor_ln786_1_fu_801_p2 | icmp_ln790_1_reg_1185);

assign empty_fu_687_p2 = (xor_ln786_fu_681_p2 | icmp_ln790_reg_1152);

assign fine_lut_address0 = zext_ln544_2_fu_244_p1;

assign grp_fu_874_p0 = zext_ln1118_fu_396_p1;

assign grp_fu_885_p0 = zext_ln1118_fu_396_p1;

assign icmp_ln790_1_fu_743_p2 = ((trunc_ln790_3_reg_1175 == 15'd0) ? 1'b1 : 1'b0);

assign icmp_ln790_fu_559_p2 = ((trunc_ln790_2_reg_1142 == 15'd0) ? 1'b1 : 1'b0);

assign icmp_ln879_1_fu_170_p2 = ((lsb_V_reg_904 == 10'd0) ? 1'b1 : 1'b0);

assign icmp_ln879_2_fu_210_p2 = ((msb_V_reg_897_pp0_iter3_reg == 2'd1) ? 1'b1 : 1'b0);

assign icmp_ln879_3_fu_215_p2 = ((msb_V_reg_897_pp0_iter3_reg == 2'd3) ? 1'b1 : 1'b0);

assign icmp_ln879_fu_205_p2 = ((msb_V_reg_897_pp0_iter3_reg == 2'd0) ? 1'b1 : 1'b0);

assign lhs_V_1_fu_438_p3 = {{sin_lut_word_V_5_reg_1021_pp0_iter8_reg}, {25'd0}};

assign lhs_V_fu_402_p3 = {{p_Val2_s_reg_1015_pp0_iter7_reg}, {25'd0}};

assign lsb_V_fu_150_p4 = {{acc_V[19:10]}};

assign or_ln340_1_fu_715_p2 = (xor_ln340_fu_709_p2 | overflow_fu_670_p2);

assign or_ln340_2_fu_823_p2 = (underflow_3_fu_818_p2 | overflow_1_fu_790_p2);

assign or_ln340_3_fu_835_p2 = (xor_ln340_1_fu_829_p2 | overflow_1_fu_790_p2);

assign or_ln340_fu_703_p2 = (underflow_2_fu_698_p2 | overflow_fu_670_p2);

assign or_ln412_fu_506_p2 = (tmp_2_fu_499_p3 | r_1_reg_1089);

assign or_ln781_1_fu_775_p2 = (xor_ln781_fu_770_p2 | tmp_11_reg_1163_pp0_iter12_reg);

assign or_ln781_fu_655_p2 = (xor_ln781_2_fu_650_p2 | tmp_5_reg_1130_pp0_iter11_reg);

assign or_ln785_1_fu_785_p2 = (xor_ln785_1_fu_780_p2 | p_Result_5_reg_1169_pp0_iter12_reg);

assign or_ln785_fu_665_p2 = (xor_ln785_fu_660_p2 | p_Result_2_reg_1136_pp0_iter11_reg);

assign or_ln879_1_fu_313_p2 = (or_ln879_fu_309_p2 | icmp_ln879_3_reg_991);

assign or_ln879_2_fu_368_p2 = (and_ln879_3_fu_324_p2 | and_ln879_2_fu_298_p2);

assign or_ln879_fu_309_p2 = (icmp_ln879_reg_977 | icmp_ln879_2_reg_985);

assign overflow_1_fu_790_p2 = (xor_ln779_1_fu_758_p2 & or_ln785_1_fu_785_p2);

assign overflow_fu_670_p2 = (xor_ln779_fu_638_p2 & or_ln785_fu_665_p2);

assign p_Val2_12_fu_564_p4 = {{ret_V_1_reg_1094_pp0_iter10_reg[42:27]}};

assign p_Val2_13_fu_602_p2 = (zext_ln415_1_fu_598_p1 + p_Val2_12_fu_564_p4);

assign p_Val2_6_fu_490_p4 = {{ret_V_reg_1053_pp0_iter9_reg[42:27]}};

assign p_Val2_8_fu_528_p2 = (zext_ln415_fu_524_p1 + p_Val2_6_fu_490_p4);

assign p_Val2_s_fu_347_p3 = ((and_ln879_4_fu_342_p2[0:0] === 1'b1) ? zext_ln879_fu_260_p1 : select_ln879_5_fu_329_p3);

assign r_1_fu_433_p2 = ((trunc_ln718_reg_1068 != 26'd0) ? 1'b1 : 1'b0);

assign r_2_fu_554_p2 = ((trunc_ln718_1_reg_1113 != 26'd0) ? 1'b1 : 1'b0);

assign r_V_1_fu_195_p2 = (18'd0 - zext_ln203_fu_179_p1);

assign r_V_fu_185_p2 = (18'd0 - zext_ln203_1_fu_182_p1);

assign r_fu_580_p2 = (tmp_8_fu_573_p3 | r_2_reg_1147);

assign ret_V_1_fu_459_p2 = ($signed(rhs_V_1_fu_449_p1) + $signed(sext_ln728_1_fu_445_p1));

assign rhs_V_1_fu_449_p1 = r_V_3_reg_1079;

assign select_ln340_2_fu_721_p3 = ((or_ln340_fu_703_p2[0:0] === 1'b1) ? 16'd32767 : p_Val2_8_reg_1124_pp0_iter11_reg);

assign select_ln340_4_fu_841_p3 = ((or_ln340_2_fu_823_p2[0:0] === 1'b1) ? 16'd32767 : p_Val2_13_reg_1157_pp0_iter12_reg);

assign select_ln340_fu_225_p3 = ((underflow_fu_220_p2[0:0] === 1'b1) ? 18'd131073 : r_V_reg_957);

assign select_ln388_1_fu_848_p3 = ((underflow_3_fu_818_p2[0:0] === 1'b1) ? 16'd32769 : p_Val2_13_reg_1157_pp0_iter12_reg);

assign select_ln388_fu_728_p3 = ((underflow_2_fu_698_p2[0:0] === 1'b1) ? 16'd32769 : p_Val2_8_reg_1124_pp0_iter11_reg);

assign select_ln879_1_fu_254_p3 = ((icmp_ln879_1_reg_920_pp0_iter4_reg[0:0] === 1'b1) ? 17'd0 : sin_lut_word_V_reg_939_pp0_iter4_reg);

assign select_ln879_2_fu_274_p3 = ((and_ln879_fu_269_p2[0:0] === 1'b1) ? zext_ln203_reg_945_pp0_iter4_reg : cos_lut_word_V_reg_1003);

assign select_ln879_3_fu_290_p3 = ((and_ln879_1_fu_285_p2[0:0] === 1'b1) ? select_ln879_fu_248_p3 : select_ln879_2_fu_274_p3);

assign select_ln879_4_fu_302_p3 = ((and_ln879_2_fu_298_p2[0:0] === 1'b1) ? zext_ln203_reg_945_pp0_iter4_reg : select_ln879_3_fu_290_p3);

assign select_ln879_5_fu_329_p3 = ((and_ln879_3_fu_324_p2[0:0] === 1'b1) ? cos_lut_word_V_reg_1003 : select_ln879_4_fu_302_p3);

assign select_ln879_fu_248_p3 = ((icmp_ln879_1_reg_920_pp0_iter4_reg[0:0] === 1'b1) ? 18'd0 : select_ln340_reg_997);

assign sext_ln728_1_fu_445_p1 = $signed(lhs_V_1_fu_438_p3);

assign sin_adr_V_fu_160_p2 = (10'd0 - lsb_V_fu_150_p4);

assign sin_dds_V_fu_855_p3 = ((or_ln340_3_fu_835_p2[0:0] === 1'b1) ? select_ln340_4_fu_841_p3 : select_ln388_1_fu_848_p3);

assign sin_lut_word_V_1_fu_355_p3 = ((and_ln879_fu_269_p2[0:0] === 1'b1) ? zext_ln203_1_reg_952_pp0_iter4_reg : select_ln340_reg_997);

assign sin_lut_word_V_2_fu_361_p3 = ((and_ln879_1_fu_285_p2[0:0] === 1'b1) ? zext_ln203_reg_945_pp0_iter4_reg : sin_lut_word_V_1_fu_355_p3);

assign sin_lut_word_V_3_fu_374_p3 = ((or_ln879_2_fu_368_p2[0:0] === 1'b1) ? 18'd0 : sin_lut_word_V_2_fu_361_p3);

assign sin_lut_word_V_5_fu_382_p3 = ((and_ln879_4_fu_342_p2[0:0] === 1'b1) ? cos_lut_word_V_reg_1003 : sin_lut_word_V_3_fu_374_p3);

assign tmp46_fu_812_p2 = (or_ln781_1_fu_775_p2 & empty_18_fu_807_p2);

assign tmp_10_fu_585_p3 = add_ln713_reg_1108_pp0_iter10_reg[32'd26];

assign tmp_2_fu_499_p3 = ret_V_reg_1053_pp0_iter9_reg[32'd27];

assign tmp_4_fu_511_p3 = ret_V_reg_1053_pp0_iter9_reg[32'd26];

assign tmp_8_fu_573_p3 = ret_V_1_reg_1094_pp0_iter10_reg[32'd27];

assign tmp_fu_692_p2 = (or_ln781_fu_655_p2 & empty_fu_687_p2);

assign trunc_ln1192_1_fu_430_p1 = grp_fu_885_p2[31:0];

assign trunc_ln1192_fu_389_p1 = sin_lut_word_V_5_fu_382_p3[6:0];

assign trunc_ln1_fu_452_p3 = {{trunc_ln1192_reg_1032_pp0_iter8_reg}, {25'd0}};

assign trunc_ln718_1_fu_478_p1 = ret_V_1_fu_459_p2[25:0];

assign trunc_ln718_fu_420_p1 = grp_fu_874_p3[25:0];

assign trunc_ln790_1_fu_201_p1 = r_V_1_fu_195_p2[16:0];

assign trunc_ln790_2_fu_550_p1 = p_Val2_8_fu_528_p2[14:0];

assign trunc_ln790_3_fu_624_p1 = p_Val2_13_fu_602_p2[14:0];

assign trunc_ln790_fu_191_p1 = r_V_fu_185_p2[16:0];

assign underflow_1_fu_232_p2 = ((trunc_ln790_1_reg_972 == 17'd0) ? 1'b1 : 1'b0);

assign underflow_2_fu_698_p2 = (tmp_fu_692_p2 & p_Result_s_17_reg_1060_pp0_iter11_reg);

assign underflow_3_fu_818_p2 = (tmp46_fu_812_p2 & p_Result_3_reg_1100_pp0_iter12_reg);

assign underflow_fu_220_p2 = ((trunc_ln790_reg_962 == 17'd0) ? 1'b1 : 1'b0);

assign xor_ln340_1_fu_829_p2 = (underflow_3_fu_818_p2 ^ 1'd1);

assign xor_ln340_fu_709_p2 = (underflow_2_fu_698_p2 ^ 1'd1);

assign xor_ln416_1_fu_748_p2 = (tmp_11_reg_1163_pp0_iter12_reg ^ 1'd1);

assign xor_ln416_fu_628_p2 = (tmp_5_reg_1130_pp0_iter11_reg ^ 1'd1);

assign xor_ln779_1_fu_758_p2 = (p_Result_3_reg_1100_pp0_iter12_reg ^ 1'd1);

assign xor_ln779_fu_638_p2 = (p_Result_s_17_reg_1060_pp0_iter11_reg ^ 1'd1);

assign xor_ln781_2_fu_650_p2 = (p_Result_1_reg_1073_pp0_iter11_reg ^ 1'd1);

assign xor_ln781_fu_770_p2 = (p_Result_4_reg_1118_pp0_iter12_reg ^ 1'd1);

assign xor_ln785_1_fu_780_p2 = (p_Result_3_reg_1100_pp0_iter12_reg ^ carry_3_fu_753_p2);

assign xor_ln785_fu_660_p2 = (p_Result_s_17_reg_1060_pp0_iter11_reg ^ carry_1_fu_633_p2);

assign xor_ln786_1_fu_801_p2 = (1'd1 ^ and_ln786_1_fu_796_p2);

assign xor_ln786_fu_681_p2 = (1'd1 ^ and_ln786_fu_676_p2);

assign xor_ln879_1_fu_280_p2 = (icmp_ln879_reg_977 ^ 1'd1);

assign xor_ln879_2_fu_318_p2 = (or_ln879_1_fu_313_p2 ^ 1'd1);

assign xor_ln879_3_fu_336_p2 = (or_ln879_fu_309_p2 ^ 1'd1);

assign xor_ln879_fu_264_p2 = (icmp_ln879_1_reg_920_pp0_iter4_reg ^ 1'd1);

assign zext_ln1118_fu_396_p1 = fine_word_V_reg_1027;

assign zext_ln203_1_fu_182_p1 = sin_lut_word_V_reg_939;

assign zext_ln203_fu_179_p1 = cos_lut_word_V_3_reg_934;

assign zext_ln415_1_fu_598_p1 = and_ln415_1_fu_592_p2;

assign zext_ln415_fu_524_p1 = and_ln415_fu_518_p2;

assign zext_ln544_1_fu_175_p1 = sin_adr_V_reg_910;

assign zext_ln544_2_fu_244_p1 = p_Result_s_reg_892_pp0_iter3_reg;

assign zext_ln544_fu_166_p1 = lsb_V_reg_904;

assign zext_ln879_fu_260_p1 = select_ln879_1_fu_254_p3;

always @ (posedge ap_clk) begin
    zext_ln203_reg_945[17] <= 1'b0;
    zext_ln203_reg_945_pp0_iter4_reg[17] <= 1'b0;
    zext_ln203_1_reg_952[17] <= 1'b0;
    zext_ln203_1_reg_952_pp0_iter4_reg[17] <= 1'b0;
end

endmodule //phase_to_sincos
