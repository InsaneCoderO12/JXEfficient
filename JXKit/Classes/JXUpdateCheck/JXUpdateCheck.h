//
//  SBUpdate.h
//  ShiBa
//
//  Created by shiba_iosJX on 9/9/15.
//  Copyright © 2016 ShiBa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXUpdateCheck : NSObject

// 检查是否有新版本
+ (void)checkAppID:(NSString *)appID result:(void(^)(BOOL haveNew, NSDictionary *result0))result;

// 检查是否有新版本, 如果有新版本 Alert 提示更新
+ (void)checkAndShowAlertIfNewVersionWithAppId:(NSString *)appID;

// 打开 appStore 去升级
+ (BOOL)openAppStoreToUpdateWithAppID:(NSString *)appID;

// 打开 appStore 去评分
+ (BOOL)openAppStoreToWriteReviewWithAppID:(NSString *)appID;

@end
