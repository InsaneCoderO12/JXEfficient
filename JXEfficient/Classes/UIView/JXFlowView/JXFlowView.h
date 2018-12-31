//
//  MCFlowView.h
//  mixc
//
//  Created by augsun on 9/10/18.
//  Copyright © 2018 crland. All rights reserved.
//

#import <UIKit/UIKit.h>

// ====================================================================================================
@interface MCFlowLayout : NSObject

@property (nonatomic, assign) CGFloat kEdgeT; // 边距
@property (nonatomic, assign) CGFloat kEdgeL;
@property (nonatomic, assign) CGFloat kEdgeB;
@property (nonatomic, assign) CGFloat kEdgeR;

@property (nonatomic, assign) CGFloat kLineGap; // 行间距 (上下间距)
@property (nonatomic, assign) CGFloat kInterGap; // 竖间距 (左右间距)

@property (nonatomic, assign) CGFloat kTitleToL; // 标题距左
@property (nonatomic, assign) CGFloat kTitleToR; // 标题距右

@property (nonatomic, assign) UIFont *titleFont; // 字体

@property (nonatomic, assign) CGFloat itemHeight; // item 高
@property (nonatomic, assign) CGFloat inWidth; // 在多宽范围内布局

@property (nonatomic, assign) CGFloat itemMaxWidth; // item 的最大宽度

@end

// ====================================================================================================
@interface MCFlowItemModel : NSObject

@property (nonatomic, assign) NSString *itemTitle;
@property (nonatomic, assign) CGFloat itemWidth;

@end

// ====================================================================================================
// 子类必须继承自 MCFlowItemView 必须是 xib
@interface MCFlowItemView : UIView

@end

// ====================================================================================================
@interface JXFlowView : UIView

+ (instancetype)flowView; // 指定初始化器

// 在 inWidth 宽度下模型化行列存放 同时计算 wCell
+ (NSArray <NSArray <MCFlowItemModel *> *> *)itemWidthsFromStrings:(NSArray <NSString *> *)strings withLayout:(MCFlowLayout *)layout;

// 计算行列后的总高度
+ (CGFloat)heightForItems:(NSArray <NSArray <MCFlowItemModel *> *> *)itemWidths withLayout:(MCFlowLayout *)layout;

// 刷新
@property (nonatomic, strong) Class itemNibClass; // item 的 View 必须是 xib
@property (nonatomic, strong) MCFlowLayout *layout; // 样式布局

@property (nonatomic, copy) NSArray <NSArray <MCFlowItemModel *> *> *itemModels;
@property (nonatomic, copy) void (^viewForIndex)(__kindof MCFlowItemView *itemView, NSInteger index); // 回调进行赋值刷新

@end

















