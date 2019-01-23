//
//  JXEfficient.h
//  JXEfficient
//
//  Created by augsun on 6/1/18.
//  Copyright © 2018 CoderSun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "JXInline.h"                        // 内联
#import "JXMacro.h"                         // 宏

// 系统类功能扩展
#import "UIImage+JXCategory.h"
#import "UIScrollView+JXCategory.h"
#import "UIButton+JXCategory.h"
#import "UIView+JXCategory.h"
#import "UIView+JXToastAndProgressHUD.h"
#import "UICollectionView+JXCategory.h"
#import "NSString+JXCategory.h"
#import "UITableView+JXCategory.h"
#import "NSDate+JXCategory.h"
#import "UIViewController+JXCategory.h"
#import "UIColor+JXCategory.h"

//
#import "JXJSONCache.h"                     // json 缓存
#import "JXLocationCoordinates.h"           // 定位
#import "JXRegular.h"                       // 常用正则匹配
#import "JXSystemAlert.h"                   // 系统 Alert
#import "JXUpdateCheck.h"                   // 版本更新检查
#import "JXUUIDAndKeyChain.h"               // UUID And KeyChain
#import "JXCoreData.h"                      // 数据库操作

// UIView
#import "JXQRCodeScanView.h"                // 二维码扫描
#import "JXImageBrowser.h"                  // 图片浏览器
#import "JXRollView.h"                      // 轮播
#import "JXNaviView.h"                      // 导航条
#import "JXFlowView.h"                      // 流布局
#import "JXVideoPlayerView.h"               // 视频播放

@interface JXEfficient : NSObject

#pragma mark 以下方法只在 JXEfficient 内部使用有效果<获取 JXEfficient 内部资源>
+ (NSBundle *)efficientBundle;
+ (UIImage *)imageNamed:(NSString *)name; // 获取图片资源
+ (UIImage *)PDFImageNamed:(NSString *)name; // 获取图片资源 (PDF)

@end
