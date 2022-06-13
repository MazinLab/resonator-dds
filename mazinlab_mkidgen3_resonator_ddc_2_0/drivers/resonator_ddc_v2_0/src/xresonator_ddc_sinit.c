// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xresonator_ddc.h"

extern XResonator_ddc_Config XResonator_ddc_ConfigTable[];

XResonator_ddc_Config *XResonator_ddc_LookupConfig(u16 DeviceId) {
	XResonator_ddc_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XRESONATOR_DDC_NUM_INSTANCES; Index++) {
		if (XResonator_ddc_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XResonator_ddc_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XResonator_ddc_Initialize(XResonator_ddc *InstancePtr, u16 DeviceId) {
	XResonator_ddc_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XResonator_ddc_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XResonator_ddc_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

