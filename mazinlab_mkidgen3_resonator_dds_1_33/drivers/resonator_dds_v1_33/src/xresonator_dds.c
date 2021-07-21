// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xresonator_dds.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XResonator_dds_CfgInitialize(XResonator_dds *InstancePtr, XResonator_dds_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

u32 XResonator_dds_Get_tones_BaseAddress(XResonator_dds *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Control_BaseAddress + XRESONATOR_DDS_CONTROL_ADDR_TONES_BASE);
}

u32 XResonator_dds_Get_tones_HighAddress(XResonator_dds *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Control_BaseAddress + XRESONATOR_DDS_CONTROL_ADDR_TONES_HIGH);
}

u32 XResonator_dds_Get_tones_TotalBytes(XResonator_dds *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XRESONATOR_DDS_CONTROL_ADDR_TONES_HIGH - XRESONATOR_DDS_CONTROL_ADDR_TONES_BASE + 1);
}

u32 XResonator_dds_Get_tones_BitWidth(XResonator_dds *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XRESONATOR_DDS_CONTROL_WIDTH_TONES;
}

u32 XResonator_dds_Get_tones_Depth(XResonator_dds *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XRESONATOR_DDS_CONTROL_DEPTH_TONES;
}

u32 XResonator_dds_Write_tones_Words(XResonator_dds *InstancePtr, int offset, word_type *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XRESONATOR_DDS_CONTROL_ADDR_TONES_HIGH - XRESONATOR_DDS_CONTROL_ADDR_TONES_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Control_BaseAddress + XRESONATOR_DDS_CONTROL_ADDR_TONES_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XResonator_dds_Read_tones_Words(XResonator_dds *InstancePtr, int offset, word_type *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XRESONATOR_DDS_CONTROL_ADDR_TONES_HIGH - XRESONATOR_DDS_CONTROL_ADDR_TONES_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Control_BaseAddress + XRESONATOR_DDS_CONTROL_ADDR_TONES_BASE + (offset + i)*4);
    }
    return length;
}

u32 XResonator_dds_Write_tones_Bytes(XResonator_dds *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XRESONATOR_DDS_CONTROL_ADDR_TONES_HIGH - XRESONATOR_DDS_CONTROL_ADDR_TONES_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Control_BaseAddress + XRESONATOR_DDS_CONTROL_ADDR_TONES_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XResonator_dds_Read_tones_Bytes(XResonator_dds *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XRESONATOR_DDS_CONTROL_ADDR_TONES_HIGH - XRESONATOR_DDS_CONTROL_ADDR_TONES_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Control_BaseAddress + XRESONATOR_DDS_CONTROL_ADDR_TONES_BASE + offset + i);
    }
    return length;
}

