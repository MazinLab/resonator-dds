// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xresonator_dds.h"

extern XResonator_dds_Config XResonator_dds_ConfigTable[];

XResonator_dds_Config *XResonator_dds_LookupConfig(u16 DeviceId) {
	XResonator_dds_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XRESONATOR_DDS_NUM_INSTANCES; Index++) {
		if (XResonator_dds_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XResonator_dds_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XResonator_dds_Initialize(XResonator_dds *InstancePtr, u16 DeviceId) {
	XResonator_dds_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XResonator_dds_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XResonator_dds_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

