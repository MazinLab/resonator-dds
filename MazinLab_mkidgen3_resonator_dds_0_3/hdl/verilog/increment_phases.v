// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2019.2.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module increment_phases (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        ap_ce,
        group_V_2,
        p_read,
        p_read1,
        p_read2,
        p_read3,
        p_read4,
        p_read5,
        p_read6,
        p_read7,
        p_read8,
        p_read9,
        p_read10,
        p_read11,
        p_read12,
        p_read13,
        p_read14,
        p_read15,
        p_read38,
        p_read39,
        p_read40,
        p_read41,
        p_read42,
        p_read43,
        p_read44,
        p_read45,
        p_read46,
        p_read47,
        p_read48,
        p_read49,
        p_read50,
        p_read51,
        p_read52,
        p_read53,
        dummyout_last_V_writ,
        ap_return_0,
        ap_return_1,
        ap_return_2,
        ap_return_3,
        ap_return_4,
        ap_return_5,
        ap_return_6,
        ap_return_7,
        ap_return_8,
        ap_return_9,
        ap_return_10,
        ap_return_11,
        ap_return_12,
        ap_return_13,
        ap_return_14,
        ap_return_15,
        ap_return_16,
        ap_return_17,
        ap_return_18,
        ap_return_19,
        ap_return_20,
        ap_return_21,
        ap_return_22,
        ap_return_23,
        ap_return_24
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input   ap_ce;
input  [7:0] group_V_2;
input  [15:0] p_read;
input  [15:0] p_read1;
input  [15:0] p_read2;
input  [15:0] p_read3;
input  [15:0] p_read4;
input  [15:0] p_read5;
input  [15:0] p_read6;
input  [15:0] p_read7;
input  [15:0] p_read8;
input  [15:0] p_read9;
input  [15:0] p_read10;
input  [15:0] p_read11;
input  [15:0] p_read12;
input  [15:0] p_read13;
input  [15:0] p_read14;
input  [15:0] p_read15;
input  [15:0] p_read38;
input  [15:0] p_read39;
input  [15:0] p_read40;
input  [15:0] p_read41;
input  [15:0] p_read42;
input  [15:0] p_read43;
input  [15:0] p_read44;
input  [15:0] p_read45;
input  [15:0] p_read46;
input  [15:0] p_read47;
input  [15:0] p_read48;
input  [15:0] p_read49;
input  [15:0] p_read50;
input  [15:0] p_read51;
input  [15:0] p_read52;
input  [15:0] p_read53;
input  [0:0] dummyout_last_V_writ;
output  [0:0] ap_return_0;
output  [21:0] ap_return_1;
output  [21:0] ap_return_2;
output  [21:0] ap_return_3;
output  [21:0] ap_return_4;
output  [21:0] ap_return_5;
output  [21:0] ap_return_6;
output  [21:0] ap_return_7;
output  [21:0] ap_return_8;
output  [15:0] ap_return_9;
output  [15:0] ap_return_10;
output  [15:0] ap_return_11;
output  [15:0] ap_return_12;
output  [15:0] ap_return_13;
output  [15:0] ap_return_14;
output  [15:0] ap_return_15;
output  [15:0] ap_return_16;
output  [15:0] ap_return_17;
output  [15:0] ap_return_18;
output  [15:0] ap_return_19;
output  [15:0] ap_return_20;
output  [15:0] ap_return_21;
output  [15:0] ap_return_22;
output  [15:0] ap_return_23;
output  [15:0] ap_return_24;

