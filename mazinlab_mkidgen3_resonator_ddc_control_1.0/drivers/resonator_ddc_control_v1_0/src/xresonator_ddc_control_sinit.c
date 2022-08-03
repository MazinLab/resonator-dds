// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Tool Version Limit: 2022.04
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xresonator_ddc_control.h"

extern XResonator_ddc_control_Config XResonator_ddc_control_ConfigTable[];

XResonator_ddc_control_Config *XResonator_ddc_control_LookupConfig(u16 DeviceId) {
	XResonator_ddc_control_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XRESONATOR_DDC_CONTROL_NUM_INSTANCES; Index++) {
		if (XResonator_ddc_control_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XResonator_ddc_control_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XResonator_ddc_control_Initialize(XResonator_ddc_control *InstancePtr, u16 DeviceId) {
	XResonator_ddc_control_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XResonator_ddc_control_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XResonator_ddc_control_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

