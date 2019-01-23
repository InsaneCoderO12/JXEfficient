//
//  NSString+JXCategory.h
//  JXEfficient
//
//  Created by augsun on 8/3/16.
//  Copyright © 2016 CoderSun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JXCategory)

@property (readonly) NSString *jx_md5String;

- (NSComparisonResult)compareToVersionString:(NSString *)version ;

- (NSString *)jx_URLEncoded;
- (NSString *)jx_URLDecoded;
- (NSString *)jx_URLDecoded_loop; // URLDecoded 直到全部被 Decoded, 最多进行 10 次 URLDecode

//
- (NSString *)jx_URLAddParameters:(NSDictionary *)parameters; // 给 URLString 添加参数
+ (NSDictionary *)jx_paramsForURLString:(NSString *)URL; // 取得 URLString 里的参数

- (CGFloat)jx_widthForFont:(UIFont *)font;

#pragma mark 浮点数
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

#pragma mark 其它
- (NSString *)jx_stringByTrimmingWhitespaceAndNewlineCharacter; // 修剪掉 前后 空格和回车

@end

NS_ASSUME_NONNULL_END