reg ap_done;
reg ap_idle;
reg ap_ready;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
wire    ap_block_pp0_stage0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_idle_pp0;
reg    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
wire    ap_block_state3_pp0_stage0_iter2;
reg    ap_block_pp0_stage0_11001;
reg   [21:0] last_phases_V_0;
reg   [21:0] last_phases_V_1;
reg   [21:0] last_phases_V_2;
reg   [21:0] last_phases_V_3;
reg   [21:0] last_phases_V_4;
reg   [21:0] last_phases_V_5;
reg   [21:0] last_phases_V_6;
reg   [21:0] last_phases_V_7;
wire   [7:0] phase_cache_phases_V_address0;
reg    phase_cache_phases_V_ce0;
wire   [175:0] phase_cache_phases_V_q0;
wire   [7:0] phase_cache_phases_V_address1;
reg    phase_cache_phases_V_ce1;
reg    phase_cache_phases_V_we1;
wire   [175:0] phase_cache_phases_V_d1;
reg   [0:0] dummyout_last_V_writ_1_reg_894;
reg   [0:0] dummyout_last_V_writ_1_reg_894_pp0_iter1_reg;
reg   [15:0] p_read_1_reg_899;
reg   [15:0] p_read_1_reg_899_pp0_iter1_reg;
reg   [15:0] p_read_2_reg_904;
reg   [15:0] p_read_2_reg_904_pp0_iter1_reg;
reg   [15:0] p_read_3_reg_909;
reg   [15:0] p_read_3_reg_909_pp0_iter1_reg;
reg   [15:0] p_read_4_reg_914;
reg   [15:0] p_read_4_reg_914_pp0_iter1_reg;
reg   [15:0] p_read_5_reg_919;
reg   [15:0] p_read_5_reg_919_pp0_iter1_reg;
reg   [15:0] p_read_6_reg_924;
reg   [15:0] p_read_6_reg_924_pp0_iter1_reg;
reg   [15:0] p_read_7_reg_929;
reg   [15:0] p_read_7_reg_929_pp0_iter1_reg;
reg   [15:0] p_read_8_reg_934;
reg   [15:0] p_read_8_reg_934_pp0_iter1_reg;
reg   [15:0] p_read_9_reg_939;
reg   [15:0] p_read_9_reg_939_pp0_iter1_reg;
reg   [15:0] p_read_10_reg_944;
reg   [15:0] p_read_10_reg_944_pp0_iter1_reg;
reg   [15:0] p_read_11_reg_949;
reg   [15:0] p_read_11_reg_949_pp0_iter1_reg;
reg   [15:0] p_read_12_reg_954;
reg   [15:0] p_read_12_reg_954_pp0_iter1_reg;
reg   [15:0] p_read_13_reg_959;
reg   [15:0] p_read_13_reg_959_pp0_iter1_reg;
reg   [15:0] p_read_14_reg_964;
reg   [15:0] p_read_14_reg_964_pp0_iter1_reg;
reg   [15:0] p_read_15_reg_969;
reg   [15:0] p_read_15_reg_969_pp0_iter1_reg;
reg   [15:0] p_read_16_reg_974;
reg   [15:0] p_read_16_reg_974_pp0_iter1_reg;
reg   [15:0] p_read_17_reg_979;
reg   [15:0] p_read_17_reg_979_pp0_iter1_reg;
reg   [15:0] p_read_18_reg_984;
reg   [15:0] p_read_18_reg_984_pp0_iter1_reg;
reg   [15:0] p_read_19_reg_989;
reg   [15:0] p_read_19_reg_989_pp0_iter1_reg;
reg   [15:0] p_read_20_reg_994;
reg   [15:0] p_read_20_reg_994_pp0_iter1_reg;
reg   [15:0] p_read_21_reg_999;
reg   [15:0] p_read_21_reg_999_pp0_iter1_reg;
reg   [15:0] p_read_22_reg_1004;
reg   [15:0] p_read_22_reg_1004_pp0_iter1_reg;
reg   [15:0] p_read_23_reg_1009;
reg   [15:0] p_read_23_reg_1009_pp0_iter1_reg;
reg   [15:0] p_read_24_reg_1014;
reg   [15:0] p_read_24_reg_1014_pp0_iter1_reg;
reg   [15:0] p_read723_reg_1019;
reg   [15:0] p_read723_reg_1019_pp0_iter1_reg;
reg   [15:0] p_read622_reg_1024;
reg   [15:0] p_read622_reg_1024_pp0_iter1_reg;
reg   [15:0] p_read521_reg_1029;
reg   [15:0] p_read521_reg_1029_pp0_iter1_reg;
reg   [15:0] p_read420_reg_1034;
reg   [15:0] p_read420_reg_1034_pp0_iter1_reg;
reg   [15:0] p_read319_reg_1039;
reg   [15:0] p_read319_reg_1039_pp0_iter1_reg;
reg   [15:0] p_read218_reg_1044;
reg   [15:0] p_read218_reg_1044_pp0_iter1_reg;
reg   [15:0] p_read117_reg_1049;
reg   [15:0] p_read117_reg_1049_pp0_iter1_reg;
reg   [15:0] p_read16_reg_1054;
reg   [15:0] p_read16_reg_1054_pp0_iter1_reg;
wire   [8:0] ret_V_fu_379_p2;
reg   [8:0] ret_V_reg_1059;
wire   [21:0] trunc_ln203_fu_447_p1;
reg   [21:0] trunc_ln203_reg_1079;
reg   [21:0] tmp_2_reg_1085;
reg   [21:0] tmp_3_reg_1091;
reg   [21:0] tmp_4_reg_1097;
reg   [21:0] tmp_5_reg_1103;
reg   [21:0] tmp_6_reg_1109;
reg   [21:0] tmp_7_reg_1115;
reg   [21:0] tmp_8_reg_1121;
reg    ap_block_pp0_stage0_subdone;
wire   [63:0] zext_ln544_fu_385_p1;
wire  signed [63:0] sext_ln544_fu_390_p1;
wire   [21:0] add_ln703_1_fu_540_p2;
reg   [21:0] ap_sig_allocacmp_last_phases_V_0_load;
wire   [21:0] add_ln703_3_fu_564_p2;
reg   [21:0] ap_sig_allocacmp_last_phases_V_1_load;
wire   [21:0] add_ln703_5_fu_588_p2;
reg   [21:0] ap_sig_allocacmp_last_phases_V_2_load;
wire   [21:0] add_ln703_7_fu_612_p2;
reg   [21:0] ap_sig_allocacmp_last_phases_V_3_load;
wire   [21:0] add_ln703_9_fu_636_p2;
reg   [21:0] ap_sig_allocacmp_last_phases_V_4_load;
wire   [21:0] add_ln703_11_fu_660_p2;
reg   [21:0] ap_sig_allocacmp_last_phases_V_5_load;
wire   [21:0] add_ln703_13_fu_684_p2;
reg   [21:0] ap_sig_allocacmp_last_phases_V_6_load;
wire   [21:0] add_ln703_15_fu_708_p2;
reg   [21:0] ap_sig_allocacmp_last_phases_V_7_load;
wire   [8:0] zext_ln215_fu_375_p1;
wire   [21:0] shl_ln_fu_521_p3;
wire   [21:0] shl_ln703_1_fu_533_p3;
wire   [21:0] shl_ln703_2_fu_545_p3;
wire   [21:0] shl_ln703_3_fu_557_p3;
wire   [21:0] shl_ln703_4_fu_569_p3;
wire   [21:0] shl_ln703_5_fu_581_p3;
wire   [21:0] shl_ln703_6_fu_593_p3;
wire   [21:0] shl_ln703_7_fu_605_p3;
wire   [21:0] shl_ln703_8_fu_617_p3;
wire   [21:0] shl_ln703_9_fu_629_p3;
wire   [21:0] shl_ln703_s_fu_641_p3;
wire   [21:0] shl_ln703_10_fu_653_p3;
wire   [21:0] shl_ln703_11_fu_665_p3;
wire   [21:0] shl_ln703_12_fu_677_p3;
wire   [21:0] shl_ln703_13_fu_689_p3;
wire   [21:0] shl_ln703_14_fu_701_p3;
wire   [21:0] add_ln703_fu_528_p2;
wire   [21:0] add_ln703_2_fu_552_p2;
wire   [21:0] add_ln703_4_fu_576_p2;
wire   [21:0] add_ln703_6_fu_600_p2;
wire   [21:0] add_ln703_8_fu_624_p2;
wire   [21:0] add_ln703_10_fu_648_p2;
wire   [21:0] add_ln703_12_fu_672_p2;
wire   [21:0] add_ln703_14_fu_696_p2;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to1;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 last_phases_V_0 = 22'd0;
#0 last_phases_V_1 = 22'd0;
#0 last_phases_V_2 = 22'd0;
#0 last_phases_V_3 = 22'd0;
#0 last_phases_V_4 = 22'd0;
#0 last_phases_V_5 = 22'd0;
#0 last_phases_V_6 = 22'd0;
#0 last_phases_V_7 = 22'd0;
end

