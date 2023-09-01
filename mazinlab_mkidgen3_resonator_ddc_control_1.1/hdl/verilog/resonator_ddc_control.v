// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Version: 2022.1
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="resonator_ddc_control_resonator_ddc_control,hls_ip_2022_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xczu28dr-ffvg1517-2-e,HLS_INPUT_CLOCK=1.818000,HLS_INPUT_ARCH=pipeline,HLS_SYN_CLOCK=1.237000,HLS_SYN_LAT=3,HLS_SYN_TPT=1,HLS_SYN_MEM=35,HLS_SYN_DSP=0,HLS_SYN_FF=1940,HLS_SYN_LUT=909,HLS_VERSION=2022_1}" *)

module resonator_ddc_control (
        ap_clk,
        ap_rst_n,
        res_in_TDATA,
        res_in_TVALID,
        res_in_TREADY,
        res_in_TKEEP,
        res_in_TSTRB,
        res_in_TUSER,
        res_in_TLAST,
        out_r_TDATA,
        out_r_TVALID,
        out_r_TREADY,
        out_r_TKEEP,
        out_r_TSTRB,
        out_r_TUSER,
        out_r_TLAST,
        s_axi_control_AWVALID,
        s_axi_control_AWREADY,
        s_axi_control_AWADDR,
        s_axi_control_WVALID,
        s_axi_control_WREADY,
        s_axi_control_WDATA,
        s_axi_control_WSTRB,
        s_axi_control_ARVALID,
        s_axi_control_ARREADY,
        s_axi_control_ARADDR,
        s_axi_control_RVALID,
        s_axi_control_RREADY,
        s_axi_control_RDATA,
        s_axi_control_RRESP,
        s_axi_control_BVALID,
        s_axi_control_BREADY,
        s_axi_control_BRESP
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;
parameter    C_S_AXI_CONTROL_DATA_WIDTH = 32;
parameter    C_S_AXI_CONTROL_ADDR_WIDTH = 15;
parameter    C_S_AXI_DATA_WIDTH = 32;

parameter C_S_AXI_CONTROL_WSTRB_WIDTH = (32 / 8);
parameter C_S_AXI_WSTRB_WIDTH = (32 / 8);

input   ap_clk;
input   ap_rst_n;
input  [255:0] res_in_TDATA;
input   res_in_TVALID;
output   res_in_TREADY;
input  [31:0] res_in_TKEEP;
input  [31:0] res_in_TSTRB;
input  [7:0] res_in_TUSER;
input  [0:0] res_in_TLAST;
output  [679:0] out_r_TDATA;
output   out_r_TVALID;
input   out_r_TREADY;
output  [84:0] out_r_TKEEP;
output  [84:0] out_r_TSTRB;
output  [7:0] out_r_TUSER;
output  [0:0] out_r_TLAST;
input   s_axi_control_AWVALID;
output   s_axi_control_AWREADY;
input  [C_S_AXI_CONTROL_ADDR_WIDTH - 1:0] s_axi_control_AWADDR;
input   s_axi_control_WVALID;
output   s_axi_control_WREADY;
input  [C_S_AXI_CONTROL_DATA_WIDTH - 1:0] s_axi_control_WDATA;
input  [C_S_AXI_CONTROL_WSTRB_WIDTH - 1:0] s_axi_control_WSTRB;
input   s_axi_control_ARVALID;
output   s_axi_control_ARREADY;
input  [C_S_AXI_CONTROL_ADDR_WIDTH - 1:0] s_axi_control_ARADDR;
output   s_axi_control_RVALID;
input   s_axi_control_RREADY;
output  [C_S_AXI_CONTROL_DATA_WIDTH - 1:0] s_axi_control_RDATA;
output  [1:0] s_axi_control_RRESP;
output   s_axi_control_BVALID;
input   s_axi_control_BREADY;
output  [1:0] s_axi_control_BRESP;

reg res_in_TREADY;

 reg    ap_rst_n_inv;
wire   [7:0] tones_address0;
reg    tones_ce0;
wire   [255:0] tones_q0;
wire   [7:0] centers_address0;
reg    centers_ce0;
wire   [255:0] centers_q0;
wire    clear_accumulator;
reg   [167:0] accg_V;
wire   [7:0] accumulator_V_address0;
reg    accumulator_V_ce0;
reg    accumulator_V_we0;
wire   [7:0] accumulator_V_address1;
reg    accumulator_V_ce1;
wire   [167:0] accumulator_V_q1;
reg   [0:0] clear;
reg    res_in_TDATA_blk_n;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_block_pp0_stage0;
reg    out_r_TDATA_blk_n;
reg    ap_enable_reg_pp0_iter2;
reg    ap_enable_reg_pp0_iter3;
reg   [0:0] clear_accumulator_read_reg_742;
reg    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
reg    ap_block_state3_pp0_stage0_iter2;
wire    regslice_both_out_r_V_data_V_U_apdone_blk;
reg    ap_block_state4_pp0_stage0_iter3;
reg    ap_block_pp0_stage0_11001;
reg   [0:0] clear_accumulator_read_reg_742_pp0_iter1_reg;
reg   [0:0] clear_accumulator_read_reg_742_pp0_iter2_reg;
reg   [255:0] tmp_data_V_1_reg_746;
reg   [255:0] tmp_data_V_1_reg_746_pp0_iter1_reg;
reg   [7:0] tmp_user_V_reg_751;
reg   [7:0] tmp_user_V_reg_751_pp0_iter1_reg;
reg   [0:0] tmp_last_V_reg_757;
reg   [0:0] tmp_last_V_reg_757_pp0_iter1_reg;
reg   [0:0] tmp_last_V_reg_757_pp0_iter2_reg;
reg   [20:0] phase0_V_reg_777;
wire   [20:0] tmp_V_fu_317_p1;
reg   [20:0] tmp_V_reg_782;
wire   [10:0] trunc_ln1393_fu_321_p1;
reg   [10:0] trunc_ln1393_reg_788;
reg   [20:0] phase0_V_1_reg_793;
reg   [20:0] tmp_V_1_reg_798;
reg   [10:0] tmp_1_reg_804;
reg   [20:0] phase0_V_2_reg_809;
reg   [20:0] tmp_V_2_reg_814;
reg   [10:0] tmp_2_reg_820;
reg   [20:0] phase0_V_3_reg_825;
reg   [20:0] tmp_V_3_reg_830;
reg   [10:0] tmp_3_reg_836;
reg   [20:0] phase0_V_4_reg_841;
reg   [20:0] tmp_V_4_reg_846;
reg   [10:0] tmp_4_reg_852;
reg   [20:0] phase0_V_5_reg_857;
reg   [20:0] tmp_V_5_reg_862;
reg   [10:0] tmp_5_reg_868;
reg   [20:0] phase0_V_6_reg_873;
reg   [20:0] tmp_V_6_reg_878;
reg   [10:0] tmp_6_reg_884;
reg   [20:0] phase0_V_7_reg_889;
reg   [20:0] tmp_V_7_reg_894;
reg   [10:0] tmp_7_reg_900;
reg   [255:0] p_Val2_18_reg_905;
wire   [7:0] add_ln232_fu_535_p2;
reg   [7:0] add_ln232_reg_910;
wire   [20:0] p_Val2_3_fu_551_p2;
reg   [20:0] p_Val2_3_reg_915;
wire   [20:0] p_Val2_5_fu_567_p2;
reg   [20:0] p_Val2_5_reg_920;
wire   [20:0] p_Val2_7_fu_583_p2;
reg   [20:0] p_Val2_7_reg_925;
wire   [20:0] p_Val2_9_fu_599_p2;
reg   [20:0] p_Val2_9_reg_930;
wire   [20:0] p_Val2_11_fu_615_p2;
reg   [20:0] p_Val2_11_reg_935;
wire   [20:0] p_Val2_13_fu_631_p2;
reg   [20:0] p_Val2_13_reg_940;
wire   [20:0] p_Val2_15_fu_647_p2;
reg   [20:0] p_Val2_15_reg_945;
wire   [20:0] p_Val2_17_fu_663_p2;
reg   [20:0] p_Val2_17_reg_950;
reg    ap_enable_reg_pp0_iter1;
reg    ap_block_pp0_stage0_subdone;
wire   [63:0] zext_ln587_fu_300_p1;
wire   [63:0] zext_ln587_1_fu_691_p1;
wire   [167:0] select_ln139_fu_716_p3;
reg    ap_block_pp0_stage0_01001;
wire   [20:0] shl_ln_fu_544_p3;
wire   [20:0] shl_ln1393_1_fu_560_p3;
wire   [20:0] shl_ln1393_2_fu_576_p3;
wire   [20:0] shl_ln1393_3_fu_592_p3;
wire   [20:0] shl_ln1393_4_fu_608_p3;
wire   [20:0] shl_ln1393_5_fu_624_p3;
wire   [20:0] shl_ln1393_6_fu_640_p3;
wire   [20:0] shl_ln1393_7_fu_656_p3;
wire   [20:0] p_Val2_16_fu_652_p2;
wire   [20:0] p_Val2_14_fu_636_p2;
wire   [20:0] p_Val2_12_fu_620_p2;
wire   [20:0] p_Val2_10_fu_604_p2;
wire   [20:0] p_Val2_8_fu_588_p2;
wire   [20:0] p_Val2_6_fu_572_p2;
wire   [20:0] p_Val2_4_fu_556_p2;
wire   [20:0] p_Val2_s_fu_540_p2;
wire   [167:0] p_Result_s_fu_700_p9;
reg   [0:0] ap_NS_fsm;
wire    ap_reset_idle_pp0;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
wire   [679:0] out_r_TDATA_int_regslice;
reg    out_r_TVALID_int_regslice;
wire    out_r_TREADY_int_regslice;
wire    regslice_both_out_r_V_data_V_U_vld_out;
wire    regslice_both_out_r_V_keep_V_U_apdone_blk;
wire    regslice_both_out_r_V_keep_V_U_ack_in_dummy;
wire    regslice_both_out_r_V_keep_V_U_vld_out;
wire    regslice_both_out_r_V_strb_V_U_apdone_blk;
wire    regslice_both_out_r_V_strb_V_U_ack_in_dummy;
wire    regslice_both_out_r_V_strb_V_U_vld_out;
wire    regslice_both_out_r_V_user_V_U_apdone_blk;
wire    regslice_both_out_r_V_user_V_U_ack_in_dummy;
wire    regslice_both_out_r_V_user_V_U_vld_out;
wire    regslice_both_out_r_V_last_V_U_apdone_blk;
wire    regslice_both_out_r_V_last_V_U_ack_in_dummy;
wire    regslice_both_out_r_V_last_V_U_vld_out;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 accg_V = 168'd0;
#0 clear = 1'd0;
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ap_enable_reg_pp0_iter3 = 1'b0;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

resonator_ddc_control_accumulator_V_RAM_AUTO_1R1W #(
    .DataWidth( 168 ),
    .AddressRange( 256 ),
    .AddressWidth( 8 ))
