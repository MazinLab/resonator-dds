// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2019.2.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module cmpy (
        ap_clk,
        ap_rst,
        ar_V_read,
        ai_V_read,
        br_V_read,
        bi_V_read,
        ap_return_0,
        ap_return_1,
        ap_ce
);


input   ap_clk;
input   ap_rst;
input  [15:0] ar_V_read;
input  [15:0] ai_V_read;
input  [15:0] br_V_read;
input  [15:0] bi_V_read;
output  [15:0] ap_return_0;
output  [15:0] ap_return_1;
input   ap_ce;

reg[15:0] ap_return_0;
reg[15:0] ap_return_1;

reg  signed [15:0] bi_V_read_1_reg_794;
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
wire    ap_block_pp0_stage0_11001;
reg  signed [15:0] bi_V_read_1_reg_794_pp0_iter1_reg;
reg  signed [15:0] bi_V_read_1_reg_794_pp0_iter2_reg;
reg  signed [15:0] br_V_read_1_reg_800;
reg  signed [15:0] br_V_read_1_reg_800_pp0_iter1_reg;
reg  signed [15:0] ar_V_read_1_reg_807;
reg  signed [15:0] ar_V_read_1_reg_807_pp0_iter1_reg;
wire   [16:0] ret_V_fu_86_p2;
reg   [16:0] ret_V_reg_812;
wire   [15:0] trunc_ln790_fu_92_p1;
reg   [15:0] trunc_ln790_reg_819;
wire   [15:0] sub_ln790_fu_96_p2;
reg   [15:0] sub_ln790_reg_824;
wire   [16:0] ret_V_3_fu_102_p2;
reg   [16:0] ret_V_3_reg_829;
wire   [15:0] trunc_ln790_4_fu_108_p1;
reg   [15:0] trunc_ln790_4_reg_836;
wire   [16:0] sum0_V_fu_131_p3;
reg   [16:0] sum0_V_reg_841;
reg  signed [16:0] sum0_V_reg_841_pp0_iter2_reg;
wire   [16:0] sum1_V_fu_170_p3;
reg  signed [16:0] sum1_V_reg_846;
wire   [16:0] sum2_V_fu_197_p3;
reg  signed [16:0] sum2_V_reg_851;
wire  signed [32:0] grp_fu_771_p2;
reg  signed [32:0] p_Val2_22_reg_886;
wire  signed [32:0] grp_fu_778_p2;
reg  signed [32:0] p_Val2_27_reg_892;
wire   [31:0] trunc_ln1192_fu_222_p1;
reg   [31:0] trunc_ln1192_reg_897;
wire   [31:0] trunc_ln1192_2_fu_225_p1;
reg   [31:0] trunc_ln1192_2_reg_902;
wire  signed [32:0] grp_fu_785_p3;
reg  signed [32:0] ret_V_4_reg_907;
reg  signed [32:0] ret_V_4_reg_907_pp0_iter6_reg;
reg  signed [32:0] ret_V_4_reg_907_pp0_iter7_reg;
reg   [0:0] p_Result_s_reg_918;
reg   [0:0] p_Result_s_reg_918_pp0_iter6_reg;
reg   [0:0] p_Result_s_reg_918_pp0_iter7_reg;
reg   [0:0] p_Result_s_reg_918_pp0_iter8_reg;
wire   [13:0] trunc_ln718_fu_235_p1;
reg   [13:0] trunc_ln718_reg_924;
(* use_dsp48 = "no" *) wire   [32:0] ret_V_5_fu_238_p2;
reg   [32:0] ret_V_5_reg_929;
reg   [32:0] ret_V_5_reg_929_pp0_iter6_reg;
reg   [32:0] ret_V_5_reg_929_pp0_iter7_reg;
reg   [0:0] p_Result_8_reg_938;
reg   [0:0] p_Result_8_reg_938_pp0_iter6_reg;
reg   [0:0] p_Result_8_reg_938_pp0_iter7_reg;
reg   [0:0] p_Result_8_reg_938_pp0_iter8_reg;
wire   [31:0] add_ln713_fu_250_p2;
reg   [31:0] add_ln713_reg_944;
reg   [31:0] add_ln713_reg_944_pp0_iter6_reg;
wire   [13:0] trunc_ln718_2_fu_254_p1;
reg   [13:0] trunc_ln718_2_reg_949;
reg   [1:0] tmp_4_reg_954;
reg   [1:0] tmp_4_reg_954_pp0_iter6_reg;
reg   [1:0] tmp_4_reg_954_pp0_iter7_reg;
wire   [0:0] r_3_fu_268_p2;
reg   [0:0] r_3_reg_960;
wire   [0:0] r_4_fu_273_p2;
reg   [0:0] r_4_reg_965;
wire   [15:0] p_Val2_26_fu_323_p2;
reg   [15:0] p_Val2_26_reg_970;
reg   [15:0] p_Val2_26_reg_970_pp0_iter8_reg;
wire   [0:0] carry_4_fu_343_p2;
reg   [0:0] carry_4_reg_976;
reg   [0:0] carry_4_reg_976_pp0_iter8_reg;
reg   [0:0] p_Result_7_reg_983;
wire   [14:0] trunc_ln790_5_fu_357_p1;
reg   [14:0] trunc_ln790_5_reg_989;
wire   [15:0] p_Val2_30_fu_406_p2;
reg   [15:0] p_Val2_30_reg_994;
reg   [15:0] p_Val2_30_reg_994_pp0_iter8_reg;
wire   [0:0] carry_6_fu_426_p2;
reg   [0:0] carry_6_reg_1000;
reg   [0:0] carry_6_reg_1000_pp0_iter8_reg;
reg   [0:0] p_Result_10_reg_1007;
wire   [14:0] trunc_ln790_6_fu_440_p1;
reg   [14:0] trunc_ln790_6_reg_1013;
wire   [0:0] Range1_all_ones_fu_460_p2;
reg   [0:0] Range1_all_ones_reg_1018;
wire   [0:0] overflow_fu_521_p2;
reg   [0:0] overflow_reg_1023;
wire   [0:0] empty_fu_543_p2;
reg   [0:0] empty_reg_1029;
wire   [0:0] Range1_all_ones_2_fu_556_p2;
reg   [0:0] Range1_all_ones_2_reg_1034;
wire   [0:0] overflow_2_fu_615_p2;
reg   [0:0] overflow_2_reg_1039;
wire   [0:0] empty_16_fu_637_p2;
reg   [0:0] empty_16_reg_1045;
wire  signed [15:0] lhs_V_fu_78_p0;
wire    ap_block_pp0_stage0;
wire  signed [16:0] rhs_V_fu_82_p1;
wire  signed [16:0] lhs_V_fu_78_p1;
wire  signed [15:0] sub_ln790_fu_96_p1;
wire   [0:0] icmp_ln790_fu_119_p2;
wire   [0:0] neg_src_fu_112_p3;
wire   [16:0] phitmp_fu_124_p3;
wire  signed [16:0] rhs_V_2_fu_141_p1;
wire  signed [16:0] lhs_V_2_fu_138_p1;
wire   [16:0] ret_V_2_fu_144_p2;
wire   [0:0] icmp_ln790_2_fu_158_p2;
wire   [0:0] neg_src_1_fu_150_p3;
wire   [16:0] phitmp1731_fu_162_p3;
wire   [0:0] icmp_ln790_3_fu_185_p2;
wire   [0:0] neg_src_2_fu_178_p3;
wire   [16:0] phitmp1732_fu_190_p3;
wire   [0:0] tmp_17_fu_287_p3;
wire   [0:0] tmp_19_fu_306_p3;
wire   [0:0] r_fu_301_p2;
wire   [0:0] and_ln415_fu_313_p2;
wire   [15:0] p_Val2_25_fu_278_p4;
wire   [15:0] zext_ln415_fu_319_p1;
wire   [0:0] tmp_20_fu_329_p3;
wire   [0:0] p_Result_6_fu_294_p3;
wire   [0:0] xor_ln416_fu_337_p2;
wire   [0:0] tmp_25_fu_370_p3;
wire   [0:0] tmp_27_fu_389_p3;
wire   [0:0] r_5_fu_384_p2;
wire   [0:0] and_ln415_2_fu_396_p2;
wire   [15:0] p_Val2_29_fu_361_p4;
wire   [15:0] zext_ln415_2_fu_402_p1;
wire   [0:0] tmp_28_fu_412_p3;
wire   [0:0] p_Result_9_fu_377_p3;
wire   [0:0] xor_ln416_2_fu_420_p2;
wire   [1:0] tmp_2_fu_451_p4;
wire   [0:0] Range1_all_zeros_fu_466_p2;
wire   [0:0] tmp_23_fu_479_p3;
wire   [0:0] Range2_all_ones_fu_444_p3;
wire   [0:0] xor_ln779_fu_486_p2;
wire   [0:0] and_ln779_fu_492_p2;
wire   [0:0] deleted_zeros_fu_472_p3;
wire   [0:0] xor_ln785_fu_505_p2;
wire   [0:0] or_ln785_fu_511_p2;
wire   [0:0] xor_ln785_2_fu_516_p2;
wire   [0:0] deleted_ones_fu_498_p3;
wire   [0:0] and_ln786_fu_527_p2;
wire   [0:0] icmp_ln790_4_fu_538_p2;
wire   [0:0] xor_ln786_fu_532_p2;
wire   [0:0] Range1_all_zeros_1_fu_561_p2;
wire   [0:0] tmp_31_fu_573_p3;
wire   [0:0] Range2_all_ones_1_fu_549_p3;
wire   [0:0] xor_ln779_2_fu_580_p2;
wire   [0:0] and_ln779_1_fu_586_p2;
wire   [0:0] deleted_zeros_1_fu_566_p3;
wire   [0:0] xor_ln785_3_fu_599_p2;
wire   [0:0] or_ln785_2_fu_605_p2;
wire   [0:0] xor_ln785_4_fu_610_p2;
wire   [0:0] deleted_ones_2_fu_592_p3;
wire   [0:0] and_ln786_2_fu_621_p2;
wire   [0:0] icmp_ln790_5_fu_632_p2;
wire   [0:0] xor_ln786_2_fu_626_p2;
wire   [0:0] and_ln781_fu_643_p2;
wire   [0:0] xor_ln781_fu_647_p2;
wire   [0:0] tmp_fu_653_p2;
wire   [0:0] underflow_fu_658_p2;
wire   [0:0] xor_ln340_fu_668_p2;
wire   [0:0] or_ln340_fu_663_p2;
wire   [0:0] or_ln340_4_fu_674_p2;
wire   [15:0] select_ln340_fu_679_p3;
wire   [15:0] select_ln388_fu_686_p3;
wire   [0:0] and_ln781_1_fu_701_p2;
wire   [0:0] xor_ln781_2_fu_705_p2;
wire   [0:0] tmp1_fu_711_p2;
wire   [0:0] underflow_4_fu_716_p2;
wire   [0:0] xor_ln340_2_fu_726_p2;
wire   [0:0] or_ln340_5_fu_721_p2;
wire   [0:0] or_ln340_6_fu_732_p2;
wire   [15:0] select_ln340_6_fu_737_p3;
wire   [15:0] select_ln388_2_fu_744_p3;
wire   [15:0] select_ln340_7_fu_693_p3;
wire   [15:0] select_ln340_8_fu_751_p3;
reg    grp_fu_771_ce;
reg    grp_fu_778_ce;
reg    grp_fu_785_ce;
reg    ap_ce_reg;
reg   [15:0] ar_V_read_int_reg;
reg   [15:0] ai_V_read_int_reg;
reg   [15:0] br_V_read_int_reg;
reg   [15:0] bi_V_read_int_reg;
reg   [15:0] ap_return_0_int_reg;
reg   [15:0] ap_return_1_int_reg;

