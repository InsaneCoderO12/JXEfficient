//
//  MCFlowView.m
//  mixc
//
//  Created by augsun on 9/10/18.
//  Copyright © 2018 crland. All rights reserved.
//

#import "JXFlowView.h"
#import "JXInline.h"
#import "UIView+JXCategory.h"
#import "JXMacro.h"
#import "JXEfficient.h"

@implementation MCFlowLayout

@end

@implementation MCFlowItemModel

@end

@implementation MCFlowItemView

@end

@interface JXFlowView ()

@property (nonatomic, strong) NSMutableArray <MCFlowItemView *> *itemViews;

@end

@implementation JXFlowView

+ (instancetype)flowView {
    return [JXFlowView jx_createFromXibInBundle:[JXEfficient efficientBundle]];
}

- (NSMutableArray<MCFlowItemView *> *)itemViews {
    if (!_itemViews) {
        _itemViews = [[NSMutableArray alloc] init];
    }
    return _itemViews;
}

+ (NSArray<NSArray<MCFlowItemModel *> *> *)itemWidthsFromStrings:(NSArray<NSString *> *)strings withLayout:(MCFlowLayout *)layout {
    
    //
    if (strings.count == 0) {
        return nil;
    }
    
    // 先全部模型化 计算宽度
    NSMutableArray <MCFlowItemModel *> *tempArr = [[NSMutableArray alloc] init];
    for (NSString *stringEnum in strings) {
        NSString *cardName = jx_strValue(stringEnum);
        if (cardName.length > 0) {
            MCFlowItemModel *model = [[MCFlowItemModel alloc] init];
            model.itemTitle = stringEnum;
            model.itemWidth = [self widthForItemModel:model withLayout:layout];
            [tempArr addObject:model];
        }
    }
    
    // 行列存放
    NSMutableArray <NSArray <MCFlowItemModel *> *> *items = [[NSMutableArray alloc] init];
    
    CGFloat leftW = layout.inWidth - layout.kEdgeL - layout.kEdgeR;
    NSMutableArray <MCFlowItemModel *> *rows = [[NSMutableArray alloc] init];
    
    for (MCFlowItemModel *modelEnum in tempArr) {
        CGFloat addW = modelEnum.itemWidth + (rows.count == 0 ? 0 : layout.kInterGap);
        if (leftW > addW) {
            leftW -= addW;
            [rows addObject:modelEnum];
        }
        else {
            [items addObject:rows];
            rows = [[NSMutableArray alloc] init];
            leftW = layout.inWidth - layout.kEdgeL - layout.kEdgeR - modelEnum.itemWidth;
            [rows addObject:modelEnum];
        }
    }
    
    if (rows.count > 0) {
        [items addObject:rows];
    }
    
    return items;
}

+ (CGFloat)widthForItemModel:(MCFlowItemModel *)model withLayout:(MCFlowLayout *)layout {
    CGSize size = CGSizeMake(CGFLOAT_MAX, layout.itemHeight);
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName: layout.titleFont,
                                 };
    
    CGFloat itemWidth = [model.itemTitle boundingRectWithSize:size
                                                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                   attributes:attributes
                                                      context:nil].size.width + 1.f;
    
    itemWidth = itemWidth > layout.itemMaxWidth ? layout.itemMaxWidth : itemWidth;
    CGFloat wItem = layout.kTitleToL + itemWidth + layout.kTitleToR;
    return wItem;
}

+ (CGFloat)heightForItems:(NSArray<NSArray<MCFlowItemModel *> *> *)itemWidths withLayout:(MCFlowLayout *)layout {
    if (itemWidths.count == 0) {
        return 0.f;
    }
    
    CGFloat lines = itemWidths.count;
    CGFloat h = layout.kEdgeT + lines * (layout.itemHeight + layout.kLineGap) - layout.kLineGap + layout.kEdgeB;
    return h;
}

- (void)setItemModels:(NSArray<NSArray<MCFlowItemModel *> *> *)itemModels {
    _itemModels = itemModels;
    
    CGFloat totalCount = 0;
    for (NSArray <MCFlowItemModel *> *rowEnum in itemModels) {
        totalCount += rowEnum.count;
    }

    Class aClass = self.itemNibClass;
    if (!aClass) {
        aClass = [MCFlowItemView class];
    }

    if (self.itemViews.count < totalCount) {
        NSInteger add = totalCount - self.itemViews.count;
        for (NSInteger i = 0; i < add; i ++) {
            MCFlowItemView *itemView = [aClass jx_createFromXib];
            [self addSubview:itemView];
            [self.itemViews addObject:itemView];
        }
    }
    else if (self.itemViews.count > totalCount) {
        for (NSInteger i = totalCount; i < self.itemViews.count; i ++) {
            MCFlowItemView *itemView = self.itemViews[i];
            itemView.hidden = YES;
        }
    }
    
    // 布局
    NSInteger index = 0;
    NSInteger row = 0;
    CGFloat x = 0.f;
    for (NSArray <MCFlowItemModel *> *rowEnum in self.itemModels) {
        for (MCFlowItemModel *modelEnum in rowEnum) {
            MCFlowItemView *itemView = self.itemViews[index];
            
            JX_BLOCK_EXEC(self.viewForIndex, itemView, index);
            
            CGFloat y = row * (self.layout.itemHeight + self.layout.kLineGap);
            
            //
            itemView.translatesAutoresizingMaskIntoConstraints = NO;
            
            // L R
            [self addConstraints:@[
                                   [NSLayoutConstraint constraintWithItem:itemView
                                                                attribute:NSLayoutAttributeLeft
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeLeft
                                                               multiplier:1.f
                                                                 constant:x],
                                   [NSLayoutConstraint constraintWithItem:itemView
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1.f
                                                                 constant:y],
                                   ]
             ];
            
            // W H
            [itemView addConstraints:@[
                                       [NSLayoutConstraint constraintWithItem:itemView
                                                                    attribute:NSLayoutAttributeWidth
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil
                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1.f
                                                                     constant:modelEnum.itemWidth],
                                       [NSLayoutConstraint constraintWithItem:itemView
                                                                    attribute:NSLayoutAttributeHeight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil
                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1.f
                                                                     constant:self.layout.itemHeight],
                                       ]
             ];
            
            itemView.hidden = NO;
            
            x+= (self.layout.kInterGap + modelEnum.itemWidth);
            
            index ++;
        }
        
        row ++;
        x = 0.f;
    }
}

@end











