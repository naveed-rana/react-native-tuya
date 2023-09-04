import { NativeModules } from 'react-native';

const tuya = NativeModules.TuyaHomeDataManagerModule;

export type GetRoomDeviceListParams = {
  homeId?: number;
  roomId: number;
};

export type GetRoomDeviceListResponse = {
  deviceList: {}[];
  groupList: {}[];
};

export function getRoomDeviceList(
  params: GetRoomDeviceListParams
): Promise<GetRoomDeviceListResponse> {
  return tuya.getRoomDeviceList(params);
}

export type GetHomeDeviceListParams = {
  homeId?: number;
};

export function getHomeDeviceList(
  params:GetHomeDeviceListParams
): Promise<any> {
  return tuya.getHomeDeviceList(params);
}
