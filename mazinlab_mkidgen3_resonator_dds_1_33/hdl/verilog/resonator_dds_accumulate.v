// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Version: 2021.1
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module resonator_dds_accumulate (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        ap_ce,
        group_r,
        tonesgroup,
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
input  [7:0] group_r;
input  [255:0] tonesgroup;
output  [167:0] ap_return;

reg ap_done;
reg ap_idle;
reg ap_ready;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_idle_pp0;
wire    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
wire    ap_block_state3_pp0_stage0_iter2;
reg    ap_block_pp0_stage0_subdone;
reg   [167:0] acc_V;
wire   [7:0] accumulator_V_address0;
reg    accumulator_V_ce0;
reg    accumulator_V_we0;
wire   [7:0] accumulator_V_address1;
reg    accumulator_V_ce1;
wire   [167:0] accumulator_V_q1;
reg   [7:0] group_read_reg_580;
wire    ap_block_pp0_stage0_11001;
reg   [20:0] p_Result_s_reg_590;
reg   [20:0] p_Result_s_reg_590_pp0_iter1_reg;
wire   [10:0] trunc_ln1245_fu_174_p1;
reg   [10:0] trunc_ln1245_reg_595;
reg   [10:0] trunc_ln1245_reg_595_pp0_iter1_reg;
reg   [20:0] p_Result_123_1_reg_600;
reg   [20:0] p_Result_123_1_reg_600_pp0_iter1_reg;
reg   [10:0] tmp_8_reg_605;
reg   [10:0] tmp_8_reg_605_pp0_iter1_reg;
reg   [20:0] p_Result_123_2_reg_610;
reg   [20:0] p_Result_123_2_reg_610_pp0_iter1_reg;
reg   [10:0] tmp_9_reg_615;
reg   [10:0] tmp_9_reg_615_pp0_iter1_reg;
reg   [20:0] p_Result_123_3_reg_620;
reg   [20:0] p_Result_123_3_reg_620_pp0_iter1_reg;
reg   [10:0] tmp_10_reg_625;
reg   [10:0] tmp_10_reg_625_pp0_iter1_reg;
reg   [20:0] p_Result_123_4_reg_630;
reg   [20:0] p_Result_123_4_reg_630_pp0_iter1_reg;
reg   [10:0] tmp_11_reg_635;
reg   [10:0] tmp_11_reg_635_pp0_iter1_reg;
reg   [20:0] p_Result_123_5_reg_640;
reg   [20:0] p_Result_123_5_reg_640_pp0_iter1_reg;
reg   [10:0] tmp_12_reg_645;
reg   [10:0] tmp_12_reg_645_pp0_iter1_reg;
reg   [20:0] p_Result_123_6_reg_650;
reg   [20:0] p_Result_123_6_reg_650_pp0_iter1_reg;
reg   [10:0] tmp_13_reg_655;
reg   [10:0] tmp_13_reg_655_pp0_iter1_reg;
reg   [20:0] p_Result_123_7_reg_660;
reg   [20:0] p_Result_123_7_reg_660_pp0_iter1_reg;
reg   [10:0] tmp_14_reg_665;
reg   [10:0] tmp_14_reg_665_pp0_iter1_reg;
wire   [7:0] add_ln223_fu_318_p2;
reg   [7:0] add_ln223_reg_670;
wire   [20:0] trunc_ln674_fu_323_p1;
reg   [20:0] trunc_ln674_reg_675;
reg   [20:0] p_Result_125_1_reg_681;
reg   [20:0] p_Result_125_2_reg_687;
reg   [20:0] p_Result_125_3_reg_693;
reg   [20:0] p_Result_125_4_reg_699;
reg   [20:0] p_Result_125_5_reg_705;
reg   [20:0] p_Result_125_6_reg_711;
reg   [20:0] p_Result_125_7_reg_717;
wire   [63:0] zext_ln573_3_fu_159_p1;
wire    ap_block_pp0_stage0;
wire   [63:0] zext_ln573_fu_397_p1;
wire   [167:0] p_Result_121_7_fu_554_p9;
wire   [20:0] shl_ln_fu_410_p3;
wire   [20:0] shl_ln1245_1_fu_426_p3;
wire   [20:0] shl_ln1245_2_fu_442_p3;
wire   [20:0] shl_ln1245_3_fu_458_p3;
wire   [20:0] shl_ln1245_4_fu_474_p3;
wire   [20:0] shl_ln1245_5_fu_490_p3;
wire   [20:0] shl_ln1245_6_fu_506_p3;
wire   [20:0] add_ln712_14_fu_518_p2;
wire   [20:0] add_ln712_12_fu_502_p2;
wire   [20:0] add_ln712_10_fu_486_p2;
wire   [20:0] add_ln712_8_fu_470_p2;
wire   [20:0] add_ln712_6_fu_454_p2;
wire   [20:0] add_ln712_4_fu_438_p2;
wire   [20:0] add_ln712_2_fu_422_p2;
wire   [20:0] add_ln712_fu_406_p2;
wire   [20:0] shl_ln1245_7_fu_542_p3;
wire   [20:0] add_ln712_15_fu_549_p2;
wire   [20:0] add_ln712_13_fu_513_p2;
wire   [20:0] add_ln712_11_fu_497_p2;
wire   [20:0] add_ln712_9_fu_481_p2;
wire   [20:0] add_ln712_7_fu_465_p2;
wire   [20:0] add_ln712_5_fu_449_p2;
wire   [20:0] add_ln712_3_fu_433_p2;
wire   [20:0] add_ln712_1_fu_417_p2;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to1;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 acc_V = 168'd0;
end

resonator_dds_accumulate_accumulator_V #(
    .DataWidth( 168 ),
    .AddressRange( 256 ),
    .AddressWidth( 8 ))
