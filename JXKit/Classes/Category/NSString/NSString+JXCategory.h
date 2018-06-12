//
//  NSString+JXCategory.h
//  mixc
//
//  Created by augsun on 8/3/16.
//  Copyright © 2016 crland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JXCategory)

@property (readonly) NSString *jx_md5String;

// 数字字符串转三位分节格式 如: [12345 -> 12,345]
- (NSString *)jx_decimalStyle;

- (NSComparisonResult)compareToVersionString:(NSString *)version ;

- (NSString *)jx_URLEncoded;
- (NSString *)jx_URLDecoded;

//
- (NSString *)jx_URLAddParameters:(NSDictionary *)parameters;

- (CGFloat)jx_widthForFont:(UIFont *)font;

// 3.40 -> 3.4 | 6.00 -> 6
- (NSString *)priceString:(CGFloat)num;

// 3.4 -> ￥3.4
- (NSString *)priceStyleString:(CGFloat)num;

@end

NS_ASSUME_NONNULL_END
