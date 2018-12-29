//
//  UIButton+JXCategory.h
//  mixc
//
//  Created by augsun on 9/8/17.
//  Copyright © 2017 crland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (JXCategory)

- (void)jx_backgroundColorStyleNormalColor:(UIColor *)normalColor
                          highlightedColor:(UIColor *)highlightedColor
                             disabledColor:(UIColor *)disabledColor
                                    radius:(CGFloat)radius;

- (void)jx_titleColorStyleNormalColor:(UIColor *)normalColor
                     highlightedColor:(UIColor *)highlightedColor
                        disabledColor:(UIColor *)disabledColor;

- (void)jx_titleForAllStatus:(NSString *)title;


@end
