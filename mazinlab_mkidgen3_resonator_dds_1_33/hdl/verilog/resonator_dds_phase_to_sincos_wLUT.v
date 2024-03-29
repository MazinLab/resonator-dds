// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Version: 2021.1
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module resonator_dds_phase_to_sincos_wLUT (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        ap_ce,
        acc,
        ap_return
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input   ap_ce;
input  [20:0] acc;
output  [31:0] ap_return;

reg ap_done;
reg ap_idle;
reg ap_ready;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
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
reg    ap_enable_reg_pp0_iter14;
reg    ap_idle_pp0;
wire    ap_block_state1_pp0_stage0_iter0;
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
wire    ap_block_state15_pp0_stage0_iter14;
reg    ap_block_pp0_stage0_subdone;
wire   [9:0] cos_lut_address0;
reg    cos_lut_ce0;
wire   [16:0] cos_lut_q0;
wire   [9:0] cos_lut_address1;
reg    cos_lut_ce1;
wire   [16:0] cos_lut_q1;
wire   [8:0] fine_lut_address0;
reg    fine_lut_ce0;
wire   [15:0] fine_lut_q0;
wire   [8:0] fine_adr_V_fu_128_p1;
reg   [8:0] fine_adr_V_reg_844;
wire    ap_block_pp0_stage0_11001;
reg   [8:0] fine_adr_V_reg_844_pp0_iter1_reg;
reg   [8:0] fine_adr_V_reg_844_pp0_iter2_reg;
reg   [8:0] fine_adr_V_reg_844_pp0_iter3_reg;
reg   [1:0] msb_V_reg_849;
reg   [1:0] msb_V_reg_849_pp0_iter1_reg;
reg   [1:0] msb_V_reg_849_pp0_iter2_reg;
reg   [1:0] msb_V_reg_849_pp0_iter3_reg;
reg   [1:0] msb_V_reg_849_pp0_iter4_reg;
wire   [9:0] lsb_V_fu_142_p4;
reg   [9:0] lsb_V_reg_859;
wire   [9:0] sin_adr_V_fu_152_p2;
reg   [9:0] sin_adr_V_reg_865;
wire   [0:0] icmp_ln1049_fu_162_p2;
reg   [0:0] icmp_ln1049_reg_875;
reg   [0:0] icmp_ln1049_reg_875_pp0_iter2_reg;
reg   [0:0] icmp_ln1049_reg_875_pp0_iter3_reg;
reg   [0:0] icmp_ln1049_reg_875_pp0_iter4_reg;
reg   [0:0] icmp_ln1049_reg_875_pp0_iter5_reg;
reg   [16:0] r_6_reg_889;
reg   [16:0] r_8_reg_894;
reg   [16:0] r_8_reg_894_pp0_iter3_reg;
reg   [16:0] r_8_reg_894_pp0_iter4_reg;
reg   [16:0] r_8_reg_894_pp0_iter5_reg;
wire   [17:0] zext_ln712_fu_171_p1;
reg   [17:0] zext_ln712_reg_900;
reg   [17:0] zext_ln712_reg_900_pp0_iter4_reg;
wire   [17:0] r_7_fu_174_p2;
reg   [17:0] r_7_reg_907;
reg   [17:0] r_7_reg_907_pp0_iter4_reg;
wire   [16:0] trunc_ln799_fu_180_p1;
reg   [16:0] trunc_ln799_reg_912;
wire   [17:0] zext_ln712_1_fu_184_p1;
reg   [17:0] zext_ln712_1_reg_917;
reg   [17:0] zext_ln712_1_reg_917_pp0_iter4_reg;
wire   [17:0] r_9_fu_187_p2;
reg   [17:0] r_9_reg_922;
reg   [17:0] r_9_reg_922_pp0_iter4_reg;
wire   [16:0] trunc_ln799_1_fu_193_p1;
reg   [16:0] trunc_ln799_1_reg_927;
wire   [0:0] underflow_1_fu_197_p2;
reg   [0:0] underflow_1_reg_932;
wire   [0:0] underflow_fu_202_p2;
reg   [0:0] underflow_reg_937;
wire   [0:0] icmp_ln58_fu_207_p2;
reg   [0:0] icmp_ln58_reg_942;
wire   [17:0] cos_lut_word_V_8_fu_308_p3;
reg   [17:0] cos_lut_word_V_8_reg_953;
wire   [0:0] icmp_ln58_5_fu_316_p2;
reg   [0:0] icmp_ln58_5_reg_958;
wire  signed [17:0] sin_lut_word_V_fu_349_p3;
reg  signed [17:0] sin_lut_word_V_reg_963;
reg  signed [17:0] sin_lut_word_V_reg_963_pp0_iter6_reg;
reg  signed [17:0] sin_lut_word_V_reg_963_pp0_iter7_reg;
reg  signed [17:0] sin_lut_word_V_reg_963_pp0_iter8_reg;
reg  signed [17:0] sin_lut_word_V_reg_963_pp0_iter9_reg;
reg   [15:0] fine_word_V_reg_969;
wire   [1:0] trunc_ln1245_2_fu_357_p1;
reg   [1:0] trunc_ln1245_2_reg_974;
reg   [1:0] trunc_ln1245_2_reg_974_pp0_iter6_reg;
reg   [1:0] trunc_ln1245_2_reg_974_pp0_iter7_reg;
reg   [1:0] trunc_ln1245_2_reg_974_pp0_iter8_reg;
reg   [1:0] trunc_ln1245_2_reg_974_pp0_iter9_reg;
wire  signed [17:0] cos_lut_word_V_10_fu_371_p3;
reg  signed [17:0] cos_lut_word_V_10_reg_979;
reg  signed [17:0] cos_lut_word_V_10_reg_979_pp0_iter7_reg;
wire   [33:0] zext_ln1171_fu_380_p1;
wire  signed [43:0] grp_fu_826_p3;
reg  signed [43:0] ret_V_reg_1005;
reg  signed [43:0] ret_V_reg_1005_pp0_iter10_reg;
reg   [0:0] p_Result_10_reg_1012;
reg   [0:0] p_Result_10_reg_1012_pp0_iter10_reg;
reg   [0:0] p_Result_10_reg_1012_pp0_iter11_reg;
reg   [0:0] p_Result_10_reg_1012_pp0_iter12_reg;
wire   [25:0] trunc_ln727_fu_405_p1;
reg   [25:0] trunc_ln727_reg_1020;
reg   [0:0] p_Result_12_reg_1025;
reg   [0:0] p_Result_12_reg_1025_pp0_iter10_reg;
reg   [0:0] p_Result_12_reg_1025_pp0_iter11_reg;
reg   [0:0] p_Result_12_reg_1025_pp0_iter12_reg;
wire  signed [33:0] grp_fu_837_p2;
reg  signed [33:0] r_V_3_reg_1031;
wire   [26:0] trunc_ln1245_fu_415_p1;
reg   [26:0] trunc_ln1245_reg_1037;
wire   [0:0] r_fu_418_p2;
reg   [0:0] r_reg_1042;
wire   [26:0] add_ln1245_1_fu_453_p2;
reg   [26:0] add_ln1245_1_reg_1047;
reg   [26:0] add_ln1245_1_reg_1047_pp0_iter11_reg;
wire   [42:0] add_ln1245_2_fu_458_p2;
reg   [42:0] add_ln1245_2_reg_1052;
reg   [42:0] add_ln1245_2_reg_1052_pp0_iter11_reg;
reg   [0:0] p_Result_14_reg_1058;
reg   [0:0] p_Result_14_reg_1058_pp0_iter11_reg;
reg   [0:0] p_Result_14_reg_1058_pp0_iter12_reg;
reg   [0:0] p_Result_14_reg_1058_pp0_iter13_reg;
wire   [25:0] trunc_ln727_1_fu_472_p1;
reg   [25:0] trunc_ln727_1_reg_1066;
reg   [0:0] p_Result_16_reg_1071;
reg   [0:0] p_Result_16_reg_1071_pp0_iter11_reg;
reg   [0:0] p_Result_16_reg_1071_pp0_iter12_reg;
reg   [0:0] p_Result_16_reg_1071_pp0_iter13_reg;
wire   [15:0] p_Val2_4_fu_522_p2;
reg   [15:0] p_Val2_4_reg_1077;
reg   [15:0] p_Val2_4_reg_1077_pp0_iter12_reg;
reg   [0:0] p_Result_13_reg_1082;
reg   [0:0] p_Result_13_reg_1082_pp0_iter12_reg;
wire   [14:0] trunc_ln799_2_fu_536_p1;
reg   [14:0] trunc_ln799_2_reg_1090;
wire   [0:0] r_5_fu_540_p2;
reg   [0:0] r_5_reg_1095;
wire   [0:0] icmp_ln799_fu_545_p2;
reg   [0:0] icmp_ln799_reg_1100;
wire   [15:0] p_Val2_7_fu_588_p2;
reg   [15:0] p_Val2_7_reg_1105;
reg   [15:0] p_Val2_7_reg_1105_pp0_iter13_reg;
reg   [0:0] p_Result_17_reg_1110;
reg   [0:0] p_Result_17_reg_1110_pp0_iter13_reg;
wire   [14:0] trunc_ln799_3_fu_602_p1;
reg   [14:0] trunc_ln799_3_reg_1118;
wire   [15:0] i_V_fu_703_p3;
reg   [15:0] i_V_reg_1123;
wire   [0:0] icmp_ln799_2_fu_710_p2;
reg   [0:0] icmp_ln799_2_reg_1128;
wire   [63:0] zext_ln573_fu_158_p1;
wire    ap_block_pp0_stage0;
wire   [63:0] zext_ln573_1_fu_167_p1;
wire   [63:0] zext_ln573_2_fu_212_p1;
wire   [17:0] select_ln340_fu_222_p3;
wire   [0:0] xor_ln1049_fu_235_p2;
wire   [0:0] and_ln1049_fu_240_p2;
wire   [17:0] cos_lut_word_V_fu_216_p3;
wire   [0:0] icmp_ln58_1_fu_252_p2;
wire   [17:0] cos_lut_word_V_3_fu_228_p3;
wire   [17:0] cos_lut_word_V_5_fu_245_p3;
wire   [0:0] and_ln1049_1_fu_265_p2;
wire   [17:0] cos_lut_word_V_6_fu_257_p3;
wire   [0:0] icmp_ln58_3_fu_281_p2;
wire   [0:0] icmp_ln58_4_fu_286_p2;
wire   [0:0] icmp_ln58_2_fu_276_p2;
wire   [0:0] and_ln1049_3_fu_297_p2;
wire   [0:0] and_ln1049_2_fu_291_p2;
wire   [0:0] and_ln1049_4_fu_302_p2;
wire   [17:0] cos_lut_word_V_7_fu_269_p3;
wire   [17:0] sin_lut_word_V_3_fu_321_p3;
wire   [0:0] or_ln1049_fu_335_p2;
wire   [17:0] sin_lut_word_V_4_fu_328_p3;
wire   [17:0] sin_lut_word_V_5_fu_341_p3;
wire   [16:0] cos_lut_word_V_4_fu_361_p3;
wire   [17:0] zext_ln47_fu_367_p1;
wire  signed [42:0] lhs_1_fu_387_p3;
wire  signed [42:0] lhs_2_fu_423_p3;
wire  signed [43:0] sext_ln1245_fu_430_p1;
wire  signed [43:0] sext_ln712_1_fu_434_p1;
wire   [26:0] trunc_ln1245_1_fu_440_p3;
wire  signed [42:0] sext_ln1245_1_fu_437_p1;
wire   [43:0] ret_V_1_fu_447_p2;
wire   [0:0] p_Result_s_fu_493_p3;
wire   [0:0] or_ln412_fu_507_p2;
wire   [0:0] p_Result_11_fu_500_p3;
wire   [0:0] and_ln412_fu_512_p2;
wire   [15:0] p_Val2_3_fu_484_p4;
wire   [15:0] zext_ln415_fu_518_p1;
wire   [0:0] p_Result_5_fu_559_p3;
wire   [0:0] or_ln412_1_fu_573_p2;
wire   [0:0] p_Result_15_fu_566_p3;
wire   [0:0] and_ln412_1_fu_578_p2;
wire   [15:0] p_Val2_6_fu_550_p4;
wire   [15:0] zext_ln415_1_fu_584_p1;
wire   [0:0] xor_ln416_fu_606_p2;
wire   [0:0] carry_1_fu_611_p2;
wire   [0:0] Range1_all_zeros_fu_616_p2;
wire   [0:0] xor_ln790_fu_635_p2;
wire   [0:0] deleted_zeros_fu_621_p3;
wire   [0:0] xor_ln794_fu_645_p2;
wire   [0:0] or_ln794_fu_651_p2;
wire   [0:0] deleted_ones_fu_628_p3;
wire   [0:0] and_ln795_fu_662_p2;
wire   [0:0] xor_ln795_fu_667_p2;
wire   [0:0] or_ln790_fu_640_p2;
wire   [0:0] or_ln797_fu_673_p2;
wire   [0:0] and_ln797_fu_678_p2;
wire   [0:0] overflow_fu_656_p2;
wire   [0:0] underflow_2_fu_684_p2;
wire   [0:0] or_ln384_fu_697_p2;
wire   [15:0] select_ln384_fu_689_p3;
wire   [0:0] xor_ln416_1_fu_715_p2;
wire   [0:0] carry_3_fu_720_p2;
wire   [0:0] Range1_all_zeros_1_fu_725_p2;
wire   [0:0] xor_ln790_1_fu_744_p2;
wire   [0:0] deleted_zeros_1_fu_730_p3;
wire   [0:0] xor_ln794_1_fu_754_p2;
wire   [0:0] or_ln794_1_fu_760_p2;
wire   [0:0] deleted_ones_1_fu_737_p3;
wire   [0:0] and_ln795_1_fu_771_p2;
wire   [0:0] xor_ln795_1_fu_776_p2;
wire   [0:0] or_ln790_1_fu_749_p2;
wire   [0:0] or_ln797_1_fu_782_p2;
wire   [0:0] and_ln797_2_fu_787_p2;
wire   [0:0] overflow_1_fu_765_p2;
wire   [0:0] underflow_3_fu_793_p2;
wire   [0:0] or_ln384_1_fu_806_p2;
wire   [15:0] select_ln384_2_fu_798_p3;
wire   [15:0] q_V_fu_812_p3;
wire   [15:0] grp_fu_826_p0;
wire   [15:0] grp_fu_837_p0;
reg    grp_fu_826_ce;
reg    grp_fu_837_ce;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to13;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;
wire    ap_ce_reg;

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
#0 ap_enable_reg_pp0_iter14 = 1'b0;
end

resonator_dds_phase_to_sincos_wLUT_cos_lut #(
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

resonator_dds_phase_to_sincos_wLUT_fine_lut #(
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

resonator_dds_mac_mulsub_16ns_18s_43s_44_4_1 #(
    .ID( 1 ),
    .NUM_STAGE( 4 ),
    .din0_WIDTH( 16 ),
    .din1_WIDTH( 18 ),
    .din2_WIDTH( 43 ),
    .dout_WIDTH( 44 ))
