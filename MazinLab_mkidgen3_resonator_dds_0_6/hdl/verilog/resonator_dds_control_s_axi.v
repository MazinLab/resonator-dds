// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2.1 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1ns/1ps
module resonator_dds_control_s_axi
#(parameter
    C_S_AXI_ADDR_WIDTH = 14,
    C_S_AXI_DATA_WIDTH = 32
)(
    input  wire                          ACLK,
    input  wire                          ARESET,
    input  wire                          ACLK_EN,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] AWADDR,
    input  wire                          AWVALID,
    output wire                          AWREADY,
    input  wire [C_S_AXI_DATA_WIDTH-1:0] WDATA,
    input  wire [C_S_AXI_DATA_WIDTH/8-1:0] WSTRB,
    input  wire                          WVALID,
    output wire                          WREADY,
    output wire [1:0]                    BRESP,
    output wire                          BVALID,
    input  wire                          BREADY,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] ARADDR,
    input  wire                          ARVALID,
    output wire                          ARREADY,
    output wire [C_S_AXI_DATA_WIDTH-1:0] RDATA,
    output wire [1:0]                    RRESP,
    output wire                          RVALID,
    input  wire                          RREADY,
    input  wire                          clk,
    input  wire                          rst,
    input  wire [7:0]                    toneinc_V_address0,
    input  wire                          toneinc_V_ce0,
    output wire [127:0]                  toneinc_V_q0,
    input  wire [7:0]                    phase0_V_address0,
    input  wire                          phase0_V_ce0,
    output wire [127:0]                  phase0_V_q0
);
//------------------------Address Info-------------------
// 0x1000 ~
// 0x1fff : Memory 'toneinc_V' (256 * 128b)
//          Word 4n   : bit [31:0] - toneinc_V[n][31: 0]
//          Word 4n+1 : bit [31:0] - toneinc_V[n][63:32]
//          Word 4n+2 : bit [31:0] - toneinc_V[n][95:64]
//          Word 4n+3 : bit [31:0] - toneinc_V[n][127:96]
// 0x2000 ~
// 0x2fff : Memory 'phase0_V' (256 * 128b)
//          Word 4n   : bit [31:0] - phase0_V[n][31: 0]
//          Word 4n+1 : bit [31:0] - phase0_V[n][63:32]
//          Word 4n+2 : bit [31:0] - phase0_V[n][95:64]
//          Word 4n+3 : bit [31:0] - phase0_V[n][127:96]
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

//------------------------Parameter----------------------
localparam
    ADDR_TONEINC_V_BASE = 14'h1000,
    ADDR_TONEINC_V_HIGH = 14'h1fff,
    ADDR_PHASE0_V_BASE  = 14'h2000,
    ADDR_PHASE0_V_HIGH  = 14'h2fff,
    WRIDLE              = 2'd0,
    WRDATA              = 2'd1,
    WRRESP              = 2'd2,
    WRRESET             = 2'd3,
    RDIDLE              = 2'd0,
    RDDATA              = 2'd1,
    RDRESET             = 2'd2,
    ADDR_BITS         = 14;

//------------------------Local signal-------------------
    reg  [1:0]                    wstate = WRRESET;
    reg  [1:0]                    wnext;
    reg  [ADDR_BITS-1:0]          waddr;
    wire [31:0]                   wmask;
    wire                          aw_hs;
    wire                          w_hs;
    reg  [1:0]                    rstate = RDRESET;
    reg  [1:0]                    rnext;
    reg  [31:0]                   rdata;
    wire                          ar_hs;
    wire [ADDR_BITS-1:0]          raddr;
    // memory signals
    wire [7:0]                    int_toneinc_V_address0;
    wire                          int_toneinc_V_ce0;
    wire                          int_toneinc_V_we0;
    wire [15:0]                   int_toneinc_V_be0;
    wire [127:0]                  int_toneinc_V_d0;
    wire [127:0]                  int_toneinc_V_q0;
    wire [7:0]                    int_toneinc_V_address1;
    wire                          int_toneinc_V_ce1;
    wire                          int_toneinc_V_we1;
    wire [15:0]                   int_toneinc_V_be1;
    wire [127:0]                  int_toneinc_V_d1;
    wire [127:0]                  int_toneinc_V_q1;
    reg                           int_toneinc_V_read;
    reg                           int_toneinc_V_write;
    reg  [1:0]                    int_toneinc_V_shift;
    wire [7:0]                    int_phase0_V_address0;
    wire                          int_phase0_V_ce0;
    wire                          int_phase0_V_we0;
    wire [15:0]                   int_phase0_V_be0;
    wire [127:0]                  int_phase0_V_d0;
    wire [127:0]                  int_phase0_V_q0;
    wire [7:0]                    int_phase0_V_address1;
    wire                          int_phase0_V_ce1;
    wire                          int_phase0_V_we1;
    wire [15:0]                   int_phase0_V_be1;
    wire [127:0]                  int_phase0_V_d1;
    wire [127:0]                  int_phase0_V_q1;
    reg                           int_phase0_V_read;
    reg                           int_phase0_V_write;
    reg  [1:0]                    int_phase0_V_shift;

