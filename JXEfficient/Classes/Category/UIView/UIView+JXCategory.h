//
//  UIView+JXCategory.h
//  JXEfficient
//
//  Created by augsun on 6/2/16.
//  Copyright © 2016 CoderSun. All rights reserved.
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

- (void)jx_subviewsHidden:(BOOL)hidden; // 隐藏子视图
- (void)jx_removeAllSubviews; // 移除子视图

@end










