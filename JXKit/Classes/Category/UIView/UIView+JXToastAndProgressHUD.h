//
//  UIView+JXToastAndProgressHUD.h
//  chifan
//
//  Created by augsun on 6/12/17.
//  Copyright © 2017 crland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JXToastAndProgressHUD)

// toast 提示
- (void)jx_showToast:(NSString *)toast animated:(BOOL)animated;
- (void)jx_showToast:(NSString *)toast animated:(BOOL)animated complete:(void (^)(void))complete;
- (void)jx_showToast:(NSString *)toast animated:(BOOL)animated yOffset:(CGFloat)yOffset;
- (void)jx_showToast:(NSString *)toast animated:(BOOL)animated yOffset:(CGFloat)yOffset complete:(void (^)(void))complete;

//
- (NSString *)jx_msgForHttpError:(NSError *)error defaultMsg:(NSString *)defaultMsg;

// ProgresssHUD
- (void)jx_showProgressHUD:(NSString *)title animation:(BOOL)animation;
- (void)jx_hideProgressHUD:(BOOL)animation;
- (void)hideToastImmediately;

@end
