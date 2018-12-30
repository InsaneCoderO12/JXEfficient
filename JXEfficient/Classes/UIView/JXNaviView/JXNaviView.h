//
//  JXNaviView.h
//  mixc
//
//  Created by augsun on 8/28/17.
//  Copyright © 2017 crland. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 JXNaviView 的布局:
        返回按钮            左边按钮           标题             右边子按钮             右边按钮
 < -- backButton -- | -- leftButton-- | -- title -- | -- rightSubButton -- | -- rightButton -- >
 
 */

@interface JXNaviView : UIView

@property (nonatomic, assign) BOOL bgColorStyle; // 背景样式 def. NO (标题按钮控件置白色) <YES 时 内部文字控件反白, NO 时 内部文字控件为 defaultStyleTitleColor 颜色>
@property (nonatomic, strong) UIColor *defaultStyleTitleColor; // bgColorStyle = NO 时生效 的标题颜色 (不设置默认为 0x333333)

@property (nonatomic, assign) BOOL backButtonHidden; // 返回按钮 def. NO <默认显示返回按钮>
@property (nonatomic, copy) void (^backClick)(void);

@property (nonatomic, copy) NSString *title; // 标题def. nil, 设置为 nil 隐藏

@property (nonatomic, assign) BOOL bottomLineHidden; // 底部线 def. YES <默认隐藏>
@property (nonatomic, strong) UIColor *bottomLineColor;

// leftButton rightButton rightSubButton 默认隐藏
@property (nonatomic, copy) NSString *leftButtonTitle; // 标题按钮 (最长 4 个中文字)
@property (nonatomic, strong) UIImage *leftButtonImage; // 图片按钮
@property (nonatomic, copy) void (^leftButtonTap)(void); // 事件回调
@property (nonatomic, assign) BOOL leftButtonHidden; // 是否隐藏按钮

@property (nonatomic, copy) NSString *rightButtonTitle; // 最右边按钮 同上
@property (nonatomic, strong) UIImage *rightButtonImage;
@property (nonatomic, copy) void (^rightButtonTap)(void);
@property (nonatomic, assign) BOOL rightButtonHidden;

@property (nonatomic, copy) NSString *rightSubButtonTitle; // 右二按钮 同上
@property (nonatomic, strong) UIImage *rightSubButtonImage;
@property (nonatomic, copy) void (^rightSubButtonTap)(void);
@property (nonatomic, assign) BOOL rightSubButtonHidden;

+ (instancetype)createFromXib; // 指定初始化方法

@end










