//
//  UIColor+JXCategory.h
//  JXEfficient
//
//  Created by augsun on 1/21/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (JXCategory)

// @"BBDD10" -> UIColor
+ (nullable UIColor *)jx_colorFromHEXString:(NSString *)HEXString;

@end

NS_ASSUME_NONNULL_END
