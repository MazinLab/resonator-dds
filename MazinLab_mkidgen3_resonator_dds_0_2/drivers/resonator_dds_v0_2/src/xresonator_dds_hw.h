// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2.1 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
// control
// 0x0000 : Control signals
//          bit 0  - ap_start (Read/Write/COH)
//          bit 1  - ap_done (Read/COR)
//          bit 2  - ap_idle (Read)
//          bit 3  - ap_ready (Read)
//          bit 7  - auto_restart (Read/Write)
//          others - reserved
// 0x0004 : Global Interrupt Enable Register
//          bit 0  - Global Interrupt Enable (Read/Write)
//          others - reserved
// 0x0008 : IP Interrupt Enable Register (Read/Write)
//          bit 0  - Channel 0 (ap_done)
//          bit 1  - Channel 1 (ap_ready)
//          others - reserved
// 0x000c : IP Interrupt Status Register (Read/TOW)
//          bit 0  - Channel 0 (ap_done)
//          bit 1  - Channel 1 (ap_ready)
//          others - reserved
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

#define XRESONATOR_DDS_CONTROL_ADDR_AP_CTRL        0x0000
#define XRESONATOR_DDS_CONTROL_ADDR_GIE            0x0004
#define XRESONATOR_DDS_CONTROL_ADDR_IER            0x0008
#define XRESONATOR_DDS_CONTROL_ADDR_ISR            0x000c
#define XRESONATOR_DDS_CONTROL_ADDR_TONEINC_V_BASE 0x1000
#define XRESONATOR_DDS_CONTROL_ADDR_TONEINC_V_HIGH 0x1fff
#define XRESONATOR_DDS_CONTROL_WIDTH_TONEINC_V     128
#define XRESONATOR_DDS_CONTROL_DEPTH_TONEINC_V     256
#define XRESONATOR_DDS_CONTROL_ADDR_PHASE0_V_BASE  0x2000
#define XRESONATOR_DDS_CONTROL_ADDR_PHASE0_V_HIGH  0x2fff
#define XRESONATOR_DDS_CONTROL_WIDTH_PHASE0_V      128
#define XRESONATOR_DDS_CONTROL_DEPTH_PHASE0_V      256

