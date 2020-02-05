// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2019.2.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module fetch_tones (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        res_in_TVALID,
        ap_ce,
        res_in_TDATA,
        res_in_TREADY,
        res_in_TLAST,
        toneinc_V_address0,
        toneinc_V_ce0,
        toneinc_V_q0,
        phase0_V_address0,
        phase0_V_ce0,
        phase0_V_q0,
        group_V,
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
        ap_return_24,
        ap_return_25,
        ap_return_26,
        ap_return_27,
        ap_return_28,
        ap_return_29,
        ap_return_30,
        ap_return_31,
        ap_return_32,
        res_in_TDATA_blk_n
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input   res_in_TVALID;
input   ap_ce;
input  [255:0] res_in_TDATA;
output   res_in_TREADY;
input  [0:0] res_in_TLAST;
output  [7:0] toneinc_V_address0;
output   toneinc_V_ce0;
input  [127:0] toneinc_V_q0;
output  [7:0] phase0_V_address0;
output   phase0_V_ce0;
input  [127:0] phase0_V_q0;
input  [7:0] group_V;
output  [0:0] ap_return_0;
output  [15:0] ap_return_1;
output  [15:0] ap_return_2;
output  [15:0] ap_return_3;
output  [15:0] ap_return_4;
output  [15:0] ap_return_5;
output  [15:0] ap_return_6;
output  [15:0] ap_return_7;
output  [15:0] ap_return_8;
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
output  [15:0] ap_return_25;
output  [15:0] ap_return_26;
output  [15:0] ap_return_27;
output  [15:0] ap_return_28;
output  [15:0] ap_return_29;
output  [15:0] ap_return_30;
output  [15:0] ap_return_31;
output  [15:0] ap_return_32;
output   res_in_TDATA_blk_n;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg res_in_TREADY;
reg toneinc_V_ce0;
reg phase0_V_ce0;
reg res_in_TDATA_blk_n;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
wire    ap_block_pp0_stage0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_idle_pp0;
reg    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
reg    ap_block_pp0_stage0_11001;
reg   [0:0] input_last_V_tmp_reg_641;
wire   [15:0] trunc_ln203_fu_152_p1;
reg   [15:0] trunc_ln203_reg_646;
reg   [15:0] resdat_data_iq_q_V_reg_651;
reg   [15:0] resdat_data_iq_i_V_1_reg_656;
reg   [15:0] resdat_data_iq_q_V_1_reg_661;
reg   [15:0] resdat_data_iq_i_V_2_reg_666;
reg   [15:0] resdat_data_iq_q_V_2_reg_671;
reg   [15:0] resdat_data_iq_i_V_3_reg_676;
reg   [15:0] resdat_data_iq_q_V_3_reg_681;
reg   [15:0] resdat_data_iq_i_V_4_reg_686;
reg   [15:0] resdat_data_iq_q_V_4_reg_691;
reg   [15:0] resdat_data_iq_i_V_5_reg_696;
reg   [15:0] resdat_data_iq_q_V_5_reg_701;
reg   [15:0] resdat_data_iq_i_V_6_reg_706;
reg   [15:0] resdat_data_iq_q_V_6_reg_711;
reg   [15:0] resdat_data_iq_i_V_7_reg_716;
reg   [15:0] resdat_data_iq_q_V_7_reg_721;
reg    ap_block_pp0_stage0_subdone;
wire   [63:0] zext_ln544_fu_306_p1;
wire   [15:0] trunc_ln203_1_fu_312_p1;
wire   [15:0] trunc_ln356_fu_316_p1;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to0;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

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
        if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter1 <= ap_start;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_ce) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        input_last_V_tmp_reg_641 <= res_in_TLAST;
        resdat_data_iq_i_V_1_reg_656 <= {{res_in_TDATA[31:16]}};
        resdat_data_iq_i_V_2_reg_666 <= {{res_in_TDATA[47:32]}};
        resdat_data_iq_i_V_3_reg_676 <= {{res_in_TDATA[63:48]}};
        resdat_data_iq_i_V_4_reg_686 <= {{res_in_TDATA[79:64]}};
        resdat_data_iq_i_V_5_reg_696 <= {{res_in_TDATA[95:80]}};
        resdat_data_iq_i_V_6_reg_706 <= {{res_in_TDATA[111:96]}};
        resdat_data_iq_i_V_7_reg_716 <= {{res_in_TDATA[127:112]}};
        resdat_data_iq_q_V_1_reg_661 <= {{res_in_TDATA[159:144]}};
        resdat_data_iq_q_V_2_reg_671 <= {{res_in_TDATA[175:160]}};
        resdat_data_iq_q_V_3_reg_681 <= {{res_in_TDATA[191:176]}};
        resdat_data_iq_q_V_4_reg_691 <= {{res_in_TDATA[207:192]}};
        resdat_data_iq_q_V_5_reg_701 <= {{res_in_TDATA[223:208]}};
        resdat_data_iq_q_V_6_reg_711 <= {{res_in_TDATA[239:224]}};
        resdat_data_iq_q_V_7_reg_721 <= {{res_in_TDATA[255:240]}};
        resdat_data_iq_q_V_reg_651 <= {{res_in_TDATA[143:128]}};
        trunc_ln203_reg_646 <= trunc_ln203_fu_152_p1;
    end
