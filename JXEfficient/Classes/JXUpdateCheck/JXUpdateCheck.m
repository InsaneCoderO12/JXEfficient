//
//  SBUpdate.m
//  ShiBa
//
//  Created by shiba_iosJX on 9/9/15.
//  Copyright © 2016 ShiBa. All rights reserved.
//

#import "JXUpdateCheck.h"
#import <UIKit/UIKit.h>
#import "JXInline.h"

static NSString *const kAppStoreLookup = @"https://itunes.apple.com/lookup?id=";
static NSString *const kAppStoreLink = @"https://itunes.apple.com/app/id";
static NSString *const kAppStoreReview = @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&onlyLatestVersion=false&sortOrdering=2&type=Purple+Software&mt=8";

@implementation JXUpdateCheck

+ (void)jx_checkAppID:(NSString *)appID result:(void (^)(BOOL, NSDictionary *))result {
    if (![self validAppID:appID]) {
        return;
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kAppStoreLookup, appID]];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    req.HTTPMethod = @"POST";
    NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    cfg.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:cfg];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!data) {
            return ;
        }
        
        id dicLookup = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        if (![dicLookup isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        
        if (![dicLookup[@"results"] isKindOfClass:[NSArray class]]) {
            return ;
        }
        
        if ([dicLookup[@"results"] count] == 0) {
            return ;
        }
        
        // 商店版本
        NSString *appStoreVersion = [NSString stringWithFormat:@"%@", [dicLookup[@"results"] firstObject][@"version"]];
        // 当前版本
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
        // 更新文案
        NSDictionary *resultsDic = [dicLookup[@"results"] firstObject];

        //
        BOOL haveNew = [self haveNewVerWithAppStoreVersion:appStoreVersion currentVersion:currentVersion];

        // 有新版本
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([currentVersion compare:appStoreVersion] == NSOrderedAscending) {
                !result ? : result(haveNew, resultsDic);
            }
            else {
                !result ? : result(haveNew, resultsDic);
            }
        });
    }];
    [task resume];
}

+ (void)jx_checkAndShowAlertIfNewVersionWithAppId:(NSString *)appID {
    if (![self validAppID:appID]) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self jx_checkAppID:appID result:^(BOOL haveNew, NSDictionary *result) {
            if (haveNew) {
                UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:@"发现新版本" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *actionNextTime = [UIAlertAction actionWithTitle:@"下次提醒我" style:UIAlertActionStyleDefault handler:nil];
                UIAlertAction *actionUpdate = [UIAlertAction actionWithTitle:@"去 AppStore 更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self jx_openAppStoreToUpdateWithAppID:appID];
                }];
                [alertCtl addAction:actionNextTime];
                [alertCtl addAction:actionUpdate];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertCtl animated:YES completion:nil];
            }
        }];
    });
}

+ (BOOL)jx_openAppStoreToUpdateWithAppID:(NSString *)appID {
    return [self openUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kAppStoreLink, appID]]];
}

+ (BOOL)jx_openAppStoreToWriteReviewWithAppID:(NSString *)appID {
    return [self openUrl:[NSURL URLWithString:[NSString stringWithFormat:kAppStoreReview, appID]]];
}

+ (BOOL)openUrl:(NSURL *)url {
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
        return YES;
    }
    else {
        return NO;
    }
}

+ (BOOL)validAppID:(NSString *)appID {
    return [appID isKindOfClass:[NSString class]] && appID.length > 0;
}

+ (BOOL)haveNewVerWithAppStoreVersion:(NSString *)appStoreVersion currentVersion:(NSString *)currentVersion {
    NSArray <NSString *> *arr_appStoreVersion = [appStoreVersion componentsSeparatedByString:@"."];
    NSArray <NSString *> *arr_currentVersion = [currentVersion componentsSeparatedByString:@"."];
    
    NSInteger appStore_count = arr_appStoreVersion.count;
    NSInteger current_count = arr_currentVersion.count;
    NSInteger max_count = MAX(arr_appStoreVersion.count, arr_currentVersion.count);
    
    BOOL haveNew = NO;
    for (NSInteger i = 0; i < max_count; i ++) {
        //
        if (i < appStore_count && i < current_count) {                  // 长度相等部分
            NSInteger appStore_sub_v = jx_intValue(arr_appStoreVersion[i]);
            NSInteger current_sub_v = jx_intValue(arr_currentVersion[i]);
            
            if (appStore_sub_v > current_sub_v) {                       // 分割后版本号 (大于当前版本 有新版本 )
                haveNew = YES;
                break;
            }
            else if (appStore_sub_v < current_sub_v) {                  // 分割后版本号 (小于当前版本 无新版本 )
                haveNew = NO;
                break;
            }
        }
        else if (i >= appStore_count && i < current_count) {            // 长度不等部分 current 版本号更长 <不存在>
            
        }
        else if (i < appStore_count && i >= current_count) {            // 长度不等部分 appStore 版本号更长
            haveNew = YES;
        }
    }
    return haveNew;
}