//------------------------Instantiation------------------
// int_toneinc_V
resonator_dds_control_s_axi_ram #(
    .BYTES    ( 16 ),
    .DEPTH    ( 256 )
) int_toneinc_V (
    .clk0     ( clk ),
    .address0 ( int_toneinc_V_address0 ),
    .ce0      ( int_toneinc_V_ce0 ),
    .we0      ( int_toneinc_V_we0 ),
    .be0      ( int_toneinc_V_be0 ),
    .d0       ( int_toneinc_V_d0 ),
    .q0       ( int_toneinc_V_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_toneinc_V_address1 ),
    .ce1      ( int_toneinc_V_ce1 ),
    .we1      ( int_toneinc_V_we1 ),
    .be1      ( int_toneinc_V_be1 ),
    .d1       ( int_toneinc_V_d1 ),
    .q1       ( int_toneinc_V_q1 )
);
// int_phase0_V
resonator_dds_control_s_axi_ram #(
    .BYTES    ( 16 ),
    .DEPTH    ( 256 )
) int_phase0_V (
    .clk0     ( clk ),
    .address0 ( int_phase0_V_address0 ),
    .ce0      ( int_phase0_V_ce0 ),
    .we0      ( int_phase0_V_we0 ),
    .be0      ( int_phase0_V_be0 ),
    .d0       ( int_phase0_V_d0 ),
    .q0       ( int_phase0_V_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_phase0_V_address1 ),
    .ce1      ( int_phase0_V_ce1 ),
    .we1      ( int_phase0_V_we1 ),
    .be1      ( int_phase0_V_be1 ),
    .d1       ( int_phase0_V_d1 ),
    .q1       ( int_phase0_V_q1 )
);

//------------------------AXI write fsm------------------
assign AWREADY = (wstate == WRIDLE);
assign WREADY  = (wstate == WRDATA);
assign BRESP   = 2'b00;  // OKAY
assign BVALID  = (wstate == WRRESP);
assign wmask   = { {8{WSTRB[3]}}, {8{WSTRB[2]}}, {8{WSTRB[1]}}, {8{WSTRB[0]}} };
assign aw_hs   = AWVALID & AWREADY;
assign w_hs    = WVALID & WREADY;

// wstate
always @(posedge ACLK) begin
    if (ARESET)
        wstate <= WRRESET;
    else if (ACLK_EN)
        wstate <= wnext;
end

// wnext
always @(*) begin
    case (wstate)
        WRIDLE:
            if (AWVALID)
                wnext = WRDATA;
            else
                wnext = WRIDLE;
        WRDATA:
            if (WVALID)
                wnext = WRRESP;
            else
                wnext = WRDATA;
        WRRESP:
            if (BREADY)
                wnext = WRIDLE;
            else
                wnext = WRRESP;
        default:
            wnext = WRIDLE;
    endcase
end

// waddr
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (aw_hs)
            waddr <= AWADDR[ADDR_BITS-1:0];
    end
end

//------------------------AXI read fsm-------------------
assign ARREADY = (rstate == RDIDLE);
assign RDATA   = rdata;
assign RRESP   = 2'b00;  // OKAY
assign RVALID  = (rstate == RDDATA) & !int_toneinc_V_read & !int_phase0_V_read;
assign ar_hs   = ARVALID & ARREADY;
assign raddr   = ARADDR[ADDR_BITS-1:0];

// rstate
always @(posedge ACLK) begin
    if (ARESET)
        rstate <= RDRESET;
    else if (ACLK_EN)
        rstate <= rnext;
end

// rnext
always @(*) begin
    case (rstate)
        RDIDLE:
            if (ARVALID)
                rnext = RDDATA;
            else
                rnext = RDIDLE;
        RDDATA:
            if (RREADY & RVALID)
                rnext = RDIDLE;
            else
                rnext = RDDATA;
        default:
            rnext = RDIDLE;
    endcase
end

// rdata
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (ar_hs) begin
            rdata <= 1'b0;
        end
        else if (int_toneinc_V_read) begin
            rdata <= int_toneinc_V_q1 >> (int_toneinc_V_shift * 32);
        end
        else if (int_phase0_V_read) begin
            rdata <= int_phase0_V_q1 >> (int_phase0_V_shift * 32);
        end
    end
end


//------------------------Register logic-----------------

