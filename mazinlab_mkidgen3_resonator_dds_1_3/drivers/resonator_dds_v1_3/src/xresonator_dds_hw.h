// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.1.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
// control
// 0x2000 ~
// 0x3fff : Memory 'tones' (256 * 256b)
//          Word 8n   : bit [31:0] - tones[n][31: 0]
//          Word 8n+1 : bit [31:0] - tones[n][63:32]
//          Word 8n+2 : bit [31:0] - tones[n][95:64]
//          Word 8n+3 : bit [31:0] - tones[n][127:96]
//          Word 8n+4 : bit [31:0] - tones[n][159:128]
//          Word 8n+5 : bit [31:0] - tones[n][191:160]
//          Word 8n+6 : bit [31:0] - tones[n][223:192]
//          Word 8n+7 : bit [31:0] - tones[n][255:224]
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XRESONATOR_DDS_CONTROL_ADDR_TONES_BASE 0x2000
#define XRESONATOR_DDS_CONTROL_ADDR_TONES_HIGH 0x3fff
#define XRESONATOR_DDS_CONTROL_WIDTH_TONES     256
#define XRESONATOR_DDS_CONTROL_DEPTH_TONES     256

