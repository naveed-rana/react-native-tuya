//
//  TuyaBLERNActivatorModule.m
//  TuyaRnDemo
//
//  Created by 浩天 on 2019/2/28.
//  Copyright © 2019年 Facebook. All rights reserved.
//

#import "TuyaBLERNActivatorModule.h"
#import <React/RCTBridgeModule.h>
#import <ThingSmartActivatorKit/ThingSmartActivatorKit.h>
#import <ThingSmartBaseKit/ThingSmartBaseKit.h>
#import <ThingSmartDeviceKit/ThingSmartDeviceKit.h>
#import <ThingSmartBLEKit/ThingSmartBLEWifiActivator.h>
#import "TuyaRNUtils+Network.h"
#import "YYModel.h"

#define kTuyaRNActivatorModuleHomeId @"homeId"
#define kTuyaRNActivatorModuleDeviceId @"deviceId"
#define kTuyaRNActivatorModuleProductId @"productId"
#define kTuyaRNActivatorModuleSSID @"ssid"
#define kTuyaRNActivatorModulePassword @"password"

// Bluetooth Pairing
static TuyaBLERNActivatorModule * activatorInstance = nil;

@interface TuyaBLERNActivatorModule()<ThingSmartBLEWifiActivatorDelegate>

@property(copy, nonatomic) RCTPromiseResolveBlock promiseResolveBlock;
@property(copy, nonatomic) RCTPromiseRejectBlock promiseRejectBlock;

@end

@implementation TuyaBLERNActivatorModule

RCT_EXPORT_MODULE(TuyaBLEActivatorModule)

RCT_EXPORT_METHOD(initActivator:(NSDictionary *)params resolver:(RCTPromiseResolveBlock)resolver rejecter:(RCTPromiseRejectBlock)rejecter) {
  if (activatorInstance == nil) {
    activatorInstance = [TuyaBLERNActivatorModule new];
  }

  [ThingSmartBLEWifiActivator sharedInstance].bleWifiDelegate = activatorInstance;
  activatorInstance.promiseResolveBlock = resolver;
  activatorInstance.promiseRejectBlock = rejecter;

  NSNumber *homeId = params[kTuyaRNActivatorModuleHomeId];
  NSString *deviceId = params[kTuyaRNActivatorModuleDeviceId];
  NSString *productId = params[kTuyaRNActivatorModuleProductId];
  NSString *ssid = params[kTuyaRNActivatorModuleSSID];
  NSString *password = params[kTuyaRNActivatorModulePassword];
  long long int homeIdValue = [homeId longLongValue];

  [[ThingSmartBLEWifiActivator sharedInstance] startConfigBLEWifiDeviceWithUUID:deviceId homeId:homeIdValue productId:productId ssid:ssid password:password  timeout:180 success:^{
      // Wait for activation
    } failure:^ {
      if (activatorInstance.promiseRejectBlock) {
        [TuyaRNUtils rejecterWithError:nil handler:rejecter];
      }
      return;
    }];
}

- (void)bleWifiActivator:(ThingSmartBLEWifiActivator *)activator didReceiveBLEWifiConfigDevice:(ThingSmartDeviceModel *)deviceModel error:(NSError *)error {
  if (!error && deviceModel) {
    if (activatorInstance.promiseResolveBlock) {
      self.promiseResolveBlock([deviceModel yy_modelToJSONObject]);
    }
  }
  if (error) {
    if (activatorInstance.promiseRejectBlock) {
      [TuyaRNUtils rejecterWithError:error handler:activatorInstance.promiseRejectBlock];
    }
  }

}

RCT_EXPORT_METHOD(startNetworkScan:(NSString *)uuid resolver:(RCTPromiseResolveBlock)resolver rejecter:(RCTPromiseRejectBlock)rejecter) {
  if (activatorInstance == nil) {
    activatorInstance = [TuyaBLERNActivatorModule new];
  }

  [ThingSmartBLEWifiActivator sharedInstance].bleWifiDelegate = activatorInstance;
  activatorInstance.promiseResolveBlock = resolver;
  activatorInstance.promiseRejectBlock = rejecter;

  [[ThingSmartBLEWifiActivator sharedInstance] connectAndQueryWifiListWithUUID:uuid success:^{
      // Wait for activation
    } failure:^(NSError *error) {
      if (activatorInstance.promiseRejectBlock) {
        [TuyaRNUtils rejecterWithError:nil handler:rejecter];
      }
      return;
    }];
}

- (void)didScanWifiList:(nullable NSArray *)wifiList uuid:(nullable NSString *)uuid error:(nullable NSError *)error {
  if (activatorInstance.promiseResolveBlock) {
    self.promiseResolveBlock([wifiList yy_modelToJSONObject]);
  }
}


@end