//------------------------Memory logic-------------------
// toneinc_V
assign int_toneinc_V_address0 = toneinc_V_address0;
assign int_toneinc_V_ce0      = toneinc_V_ce0;
assign int_toneinc_V_we0      = 1'b0;
assign int_toneinc_V_be0      = 1'b0;
assign int_toneinc_V_d0       = 1'b0;
assign toneinc_V_q0           = int_toneinc_V_q0;
assign int_toneinc_V_address1 = ar_hs? raddr[11:4] : waddr[11:4];
assign int_toneinc_V_ce1      = ar_hs | (int_toneinc_V_write & WVALID);
assign int_toneinc_V_we1      = int_toneinc_V_write & WVALID;
assign int_toneinc_V_be1      = WSTRB << (waddr[3:2] * 4);
assign int_toneinc_V_d1       = {4{WDATA}};
// phase0_V
assign int_phase0_V_address0  = phase0_V_address0;
assign int_phase0_V_ce0       = phase0_V_ce0;
assign int_phase0_V_we0       = 1'b0;
assign int_phase0_V_be0       = 1'b0;
assign int_phase0_V_d0        = 1'b0;
assign phase0_V_q0            = int_phase0_V_q0;
assign int_phase0_V_address1  = ar_hs? raddr[11:4] : waddr[11:4];
assign int_phase0_V_ce1       = ar_hs | (int_phase0_V_write & WVALID);
assign int_phase0_V_we1       = int_phase0_V_write & WVALID;
assign int_phase0_V_be1       = WSTRB << (waddr[3:2] * 4);
assign int_phase0_V_d1        = {4{WDATA}};
// int_toneinc_V_read
always @(posedge ACLK) begin
    if (ARESET)
        int_toneinc_V_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_TONEINC_V_BASE && raddr <= ADDR_TONEINC_V_HIGH)
            int_toneinc_V_read <= 1'b1;
        else
            int_toneinc_V_read <= 1'b0;
    end
end

// int_toneinc_V_write
always @(posedge ACLK) begin
    if (ARESET)
        int_toneinc_V_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_TONEINC_V_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_TONEINC_V_HIGH)
            int_toneinc_V_write <= 1'b1;
        else if (WVALID)
            int_toneinc_V_write <= 1'b0;
    end
end

// int_toneinc_V_shift
always @(posedge clk) begin
    if (ACLK_EN) begin
        if (ar_hs)
            int_toneinc_V_shift <= raddr[3:2];
    end
end

// int_phase0_V_read
always @(posedge ACLK) begin
    if (ARESET)
        int_phase0_V_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_PHASE0_V_BASE && raddr <= ADDR_PHASE0_V_HIGH)
            int_phase0_V_read <= 1'b1;
        else
            int_phase0_V_read <= 1'b0;
    end
end

// int_phase0_V_write
always @(posedge ACLK) begin
    if (ARESET)
        int_phase0_V_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_PHASE0_V_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_PHASE0_V_HIGH)
            int_phase0_V_write <= 1'b1;
        else if (WVALID)
            int_phase0_V_write <= 1'b0;
    end
end

// int_phase0_V_shift
always @(posedge clk) begin
    if (ACLK_EN) begin
        if (ar_hs)
            int_phase0_V_shift <= raddr[3:2];
    end
end


endmodule


`timescale 1ns/1ps

module resonator_dds_control_s_axi_ram
#(parameter
    BYTES  = 4,
    DEPTH  = 256,
    AWIDTH = log2(DEPTH)
) (
    input  wire               clk0,
    input  wire [AWIDTH-1:0]  address0,
    input  wire               ce0,
    input  wire               we0,
    input  wire [BYTES-1:0]   be0,
    input  wire [BYTES*8-1:0] d0,
    output reg  [BYTES*8-1:0] q0,
    input  wire               clk1,
    input  wire [AWIDTH-1:0]  address1,
    input  wire               ce1,
    input  wire               we1,
    input  wire [BYTES-1:0]   be1,
    input  wire [BYTES*8-1:0] d1,
    output reg  [BYTES*8-1:0] q1
);
//------------------------Local signal-------------------
reg  [BYTES*8-1:0] mem[0:DEPTH-1];
//------------------------Task and function--------------
function integer log2;
    input integer x;
    integer n, m;
begin
    n = 1;
    m = 2;
    while (m < x) begin
        n = n + 1;
        m = m * 2;
    end
    log2 = n;
end
endfunction
//------------------------Body---------------------------
// read port 0
always @(posedge clk0) begin
    if (ce0) q0 <= mem[address0];
end

// read port 1
always @(posedge clk1) begin
    if (ce1) q1 <= mem[address1];
end

genvar i;
generate
    for (i = 0; i < BYTES; i = i + 1) begin : gen_write
        // write port 0
        always @(posedge clk0) begin
            if (ce0 & we0 & be0[i]) begin
                mem[address0][8*i+7:8*i] <= d0[8*i+7:8*i];
            end
        end
        // write port 1
        always @(posedge clk1) begin
            if (ce1 & we1 & be1[i]) begin
                mem[address1][8*i+7:8*i] <= d1[8*i+7:8*i];
            end
        end
    end
endgenerate

endmodule

