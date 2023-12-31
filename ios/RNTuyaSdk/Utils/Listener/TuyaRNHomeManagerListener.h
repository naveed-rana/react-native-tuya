//
//  TuyaRNHomeManagerListener.h
//  TuyaRnDemo
//
//  Created by 浩天 on 2019/3/6.
//  Copyright © 2019年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ThingSmartDeviceKit/ThingSmartHome.h>
#import <ThingSmartDeviceKit/ThingSmartHomeManager.h>
#import <ThingSmartBaseKit/ThingSmartRequest.h>




NS_ASSUME_NONNULL_BEGIN

@interface TuyaRNHomeManagerListener : NSObject

/**
 单例
 */
+ (instancetype)sharedInstance;

/**
 注册家庭管理通知

 */
- (void)registerSmartHomeManager:(ThingSmartHomeManager *)homeManager;


/**
 移除家庭管理的通知
 */
- (void)removeSmartHomeManager;

@end

NS_ASSUME_NONNULL_END
