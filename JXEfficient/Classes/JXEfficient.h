//
//  JXEfficient.h
//  JXEfficient_Example
//
//  Created by augsun on 6/1/18.
//  Copyright © 2018 452720799@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "JXInline.h"
#import "JXMacro.h"

// Category
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
#import "JXJSONCache.h"
#import "JXLocationCoordinates.h"
#import "JXRegular.h"
#import "JXSystemAlert.h"
#import "JXUpdateCheck.h"
#import "JXUUIDAndKeyChain.h"

// UIView
#import "JXQRCodeScanView.h"
#import "JXImageBrowser.h"
#import "JXRollView.h"
#import "JXNaviView.h"
#import "JXFlowView.h"
#import "JXVideoPlayerView.h"

@interface JXEfficient : NSObject

#pragma mark 以下方法只在 JXEfficient 内部使用有效果<获取 JXEfficient 内部资源>
+ (NSBundle *)efficientBundle;
+ (UIImage *)imageNamed:(NSString *)name; // 获取图片资源
+ (UIImage *)PDFImageNamed:(NSString *)name; // 获取图片资源 (PDF)

@end