mac_mulsub_16ns_18s_43s_44_4_1_U4(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(grp_fu_826_p0),
    .din1(sin_lut_word_V_reg_963),
    .din2(lhs_1_fu_387_p3),
    .ce(grp_fu_826_ce),
    .dout(grp_fu_826_p3)
);

resonator_dds_mul_mul_16ns_18s_34_4_1 #(
    .ID( 1 ),
    .NUM_STAGE( 4 ),
    .din0_WIDTH( 16 ),
    .din1_WIDTH( 18 ),
    .dout_WIDTH( 34 ))
mul_mul_16ns_18s_34_4_1_U5(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(grp_fu_837_p0),
    .din1(cos_lut_word_V_10_fu_371_p3),
    .ce(grp_fu_837_ce),
    .dout(grp_fu_837_p2)
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
        ap_enable_reg_pp0_iter14 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter14 <= ap_enable_reg_pp0_iter13;
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
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_ce))) begin
        add_ln1245_1_reg_1047 <= add_ln1245_1_fu_453_p2;
        add_ln1245_1_reg_1047_pp0_iter11_reg <= add_ln1245_1_reg_1047;
        add_ln1245_2_reg_1052 <= add_ln1245_2_fu_458_p2;
        add_ln1245_2_reg_1052_pp0_iter11_reg <= add_ln1245_2_reg_1052;
        cos_lut_word_V_10_reg_979 <= cos_lut_word_V_10_fu_371_p3;
        cos_lut_word_V_10_reg_979_pp0_iter7_reg <= cos_lut_word_V_10_reg_979;
        cos_lut_word_V_8_reg_953 <= cos_lut_word_V_8_fu_308_p3;
        fine_adr_V_reg_844_pp0_iter2_reg <= fine_adr_V_reg_844_pp0_iter1_reg;
        fine_adr_V_reg_844_pp0_iter3_reg <= fine_adr_V_reg_844_pp0_iter2_reg;
        fine_word_V_reg_969 <= fine_lut_q0;
        i_V_reg_1123 <= i_V_fu_703_p3;
        icmp_ln1049_reg_875_pp0_iter2_reg <= icmp_ln1049_reg_875;
        icmp_ln1049_reg_875_pp0_iter3_reg <= icmp_ln1049_reg_875_pp0_iter2_reg;
        icmp_ln1049_reg_875_pp0_iter4_reg <= icmp_ln1049_reg_875_pp0_iter3_reg;
        icmp_ln1049_reg_875_pp0_iter5_reg <= icmp_ln1049_reg_875_pp0_iter4_reg;
        icmp_ln58_5_reg_958 <= icmp_ln58_5_fu_316_p2;
        icmp_ln58_reg_942 <= icmp_ln58_fu_207_p2;
        icmp_ln799_2_reg_1128 <= icmp_ln799_2_fu_710_p2;
        icmp_ln799_reg_1100 <= icmp_ln799_fu_545_p2;
        msb_V_reg_849_pp0_iter2_reg <= msb_V_reg_849_pp0_iter1_reg;
        msb_V_reg_849_pp0_iter3_reg <= msb_V_reg_849_pp0_iter2_reg;
        msb_V_reg_849_pp0_iter4_reg <= msb_V_reg_849_pp0_iter3_reg;
        p_Result_10_reg_1012 <= grp_fu_826_p3[32'd43];
        p_Result_10_reg_1012_pp0_iter10_reg <= p_Result_10_reg_1012;
        p_Result_10_reg_1012_pp0_iter11_reg <= p_Result_10_reg_1012_pp0_iter10_reg;
        p_Result_10_reg_1012_pp0_iter12_reg <= p_Result_10_reg_1012_pp0_iter11_reg;
        p_Result_12_reg_1025 <= grp_fu_826_p3[32'd42];
        p_Result_12_reg_1025_pp0_iter10_reg <= p_Result_12_reg_1025;
        p_Result_12_reg_1025_pp0_iter11_reg <= p_Result_12_reg_1025_pp0_iter10_reg;
        p_Result_12_reg_1025_pp0_iter12_reg <= p_Result_12_reg_1025_pp0_iter11_reg;
        p_Result_13_reg_1082 <= p_Val2_4_fu_522_p2[32'd15];
        p_Result_13_reg_1082_pp0_iter12_reg <= p_Result_13_reg_1082;
        p_Result_14_reg_1058 <= ret_V_1_fu_447_p2[32'd43];
        p_Result_14_reg_1058_pp0_iter11_reg <= p_Result_14_reg_1058;
        p_Result_14_reg_1058_pp0_iter12_reg <= p_Result_14_reg_1058_pp0_iter11_reg;
        p_Result_14_reg_1058_pp0_iter13_reg <= p_Result_14_reg_1058_pp0_iter12_reg;
        p_Result_16_reg_1071 <= add_ln1245_2_fu_458_p2[32'd42];
        p_Result_16_reg_1071_pp0_iter11_reg <= p_Result_16_reg_1071;
        p_Result_16_reg_1071_pp0_iter12_reg <= p_Result_16_reg_1071_pp0_iter11_reg;
        p_Result_16_reg_1071_pp0_iter13_reg <= p_Result_16_reg_1071_pp0_iter12_reg;
        p_Result_17_reg_1110 <= p_Val2_7_fu_588_p2[32'd15];
        p_Result_17_reg_1110_pp0_iter13_reg <= p_Result_17_reg_1110;
        p_Val2_4_reg_1077 <= p_Val2_4_fu_522_p2;
        p_Val2_4_reg_1077_pp0_iter12_reg <= p_Val2_4_reg_1077;
        p_Val2_7_reg_1105 <= p_Val2_7_fu_588_p2;
        p_Val2_7_reg_1105_pp0_iter13_reg <= p_Val2_7_reg_1105;
        r_5_reg_1095 <= r_5_fu_540_p2;
        r_7_reg_907 <= r_7_fu_174_p2;
        r_7_reg_907_pp0_iter4_reg <= r_7_reg_907;
        r_8_reg_894_pp0_iter3_reg <= r_8_reg_894;
        r_8_reg_894_pp0_iter4_reg <= r_8_reg_894_pp0_iter3_reg;
        r_8_reg_894_pp0_iter5_reg <= r_8_reg_894_pp0_iter4_reg;
        r_9_reg_922 <= r_9_fu_187_p2;
        r_9_reg_922_pp0_iter4_reg <= r_9_reg_922;
        r_V_3_reg_1031 <= grp_fu_837_p2;
        r_reg_1042 <= r_fu_418_p2;
        ret_V_reg_1005_pp0_iter10_reg <= ret_V_reg_1005;
        sin_lut_word_V_reg_963 <= sin_lut_word_V_fu_349_p3;
        sin_lut_word_V_reg_963_pp0_iter6_reg <= sin_lut_word_V_reg_963;
        sin_lut_word_V_reg_963_pp0_iter7_reg <= sin_lut_word_V_reg_963_pp0_iter6_reg;
        sin_lut_word_V_reg_963_pp0_iter8_reg <= sin_lut_word_V_reg_963_pp0_iter7_reg;
        sin_lut_word_V_reg_963_pp0_iter9_reg <= sin_lut_word_V_reg_963_pp0_iter8_reg;
        trunc_ln1245_2_reg_974 <= trunc_ln1245_2_fu_357_p1;
        trunc_ln1245_2_reg_974_pp0_iter6_reg <= trunc_ln1245_2_reg_974;
        trunc_ln1245_2_reg_974_pp0_iter7_reg <= trunc_ln1245_2_reg_974_pp0_iter6_reg;
        trunc_ln1245_2_reg_974_pp0_iter8_reg <= trunc_ln1245_2_reg_974_pp0_iter7_reg;
        trunc_ln1245_2_reg_974_pp0_iter9_reg <= trunc_ln1245_2_reg_974_pp0_iter8_reg;
        trunc_ln1245_reg_1037 <= trunc_ln1245_fu_415_p1;
        trunc_ln727_1_reg_1066 <= trunc_ln727_1_fu_472_p1;
        trunc_ln727_reg_1020 <= trunc_ln727_fu_405_p1;
        trunc_ln799_1_reg_927 <= trunc_ln799_1_fu_193_p1;
        trunc_ln799_2_reg_1090 <= trunc_ln799_2_fu_536_p1;
        trunc_ln799_3_reg_1118 <= trunc_ln799_3_fu_602_p1;
        trunc_ln799_reg_912 <= trunc_ln799_fu_180_p1;
        underflow_1_reg_932 <= underflow_1_fu_197_p2;
        underflow_reg_937 <= underflow_fu_202_p2;
        zext_ln712_1_reg_917[16 : 0] <= zext_ln712_1_fu_184_p1[16 : 0];
        zext_ln712_1_reg_917_pp0_iter4_reg[16 : 0] <= zext_ln712_1_reg_917[16 : 0];
        zext_ln712_reg_900[16 : 0] <= zext_ln712_fu_171_p1[16 : 0];
        zext_ln712_reg_900_pp0_iter4_reg[16 : 0] <= zext_ln712_reg_900[16 : 0];
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_ce) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        fine_adr_V_reg_844 <= fine_adr_V_fu_128_p1;
        fine_adr_V_reg_844_pp0_iter1_reg <= fine_adr_V_reg_844;
        icmp_ln1049_reg_875 <= icmp_ln1049_fu_162_p2;
        lsb_V_reg_859 <= {{acc[18:9]}};
        msb_V_reg_849 <= {{acc[20:19]}};
        msb_V_reg_849_pp0_iter1_reg <= msb_V_reg_849;
        sin_adr_V_reg_865 <= sin_adr_V_fu_152_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b1 == ap_ce))) begin
        r_6_reg_889 <= cos_lut_q1;
        r_8_reg_894 <= cos_lut_q0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter9 == 1'b1) & (1'b1 == ap_ce))) begin
        ret_V_reg_1005 <= grp_fu_826_p3;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter14 == 1'b1))) begin
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
    if (((ap_enable_reg_pp0_iter14 == 1'b0) & (ap_enable_reg_pp0_iter13 == 1'b0) & (ap_enable_reg_pp0_iter12 == 1'b0) & (ap_enable_reg_pp0_iter11 == 1'b0) & (ap_enable_reg_pp0_iter10 == 1'b0) & (ap_enable_reg_pp0_iter9 == 1'b0) & (ap_enable_reg_pp0_iter8 == 1'b0) & (ap_enable_reg_pp0_iter7 == 1'b0) & (ap_enable_reg_pp0_iter6 == 1'b0) & (ap_enable_reg_pp0_iter5 == 1'b0) & (ap_enable_reg_pp0_iter4 == 1'b0) & (ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter13 == 1'b0) & (ap_enable_reg_pp0_iter12 == 1'b0) & (ap_enable_reg_pp0_iter11 == 1'b0) & (ap_enable_reg_pp0_iter10 == 1'b0) & (ap_enable_reg_pp0_iter9 == 1'b0) & (ap_enable_reg_pp0_iter8 == 1'b0) & (ap_enable_reg_pp0_iter7 == 1'b0) & (ap_enable_reg_pp0_iter6 == 1'b0) & (ap_enable_reg_pp0_iter5 == 1'b0) & (ap_enable_reg_pp0_iter4 == 1'b0) & (ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0_0to13 = 1'b1;
    end else begin
        ap_idle_pp0_0to13 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((ap_idle_pp0_0to13 == 1'b1) & (ap_start == 1'b0))) begin
        ap_reset_idle_pp0 = 1'b1;
    end else begin
        ap_reset_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_ce) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        cos_lut_ce0 = 1'b1;
    end else begin
        cos_lut_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_ce) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        cos_lut_ce1 = 1'b1;
    end else begin
        cos_lut_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter4 == 1'b1) & (1'b1 == ap_ce))) begin
        fine_lut_ce0 = 1'b1;
    end else begin
        fine_lut_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_ce) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        grp_fu_826_ce = 1'b1;
    end else begin
        grp_fu_826_ce = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_ce) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        grp_fu_837_ce = 1'b1;
    end else begin
        grp_fu_837_ce = 1'b0;
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

