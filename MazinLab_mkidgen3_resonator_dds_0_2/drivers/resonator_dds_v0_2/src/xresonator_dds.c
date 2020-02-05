// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2.1 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
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

void XResonator_dds_Start(XResonator_dds *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XResonator_dds_ReadReg(InstancePtr->Control_BaseAddress, XRESONATOR_DDS_CONTROL_ADDR_AP_CTRL) & 0x80;
    XResonator_dds_WriteReg(InstancePtr->Control_BaseAddress, XRESONATOR_DDS_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XResonator_dds_IsDone(XResonator_dds *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XResonator_dds_ReadReg(InstancePtr->Control_BaseAddress, XRESONATOR_DDS_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XResonator_dds_IsIdle(XResonator_dds *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XResonator_dds_ReadReg(InstancePtr->Control_BaseAddress, XRESONATOR_DDS_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XResonator_dds_IsReady(XResonator_dds *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XResonator_dds_ReadReg(InstancePtr->Control_BaseAddress, XRESONATOR_DDS_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XResonator_dds_EnableAutoRestart(XResonator_dds *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XResonator_dds_WriteReg(InstancePtr->Control_BaseAddress, XRESONATOR_DDS_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XResonator_dds_DisableAutoRestart(XResonator_dds *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XResonator_dds_WriteReg(InstancePtr->Control_BaseAddress, XRESONATOR_DDS_CONTROL_ADDR_AP_CTRL, 0);
}

u32 XResonator_dds_Get_toneinc_V_BaseAddress(XResonator_dds *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Control_BaseAddress + XRESONATOR_DDS_CONTROL_ADDR_TONEINC_V_BASE);
}

u32 XResonator_dds_Get_toneinc_V_HighAddress(XResonator_dds *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Control_BaseAddress + XRESONATOR_DDS_CONTROL_ADDR_TONEINC_V_HIGH);
}

u32 XResonator_dds_Get_toneinc_V_TotalBytes(XResonator_dds *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XRESONATOR_DDS_CONTROL_ADDR_TONEINC_V_HIGH - XRESONATOR_DDS_CONTROL_ADDR_TONEINC_V_BASE + 1);
}

u32 XResonator_dds_Get_toneinc_V_BitWidth(XResonator_dds *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XRESONATOR_DDS_CONTROL_WIDTH_TONEINC_V;
}

u32 XResonator_dds_Get_toneinc_V_Depth(XResonator_dds *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XRESONATOR_DDS_CONTROL_DEPTH_TONEINC_V;
}

u32 XResonator_dds_Write_toneinc_V_Words(XResonator_dds *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XRESONATOR_DDS_CONTROL_ADDR_TONEINC_V_HIGH - XRESONATOR_DDS_CONTROL_ADDR_TONEINC_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Control_BaseAddress + XRESONATOR_DDS_CONTROL_ADDR_TONEINC_V_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XResonator_dds_Read_toneinc_V_Words(XResonator_dds *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XRESONATOR_DDS_CONTROL_ADDR_TONEINC_V_HIGH - XRESONATOR_DDS_CONTROL_ADDR_TONEINC_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Control_BaseAddress + XRESONATOR_DDS_CONTROL_ADDR_TONEINC_V_BASE + (offset + i)*4);
    }
    return length;
}

u32 XResonator_dds_Write_toneinc_V_Bytes(XResonator_dds *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XRESONATOR_DDS_CONTROL_ADDR_TONEINC_V_HIGH - XRESONATOR_DDS_CONTROL_ADDR_TONEINC_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Control_BaseAddress + XRESONATOR_DDS_CONTROL_ADDR_TONEINC_V_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XResonator_dds_Read_toneinc_V_Bytes(XResonator_dds *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XRESONATOR_DDS_CONTROL_ADDR_TONEINC_V_HIGH - XRESONATOR_DDS_CONTROL_ADDR_TONEINC_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Control_BaseAddress + XRESONATOR_DDS_CONTROL_ADDR_TONEINC_V_BASE + offset + i);
    }
    return length;
}

u32 XResonator_dds_Get_phase0_V_BaseAddress(XResonator_dds *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Control_BaseAddress + XRESONATOR_DDS_CONTROL_ADDR_PHASE0_V_BASE);
}

u32 XResonator_dds_Get_phase0_V_HighAddress(XResonator_dds *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Control_BaseAddress + XRESONATOR_DDS_CONTROL_ADDR_PHASE0_V_HIGH);
}

u32 XResonator_dds_Get_phase0_V_TotalBytes(XResonator_dds *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XRESONATOR_DDS_CONTROL_ADDR_PHASE0_V_HIGH - XRESONATOR_DDS_CONTROL_ADDR_PHASE0_V_BASE + 1);
}

u32 XResonator_dds_Get_phase0_V_BitWidth(XResonator_dds *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XRESONATOR_DDS_CONTROL_WIDTH_PHASE0_V;
}

u32 XResonator_dds_Get_phase0_V_Depth(XResonator_dds *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XRESONATOR_DDS_CONTROL_DEPTH_PHASE0_V;
}

u32 XResonator_dds_Write_phase0_V_Words(XResonator_dds *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XRESONATOR_DDS_CONTROL_ADDR_PHASE0_V_HIGH - XRESONATOR_DDS_CONTROL_ADDR_PHASE0_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Control_BaseAddress + XRESONATOR_DDS_CONTROL_ADDR_PHASE0_V_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XResonator_dds_Read_phase0_V_Words(XResonator_dds *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XRESONATOR_DDS_CONTROL_ADDR_PHASE0_V_HIGH - XRESONATOR_DDS_CONTROL_ADDR_PHASE0_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Control_BaseAddress + XRESONATOR_DDS_CONTROL_ADDR_PHASE0_V_BASE + (offset + i)*4);
    }
    return length;
}

u32 XResonator_dds_Write_phase0_V_Bytes(XResonator_dds *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XRESONATOR_DDS_CONTROL_ADDR_PHASE0_V_HIGH - XRESONATOR_DDS_CONTROL_ADDR_PHASE0_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Control_BaseAddress + XRESONATOR_DDS_CONTROL_ADDR_PHASE0_V_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XResonator_dds_Read_phase0_V_Bytes(XResonator_dds *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XRESONATOR_DDS_CONTROL_ADDR_PHASE0_V_HIGH - XRESONATOR_DDS_CONTROL_ADDR_PHASE0_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Control_BaseAddress + XRESONATOR_DDS_CONTROL_ADDR_PHASE0_V_BASE + offset + i);
    }
    return length;
}

