//
//  SBUpdate.h
//  JXEfficient
//
//  Created by augsun on 9/9/15.
//  Copyright © 2016 CoderSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXUpdateCheck : NSObject

// 检查是否有新版本
+ (void)jx_checkAppID:(NSString *)appID result:(void(^)(BOOL haveNew, NSDictionary *result0))result;

// 检查是否有新版本, 如果有新版本 Alert 提示更新
+ (void)jx_checkAndShowAlertIfNewVersionWithAppId:(NSString *)appID;

// 打开 appStore 去升级
+ (BOOL)jx_openAppStoreToUpdateWithAppID:(NSString *)appID;

// 打开 appStore 去评分
+ (BOOL)jx_openAppStoreToWriteReviewWithAppID:(NSString *)appID;

@end
