// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2.1 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XRESONATOR_DDS_H
#define XRESONATOR_DDS_H

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
#include "xresonator_dds_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
#else
typedef struct {
    u16 DeviceId;
    u32 Control_BaseAddress;
} XResonator_dds_Config;
#endif

typedef struct {
    u32 Control_BaseAddress;
    u32 IsReady;
} XResonator_dds;

typedef struct {
    u32 word_0;
    u32 word_1;
    u32 word_2;
    u32 word_3;
    u32 word_4;
    u32 word_5;
    u32 word_6;
    u32 word_7;
} XResonator_dds_Tones;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XResonator_dds_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XResonator_dds_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XResonator_dds_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XResonator_dds_ReadReg(BaseAddress, RegOffset) \
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
int XResonator_dds_Initialize(XResonator_dds *InstancePtr, u16 DeviceId);
XResonator_dds_Config* XResonator_dds_LookupConfig(u16 DeviceId);
int XResonator_dds_CfgInitialize(XResonator_dds *InstancePtr, XResonator_dds_Config *ConfigPtr);
#else
int XResonator_dds_Initialize(XResonator_dds *InstancePtr, const char* InstanceName);
int XResonator_dds_Release(XResonator_dds *InstancePtr);
#endif


u32 XResonator_dds_Get_tones_BaseAddress(XResonator_dds *InstancePtr);
u32 XResonator_dds_Get_tones_HighAddress(XResonator_dds *InstancePtr);
u32 XResonator_dds_Get_tones_TotalBytes(XResonator_dds *InstancePtr);
u32 XResonator_dds_Get_tones_BitWidth(XResonator_dds *InstancePtr);
u32 XResonator_dds_Get_tones_Depth(XResonator_dds *InstancePtr);
u32 XResonator_dds_Write_tones_Words(XResonator_dds *InstancePtr, int offset, int *data, int length);
u32 XResonator_dds_Read_tones_Words(XResonator_dds *InstancePtr, int offset, int *data, int length);
u32 XResonator_dds_Write_tones_Bytes(XResonator_dds *InstancePtr, int offset, char *data, int length);
u32 XResonator_dds_Read_tones_Bytes(XResonator_dds *InstancePtr, int offset, char *data, int length);

#ifdef __cplusplus
}
#endif

#endif