resonator_dds_mulg8j #(
    .ID( 1 ),
    .NUM_STAGE( 3 ),
    .din0_WIDTH( 17 ),
    .din1_WIDTH( 16 ),
    .dout_WIDTH( 33 ))
resonator_dds_mulg8j_U73(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(sum1_V_reg_846),
    .din1(ar_V_read_1_reg_807_pp0_iter1_reg),
    .ce(grp_fu_771_ce),
    .dout(grp_fu_771_p2)
);

resonator_dds_mulg8j #(
    .ID( 1 ),
    .NUM_STAGE( 3 ),
    .din0_WIDTH( 17 ),
    .din1_WIDTH( 16 ),
    .dout_WIDTH( 33 ))
resonator_dds_mulg8j_U74(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(sum2_V_reg_851),
    .din1(br_V_read_1_reg_800_pp0_iter1_reg),
    .ce(grp_fu_778_ce),
    .dout(grp_fu_778_p2)
);

resonator_dds_machbi #(
    .ID( 1 ),
    .NUM_STAGE( 3 ),
    .din0_WIDTH( 17 ),
    .din1_WIDTH( 16 ),
    .din2_WIDTH( 33 ),
    .dout_WIDTH( 33 ))
resonator_dds_machbi_U75(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(sum0_V_reg_841_pp0_iter2_reg),
    .din1(bi_V_read_1_reg_794_pp0_iter2_reg),
    .din2(p_Val2_22_reg_886),
    .ce(grp_fu_785_ce),
    .dout(grp_fu_785_p3)
);