accumulator_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(accumulator_V_address0),
    .ce0(accumulator_V_ce0),
    .we0(accumulator_V_we0),
    .d0(acc_V),
    .address1(accumulator_V_address1),
    .ce1(accumulator_V_ce1),
    .q1(accumulator_V_q1)
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
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b1 == ap_ce))) begin
        acc_V <= p_Result_121_7_fu_554_p9;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_ce) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        add_ln223_reg_670 <= add_ln223_fu_318_p2;
        group_read_reg_580 <= group_r;
        p_Result_123_1_reg_600 <= {{tonesgroup[129:109]}};
        p_Result_123_1_reg_600_pp0_iter1_reg <= p_Result_123_1_reg_600;
        p_Result_123_2_reg_610 <= {{tonesgroup[150:130]}};
        p_Result_123_2_reg_610_pp0_iter1_reg <= p_Result_123_2_reg_610;
        p_Result_123_3_reg_620 <= {{tonesgroup[171:151]}};
        p_Result_123_3_reg_620_pp0_iter1_reg <= p_Result_123_3_reg_620;
        p_Result_123_4_reg_630 <= {{tonesgroup[192:172]}};
        p_Result_123_4_reg_630_pp0_iter1_reg <= p_Result_123_4_reg_630;
        p_Result_123_5_reg_640 <= {{tonesgroup[213:193]}};
        p_Result_123_5_reg_640_pp0_iter1_reg <= p_Result_123_5_reg_640;
        p_Result_123_6_reg_650 <= {{tonesgroup[234:214]}};
        p_Result_123_6_reg_650_pp0_iter1_reg <= p_Result_123_6_reg_650;
        p_Result_123_7_reg_660 <= {{tonesgroup[255:235]}};
        p_Result_123_7_reg_660_pp0_iter1_reg <= p_Result_123_7_reg_660;
        p_Result_125_1_reg_681 <= {{accumulator_V_q1[41:21]}};
        p_Result_125_2_reg_687 <= {{accumulator_V_q1[62:42]}};
        p_Result_125_3_reg_693 <= {{accumulator_V_q1[83:63]}};
        p_Result_125_4_reg_699 <= {{accumulator_V_q1[104:84]}};
        p_Result_125_5_reg_705 <= {{accumulator_V_q1[125:105]}};
        p_Result_125_6_reg_711 <= {{accumulator_V_q1[146:126]}};
        p_Result_125_7_reg_717 <= {{accumulator_V_q1[167:147]}};
        p_Result_s_reg_590 <= {{tonesgroup[108:88]}};
        p_Result_s_reg_590_pp0_iter1_reg <= p_Result_s_reg_590;
        tmp_10_reg_625 <= {{tonesgroup[43:33]}};
        tmp_10_reg_625_pp0_iter1_reg <= tmp_10_reg_625;
        tmp_11_reg_635 <= {{tonesgroup[54:44]}};
        tmp_11_reg_635_pp0_iter1_reg <= tmp_11_reg_635;
        tmp_12_reg_645 <= {{tonesgroup[65:55]}};
        tmp_12_reg_645_pp0_iter1_reg <= tmp_12_reg_645;
        tmp_13_reg_655 <= {{tonesgroup[76:66]}};
        tmp_13_reg_655_pp0_iter1_reg <= tmp_13_reg_655;
        tmp_14_reg_665 <= {{tonesgroup[87:77]}};
        tmp_14_reg_665_pp0_iter1_reg <= tmp_14_reg_665;
        tmp_8_reg_605 <= {{tonesgroup[21:11]}};
        tmp_8_reg_605_pp0_iter1_reg <= tmp_8_reg_605;
        tmp_9_reg_615 <= {{tonesgroup[32:22]}};
        tmp_9_reg_615_pp0_iter1_reg <= tmp_9_reg_615;
        trunc_ln1245_reg_595 <= trunc_ln1245_fu_174_p1;
        trunc_ln1245_reg_595_pp0_iter1_reg <= trunc_ln1245_reg_595;
        trunc_ln674_reg_675 <= trunc_ln674_fu_323_p1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b1 == ap_ce))) begin
        accumulator_V_ce0 = 1'b1;
    end else begin
        accumulator_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_ce) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        accumulator_V_ce1 = 1'b1;
    end else begin
        accumulator_V_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b1 == ap_ce))) begin
        accumulator_V_we0 = 1'b1;
    end else begin
        accumulator_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
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
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
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
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign accumulator_V_address0 = zext_ln573_fu_397_p1;

