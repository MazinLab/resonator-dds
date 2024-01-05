// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
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
// 0x4000 ~
// 0x5fff : Memory 'centers' (256 * 256b)
//          Word 8n   : bit [31:0] - centers[n][31: 0]
//          Word 8n+1 : bit [31:0] - centers[n][63:32]
//          Word 8n+2 : bit [31:0] - centers[n][95:64]
//          Word 8n+3 : bit [31:0] - centers[n][127:96]
//          Word 8n+4 : bit [31:0] - centers[n][159:128]
//          Word 8n+5 : bit [31:0] - centers[n][191:160]
//          Word 8n+6 : bit [31:0] - centers[n][223:192]
//          Word 8n+7 : bit [31:0] - centers[n][255:224]
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XRESONATOR_DDC_CONTROL_ADDR_TONES_BASE   0x2000
#define XRESONATOR_DDC_CONTROL_ADDR_TONES_HIGH   0x3fff
#define XRESONATOR_DDC_CONTROL_WIDTH_TONES       256
#define XRESONATOR_DDC_CONTROL_DEPTH_TONES       256
#define XRESONATOR_DDC_CONTROL_ADDR_CENTERS_BASE 0x4000
#define XRESONATOR_DDC_CONTROL_ADDR_CENTERS_HIGH 0x5fff
#define XRESONATOR_DDC_CONTROL_WIDTH_CENTERS     256
#define XRESONATOR_DDC_CONTROL_DEPTH_CENTERS     256