increment_phases_bkb #(
    .DataWidth( 176 ),
    .AddressRange( 256 ),
    .AddressWidth( 8 ))
phase_cache_phases_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(phase_cache_phases_V_address0),
    .ce0(phase_cache_phases_V_ce0),
    .q0(phase_cache_phases_V_q0),
    .address1(phase_cache_phases_V_address1),
    .ce1(phase_cache_phases_V_ce1),
    .we1(phase_cache_phases_V_we1),
    .d1(phase_cache_phases_V_d1)
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
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_ce) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        dummyout_last_V_writ_1_reg_894 <= dummyout_last_V_writ;
        dummyout_last_V_writ_1_reg_894_pp0_iter1_reg <= dummyout_last_V_writ_1_reg_894;
        p_read117_reg_1049 <= p_read1;
        p_read117_reg_1049_pp0_iter1_reg <= p_read117_reg_1049;
        p_read16_reg_1054 <= p_read;
        p_read16_reg_1054_pp0_iter1_reg <= p_read16_reg_1054;
        p_read218_reg_1044 <= p_read2;
        p_read218_reg_1044_pp0_iter1_reg <= p_read218_reg_1044;
        p_read319_reg_1039 <= p_read3;
        p_read319_reg_1039_pp0_iter1_reg <= p_read319_reg_1039;
        p_read420_reg_1034 <= p_read4;
        p_read420_reg_1034_pp0_iter1_reg <= p_read420_reg_1034;
        p_read521_reg_1029 <= p_read5;
        p_read521_reg_1029_pp0_iter1_reg <= p_read521_reg_1029;
        p_read622_reg_1024 <= p_read6;
        p_read622_reg_1024_pp0_iter1_reg <= p_read622_reg_1024;
        p_read723_reg_1019 <= p_read7;
        p_read723_reg_1019_pp0_iter1_reg <= p_read723_reg_1019;
        p_read_10_reg_944 <= p_read44;
        p_read_10_reg_944_pp0_iter1_reg <= p_read_10_reg_944;
        p_read_11_reg_949 <= p_read43;
        p_read_11_reg_949_pp0_iter1_reg <= p_read_11_reg_949;
        p_read_12_reg_954 <= p_read42;
        p_read_12_reg_954_pp0_iter1_reg <= p_read_12_reg_954;
        p_read_13_reg_959 <= p_read41;
        p_read_13_reg_959_pp0_iter1_reg <= p_read_13_reg_959;
        p_read_14_reg_964 <= p_read40;
        p_read_14_reg_964_pp0_iter1_reg <= p_read_14_reg_964;
        p_read_15_reg_969 <= p_read39;
        p_read_15_reg_969_pp0_iter1_reg <= p_read_15_reg_969;
        p_read_16_reg_974 <= p_read38;
        p_read_16_reg_974_pp0_iter1_reg <= p_read_16_reg_974;
        p_read_17_reg_979 <= p_read15;
        p_read_17_reg_979_pp0_iter1_reg <= p_read_17_reg_979;
        p_read_18_reg_984 <= p_read14;
        p_read_18_reg_984_pp0_iter1_reg <= p_read_18_reg_984;
        p_read_19_reg_989 <= p_read13;
        p_read_19_reg_989_pp0_iter1_reg <= p_read_19_reg_989;
        p_read_1_reg_899 <= p_read53;
        p_read_1_reg_899_pp0_iter1_reg <= p_read_1_reg_899;
        p_read_20_reg_994 <= p_read12;
        p_read_20_reg_994_pp0_iter1_reg <= p_read_20_reg_994;
        p_read_21_reg_999 <= p_read11;
        p_read_21_reg_999_pp0_iter1_reg <= p_read_21_reg_999;
        p_read_22_reg_1004 <= p_read10;
        p_read_22_reg_1004_pp0_iter1_reg <= p_read_22_reg_1004;
        p_read_23_reg_1009 <= p_read9;
        p_read_23_reg_1009_pp0_iter1_reg <= p_read_23_reg_1009;
        p_read_24_reg_1014 <= p_read8;
        p_read_24_reg_1014_pp0_iter1_reg <= p_read_24_reg_1014;
        p_read_2_reg_904 <= p_read52;
        p_read_2_reg_904_pp0_iter1_reg <= p_read_2_reg_904;
        p_read_3_reg_909 <= p_read51;
        p_read_3_reg_909_pp0_iter1_reg <= p_read_3_reg_909;
        p_read_4_reg_914 <= p_read50;
        p_read_4_reg_914_pp0_iter1_reg <= p_read_4_reg_914;
        p_read_5_reg_919 <= p_read49;
        p_read_5_reg_919_pp0_iter1_reg <= p_read_5_reg_919;
        p_read_6_reg_924 <= p_read48;
        p_read_6_reg_924_pp0_iter1_reg <= p_read_6_reg_924;
        p_read_7_reg_929 <= p_read47;
        p_read_7_reg_929_pp0_iter1_reg <= p_read_7_reg_929;
        p_read_8_reg_934 <= p_read46;
        p_read_8_reg_934_pp0_iter1_reg <= p_read_8_reg_934;
        p_read_9_reg_939 <= p_read45;
        p_read_9_reg_939_pp0_iter1_reg <= p_read_9_reg_939;
        ret_V_reg_1059 <= ret_V_fu_379_p2;
        tmp_2_reg_1085 <= {{phase_cache_phases_V_q0[43:22]}};
        tmp_3_reg_1091 <= {{phase_cache_phases_V_q0[65:44]}};
        tmp_4_reg_1097 <= {{phase_cache_phases_V_q0[87:66]}};
        tmp_5_reg_1103 <= {{phase_cache_phases_V_q0[109:88]}};
        tmp_6_reg_1109 <= {{phase_cache_phases_V_q0[131:110]}};
        tmp_7_reg_1115 <= {{phase_cache_phases_V_q0[153:132]}};
        tmp_8_reg_1121 <= {{phase_cache_phases_V_q0[175:154]}};
        trunc_ln203_reg_1079 <= trunc_ln203_fu_447_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_ce) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        last_phases_V_0 <= add_ln703_1_fu_540_p2;
        last_phases_V_1 <= add_ln703_3_fu_564_p2;
        last_phases_V_2 <= add_ln703_5_fu_588_p2;
        last_phases_V_3 <= add_ln703_7_fu_612_p2;
        last_phases_V_4 <= add_ln703_9_fu_636_p2;
        last_phases_V_5 <= add_ln703_11_fu_660_p2;
        last_phases_V_6 <= add_ln703_13_fu_684_p2;
        last_phases_V_7 <= add_ln703_15_fu_708_p2;
    end