always @ (posedge ap_clk) begin
    ap_ce_reg <= ap_ce;
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_ce_reg) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        Range1_all_ones_2_reg_1034 <= Range1_all_ones_2_fu_556_p2;
        Range1_all_ones_reg_1018 <= Range1_all_ones_fu_460_p2;
        add_ln713_reg_944 <= add_ln713_fu_250_p2;
        add_ln713_reg_944_pp0_iter6_reg <= add_ln713_reg_944;
        ar_V_read_1_reg_807 <= ar_V_read_int_reg;
        ar_V_read_1_reg_807_pp0_iter1_reg <= ar_V_read_1_reg_807;
        bi_V_read_1_reg_794 <= bi_V_read_int_reg;
        bi_V_read_1_reg_794_pp0_iter1_reg <= bi_V_read_1_reg_794;
        bi_V_read_1_reg_794_pp0_iter2_reg <= bi_V_read_1_reg_794_pp0_iter1_reg;
        br_V_read_1_reg_800 <= br_V_read_int_reg;
        br_V_read_1_reg_800_pp0_iter1_reg <= br_V_read_1_reg_800;
        carry_4_reg_976 <= carry_4_fu_343_p2;
        carry_4_reg_976_pp0_iter8_reg <= carry_4_reg_976;
        carry_6_reg_1000 <= carry_6_fu_426_p2;
        carry_6_reg_1000_pp0_iter8_reg <= carry_6_reg_1000;
        empty_16_reg_1045 <= empty_16_fu_637_p2;
        empty_reg_1029 <= empty_fu_543_p2;
        overflow_2_reg_1039 <= overflow_2_fu_615_p2;
        overflow_reg_1023 <= overflow_fu_521_p2;
        p_Result_10_reg_1007 <= p_Val2_30_fu_406_p2[32'd15];
        p_Result_7_reg_983 <= p_Val2_26_fu_323_p2[32'd15];
        p_Result_8_reg_938 <= ret_V_5_fu_238_p2[32'd32];
        p_Result_8_reg_938_pp0_iter6_reg <= p_Result_8_reg_938;
        p_Result_8_reg_938_pp0_iter7_reg <= p_Result_8_reg_938_pp0_iter6_reg;
        p_Result_8_reg_938_pp0_iter8_reg <= p_Result_8_reg_938_pp0_iter7_reg;
        p_Result_s_reg_918 <= grp_fu_785_p3[32'd32];
        p_Result_s_reg_918_pp0_iter6_reg <= p_Result_s_reg_918;
        p_Result_s_reg_918_pp0_iter7_reg <= p_Result_s_reg_918_pp0_iter6_reg;
        p_Result_s_reg_918_pp0_iter8_reg <= p_Result_s_reg_918_pp0_iter7_reg;
        p_Val2_22_reg_886 <= grp_fu_771_p2;
        p_Val2_26_reg_970 <= p_Val2_26_fu_323_p2;
        p_Val2_26_reg_970_pp0_iter8_reg <= p_Val2_26_reg_970;
        p_Val2_27_reg_892 <= grp_fu_778_p2;
        p_Val2_30_reg_994 <= p_Val2_30_fu_406_p2;
        p_Val2_30_reg_994_pp0_iter8_reg <= p_Val2_30_reg_994;
        r_3_reg_960 <= r_3_fu_268_p2;
        r_4_reg_965 <= r_4_fu_273_p2;
        ret_V_3_reg_829 <= ret_V_3_fu_102_p2;
        ret_V_4_reg_907 <= grp_fu_785_p3;
        ret_V_4_reg_907_pp0_iter6_reg <= ret_V_4_reg_907;
        ret_V_4_reg_907_pp0_iter7_reg <= ret_V_4_reg_907_pp0_iter6_reg;
        ret_V_5_reg_929 <= ret_V_5_fu_238_p2;
        ret_V_5_reg_929_pp0_iter6_reg <= ret_V_5_reg_929;
        ret_V_5_reg_929_pp0_iter7_reg <= ret_V_5_reg_929_pp0_iter6_reg;
        ret_V_reg_812 <= ret_V_fu_86_p2;
        sub_ln790_reg_824 <= sub_ln790_fu_96_p2;
        sum0_V_reg_841 <= sum0_V_fu_131_p3;
        sum0_V_reg_841_pp0_iter2_reg <= sum0_V_reg_841;
        sum1_V_reg_846 <= sum1_V_fu_170_p3;
        sum2_V_reg_851 <= sum2_V_fu_197_p3;
        tmp_4_reg_954 <= {{ret_V_5_fu_238_p2[32:31]}};
        tmp_4_reg_954_pp0_iter6_reg <= tmp_4_reg_954;
        tmp_4_reg_954_pp0_iter7_reg <= tmp_4_reg_954_pp0_iter6_reg;
        trunc_ln1192_2_reg_902 <= trunc_ln1192_2_fu_225_p1;
        trunc_ln1192_reg_897 <= trunc_ln1192_fu_222_p1;
        trunc_ln718_2_reg_949 <= trunc_ln718_2_fu_254_p1;
        trunc_ln718_reg_924 <= trunc_ln718_fu_235_p1;
        trunc_ln790_4_reg_836 <= trunc_ln790_4_fu_108_p1;
        trunc_ln790_5_reg_989 <= trunc_ln790_5_fu_357_p1;
        trunc_ln790_6_reg_1013 <= trunc_ln790_6_fu_440_p1;
        trunc_ln790_reg_819 <= trunc_ln790_fu_92_p1;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_ce)) begin
        ai_V_read_int_reg <= ai_V_read;
        ar_V_read_int_reg <= ar_V_read;
        bi_V_read_int_reg <= bi_V_read;
        br_V_read_int_reg <= br_V_read;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_ce_reg)) begin
        ap_return_0_int_reg <= select_ln340_7_fu_693_p3;
        ap_return_1_int_reg <= select_ln340_8_fu_751_p3;
    end
