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

- (NSComparisonResult)compareToVersionString:(NSString *)version ;

- (NSString *)jx_URLEncoded;
- (NSString *)jx_URLDecoded;
- (NSString *)jx_URLDecoded_loop; // 最多进行 10 次 URLDecode

//
- (NSString *)jx_URLAddParameters:(NSDictionary *)parameters;
+ (NSDictionary *)jx_paramsForURLString:(NSString *)URL;

- (CGFloat)jx_widthForFont:(UIFont *)font;

// 12345.432 -> 12,345.432 转三位分节格式 NSNumberFormatterDecimalStyle
+ (NSString *)jx_decimalStyle:(CGFloat)num;

// 123456.40 -> 123456.4 自动去除无效小数点位
+ (NSString *)jx_priceString:(CGFloat)num;

// 123456.40 -> ￥123456.4 自动去除无效小数点位 & 添加人民币符号
+ (NSString *)jx_priceStyleString:(CGFloat)num;

// 123456.40 -> 123,456.4 自动去除无效小数点位 & NSNumberFormatterDecimalStyle样式
+ (NSString *)jx_priceDecimalString:(CGFloat)num;

// 123456.40 -> ￥123,456.4 自动去除无效小数点位 & 添加人民币符号 & NSNumberFormatterDecimalStyle样式
+ (NSString *)jx_priceDecimalStyleString:(CGFloat)num;

@end

NS_ASSUME_NONNULL_END