assign accumulator_V_address1 = zext_ln573_3_fu_159_p1;

assign add_ln223_fu_318_p2 = ($signed(group_read_reg_580) + $signed(8'd255));

assign add_ln712_10_fu_486_p2 = (p_Result_125_5_reg_705 + p_Result_123_5_reg_640_pp0_iter1_reg);

assign add_ln712_11_fu_497_p2 = (p_Result_125_5_reg_705 + shl_ln1245_5_fu_490_p3);

assign add_ln712_12_fu_502_p2 = (p_Result_125_6_reg_711 + p_Result_123_6_reg_650_pp0_iter1_reg);

assign add_ln712_13_fu_513_p2 = (p_Result_125_6_reg_711 + shl_ln1245_6_fu_506_p3);

assign add_ln712_14_fu_518_p2 = (p_Result_125_7_reg_717 + p_Result_123_7_reg_660_pp0_iter1_reg);

assign add_ln712_15_fu_549_p2 = (p_Result_125_7_reg_717 + shl_ln1245_7_fu_542_p3);

assign add_ln712_1_fu_417_p2 = (trunc_ln674_reg_675 + shl_ln_fu_410_p3);

assign add_ln712_2_fu_422_p2 = (p_Result_125_1_reg_681 + p_Result_123_1_reg_600_pp0_iter1_reg);

assign add_ln712_3_fu_433_p2 = (p_Result_125_1_reg_681 + shl_ln1245_1_fu_426_p3);

assign add_ln712_4_fu_438_p2 = (p_Result_125_2_reg_687 + p_Result_123_2_reg_610_pp0_iter1_reg);

assign add_ln712_5_fu_449_p2 = (p_Result_125_2_reg_687 + shl_ln1245_2_fu_442_p3);

assign add_ln712_6_fu_454_p2 = (p_Result_125_3_reg_693 + p_Result_123_3_reg_620_pp0_iter1_reg);

assign add_ln712_7_fu_465_p2 = (p_Result_125_3_reg_693 + shl_ln1245_3_fu_458_p3);

assign add_ln712_8_fu_470_p2 = (p_Result_125_4_reg_699 + p_Result_123_4_reg_630_pp0_iter1_reg);

assign add_ln712_9_fu_481_p2 = (p_Result_125_4_reg_699 + shl_ln1245_4_fu_474_p3);

assign add_ln712_fu_406_p2 = (trunc_ln674_reg_675 + p_Result_s_reg_590_pp0_iter1_reg);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_11001 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_subdone = (1'b0 == ap_ce);
end

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state3_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start;

assign ap_return = {{{{{{{{add_ln712_14_fu_518_p2}, {add_ln712_12_fu_502_p2}}, {add_ln712_10_fu_486_p2}}, {add_ln712_8_fu_470_p2}}, {add_ln712_6_fu_454_p2}}, {add_ln712_4_fu_438_p2}}, {add_ln712_2_fu_422_p2}}, {add_ln712_fu_406_p2}};

assign p_Result_121_7_fu_554_p9 = {{{{{{{{add_ln712_15_fu_549_p2}, {add_ln712_13_fu_513_p2}}, {add_ln712_11_fu_497_p2}}, {add_ln712_9_fu_481_p2}}, {add_ln712_7_fu_465_p2}}, {add_ln712_5_fu_449_p2}}, {add_ln712_3_fu_433_p2}}, {add_ln712_1_fu_417_p2}};

assign shl_ln1245_1_fu_426_p3 = {{tmp_8_reg_605_pp0_iter1_reg}, {10'd0}};

assign shl_ln1245_2_fu_442_p3 = {{tmp_9_reg_615_pp0_iter1_reg}, {10'd0}};

assign shl_ln1245_3_fu_458_p3 = {{tmp_10_reg_625_pp0_iter1_reg}, {10'd0}};

assign shl_ln1245_4_fu_474_p3 = {{tmp_11_reg_635_pp0_iter1_reg}, {10'd0}};

assign shl_ln1245_5_fu_490_p3 = {{tmp_12_reg_645_pp0_iter1_reg}, {10'd0}};

assign shl_ln1245_6_fu_506_p3 = {{tmp_13_reg_655_pp0_iter1_reg}, {10'd0}};

assign shl_ln1245_7_fu_542_p3 = {{tmp_14_reg_665_pp0_iter1_reg}, {10'd0}};

assign shl_ln_fu_410_p3 = {{trunc_ln1245_reg_595_pp0_iter1_reg}, {10'd0}};

assign trunc_ln1245_fu_174_p1 = tonesgroup[10:0];

assign trunc_ln674_fu_323_p1 = accumulator_V_q1[20:0];

assign zext_ln573_3_fu_159_p1 = group_r;

assign zext_ln573_fu_397_p1 = add_ln223_reg_670;

endmodule //resonator_dds_accumulate