end

always @ (*) begin
    if ((1'b0 == ap_ce_reg)) begin
        ap_return_0 = ap_return_0_int_reg;
    end else if ((1'b1 == ap_ce_reg)) begin
        ap_return_0 = select_ln340_7_fu_693_p3;
    end
end

always @ (*) begin
    if ((1'b0 == ap_ce_reg)) begin
        ap_return_1 = ap_return_1_int_reg;
    end else if ((1'b1 == ap_ce_reg)) begin
        ap_return_1 = select_ln340_8_fu_751_p3;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_ce_reg))) begin
        grp_fu_771_ce = 1'b1;
    end else begin
        grp_fu_771_ce = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_ce_reg))) begin
        grp_fu_778_ce = 1'b1;
    end else begin
        grp_fu_778_ce = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_ce_reg))) begin
        grp_fu_785_ce = 1'b1;
    end else begin
        grp_fu_785_ce = 1'b0;
    end
end

assign Range1_all_ones_2_fu_556_p2 = ((tmp_4_reg_954_pp0_iter7_reg == 2'd3) ? 1'b1 : 1'b0);

assign Range1_all_ones_fu_460_p2 = ((tmp_2_fu_451_p4 == 2'd3) ? 1'b1 : 1'b0);

assign Range1_all_zeros_1_fu_561_p2 = ((tmp_4_reg_954_pp0_iter7_reg == 2'd0) ? 1'b1 : 1'b0);

assign Range1_all_zeros_fu_466_p2 = ((tmp_2_fu_451_p4 == 2'd0) ? 1'b1 : 1'b0);

assign Range2_all_ones_1_fu_549_p3 = ret_V_5_reg_929_pp0_iter7_reg[32'd32];

assign Range2_all_ones_fu_444_p3 = ret_V_4_reg_907_pp0_iter7_reg[32'd32];

assign add_ln713_fu_250_p2 = (trunc_ln1192_2_reg_902 + trunc_ln1192_reg_897);

assign and_ln415_2_fu_396_p2 = (tmp_27_fu_389_p3 & r_5_fu_384_p2);

assign and_ln415_fu_313_p2 = (tmp_19_fu_306_p3 & r_fu_301_p2);

assign and_ln779_1_fu_586_p2 = (xor_ln779_2_fu_580_p2 & Range2_all_ones_1_fu_549_p3);

assign and_ln779_fu_492_p2 = (xor_ln779_fu_486_p2 & Range2_all_ones_fu_444_p3);

assign and_ln781_1_fu_701_p2 = (carry_6_reg_1000_pp0_iter8_reg & Range1_all_ones_2_reg_1034);

assign and_ln781_fu_643_p2 = (carry_4_reg_976_pp0_iter8_reg & Range1_all_ones_reg_1018);

assign and_ln786_2_fu_621_p2 = (p_Result_10_reg_1007 & deleted_ones_2_fu_592_p3);

assign and_ln786_fu_527_p2 = (p_Result_7_reg_983 & deleted_ones_fu_498_p3);

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_11001 = ~(1'b1 == 1'b1);

assign ap_block_state10_pp0_stage0_iter9 = ~(1'b1 == 1'b1);

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state3_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_block_state4_pp0_stage0_iter3 = ~(1'b1 == 1'b1);

assign ap_block_state5_pp0_stage0_iter4 = ~(1'b1 == 1'b1);

assign ap_block_state6_pp0_stage0_iter5 = ~(1'b1 == 1'b1);

assign ap_block_state7_pp0_stage0_iter6 = ~(1'b1 == 1'b1);

assign ap_block_state8_pp0_stage0_iter7 = ~(1'b1 == 1'b1);

assign ap_block_state9_pp0_stage0_iter8 = ~(1'b1 == 1'b1);

assign carry_4_fu_343_p2 = (xor_ln416_fu_337_p2 & p_Result_6_fu_294_p3);

assign carry_6_fu_426_p2 = (xor_ln416_2_fu_420_p2 & p_Result_9_fu_377_p3);

assign deleted_ones_2_fu_592_p3 = ((carry_6_reg_1000[0:0] === 1'b1) ? and_ln779_1_fu_586_p2 : Range1_all_ones_2_fu_556_p2);

assign deleted_ones_fu_498_p3 = ((carry_4_reg_976[0:0] === 1'b1) ? and_ln779_fu_492_p2 : Range1_all_ones_fu_460_p2);

assign deleted_zeros_1_fu_566_p3 = ((carry_6_reg_1000[0:0] === 1'b1) ? Range1_all_ones_2_fu_556_p2 : Range1_all_zeros_1_fu_561_p2);

assign deleted_zeros_fu_472_p3 = ((carry_4_reg_976[0:0] === 1'b1) ? Range1_all_ones_fu_460_p2 : Range1_all_zeros_fu_466_p2);

assign empty_16_fu_637_p2 = (xor_ln786_2_fu_626_p2 | icmp_ln790_5_fu_632_p2);

assign empty_fu_543_p2 = (xor_ln786_fu_532_p2 | icmp_ln790_4_fu_538_p2);

assign icmp_ln790_2_fu_158_p2 = ((br_V_read_1_reg_800 == sub_ln790_reg_824) ? 1'b1 : 1'b0);

assign icmp_ln790_3_fu_185_p2 = ((trunc_ln790_4_reg_836 == 16'd0) ? 1'b1 : 1'b0);

assign icmp_ln790_4_fu_538_p2 = ((trunc_ln790_5_reg_989 == 15'd0) ? 1'b1 : 1'b0);

assign icmp_ln790_5_fu_632_p2 = ((trunc_ln790_6_reg_1013 == 15'd0) ? 1'b1 : 1'b0);

assign icmp_ln790_fu_119_p2 = ((trunc_ln790_reg_819 == 16'd0) ? 1'b1 : 1'b0);

assign lhs_V_2_fu_138_p1 = br_V_read_1_reg_800;

assign lhs_V_fu_78_p0 = ar_V_read_int_reg;

assign lhs_V_fu_78_p1 = lhs_V_fu_78_p0;

assign neg_src_1_fu_150_p3 = ret_V_2_fu_144_p2[32'd16];

assign neg_src_2_fu_178_p3 = ret_V_3_reg_829[32'd16];

assign neg_src_fu_112_p3 = ret_V_reg_812[32'd16];

assign or_ln340_4_fu_674_p2 = (xor_ln340_fu_668_p2 | overflow_reg_1023);

assign or_ln340_5_fu_721_p2 = (underflow_4_fu_716_p2 | overflow_2_reg_1039);

assign or_ln340_6_fu_732_p2 = (xor_ln340_2_fu_726_p2 | overflow_2_reg_1039);

assign or_ln340_fu_663_p2 = (underflow_fu_658_p2 | overflow_reg_1023);

assign or_ln785_2_fu_605_p2 = (xor_ln785_3_fu_599_p2 | p_Result_10_reg_1007);

assign or_ln785_fu_511_p2 = (xor_ln785_fu_505_p2 | p_Result_7_reg_983);

assign overflow_2_fu_615_p2 = (xor_ln785_4_fu_610_p2 & or_ln785_2_fu_605_p2);

assign overflow_fu_521_p2 = (xor_ln785_2_fu_516_p2 & or_ln785_fu_511_p2);

assign p_Result_6_fu_294_p3 = ret_V_4_reg_907_pp0_iter6_reg[32'd30];

assign p_Result_9_fu_377_p3 = ret_V_5_reg_929_pp0_iter6_reg[32'd30];

assign p_Val2_25_fu_278_p4 = {{ret_V_4_reg_907_pp0_iter6_reg[30:15]}};

assign p_Val2_26_fu_323_p2 = (p_Val2_25_fu_278_p4 + zext_ln415_fu_319_p1);

assign p_Val2_29_fu_361_p4 = {{ret_V_5_reg_929_pp0_iter6_reg[30:15]}};

assign p_Val2_30_fu_406_p2 = (p_Val2_29_fu_361_p4 + zext_ln415_2_fu_402_p1);

assign phitmp1731_fu_162_p3 = ((icmp_ln790_2_fu_158_p2[0:0] === 1'b1) ? 17'd65537 : ret_V_2_fu_144_p2);

assign phitmp1732_fu_190_p3 = ((icmp_ln790_3_fu_185_p2[0:0] === 1'b1) ? 17'd65537 : ret_V_3_reg_829);

assign phitmp_fu_124_p3 = ((icmp_ln790_fu_119_p2[0:0] === 1'b1) ? 17'd65537 : ret_V_reg_812);

assign r_3_fu_268_p2 = ((trunc_ln718_reg_924 != 14'd0) ? 1'b1 : 1'b0);

assign r_4_fu_273_p2 = ((trunc_ln718_2_reg_949 != 14'd0) ? 1'b1 : 1'b0);

assign r_5_fu_384_p2 = (tmp_25_fu_370_p3 | r_4_reg_965);

assign r_fu_301_p2 = (tmp_17_fu_287_p3 | r_3_reg_960);

assign ret_V_2_fu_144_p2 = ($signed(rhs_V_2_fu_141_p1) + $signed(lhs_V_2_fu_138_p1));

assign ret_V_3_fu_102_p2 = ($signed(rhs_V_fu_82_p1) - $signed(lhs_V_fu_78_p1));

assign ret_V_5_fu_238_p2 = ($signed(p_Val2_22_reg_886) + $signed(p_Val2_27_reg_892));

assign ret_V_fu_86_p2 = ($signed(rhs_V_fu_82_p1) + $signed(lhs_V_fu_78_p1));

assign rhs_V_2_fu_141_p1 = bi_V_read_1_reg_794;

assign rhs_V_fu_82_p1 = $signed(ai_V_read_int_reg);

assign select_ln340_6_fu_737_p3 = ((or_ln340_5_fu_721_p2[0:0] === 1'b1) ? 16'd32767 : p_Val2_30_reg_994_pp0_iter8_reg);

assign select_ln340_7_fu_693_p3 = ((or_ln340_4_fu_674_p2[0:0] === 1'b1) ? select_ln340_fu_679_p3 : select_ln388_fu_686_p3);

assign select_ln340_8_fu_751_p3 = ((or_ln340_6_fu_732_p2[0:0] === 1'b1) ? select_ln340_6_fu_737_p3 : select_ln388_2_fu_744_p3);

assign select_ln340_fu_679_p3 = ((or_ln340_fu_663_p2[0:0] === 1'b1) ? 16'd32767 : p_Val2_26_reg_970_pp0_iter8_reg);

assign select_ln388_2_fu_744_p3 = ((underflow_4_fu_716_p2[0:0] === 1'b1) ? 16'd32769 : p_Val2_30_reg_994_pp0_iter8_reg);

assign select_ln388_fu_686_p3 = ((underflow_fu_658_p2[0:0] === 1'b1) ? 16'd32769 : p_Val2_26_reg_970_pp0_iter8_reg);

assign sub_ln790_fu_96_p1 = bi_V_read_int_reg;

assign sub_ln790_fu_96_p2 = ($signed(16'd0) - $signed(sub_ln790_fu_96_p1));

assign sum0_V_fu_131_p3 = ((neg_src_fu_112_p3[0:0] === 1'b1) ? phitmp_fu_124_p3 : ret_V_reg_812);

assign sum1_V_fu_170_p3 = ((neg_src_1_fu_150_p3[0:0] === 1'b1) ? phitmp1731_fu_162_p3 : ret_V_2_fu_144_p2);

assign sum2_V_fu_197_p3 = ((neg_src_2_fu_178_p3[0:0] === 1'b1) ? phitmp1732_fu_190_p3 : ret_V_3_reg_829);

assign tmp1_fu_711_p2 = (xor_ln781_2_fu_705_p2 & empty_16_reg_1045);

assign tmp_17_fu_287_p3 = ret_V_4_reg_907_pp0_iter6_reg[32'd15];

assign tmp_19_fu_306_p3 = ret_V_4_reg_907_pp0_iter6_reg[32'd14];

assign tmp_20_fu_329_p3 = p_Val2_26_fu_323_p2[32'd15];

assign tmp_23_fu_479_p3 = ret_V_4_reg_907_pp0_iter7_reg[32'd31];

assign tmp_25_fu_370_p3 = ret_V_5_reg_929_pp0_iter6_reg[32'd15];

assign tmp_27_fu_389_p3 = add_ln713_reg_944_pp0_iter6_reg[32'd14];

assign tmp_28_fu_412_p3 = p_Val2_30_fu_406_p2[32'd15];

assign tmp_2_fu_451_p4 = {{ret_V_4_reg_907_pp0_iter7_reg[32:31]}};

assign tmp_31_fu_573_p3 = ret_V_5_reg_929_pp0_iter7_reg[32'd31];

assign tmp_fu_653_p2 = (xor_ln781_fu_647_p2 & empty_reg_1029);

assign trunc_ln1192_2_fu_225_p1 = grp_fu_778_p2[31:0];

assign trunc_ln1192_fu_222_p1 = grp_fu_771_p2[31:0];

assign trunc_ln718_2_fu_254_p1 = ret_V_5_fu_238_p2[13:0];

assign trunc_ln718_fu_235_p1 = grp_fu_785_p3[13:0];

assign trunc_ln790_4_fu_108_p1 = ret_V_3_fu_102_p2[15:0];

assign trunc_ln790_5_fu_357_p1 = p_Val2_26_fu_323_p2[14:0];

assign trunc_ln790_6_fu_440_p1 = p_Val2_30_fu_406_p2[14:0];

assign trunc_ln790_fu_92_p1 = ret_V_fu_86_p2[15:0];

assign underflow_4_fu_716_p2 = (tmp1_fu_711_p2 & p_Result_8_reg_938_pp0_iter8_reg);

assign underflow_fu_658_p2 = (tmp_fu_653_p2 & p_Result_s_reg_918_pp0_iter8_reg);

assign xor_ln340_2_fu_726_p2 = (underflow_4_fu_716_p2 ^ 1'd1);

assign xor_ln340_fu_668_p2 = (underflow_fu_658_p2 ^ 1'd1);

assign xor_ln416_2_fu_420_p2 = (tmp_28_fu_412_p3 ^ 1'd1);

assign xor_ln416_fu_337_p2 = (tmp_20_fu_329_p3 ^ 1'd1);

assign xor_ln779_2_fu_580_p2 = (tmp_31_fu_573_p3 ^ 1'd1);

assign xor_ln779_fu_486_p2 = (tmp_23_fu_479_p3 ^ 1'd1);

assign xor_ln781_2_fu_705_p2 = (1'd1 ^ and_ln781_1_fu_701_p2);

assign xor_ln781_fu_647_p2 = (1'd1 ^ and_ln781_fu_643_p2);

assign xor_ln785_2_fu_516_p2 = (p_Result_s_reg_918_pp0_iter7_reg ^ 1'd1);

assign xor_ln785_3_fu_599_p2 = (deleted_zeros_1_fu_566_p3 ^ 1'd1);

assign xor_ln785_4_fu_610_p2 = (p_Result_8_reg_938_pp0_iter7_reg ^ 1'd1);

assign xor_ln785_fu_505_p2 = (deleted_zeros_fu_472_p3 ^ 1'd1);

assign xor_ln786_2_fu_626_p2 = (1'd1 ^ and_ln786_2_fu_621_p2);

assign xor_ln786_fu_532_p2 = (1'd1 ^ and_ln786_fu_527_p2);

assign zext_ln415_2_fu_402_p1 = and_ln415_2_fu_396_p2;

assign zext_ln415_fu_319_p1 = and_ln415_fu_313_p2;

endmodule //cmpy
