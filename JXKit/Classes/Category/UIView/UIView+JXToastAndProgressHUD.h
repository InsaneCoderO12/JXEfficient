//
//  UIView+JXToastAndProgressHUD.h
//  chifan
//
//  Created by augsun on 6/12/17.
//  Copyright © 2017 crland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JXToastAndProgressHUD)

#pragma mark Toast

// toast 样式
+ (void)jx_toastStyleBgColor:(UIColor *)bgColor;
+ (void)jx_toastStyleTextColor:(UIColor *)textColor;
+ (void)jx_toastStyleResetToDefault;

// toast 提示
- (void)jx_showToast:(NSString *)toast animated:(BOOL)animated;
- (void)jx_showToast:(NSString *)toast animated:(BOOL)animated complete:(void (^)(void))complete;
- (void)jx_showToast:(NSString *)toast animated:(BOOL)animated yOffset:(CGFloat)yOffset;
- (void)jx_showToast:(NSString *)toast animated:(BOOL)animated yOffset:(CGFloat)yOffset complete:(void (^)(void))complete;

#pragma mark ProgresssHUD

// ProgresssHUD 样式
+ (void)jx_progressHUDStyleBgColor:(UIColor *)bgColor;
+ (void)jx_progressHUDStyleTextColor:(UIColor *)textColor;
+ (void)jx_progressHUDStyleActivityIndicatorColor:(UIColor *)activityIndicatorColor;
+ (void)jx_progressHUDStyleResetToDefault;

// ProgresssHUD
- (void)jx_showProgressHUD:(NSString *)title animation:(BOOL)animation;
- (void)jx_hideProgressHUD:(BOOL)animation;
- (BOOL)jx_progressHUDShowing; // 当前页面是否正在显示 ProgresssHUD

@end










