// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Tool Version Limit: 2022.04
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xresonator_ddc_control.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XResonator_ddc_control_CfgInitialize(XResonator_ddc_control *InstancePtr, XResonator_ddc_control_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XResonator_ddc_control_Set_clear_accumulator(XResonator_ddc_control *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XResonator_ddc_control_WriteReg(InstancePtr->Control_BaseAddress, XRESONATOR_DDC_CONTROL_CONTROL_ADDR_CLEAR_ACCUMULATOR_DATA, Data);
}

u32 XResonator_ddc_control_Get_clear_accumulator(XResonator_ddc_control *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XResonator_ddc_control_ReadReg(InstancePtr->Control_BaseAddress, XRESONATOR_DDC_CONTROL_CONTROL_ADDR_CLEAR_ACCUMULATOR_DATA);
    return Data;
}

u32 XResonator_ddc_control_Get_tones_BaseAddress(XResonator_ddc_control *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Control_BaseAddress + XRESONATOR_DDC_CONTROL_CONTROL_ADDR_TONES_BASE);
}

u32 XResonator_ddc_control_Get_tones_HighAddress(XResonator_ddc_control *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Control_BaseAddress + XRESONATOR_DDC_CONTROL_CONTROL_ADDR_TONES_HIGH);
}

u32 XResonator_ddc_control_Get_tones_TotalBytes(XResonator_ddc_control *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XRESONATOR_DDC_CONTROL_CONTROL_ADDR_TONES_HIGH - XRESONATOR_DDC_CONTROL_CONTROL_ADDR_TONES_BASE + 1);
}

u32 XResonator_ddc_control_Get_tones_BitWidth(XResonator_ddc_control *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XRESONATOR_DDC_CONTROL_CONTROL_WIDTH_TONES;
}

u32 XResonator_ddc_control_Get_tones_Depth(XResonator_ddc_control *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XRESONATOR_DDC_CONTROL_CONTROL_DEPTH_TONES;
}

u32 XResonator_ddc_control_Write_tones_Words(XResonator_ddc_control *InstancePtr, int offset, word_type *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XRESONATOR_DDC_CONTROL_CONTROL_ADDR_TONES_HIGH - XRESONATOR_DDC_CONTROL_CONTROL_ADDR_TONES_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Control_BaseAddress + XRESONATOR_DDC_CONTROL_CONTROL_ADDR_TONES_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XResonator_ddc_control_Read_tones_Words(XResonator_ddc_control *InstancePtr, int offset, word_type *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XRESONATOR_DDC_CONTROL_CONTROL_ADDR_TONES_HIGH - XRESONATOR_DDC_CONTROL_CONTROL_ADDR_TONES_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Control_BaseAddress + XRESONATOR_DDC_CONTROL_CONTROL_ADDR_TONES_BASE + (offset + i)*4);
    }
    return length;
}

u32 XResonator_ddc_control_Write_tones_Bytes(XResonator_ddc_control *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XRESONATOR_DDC_CONTROL_CONTROL_ADDR_TONES_HIGH - XRESONATOR_DDC_CONTROL_CONTROL_ADDR_TONES_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Control_BaseAddress + XRESONATOR_DDC_CONTROL_CONTROL_ADDR_TONES_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XResonator_ddc_control_Read_tones_Bytes(XResonator_ddc_control *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XRESONATOR_DDC_CONTROL_CONTROL_ADDR_TONES_HIGH - XRESONATOR_DDC_CONTROL_CONTROL_ADDR_TONES_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Control_BaseAddress + XRESONATOR_DDC_CONTROL_CONTROL_ADDR_TONES_BASE + offset + i);
    }
    return length;
}

u32 XResonator_ddc_control_Get_centers_BaseAddress(XResonator_ddc_control *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Control_BaseAddress + XRESONATOR_DDC_CONTROL_CONTROL_ADDR_CENTERS_BASE);
}

u32 XResonator_ddc_control_Get_centers_HighAddress(XResonator_ddc_control *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Control_BaseAddress + XRESONATOR_DDC_CONTROL_CONTROL_ADDR_CENTERS_HIGH);
}

u32 XResonator_ddc_control_Get_centers_TotalBytes(XResonator_ddc_control *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XRESONATOR_DDC_CONTROL_CONTROL_ADDR_CENTERS_HIGH - XRESONATOR_DDC_CONTROL_CONTROL_ADDR_CENTERS_BASE + 1);
}

u32 XResonator_ddc_control_Get_centers_BitWidth(XResonator_ddc_control *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XRESONATOR_DDC_CONTROL_CONTROL_WIDTH_CENTERS;
}

u32 XResonator_ddc_control_Get_centers_Depth(XResonator_ddc_control *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XRESONATOR_DDC_CONTROL_CONTROL_DEPTH_CENTERS;
}

u32 XResonator_ddc_control_Write_centers_Words(XResonator_ddc_control *InstancePtr, int offset, word_type *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XRESONATOR_DDC_CONTROL_CONTROL_ADDR_CENTERS_HIGH - XRESONATOR_DDC_CONTROL_CONTROL_ADDR_CENTERS_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Control_BaseAddress + XRESONATOR_DDC_CONTROL_CONTROL_ADDR_CENTERS_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XResonator_ddc_control_Read_centers_Words(XResonator_ddc_control *InstancePtr, int offset, word_type *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XRESONATOR_DDC_CONTROL_CONTROL_ADDR_CENTERS_HIGH - XRESONATOR_DDC_CONTROL_CONTROL_ADDR_CENTERS_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Control_BaseAddress + XRESONATOR_DDC_CONTROL_CONTROL_ADDR_CENTERS_BASE + (offset + i)*4);
    }
    return length;
}

u32 XResonator_ddc_control_Write_centers_Bytes(XResonator_ddc_control *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XRESONATOR_DDC_CONTROL_CONTROL_ADDR_CENTERS_HIGH - XRESONATOR_DDC_CONTROL_CONTROL_ADDR_CENTERS_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Control_BaseAddress + XRESONATOR_DDC_CONTROL_CONTROL_ADDR_CENTERS_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XResonator_ddc_control_Read_centers_Bytes(XResonator_ddc_control *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XRESONATOR_DDC_CONTROL_CONTROL_ADDR_CENTERS_HIGH - XRESONATOR_DDC_CONTROL_CONTROL_ADDR_CENTERS_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Control_BaseAddress + XRESONATOR_DDC_CONTROL_CONTROL_ADDR_CENTERS_BASE + offset + i);
    }
    return length;
}

