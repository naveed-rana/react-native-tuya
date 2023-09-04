import { DeviceBean } from './device';
import { NativeModules, Platform } from 'react-native';
import { DeviceDetailResponse } from './home';

const tuya = NativeModules.TuyaActivatorModule;
const tuyaBLEActivator = NativeModules.TuyaBLEActivatorModule;
const tuyaBLEScanner = NativeModules.TuyaBLEScannerModule;

export function openNetworkSettings() {
  return tuya.openNetworkSettings({});
}

export enum TuyaActivationType {
  EZ = 'TY_EZ',
  AP = 'TY_AP',
  QR = 'TY_QR',
}

export type InitActivatorParams = {
  homeId: number;
  ssid: string;
  password: string;
  time: number;
  type: TuyaActivationType;
};

export interface InitBluetoothActivatorParams {
  deviceId?: string;
  homeId: number;
  ssid: string;
  password: string;
}

export function initActivator(
  params: InitActivatorParams
): Promise<DeviceDetailResponse> {
  return tuya.initActivator(params);
}

export function stopConfig() {
  return tuya.stopConfig();
}

export function startBluetoothScan() {
  if (Platform.OS === 'ios') {
    return tuyaBLEScanner.startBluetoothScan();
  }
  return tuya.startBluetoothScan();
}

export function initBluetoothDualModeActivator(
  params: InitBluetoothActivatorParams
): Promise<DeviceBean> {
  if (Platform.OS === 'ios') {
    return tuyaBLEActivator.initActivator(params);
  }
  return tuya.initBluetoothDualModeActivator(params);
}

export function getCurrentWifi(
  success: (ssid: string) => void,
  error: () => void
) {
  // We need the Allow While Using App location permission to use this.
  return tuya.getCurrentWifi({}, success, error);
}

export function getActivatorToken(): Promise<String> {
  return tuya.getActivatorToken();
}