end

always @ (*) begin
    if ((((ap_start == 1'b0) & (1'b0 == ap_block_pp0_stage0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b1 == ap_ce) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
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
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((ap_enable_reg_pp0_iter0 == 1'b0)) begin
        ap_idle_pp0_0to0 = 1'b1;
    end else begin
        ap_idle_pp0_0to0 = 1'b0;
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
    if (((ap_start == 1'b0) & (ap_idle_pp0_0to0 == 1'b1))) begin
        ap_reset_idle_pp0 = 1'b1;
    end else begin
        ap_reset_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_ce) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        phase0_V_ce0 = 1'b1;
    end else begin
        phase0_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        res_in_TDATA_blk_n = res_in_TVALID;
    end else begin
        res_in_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b1 == ap_ce) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        res_in_TREADY = 1'b1;
    end else begin
        res_in_TREADY = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_ce) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        toneinc_V_ce0 = 1'b1;
    end else begin
        toneinc_V_ce0 = 1'b0;
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

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_start == 1'b1) & ((ap_start == 1'b0) | (res_in_TVALID == 1'b0)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((1'b0 == ap_ce) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (res_in_TVALID == 1'b0))));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = ((ap_start == 1'b0) | (res_in_TVALID == 1'b0));
end

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start;

assign ap_return_0 = input_last_V_tmp_reg_641;

assign ap_return_1 = trunc_ln203_1_fu_312_p1;

assign ap_return_10 = {{phase0_V_q0[31:16]}};

assign ap_return_11 = {{phase0_V_q0[47:32]}};

assign ap_return_12 = {{phase0_V_q0[63:48]}};

assign ap_return_13 = {{phase0_V_q0[79:64]}};

assign ap_return_14 = {{phase0_V_q0[95:80]}};

assign ap_return_15 = {{phase0_V_q0[111:96]}};

assign ap_return_16 = {{phase0_V_q0[127:112]}};

assign ap_return_17 = trunc_ln203_reg_646;

assign ap_return_18 = resdat_data_iq_i_V_1_reg_656;

assign ap_return_19 = resdat_data_iq_i_V_2_reg_666;

assign ap_return_2 = {{toneinc_V_q0[31:16]}};

assign ap_return_20 = resdat_data_iq_i_V_3_reg_676;

assign ap_return_21 = resdat_data_iq_i_V_4_reg_686;

assign ap_return_22 = resdat_data_iq_i_V_5_reg_696;

assign ap_return_23 = resdat_data_iq_i_V_6_reg_706;

assign ap_return_24 = resdat_data_iq_i_V_7_reg_716;

assign ap_return_25 = resdat_data_iq_q_V_reg_651;

assign ap_return_26 = resdat_data_iq_q_V_1_reg_661;

assign ap_return_27 = resdat_data_iq_q_V_2_reg_671;

assign ap_return_28 = resdat_data_iq_q_V_3_reg_681;

assign ap_return_29 = resdat_data_iq_q_V_4_reg_691;

assign ap_return_3 = {{toneinc_V_q0[47:32]}};

assign ap_return_30 = resdat_data_iq_q_V_5_reg_701;

assign ap_return_31 = resdat_data_iq_q_V_6_reg_711;

assign ap_return_32 = resdat_data_iq_q_V_7_reg_721;

assign ap_return_4 = {{toneinc_V_q0[63:48]}};

assign ap_return_5 = {{toneinc_V_q0[79:64]}};

assign ap_return_6 = {{toneinc_V_q0[95:80]}};

assign ap_return_7 = {{toneinc_V_q0[111:96]}};

assign ap_return_8 = {{toneinc_V_q0[127:112]}};

assign ap_return_9 = trunc_ln356_fu_316_p1;

assign phase0_V_address0 = zext_ln544_fu_306_p1;

assign toneinc_V_address0 = zext_ln544_fu_306_p1;

assign trunc_ln203_1_fu_312_p1 = toneinc_V_q0[15:0];

assign trunc_ln203_fu_152_p1 = res_in_TDATA[15:0];

assign trunc_ln356_fu_316_p1 = phase0_V_q0[15:0];

assign zext_ln544_fu_306_p1 = group_V;

endmodule //fetch_tones