accumulator_V_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .address0(accumulator_V_address0),
    .ce0(accumulator_V_ce0),
    .we0(accumulator_V_we0),
    .d0(accg_V),
    .address1(accumulator_V_address1),
    .ce1(accumulator_V_ce1),
    .q1(accumulator_V_q1)
);

resonator_ddc_control_control_s_axi #(
    .C_S_AXI_ADDR_WIDTH( C_S_AXI_CONTROL_ADDR_WIDTH ),
    .C_S_AXI_DATA_WIDTH( C_S_AXI_CONTROL_DATA_WIDTH ))
control_s_axi_U(
    .AWVALID(s_axi_control_AWVALID),
    .AWREADY(s_axi_control_AWREADY),
    .AWADDR(s_axi_control_AWADDR),
    .WVALID(s_axi_control_WVALID),
    .WREADY(s_axi_control_WREADY),
    .WDATA(s_axi_control_WDATA),
    .WSTRB(s_axi_control_WSTRB),
    .ARVALID(s_axi_control_ARVALID),
    .ARREADY(s_axi_control_ARREADY),
    .ARADDR(s_axi_control_ARADDR),
    .RVALID(s_axi_control_RVALID),
    .RREADY(s_axi_control_RREADY),
    .RDATA(s_axi_control_RDATA),
    .RRESP(s_axi_control_RRESP),
    .BVALID(s_axi_control_BVALID),
    .BREADY(s_axi_control_BREADY),
    .BRESP(s_axi_control_BRESP),
    .ACLK(ap_clk),
    .ARESET(ap_rst_n_inv),
    .ACLK_EN(1'b1),
    .clear_accumulator(clear_accumulator),
    .tones_address0(tones_address0),
    .tones_ce0(tones_ce0),
    .tones_q0(tones_q0),
    .centers_address0(centers_address0),
    .centers_ce0(centers_ce0),
    .centers_q0(centers_q0)
);

resonator_ddc_control_regslice_both #(
    .DataWidth( 680 ))
