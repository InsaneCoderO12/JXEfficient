//
//  UIView+JXCategory.h
//  ShiBa
//
//  Created by shiba_iosJX on 6/2/16.
//  Copyright © 2016 ShiBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JXCategory)

// 从 xib 取得 view
+ (instancetype)jx_createFromXib;
+ (instancetype)jx_createFromXibInBundle:(NSBundle *)bundle;

+ (instancetype)jx_createFromXibWithFrame:(CGRect)frame;
+ (instancetype)jx_createFromXibWithFrame:(CGRect)frame inBundle:(NSBundle *)bundle;

// 快速(设置或取得) view 的坐标
@property (nonatomic, assign)   CGFloat     jx_x;
@property (nonatomic, assign)   CGFloat     jx_y;
@property (nonatomic, assign)   CGFloat     jx_width;
@property (nonatomic, assign)   CGFloat     jx_height;
@property (nonatomic, assign)   CGPoint     jx_origin;
@property (nonatomic, assign)   CGSize      jx_size;
@property (nonatomic, assign)   CGFloat     jx_centerX;
@property (nonatomic, assign)   CGFloat     jx_bottom;
@property (nonatomic, assign)   CGFloat     jx_right;

//#pragma mark 消息弹窗提示
//// 普通消息 动画
//- (void)jx_showMsg:(NSString *)msg animated:(BOOL)animated;
//
//// 普通消息 动画 结束回调
//- (void)jx_showMsg:(NSString *)msg animated:(BOOL)animated complete:(void (^)(void))complete;
//
//// 网络错误消息 动画
//- (void)jx_showHttpError:(NSError *)error msg:(NSString *)msg animated:(BOOL)animated;
//
//// 普通消息 动画 y偏移
//- (void)jx_showMsg:(NSString *)msg animated:(BOOL)animated yLocation:(CGFloat)yLocation;
//
//// 普通消息 动画 y偏移 动画结束回调
//- (void)jx_showMsg:(NSString *)msg animated:(BOOL)animated yLocation:(CGFloat)yLocation complete:(void (^)(void))complete;
//
//// 网络错误消息 动画 y偏移
//- (void)jx_showHttpError:(NSError *)error msg:(NSString *)msg animated:(BOOL)animated yLocation:(CGFloat)yLocation;
//
//// 隐藏提示
//- (void)jx_hideMsg;

#pragma mark progresssHUD 
//- (void)jx_showProgressHUD:(NSString *)title animation:(BOOL)animation;
//- (void)jx_hideProgressHUD:(BOOL)animation;

- (void)jx_subviewsHidden:(BOOL)hidden; // 隐藏子视图
- (void)jx_removeAllSubviews; // 移除子视图

@end










