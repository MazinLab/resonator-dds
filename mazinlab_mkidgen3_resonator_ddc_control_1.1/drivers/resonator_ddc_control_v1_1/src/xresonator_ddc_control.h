// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Tool Version Limit: 2022.04
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XRESONATOR_DDC_CONTROL_H
#define XRESONATOR_DDC_CONTROL_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xresonator_ddc_control_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
    u16 DeviceId;
    u64 Control_BaseAddress;
} XResonator_ddc_control_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XResonator_ddc_control;

typedef u32 word_type;

typedef struct {
    u32 word_0;
    u32 word_1;
    u32 word_2;
    u32 word_3;
    u32 word_4;
    u32 word_5;
    u32 word_6;
    u32 word_7;
} XResonator_ddc_control_Tones;

typedef struct {
    u32 word_0;
    u32 word_1;
    u32 word_2;
    u32 word_3;
    u32 word_4;
    u32 word_5;
    u32 word_6;
    u32 word_7;
} XResonator_ddc_control_Centers;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XResonator_ddc_control_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XResonator_ddc_control_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XResonator_ddc_control_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XResonator_ddc_control_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XResonator_ddc_control_Initialize(XResonator_ddc_control *InstancePtr, u16 DeviceId);
XResonator_ddc_control_Config* XResonator_ddc_control_LookupConfig(u16 DeviceId);
int XResonator_ddc_control_CfgInitialize(XResonator_ddc_control *InstancePtr, XResonator_ddc_control_Config *ConfigPtr);
#else
int XResonator_ddc_control_Initialize(XResonator_ddc_control *InstancePtr, const char* InstanceName);
int XResonator_ddc_control_Release(XResonator_ddc_control *InstancePtr);
#endif


void XResonator_ddc_control_Set_clear_accumulator(XResonator_ddc_control *InstancePtr, u32 Data);
u32 XResonator_ddc_control_Get_clear_accumulator(XResonator_ddc_control *InstancePtr);
u32 XResonator_ddc_control_Get_tones_BaseAddress(XResonator_ddc_control *InstancePtr);
u32 XResonator_ddc_control_Get_tones_HighAddress(XResonator_ddc_control *InstancePtr);
u32 XResonator_ddc_control_Get_tones_TotalBytes(XResonator_ddc_control *InstancePtr);
u32 XResonator_ddc_control_Get_tones_BitWidth(XResonator_ddc_control *InstancePtr);
u32 XResonator_ddc_control_Get_tones_Depth(XResonator_ddc_control *InstancePtr);
u32 XResonator_ddc_control_Write_tones_Words(XResonator_ddc_control *InstancePtr, int offset, word_type *data, int length);
u32 XResonator_ddc_control_Read_tones_Words(XResonator_ddc_control *InstancePtr, int offset, word_type *data, int length);
u32 XResonator_ddc_control_Write_tones_Bytes(XResonator_ddc_control *InstancePtr, int offset, char *data, int length);
u32 XResonator_ddc_control_Read_tones_Bytes(XResonator_ddc_control *InstancePtr, int offset, char *data, int length);
u32 XResonator_ddc_control_Get_centers_BaseAddress(XResonator_ddc_control *InstancePtr);
u32 XResonator_ddc_control_Get_centers_HighAddress(XResonator_ddc_control *InstancePtr);
u32 XResonator_ddc_control_Get_centers_TotalBytes(XResonator_ddc_control *InstancePtr);
u32 XResonator_ddc_control_Get_centers_BitWidth(XResonator_ddc_control *InstancePtr);
u32 XResonator_ddc_control_Get_centers_Depth(XResonator_ddc_control *InstancePtr);
u32 XResonator_ddc_control_Write_centers_Words(XResonator_ddc_control *InstancePtr, int offset, word_type *data, int length);
u32 XResonator_ddc_control_Read_centers_Words(XResonator_ddc_control *InstancePtr, int offset, word_type *data, int length);
u32 XResonator_ddc_control_Write_centers_Bytes(XResonator_ddc_control *InstancePtr, int offset, char *data, int length);
u32 XResonator_ddc_control_Read_centers_Bytes(XResonator_ddc_control *InstancePtr, int offset, char *data, int length);

#ifdef __cplusplus
}
#endif

#endif