void XResonator_dds_InterruptGlobalEnable(XResonator_dds *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XResonator_dds_WriteReg(InstancePtr->Control_BaseAddress, XRESONATOR_DDS_CONTROL_ADDR_GIE, 1);
}

void XResonator_dds_InterruptGlobalDisable(XResonator_dds *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XResonator_dds_WriteReg(InstancePtr->Control_BaseAddress, XRESONATOR_DDS_CONTROL_ADDR_GIE, 0);
}

void XResonator_dds_InterruptEnable(XResonator_dds *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XResonator_dds_ReadReg(InstancePtr->Control_BaseAddress, XRESONATOR_DDS_CONTROL_ADDR_IER);
    XResonator_dds_WriteReg(InstancePtr->Control_BaseAddress, XRESONATOR_DDS_CONTROL_ADDR_IER, Register | Mask);
}

void XResonator_dds_InterruptDisable(XResonator_dds *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XResonator_dds_ReadReg(InstancePtr->Control_BaseAddress, XRESONATOR_DDS_CONTROL_ADDR_IER);
    XResonator_dds_WriteReg(InstancePtr->Control_BaseAddress, XRESONATOR_DDS_CONTROL_ADDR_IER, Register & (~Mask));
}

void XResonator_dds_InterruptClear(XResonator_dds *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XResonator_dds_WriteReg(InstancePtr->Control_BaseAddress, XRESONATOR_DDS_CONTROL_ADDR_ISR, Mask);
}

u32 XResonator_dds_InterruptGetEnabled(XResonator_dds *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XResonator_dds_ReadReg(InstancePtr->Control_BaseAddress, XRESONATOR_DDS_CONTROL_ADDR_IER);
}

u32 XResonator_dds_InterruptGetStatus(XResonator_dds *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XResonator_dds_ReadReg(InstancePtr->Control_BaseAddress, XRESONATOR_DDS_CONTROL_ADDR_ISR);
}