regslice_both_out_r_V_data_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(out_r_TDATA_int_regslice),
    .vld_in(out_r_TVALID_int_regslice),
    .ack_in(out_r_TREADY_int_regslice),
    .data_out(out_r_TDATA),
    .vld_out(regslice_both_out_r_V_data_V_U_vld_out),
    .ack_out(out_r_TREADY),
    .apdone_blk(regslice_both_out_r_V_data_V_U_apdone_blk)
);

resonator_ddc_control_regslice_both #(
    .DataWidth( 85 ))
regslice_both_out_r_V_keep_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(85'd0),
    .vld_in(out_r_TVALID_int_regslice),
    .ack_in(regslice_both_out_r_V_keep_V_U_ack_in_dummy),
    .data_out(out_r_TKEEP),
    .vld_out(regslice_both_out_r_V_keep_V_U_vld_out),
    .ack_out(out_r_TREADY),
    .apdone_blk(regslice_both_out_r_V_keep_V_U_apdone_blk)
);

resonator_ddc_control_regslice_both #(
    .DataWidth( 85 ))
regslice_both_out_r_V_strb_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(85'd0),
    .vld_in(out_r_TVALID_int_regslice),
    .ack_in(regslice_both_out_r_V_strb_V_U_ack_in_dummy),
    .data_out(out_r_TSTRB),
    .vld_out(regslice_both_out_r_V_strb_V_U_vld_out),
    .ack_out(out_r_TREADY),
    .apdone_blk(regslice_both_out_r_V_strb_V_U_apdone_blk)
);