assign Range1_all_zeros_1_fu_725_p2 = (p_Result_14_reg_1058_pp0_iter13_reg ^ 1'd1);

assign Range1_all_zeros_fu_616_p2 = (p_Result_10_reg_1012_pp0_iter12_reg ^ 1'd1);

assign add_ln1245_1_fu_453_p2 = (trunc_ln1245_1_fu_440_p3 + trunc_ln1245_reg_1037);

assign add_ln1245_2_fu_458_p2 = ($signed(lhs_2_fu_423_p3) + $signed(sext_ln1245_1_fu_437_p1));

assign and_ln1049_1_fu_265_p2 = (icmp_ln58_reg_942 & icmp_ln1049_reg_875_pp0_iter4_reg);

assign and_ln1049_2_fu_291_p2 = (icmp_ln58_4_fu_286_p2 & icmp_ln58_3_fu_281_p2);

assign and_ln1049_3_fu_297_p2 = (icmp_ln58_2_fu_276_p2 & icmp_ln1049_reg_875_pp0_iter4_reg);

assign and_ln1049_4_fu_302_p2 = (and_ln1049_3_fu_297_p2 & and_ln1049_2_fu_291_p2);

assign and_ln1049_fu_240_p2 = (xor_ln1049_fu_235_p2 & icmp_ln58_reg_942);

assign and_ln412_1_fu_578_p2 = (p_Result_15_fu_566_p3 & or_ln412_1_fu_573_p2);

assign and_ln412_fu_512_p2 = (p_Result_11_fu_500_p3 & or_ln412_fu_507_p2);

assign and_ln795_1_fu_771_p2 = (p_Result_17_reg_1110_pp0_iter13_reg & deleted_ones_1_fu_737_p3);

assign and_ln795_fu_662_p2 = (p_Result_13_reg_1082_pp0_iter12_reg & deleted_ones_fu_628_p3);

assign and_ln797_2_fu_787_p2 = (or_ln797_1_fu_782_p2 & or_ln790_1_fu_749_p2);

assign and_ln797_fu_678_p2 = (or_ln797_fu_673_p2 & or_ln790_fu_640_p2);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_11001 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_subdone = (1'b0 == ap_ce);
end

assign ap_block_state10_pp0_stage0_iter9 = ~(1'b1 == 1'b1);

assign ap_block_state11_pp0_stage0_iter10 = ~(1'b1 == 1'b1);

assign ap_block_state12_pp0_stage0_iter11 = ~(1'b1 == 1'b1);

assign ap_block_state13_pp0_stage0_iter12 = ~(1'b1 == 1'b1);

assign ap_block_state14_pp0_stage0_iter13 = ~(1'b1 == 1'b1);

assign ap_block_state15_pp0_stage0_iter14 = ~(1'b1 == 1'b1);

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

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

assign ap_return = {{q_V_fu_812_p3}, {i_V_reg_1123}};

assign carry_1_fu_611_p2 = (xor_ln416_fu_606_p2 & p_Result_12_reg_1025_pp0_iter12_reg);

assign carry_3_fu_720_p2 = (xor_ln416_1_fu_715_p2 & p_Result_16_reg_1071_pp0_iter13_reg);

assign cos_lut_address0 = zext_ln573_1_fu_167_p1;

assign cos_lut_address1 = zext_ln573_fu_158_p1;

assign cos_lut_word_V_10_fu_371_p3 = ((icmp_ln58_5_reg_958[0:0] == 1'b1) ? zext_ln47_fu_367_p1 : cos_lut_word_V_8_reg_953);

assign cos_lut_word_V_3_fu_228_p3 = ((icmp_ln1049_reg_875_pp0_iter4_reg[0:0] == 1'b1) ? 18'd0 : select_ln340_fu_222_p3);

assign cos_lut_word_V_4_fu_361_p3 = ((icmp_ln1049_reg_875_pp0_iter5_reg[0:0] == 1'b1) ? 17'd0 : r_8_reg_894_pp0_iter5_reg);

assign cos_lut_word_V_5_fu_245_p3 = ((and_ln1049_fu_240_p2[0:0] == 1'b1) ? zext_ln712_reg_900_pp0_iter4_reg : cos_lut_word_V_fu_216_p3);

assign cos_lut_word_V_6_fu_257_p3 = ((icmp_ln58_1_fu_252_p2[0:0] == 1'b1) ? cos_lut_word_V_3_fu_228_p3 : cos_lut_word_V_5_fu_245_p3);

assign cos_lut_word_V_7_fu_269_p3 = ((and_ln1049_1_fu_265_p2[0:0] == 1'b1) ? zext_ln712_reg_900_pp0_iter4_reg : cos_lut_word_V_6_fu_257_p3);

assign cos_lut_word_V_8_fu_308_p3 = ((and_ln1049_4_fu_302_p2[0:0] == 1'b1) ? cos_lut_word_V_fu_216_p3 : cos_lut_word_V_7_fu_269_p3);

assign cos_lut_word_V_fu_216_p3 = ((underflow_1_reg_932[0:0] == 1'b1) ? 18'd131073 : r_7_reg_907_pp0_iter4_reg);

assign deleted_ones_1_fu_737_p3 = ((carry_3_fu_720_p2[0:0] == 1'b1) ? Range1_all_zeros_1_fu_725_p2 : p_Result_14_reg_1058_pp0_iter13_reg);

assign deleted_ones_fu_628_p3 = ((carry_1_fu_611_p2[0:0] == 1'b1) ? Range1_all_zeros_fu_616_p2 : p_Result_10_reg_1012_pp0_iter12_reg);

assign deleted_zeros_1_fu_730_p3 = ((carry_3_fu_720_p2[0:0] == 1'b1) ? p_Result_14_reg_1058_pp0_iter13_reg : Range1_all_zeros_1_fu_725_p2);

assign deleted_zeros_fu_621_p3 = ((carry_1_fu_611_p2[0:0] == 1'b1) ? p_Result_10_reg_1012_pp0_iter12_reg : Range1_all_zeros_fu_616_p2);

assign fine_adr_V_fu_128_p1 = acc[8:0];

assign fine_lut_address0 = zext_ln573_2_fu_212_p1;

assign grp_fu_826_p0 = zext_ln1171_fu_380_p1;

assign grp_fu_837_p0 = zext_ln1171_fu_380_p1;

assign i_V_fu_703_p3 = ((or_ln384_fu_697_p2[0:0] == 1'b1) ? select_ln384_fu_689_p3 : p_Val2_4_reg_1077_pp0_iter12_reg);

assign icmp_ln1049_fu_162_p2 = ((lsb_V_reg_859 == 10'd0) ? 1'b1 : 1'b0);

assign icmp_ln58_1_fu_252_p2 = ((msb_V_reg_849_pp0_iter4_reg == 2'd1) ? 1'b1 : 1'b0);

assign icmp_ln58_2_fu_276_p2 = ((msb_V_reg_849_pp0_iter4_reg != 2'd0) ? 1'b1 : 1'b0);

assign icmp_ln58_3_fu_281_p2 = ((msb_V_reg_849_pp0_iter4_reg != 2'd1) ? 1'b1 : 1'b0);

assign icmp_ln58_4_fu_286_p2 = ((msb_V_reg_849_pp0_iter4_reg != 2'd3) ? 1'b1 : 1'b0);

assign icmp_ln58_5_fu_316_p2 = ((msb_V_reg_849_pp0_iter4_reg == 2'd3) ? 1'b1 : 1'b0);

assign icmp_ln58_fu_207_p2 = ((msb_V_reg_849_pp0_iter3_reg == 2'd0) ? 1'b1 : 1'b0);

assign icmp_ln799_2_fu_710_p2 = ((trunc_ln799_3_reg_1118 == 15'd0) ? 1'b1 : 1'b0);

assign icmp_ln799_fu_545_p2 = ((trunc_ln799_2_reg_1090 == 15'd0) ? 1'b1 : 1'b0);

assign lhs_1_fu_387_p3 = {{cos_lut_word_V_10_reg_979_pp0_iter7_reg}, {25'd0}};

assign lhs_2_fu_423_p3 = {{sin_lut_word_V_reg_963_pp0_iter9_reg}, {25'd0}};

assign lsb_V_fu_142_p4 = {{acc[18:9]}};

assign or_ln1049_fu_335_p2 = (and_ln1049_4_fu_302_p2 | and_ln1049_1_fu_265_p2);

assign or_ln384_1_fu_806_p2 = (underflow_3_fu_793_p2 | overflow_1_fu_765_p2);

assign or_ln384_fu_697_p2 = (underflow_2_fu_684_p2 | overflow_fu_656_p2);

assign or_ln412_1_fu_573_p2 = (r_5_reg_1095 | p_Result_5_fu_559_p3);

assign or_ln412_fu_507_p2 = (r_reg_1042 | p_Result_s_fu_493_p3);

assign or_ln790_1_fu_749_p2 = (xor_ln790_1_fu_744_p2 | p_Result_17_reg_1110_pp0_iter13_reg);

assign or_ln790_fu_640_p2 = (xor_ln790_fu_635_p2 | p_Result_13_reg_1082_pp0_iter12_reg);

assign or_ln794_1_fu_760_p2 = (xor_ln794_1_fu_754_p2 | p_Result_17_reg_1110_pp0_iter13_reg);

assign or_ln794_fu_651_p2 = (xor_ln794_fu_645_p2 | p_Result_13_reg_1082_pp0_iter12_reg);

assign or_ln797_1_fu_782_p2 = (xor_ln795_1_fu_776_p2 | icmp_ln799_2_reg_1128);

assign or_ln797_fu_673_p2 = (xor_ln795_fu_667_p2 | icmp_ln799_reg_1100);

assign overflow_1_fu_765_p2 = (or_ln794_1_fu_760_p2 & Range1_all_zeros_1_fu_725_p2);

assign overflow_fu_656_p2 = (or_ln794_fu_651_p2 & Range1_all_zeros_fu_616_p2);

assign p_Result_11_fu_500_p3 = ret_V_reg_1005_pp0_iter10_reg[32'd26];

assign p_Result_15_fu_566_p3 = add_ln1245_1_reg_1047_pp0_iter11_reg[32'd26];

assign p_Result_5_fu_559_p3 = add_ln1245_2_reg_1052_pp0_iter11_reg[32'd27];

assign p_Result_s_fu_493_p3 = ret_V_reg_1005_pp0_iter10_reg[32'd27];

assign p_Val2_3_fu_484_p4 = {{ret_V_reg_1005_pp0_iter10_reg[42:27]}};

assign p_Val2_4_fu_522_p2 = (p_Val2_3_fu_484_p4 + zext_ln415_fu_518_p1);

assign p_Val2_6_fu_550_p4 = {{add_ln1245_2_reg_1052_pp0_iter11_reg[42:27]}};

assign p_Val2_7_fu_588_p2 = (p_Val2_6_fu_550_p4 + zext_ln415_1_fu_584_p1);

assign q_V_fu_812_p3 = ((or_ln384_1_fu_806_p2[0:0] == 1'b1) ? select_ln384_2_fu_798_p3 : p_Val2_7_reg_1105_pp0_iter13_reg);

assign r_5_fu_540_p2 = ((trunc_ln727_1_reg_1066 != 26'd0) ? 1'b1 : 1'b0);

assign r_7_fu_174_p2 = (18'd0 - zext_ln712_fu_171_p1);

assign r_9_fu_187_p2 = (18'd0 - zext_ln712_1_fu_184_p1);

assign r_fu_418_p2 = ((trunc_ln727_reg_1020 != 26'd0) ? 1'b1 : 1'b0);

assign ret_V_1_fu_447_p2 = ($signed(sext_ln1245_fu_430_p1) + $signed(sext_ln712_1_fu_434_p1));

assign select_ln340_fu_222_p3 = ((underflow_reg_937[0:0] == 1'b1) ? 18'd131073 : r_9_reg_922_pp0_iter4_reg);

assign select_ln384_2_fu_798_p3 = ((overflow_1_fu_765_p2[0:0] == 1'b1) ? 16'd32767 : 16'd32769);

assign select_ln384_fu_689_p3 = ((overflow_fu_656_p2[0:0] == 1'b1) ? 16'd32767 : 16'd32769);

assign sext_ln1245_1_fu_437_p1 = r_V_3_reg_1031;

assign sext_ln1245_fu_430_p1 = lhs_2_fu_423_p3;

assign sext_ln712_1_fu_434_p1 = r_V_3_reg_1031;

assign sin_adr_V_fu_152_p2 = (10'd0 - lsb_V_fu_142_p4);

assign sin_lut_word_V_3_fu_321_p3 = ((and_ln1049_fu_240_p2[0:0] == 1'b1) ? zext_ln712_1_reg_917_pp0_iter4_reg : select_ln340_fu_222_p3);

assign sin_lut_word_V_4_fu_328_p3 = ((icmp_ln58_1_fu_252_p2[0:0] == 1'b1) ? zext_ln712_reg_900_pp0_iter4_reg : sin_lut_word_V_3_fu_321_p3);

assign sin_lut_word_V_5_fu_341_p3 = ((or_ln1049_fu_335_p2[0:0] == 1'b1) ? 18'd0 : sin_lut_word_V_4_fu_328_p3);

assign sin_lut_word_V_fu_349_p3 = ((icmp_ln58_5_fu_316_p2[0:0] == 1'b1) ? cos_lut_word_V_fu_216_p3 : sin_lut_word_V_5_fu_341_p3);

assign trunc_ln1245_1_fu_440_p3 = {{trunc_ln1245_2_reg_974_pp0_iter9_reg}, {25'd0}};

assign trunc_ln1245_2_fu_357_p1 = sin_lut_word_V_fu_349_p3[1:0];

assign trunc_ln1245_fu_415_p1 = grp_fu_837_p2[26:0];

assign trunc_ln727_1_fu_472_p1 = ret_V_1_fu_447_p2[25:0];

assign trunc_ln727_fu_405_p1 = grp_fu_826_p3[25:0];

assign trunc_ln799_1_fu_193_p1 = r_9_fu_187_p2[16:0];

assign trunc_ln799_2_fu_536_p1 = p_Val2_4_fu_522_p2[14:0];

assign trunc_ln799_3_fu_602_p1 = p_Val2_7_fu_588_p2[14:0];

assign trunc_ln799_fu_180_p1 = r_7_fu_174_p2[16:0];

assign underflow_1_fu_197_p2 = ((trunc_ln799_reg_912 == 17'd0) ? 1'b1 : 1'b0);

assign underflow_2_fu_684_p2 = (p_Result_10_reg_1012_pp0_iter12_reg & and_ln797_fu_678_p2);

assign underflow_3_fu_793_p2 = (p_Result_14_reg_1058_pp0_iter13_reg & and_ln797_2_fu_787_p2);

assign underflow_fu_202_p2 = ((trunc_ln799_1_reg_927 == 17'd0) ? 1'b1 : 1'b0);

assign xor_ln1049_fu_235_p2 = (icmp_ln1049_reg_875_pp0_iter4_reg ^ 1'd1);

assign xor_ln416_1_fu_715_p2 = (p_Result_17_reg_1110_pp0_iter13_reg ^ 1'd1);

assign xor_ln416_fu_606_p2 = (p_Result_13_reg_1082_pp0_iter12_reg ^ 1'd1);

assign xor_ln790_1_fu_744_p2 = (p_Result_16_reg_1071_pp0_iter13_reg ^ 1'd1);

assign xor_ln790_fu_635_p2 = (p_Result_12_reg_1025_pp0_iter12_reg ^ 1'd1);

assign xor_ln794_1_fu_754_p2 = (deleted_zeros_1_fu_730_p3 ^ 1'd1);

assign xor_ln794_fu_645_p2 = (deleted_zeros_fu_621_p3 ^ 1'd1);

assign xor_ln795_1_fu_776_p2 = (1'd1 ^ and_ln795_1_fu_771_p2);

assign xor_ln795_fu_667_p2 = (1'd1 ^ and_ln795_fu_662_p2);

assign zext_ln1171_fu_380_p1 = fine_word_V_reg_969;

assign zext_ln415_1_fu_584_p1 = and_ln412_1_fu_578_p2;

assign zext_ln415_fu_518_p1 = and_ln412_fu_512_p2;

assign zext_ln47_fu_367_p1 = cos_lut_word_V_4_fu_361_p3;

assign zext_ln573_1_fu_167_p1 = sin_adr_V_reg_865;

assign zext_ln573_2_fu_212_p1 = fine_adr_V_reg_844_pp0_iter3_reg;

assign zext_ln573_fu_158_p1 = lsb_V_reg_859;

assign zext_ln712_1_fu_184_p1 = r_8_reg_894;

assign zext_ln712_fu_171_p1 = r_6_reg_889;

always @ (posedge ap_clk) begin
    zext_ln712_reg_900[17] <= 1'b0;
    zext_ln712_reg_900_pp0_iter4_reg[17] <= 1'b0;
    zext_ln712_1_reg_917[17] <= 1'b0;
    zext_ln712_1_reg_917_pp0_iter4_reg[17] <= 1'b0;
end

endmodule //resonator_dds_phase_to_sincos_wLUT
