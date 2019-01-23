//
//  JXMacro.h
//  JXEfficient
//
//  Created by augsun on 4/24/18.
//  Copyright © 2018 CoderSun. All rights reserved.
//

#import <Foundation/Foundation.h>

// ====================================================================================================
#pragma mark - (颜色)Color
// 自定义色
#define COLOR_RGBA(r, g, b, a)  [UIColor colorWithRed:(r) / 255.f green:(g) / 255.f blue:(b) / 255.f alpha:(a) / 1.f] // RGBA 颜色
#define COLOR_RGB(r, g, b)      COLOR_RGBA(r, g, b, 1.f) // RGB 颜色
#define COLOR_HEX(hexValue)     [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.f \
                                green:((float)((hexValue & 0xFF00) >> 8)) / 255.f \
                                blue:((float)(hexValue & 0xFF)) / 255.f \
                                alpha:1.f] // 十六进制 (0x9daa76)
#define COLOR_GRAY(gray)        COLOR_RGBA(gray, gray, gray, 1.f) // 灰度 [0, 255]
#define COLOR_GRAY_PERCENT(percent) COLOR_GRAY(percent * 0.01f * 255.f) // 百分比灰度 [0, 100]
#define COLOR_RANDOM            COLOR_RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256)) // 随机颜色

// 系统色
#define COLOR_SYS_SECTION           COLOR_RGB(239, 239, 244)        // (EFEFF4) section 颜色
#define COLOR_SYS_CELL_LINE         COLOR_RGB(200, 199, 204)        // (C8C7CC) cell分割线颜色
#define COLOR_SYS_CELL_SELECTION    COLOR_RGB(217, 217, 217)        // (D9D9D9) cell选中颜色
#define COLOR_SYS_BLUE              COLOR_RGB(000, 122, 255)        // (007AFF) btn 蓝色
#define COLOR_SYS_TAB_LINE          COLOR_RGB(167, 167, 170)        // (A7A7AA) tab nav 栏的横线
#define COLOR_SYS_TAB_FONT          COLOR_RGB(146, 146, 146)        // (929292) tab nav 栏的灰色字
#define COLOR_SYS_PLACEHOLDER       COLOR_RGB(199, 199, 204)        // (c7c7cc) placeholder
#define COLOR_SYS_IMG_BG            COLOR_RGB(217, 217, 217)        // (D9D9D9) 图片背景
#define COLOR_SYS_SEARCH            COLOR_RGB(200, 200, 206)        // (C8C8CE) 搜索框边上颜色

#define JX_WEAK_SELF                __weak __typeof(self) weakSelf = self
#define JX_STRONG_SELF              __strong __typeof(weakSelf) self = weakSelf

#define W_SCREEN                    [UIScreen mainScreen].bounds.size.width         // 屏幕宽
#define H_SCREEN                    [UIScreen mainScreen].bounds.size.height        // 屏幕高
#define H_STATUSBAR                 [UIApplication sharedApplication].statusBarFrame.size.height // 状态栏高
#define IS_STATUSBAR_44             (H_STATUSBAR == 44.f)                           // iPhone X
#define H_NAVBAR                    (IS_STATUSBAR_44 ? 88.f : 64.f)                 // 导航条高
#define H_TABBAR                    (IS_STATUSBAR_44 ? 83.f : 49.f)                 // 标签栏高
#define IS_320_W                    (W_SCREEN == 320.f ? YES : NO)                  // 是否是 320 宽的手机 5s
#define IS_375_W                    (W_SCREEN == 375.f ? YES : NO)                  // 是否是 375 宽的手机 6s
#define IS_414_W                    (W_SCREEN == 414.f ? YES : NO)                  // 是否是 414 宽的手机 6sP
#define IS_480_H                    (H_SCREEN == 480.f ? YES : NO)                  // 是否是 480 高的手机 4s
#define IS_568_H                    (H_SCREEN == 568.f ? YES : NO)                  // 是否是 568 高的手机 5s
#define IS_667_H                    (H_SCREEN == 667.f ? YES : NO)                  // 是否是 667 高的手机 6s
#define IS_736_H                    (H_SCREEN == 736.f ? YES : NO)                  // 是否是 736 高的手机 6sP
#define IS_812_H                    (H_SCREEN == 812.f ? YES : NO)                  // 是否是 812 高的手机 iPhone X

#define JX_DOCUMENT_DIRECTORY       [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define JX_DOCUMENT_APPEND(path)    [JX_DOCUMENT_DIRECTORY stringByAppendingPathComponent:path]
#define JX_ONE_SCREEN_PIX           (1.f / [UIScreen mainScreen].scale)             // 屏幕一个像素
#define JX_SECONDS_OF_DAY           86400                                           // 一天的秒数
#define JX_UNUSE_AREA_OF_BOTTOM     (H_TABBAR - 49.f)                               // X 底部闲置区域
#define JX_BLOCK_EXEC(block, ...)   !block ? nil : block(__VA_ARGS__)               // 执行无返回值的 block

@interface JXMacro : NSObject

@end