resonator_ddc_control_regslice_both #(
    .DataWidth( 8 ))
regslice_both_out_r_V_user_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(tmp_user_V_reg_751_pp0_iter1_reg),
    .vld_in(out_r_TVALID_int_regslice),
    .ack_in(regslice_both_out_r_V_user_V_U_ack_in_dummy),
    .data_out(out_r_TUSER),
    .vld_out(regslice_both_out_r_V_user_V_U_vld_out),
    .ack_out(out_r_TREADY),
    .apdone_blk(regslice_both_out_r_V_user_V_U_apdone_blk)
);

resonator_ddc_control_regslice_both #(
    .DataWidth( 1 ))
regslice_both_out_r_V_last_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(tmp_last_V_reg_757_pp0_iter1_reg),
    .vld_in(out_r_TVALID_int_regslice),
    .ack_in(regslice_both_out_r_V_last_V_U_ack_in_dummy),
    .data_out(out_r_TLAST),
    .vld_out(regslice_both_out_r_V_last_V_U_vld_out),
    .ack_out(out_r_TREADY),
    .apdone_blk(regslice_both_out_r_V_last_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter1 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter3 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter3 <= ap_enable_reg_pp0_iter2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((ap_enable_reg_pp0_iter3 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        if ((clear_accumulator_read_reg_742_pp0_iter2_reg == 1'd1)) begin
            clear <= 1'd1;
        end else if (((clear_accumulator_read_reg_742_pp0_iter2_reg == 1'd0) & (tmp_last_V_reg_757_pp0_iter2_reg == 1'd1))) begin
            clear <= 1'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((ap_enable_reg_pp0_iter3 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        accg_V <= select_ln139_fu_716_p3;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        add_ln232_reg_910 <= add_ln232_fu_535_p2;
        clear_accumulator_read_reg_742_pp0_iter2_reg <= clear_accumulator_read_reg_742_pp0_iter1_reg;
        p_Val2_11_reg_935 <= p_Val2_11_fu_615_p2;
        p_Val2_13_reg_940 <= p_Val2_13_fu_631_p2;
        p_Val2_15_reg_945 <= p_Val2_15_fu_647_p2;
        p_Val2_17_reg_950 <= p_Val2_17_fu_663_p2;
        p_Val2_3_reg_915 <= p_Val2_3_fu_551_p2;
        p_Val2_5_reg_920 <= p_Val2_5_fu_567_p2;
        p_Val2_7_reg_925 <= p_Val2_7_fu_583_p2;
        p_Val2_9_reg_930 <= p_Val2_9_fu_599_p2;
        tmp_last_V_reg_757_pp0_iter2_reg <= tmp_last_V_reg_757_pp0_iter1_reg;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        clear_accumulator_read_reg_742 <= clear_accumulator;
        clear_accumulator_read_reg_742_pp0_iter1_reg <= clear_accumulator_read_reg_742;
        p_Val2_18_reg_905 <= centers_q0;
        phase0_V_1_reg_793 <= {{tones_q0[129:109]}};
        phase0_V_2_reg_809 <= {{tones_q0[150:130]}};
        phase0_V_3_reg_825 <= {{tones_q0[171:151]}};
        phase0_V_4_reg_841 <= {{tones_q0[192:172]}};
        phase0_V_5_reg_857 <= {{tones_q0[213:193]}};
        phase0_V_6_reg_873 <= {{tones_q0[234:214]}};
        phase0_V_7_reg_889 <= {{tones_q0[255:235]}};
        phase0_V_reg_777 <= {{tones_q0[108:88]}};
        tmp_1_reg_804 <= {{tones_q0[21:11]}};
        tmp_2_reg_820 <= {{tones_q0[32:22]}};
        tmp_3_reg_836 <= {{tones_q0[43:33]}};
        tmp_4_reg_852 <= {{tones_q0[54:44]}};
        tmp_5_reg_868 <= {{tones_q0[65:55]}};
        tmp_6_reg_884 <= {{tones_q0[76:66]}};
        tmp_7_reg_900 <= {{tones_q0[87:77]}};
        tmp_V_1_reg_798 <= {{accumulator_V_q1[41:21]}};
        tmp_V_2_reg_814 <= {{accumulator_V_q1[62:42]}};
        tmp_V_3_reg_830 <= {{accumulator_V_q1[83:63]}};
        tmp_V_4_reg_846 <= {{accumulator_V_q1[104:84]}};
        tmp_V_5_reg_862 <= {{accumulator_V_q1[125:105]}};
        tmp_V_6_reg_878 <= {{accumulator_V_q1[146:126]}};
        tmp_V_7_reg_894 <= {{accumulator_V_q1[167:147]}};
        tmp_V_reg_782 <= tmp_V_fu_317_p1;
        tmp_data_V_1_reg_746 <= res_in_TDATA;
        tmp_data_V_1_reg_746_pp0_iter1_reg <= tmp_data_V_1_reg_746;
        tmp_last_V_reg_757 <= res_in_TLAST;
        tmp_last_V_reg_757_pp0_iter1_reg <= tmp_last_V_reg_757;
        tmp_user_V_reg_751 <= res_in_TUSER;
        tmp_user_V_reg_751_pp0_iter1_reg <= tmp_user_V_reg_751;
        trunc_ln1393_reg_788 <= trunc_ln1393_fu_321_p1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter3 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        accumulator_V_ce0 = 1'b1;
    end else begin
        accumulator_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        accumulator_V_ce1 = 1'b1;
    end else begin
        accumulator_V_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter3 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        accumulator_V_we0 = 1'b1;
    end else begin
        accumulator_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (1'b1 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

assign ap_reset_idle_pp0 = 1'b0;

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        centers_ce0 = 1'b1;
    end else begin
        centers_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((((ap_enable_reg_pp0_iter3 == 1'b1) & (1'b0 == ap_block_pp0_stage0)) | ((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0)))) begin
        out_r_TDATA_blk_n = out_r_TREADY_int_regslice;
    end else begin
        out_r_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        out_r_TVALID_int_regslice = 1'b1;
    end else begin
        out_r_TVALID_int_regslice = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        res_in_TDATA_blk_n = res_in_TVALID;
    end else begin
        res_in_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        res_in_TREADY = 1'b1;
    end else begin
        res_in_TREADY = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tones_ce0 = 1'b1;
    end else begin
        tones_ce0 = 1'b0;
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

assign accumulator_V_address0 = zext_ln587_1_fu_691_p1;

assign accumulator_V_address1 = zext_ln587_fu_300_p1;

assign add_ln232_fu_535_p2 = ($signed(tmp_user_V_reg_751_pp0_iter1_reg) + $signed(8'd255));

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = (((res_in_TVALID == 1'b0) & (1'b1 == 1'b1)) | ((ap_enable_reg_pp0_iter3 == 1'b1) & ((regslice_both_out_r_V_data_V_U_apdone_blk == 1'b1) | (out_r_TREADY_int_regslice == 1'b0))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & (out_r_TREADY_int_regslice == 1'b0)));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((res_in_TVALID == 1'b0) & (1'b1 == 1'b1)) | ((ap_enable_reg_pp0_iter3 == 1'b1) & ((regslice_both_out_r_V_data_V_U_apdone_blk == 1'b1) | (out_r_TREADY_int_regslice == 1'b0))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & (out_r_TREADY_int_regslice == 1'b0)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((res_in_TVALID == 1'b0) & (1'b1 == 1'b1)) | ((ap_enable_reg_pp0_iter3 == 1'b1) & ((regslice_both_out_r_V_data_V_U_apdone_blk == 1'b1) | (out_r_TREADY_int_regslice == 1'b0))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & (out_r_TREADY_int_regslice == 1'b0)));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = (res_in_TVALID == 1'b0);
end

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state3_pp0_stage0_iter2 = (out_r_TREADY_int_regslice == 1'b0);
end

always @ (*) begin
    ap_block_state4_pp0_stage0_iter3 = ((regslice_both_out_r_V_data_V_U_apdone_blk == 1'b1) | (out_r_TREADY_int_regslice == 1'b0));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign centers_address0 = zext_ln587_fu_300_p1;

assign out_r_TDATA_int_regslice = {{{{{{{{{{p_Val2_18_reg_905}, {p_Val2_16_fu_652_p2}}, {p_Val2_14_fu_636_p2}}, {p_Val2_12_fu_620_p2}}, {p_Val2_10_fu_604_p2}}, {p_Val2_8_fu_588_p2}}, {p_Val2_6_fu_572_p2}}, {p_Val2_4_fu_556_p2}}, {p_Val2_s_fu_540_p2}}, {tmp_data_V_1_reg_746_pp0_iter1_reg}};

assign out_r_TVALID = regslice_both_out_r_V_data_V_U_vld_out;

assign p_Result_s_fu_700_p9 = {{{{{{{{p_Val2_17_reg_950}, {p_Val2_15_reg_945}}, {p_Val2_13_reg_940}}, {p_Val2_11_reg_935}}, {p_Val2_9_reg_930}}, {p_Val2_7_reg_925}}, {p_Val2_5_reg_920}}, {p_Val2_3_reg_915}};

assign p_Val2_10_fu_604_p2 = (tmp_V_4_reg_846 + phase0_V_4_reg_841);

assign p_Val2_11_fu_615_p2 = (tmp_V_4_reg_846 + shl_ln1393_4_fu_608_p3);

assign p_Val2_12_fu_620_p2 = (tmp_V_5_reg_862 + phase0_V_5_reg_857);

assign p_Val2_13_fu_631_p2 = (tmp_V_5_reg_862 + shl_ln1393_5_fu_624_p3);

assign p_Val2_14_fu_636_p2 = (tmp_V_6_reg_878 + phase0_V_6_reg_873);

assign p_Val2_15_fu_647_p2 = (tmp_V_6_reg_878 + shl_ln1393_6_fu_640_p3);

assign p_Val2_16_fu_652_p2 = (tmp_V_7_reg_894 + phase0_V_7_reg_889);

assign p_Val2_17_fu_663_p2 = (tmp_V_7_reg_894 + shl_ln1393_7_fu_656_p3);

assign p_Val2_3_fu_551_p2 = (tmp_V_reg_782 + shl_ln_fu_544_p3);

assign p_Val2_4_fu_556_p2 = (tmp_V_1_reg_798 + phase0_V_1_reg_793);

assign p_Val2_5_fu_567_p2 = (tmp_V_1_reg_798 + shl_ln1393_1_fu_560_p3);

assign p_Val2_6_fu_572_p2 = (tmp_V_2_reg_814 + phase0_V_2_reg_809);

assign p_Val2_7_fu_583_p2 = (tmp_V_2_reg_814 + shl_ln1393_2_fu_576_p3);

assign p_Val2_8_fu_588_p2 = (tmp_V_3_reg_830 + phase0_V_3_reg_825);

assign p_Val2_9_fu_599_p2 = (tmp_V_3_reg_830 + shl_ln1393_3_fu_592_p3);

assign p_Val2_s_fu_540_p2 = (tmp_V_reg_782 + phase0_V_reg_777);

assign select_ln139_fu_716_p3 = ((clear[0:0] == 1'b1) ? 168'd0 : p_Result_s_fu_700_p9);

assign shl_ln1393_1_fu_560_p3 = {{tmp_1_reg_804}, {10'd0}};

assign shl_ln1393_2_fu_576_p3 = {{tmp_2_reg_820}, {10'd0}};

assign shl_ln1393_3_fu_592_p3 = {{tmp_3_reg_836}, {10'd0}};

assign shl_ln1393_4_fu_608_p3 = {{tmp_4_reg_852}, {10'd0}};

assign shl_ln1393_5_fu_624_p3 = {{tmp_5_reg_868}, {10'd0}};

assign shl_ln1393_6_fu_640_p3 = {{tmp_6_reg_884}, {10'd0}};

assign shl_ln1393_7_fu_656_p3 = {{tmp_7_reg_900}, {10'd0}};

assign shl_ln_fu_544_p3 = {{trunc_ln1393_reg_788}, {10'd0}};

assign tmp_V_fu_317_p1 = accumulator_V_q1[20:0];

assign tones_address0 = zext_ln587_fu_300_p1;

assign trunc_ln1393_fu_321_p1 = tones_q0[10:0];

assign zext_ln587_1_fu_691_p1 = add_ln232_reg_910;

assign zext_ln587_fu_300_p1 = res_in_TUSER;


reg find_kernel_block = 0;
// synthesis translate_off
`include "resonator_ddc_control_hls_deadlock_kernel_monitor_top.vh"
// synthesis translate_on

endmodule //resonator_ddc_control