end

always @ (*) begin
    if ((((ap_start == 1'b0) & (1'b0 == ap_block_pp0_stage0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b1 == ap_ce) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1)))) begin
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
    if (((ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0_0to1 = 1'b1;
    end else begin
        ap_idle_pp0_0to1 = 1'b0;
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
    if (((ap_start == 1'b0) & (ap_idle_pp0_0to1 == 1'b1))) begin
        ap_reset_idle_pp0 = 1'b1;
    end else begin
        ap_reset_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        ap_sig_allocacmp_last_phases_V_0_load = add_ln703_1_fu_540_p2;
    end else begin
        ap_sig_allocacmp_last_phases_V_0_load = last_phases_V_0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        ap_sig_allocacmp_last_phases_V_1_load = add_ln703_3_fu_564_p2;
    end else begin
        ap_sig_allocacmp_last_phases_V_1_load = last_phases_V_1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        ap_sig_allocacmp_last_phases_V_2_load = add_ln703_5_fu_588_p2;
    end else begin
        ap_sig_allocacmp_last_phases_V_2_load = last_phases_V_2;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        ap_sig_allocacmp_last_phases_V_3_load = add_ln703_7_fu_612_p2;
    end else begin
        ap_sig_allocacmp_last_phases_V_3_load = last_phases_V_3;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        ap_sig_allocacmp_last_phases_V_4_load = add_ln703_9_fu_636_p2;
    end else begin
        ap_sig_allocacmp_last_phases_V_4_load = last_phases_V_4;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        ap_sig_allocacmp_last_phases_V_5_load = add_ln703_11_fu_660_p2;
    end else begin
        ap_sig_allocacmp_last_phases_V_5_load = last_phases_V_5;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        ap_sig_allocacmp_last_phases_V_6_load = add_ln703_13_fu_684_p2;
    end else begin
        ap_sig_allocacmp_last_phases_V_6_load = last_phases_V_6;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        ap_sig_allocacmp_last_phases_V_7_load = add_ln703_15_fu_708_p2;
    end else begin
        ap_sig_allocacmp_last_phases_V_7_load = last_phases_V_7;
    end
end

always @ (*) begin
    if (((1'b1 == ap_ce) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        phase_cache_phases_V_ce0 = 1'b1;
    end else begin
        phase_cache_phases_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b1 == ap_ce) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1)) | ((1'b1 == ap_ce) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        phase_cache_phases_V_ce1 = 1'b1;
    end else begin
        phase_cache_phases_V_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_ce) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        phase_cache_phases_V_we1 = 1'b1;
    end else begin
        phase_cache_phases_V_we1 = 1'b0;
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

assign add_ln703_10_fu_648_p2 = (shl_ln703_s_fu_641_p3 + tmp_6_reg_1109);

assign add_ln703_11_fu_660_p2 = (shl_ln703_10_fu_653_p3 + tmp_6_reg_1109);

assign add_ln703_12_fu_672_p2 = (shl_ln703_11_fu_665_p3 + tmp_7_reg_1115);

assign add_ln703_13_fu_684_p2 = (shl_ln703_12_fu_677_p3 + tmp_7_reg_1115);

assign add_ln703_14_fu_696_p2 = (shl_ln703_13_fu_689_p3 + tmp_8_reg_1121);

assign add_ln703_15_fu_708_p2 = (shl_ln703_14_fu_701_p3 + tmp_8_reg_1121);

assign add_ln703_1_fu_540_p2 = (shl_ln703_1_fu_533_p3 + trunc_ln203_reg_1079);

assign add_ln703_2_fu_552_p2 = (shl_ln703_2_fu_545_p3 + tmp_2_reg_1085);

assign add_ln703_3_fu_564_p2 = (shl_ln703_3_fu_557_p3 + tmp_2_reg_1085);

assign add_ln703_4_fu_576_p2 = (shl_ln703_4_fu_569_p3 + tmp_3_reg_1091);

assign add_ln703_5_fu_588_p2 = (shl_ln703_5_fu_581_p3 + tmp_3_reg_1091);

assign add_ln703_6_fu_600_p2 = (shl_ln703_6_fu_593_p3 + tmp_4_reg_1097);

assign add_ln703_7_fu_612_p2 = (shl_ln703_7_fu_605_p3 + tmp_4_reg_1097);

assign add_ln703_8_fu_624_p2 = (shl_ln703_8_fu_617_p3 + tmp_5_reg_1103);

assign add_ln703_9_fu_636_p2 = (shl_ln703_9_fu_629_p3 + tmp_5_reg_1103);

assign add_ln703_fu_528_p2 = (shl_ln_fu_521_p3 + trunc_ln203_reg_1079);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_start == 1'b0) & (ap_start == 1'b1));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((1'b0 == ap_ce) | ((ap_start == 1'b0) & (ap_start == 1'b1)));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = (ap_start == 1'b0);
end

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state3_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start;

assign ap_return_0 = dummyout_last_V_writ_1_reg_894_pp0_iter1_reg;

assign ap_return_1 = add_ln703_fu_528_p2;

assign ap_return_10 = p_read_15_reg_969_pp0_iter1_reg;

assign ap_return_11 = p_read_14_reg_964_pp0_iter1_reg;

assign ap_return_12 = p_read_13_reg_959_pp0_iter1_reg;

assign ap_return_13 = p_read_12_reg_954_pp0_iter1_reg;

assign ap_return_14 = p_read_11_reg_949_pp0_iter1_reg;

assign ap_return_15 = p_read_10_reg_944_pp0_iter1_reg;

assign ap_return_16 = p_read_9_reg_939_pp0_iter1_reg;

assign ap_return_17 = p_read_8_reg_934_pp0_iter1_reg;

assign ap_return_18 = p_read_7_reg_929_pp0_iter1_reg;

assign ap_return_19 = p_read_6_reg_924_pp0_iter1_reg;

assign ap_return_2 = add_ln703_2_fu_552_p2;

assign ap_return_20 = p_read_5_reg_919_pp0_iter1_reg;

assign ap_return_21 = p_read_4_reg_914_pp0_iter1_reg;

assign ap_return_22 = p_read_3_reg_909_pp0_iter1_reg;

assign ap_return_23 = p_read_2_reg_904_pp0_iter1_reg;

assign ap_return_24 = p_read_1_reg_899_pp0_iter1_reg;

assign ap_return_3 = add_ln703_4_fu_576_p2;

assign ap_return_4 = add_ln703_6_fu_600_p2;

assign ap_return_5 = add_ln703_8_fu_624_p2;

assign ap_return_6 = add_ln703_10_fu_648_p2;

assign ap_return_7 = add_ln703_12_fu_672_p2;

assign ap_return_8 = add_ln703_14_fu_696_p2;

assign ap_return_9 = p_read_16_reg_974_pp0_iter1_reg;

assign phase_cache_phases_V_address0 = zext_ln544_fu_385_p1;

assign phase_cache_phases_V_address1 = sext_ln544_fu_390_p1;

assign phase_cache_phases_V_d1 = {{{{{{{{ap_sig_allocacmp_last_phases_V_7_load}, {ap_sig_allocacmp_last_phases_V_6_load}}, {ap_sig_allocacmp_last_phases_V_5_load}}, {ap_sig_allocacmp_last_phases_V_4_load}}, {ap_sig_allocacmp_last_phases_V_3_load}}, {ap_sig_allocacmp_last_phases_V_2_load}}, {ap_sig_allocacmp_last_phases_V_1_load}}, {ap_sig_allocacmp_last_phases_V_0_load}};

assign ret_V_fu_379_p2 = ($signed(9'd511) + $signed(zext_ln215_fu_375_p1));

assign sext_ln544_fu_390_p1 = $signed(ret_V_reg_1059);

assign shl_ln703_10_fu_653_p3 = {{p_read521_reg_1029_pp0_iter1_reg}, {6'd0}};

assign shl_ln703_11_fu_665_p3 = {{p_read_18_reg_984_pp0_iter1_reg}, {6'd0}};

assign shl_ln703_12_fu_677_p3 = {{p_read622_reg_1024_pp0_iter1_reg}, {6'd0}};

assign shl_ln703_13_fu_689_p3 = {{p_read_17_reg_979_pp0_iter1_reg}, {6'd0}};

assign shl_ln703_14_fu_701_p3 = {{p_read723_reg_1019_pp0_iter1_reg}, {6'd0}};

assign shl_ln703_1_fu_533_p3 = {{p_read16_reg_1054_pp0_iter1_reg}, {6'd0}};

assign shl_ln703_2_fu_545_p3 = {{p_read_23_reg_1009_pp0_iter1_reg}, {6'd0}};

assign shl_ln703_3_fu_557_p3 = {{p_read117_reg_1049_pp0_iter1_reg}, {6'd0}};

assign shl_ln703_4_fu_569_p3 = {{p_read_22_reg_1004_pp0_iter1_reg}, {6'd0}};

assign shl_ln703_5_fu_581_p3 = {{p_read218_reg_1044_pp0_iter1_reg}, {6'd0}};

assign shl_ln703_6_fu_593_p3 = {{p_read_21_reg_999_pp0_iter1_reg}, {6'd0}};

assign shl_ln703_7_fu_605_p3 = {{p_read319_reg_1039_pp0_iter1_reg}, {6'd0}};

assign shl_ln703_8_fu_617_p3 = {{p_read_20_reg_994_pp0_iter1_reg}, {6'd0}};

assign shl_ln703_9_fu_629_p3 = {{p_read420_reg_1034_pp0_iter1_reg}, {6'd0}};

assign shl_ln703_s_fu_641_p3 = {{p_read_19_reg_989_pp0_iter1_reg}, {6'd0}};

assign shl_ln_fu_521_p3 = {{p_read_24_reg_1014_pp0_iter1_reg}, {6'd0}};

assign trunc_ln203_fu_447_p1 = phase_cache_phases_V_q0[21:0];

assign zext_ln215_fu_375_p1 = group_V_2;

assign zext_ln544_fu_385_p1 = group_V_2;

endmodule //increment_phases