@end

#if 0
// NSDictionary result0
{
    "resultCount": 1,
    "results": [
                {
                    "ipadScreenshotUrls": [],
                    "appletvScreenshotUrls": [],
                    "artworkUrl512": "http://is2.mzstatic.com/image/thumb/Purple71/v4/5a/89/9c/5a899c81-961d-d552-f9a5-5dfad2c8230e/source/512x512bb.jpg",
                    "artistViewUrl": "https://itunes.apple.com/us/developer/china-resources-holdings-company/id1098134092?uo=4",
                    "artworkUrl60": "http://is2.mzstatic.com/image/thumb/Purple71/v4/5a/89/9c/5a899c81-961d-d552-f9a5-5dfad2c8230e/source/60x60bb.jpg",
                    "artworkUrl100": "http://is2.mzstatic.com/image/thumb/Purple71/v4/5a/89/9c/5a899c81-961d-d552-f9a5-5dfad2c8230e/source/100x100bb.jpg",
                    "kind": "software",
                    "features": [],
                    "supportedDevices": [
                                         "iPad2Wifi",
                                         "iPad23G",
                                         "iPhone4S",
                                         "iPadThirdGen",
                                         "iPadThirdGen4G",
                                         "iPhone5",
                                         "iPodTouchFifthGen",
                                         "iPadFourthGen",
                                         "iPadFourthGen4G",
                                         "iPadMini",
                                         "iPadMini4G",
                                         "iPhone5c",
                                         "iPhone5s",
                                         "iPhone6",
                                         "iPhone6Plus",
                                         "iPodTouchSixthGen"
                                         ],
                    "advisories": [],
                    "screenshotUrls": [
                                       "http://a4.mzstatic.com/us/r30/Purple71/v4/31/8e/ba/318eba01-fe5a-e117-fb3b-863e61fc6b7d/screen696x696.jpeg",
                                       "http://a4.mzstatic.com/us/r30/Purple71/v4/09/56/a8/0956a8bb-4606-7370-9ec6-47bb93fe90a2/screen696x696.jpeg",
                                       "http://a1.mzstatic.com/us/r30/Purple71/v4/91/07/2f/91072f98-d33a-fedb-e885-dec72f0f3877/screen696x696.jpeg",
                                       "http://a1.mzstatic.com/us/r30/Purple71/v4/4f/3b/f3/4f3bf3c7-fc05-0192-9e07-89e750a89c9f/screen696x696.jpeg",
                                       "http://a1.mzstatic.com/us/r30/Purple71/v4/ea/92/d9/ea92d96d-2d5e-2644-a1b7-0918b24a9b52/screen696x696.jpeg"
                                       ],
                    "isGameCenterEnabled": false,
                    "languageCodesISO2A": [
                                           "EN",
                                           "ZH"
                                           ],
                    "fileSizeBytes": "27817984",
                    "trackContentRating": "4+",
                    "trackCensoredName": "一点万象Pro - 星沙万象汇官方APP",
                    "trackViewUrl": "https://itunes.apple.com/us/app/yi-dian-wan-xiangpro-xing/id1142151719?mt=8&uo=4",
                    "contentAdvisoryRating": "4+",
                    "minimumOsVersion": "8.0",
                    "wrapperType": "software",
                    "version": "1.0.2",
                    "releaseDate": "2016-09-27T10:47:43Z",
                    "description": "一点万象APP——华润置地高端商业地产系列与“互联网+”的碰撞，为您开启潮流时尚、便捷服务新时代！\n轻轻一点，丰富及时的商场活动信息、包罗万象的新店咨询、琳琅满目的精品特惠应有尽有，万象特权尽情享受。一键咨询、自助积分、沙龙预约、礼品兑换、寻车缴费……动动拇指轻松实现。让您抛却顾虑，随心逛，任性买！\n马上下载，立即开启您的万象时间！",
                    "artistId": 1098134092,
                    "artistName": "China Resources (Holdings) Company Limited",
                    "genres": [
                               "Lifestyle",
                               "Shopping"
                               ],
                    "price": 0,
                    "currency": "USD",
                    "bundleId": "com.crland.newMixc",
                    "trackId": 1142151719,
                    "trackName": "一点万象Pro - 星沙万象汇官方APP",
                    "primaryGenreName": "Lifestyle",
                    "isVppDeviceBasedLicensingEnabled": true,
                    "formattedPrice": "Free",
                    "currentVersionReleaseDate": "2016-10-19T00:38:00Z",
                    "releaseNotes": "1、礼品兑换增加会员卡限制；\n2、体验优化及bug修复；",
                    "sellerName": "China Resources (Holdings) Company Limited",
                    "primaryGenreId": 6012,
                    "genreIds": [
                                 "6012",
                                 "6024"
                                 ]
                }
                ]
}
#endif


















