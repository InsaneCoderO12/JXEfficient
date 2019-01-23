//
//  JXRegular.h
//  JXEfficient
//
//  Created by augsun on 9/9/15.
//  Copyright © 2016 CoderSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXRegular : NSObject

// 验证 Pwd 满足 6-20位 的a-z A-Z 0-9组成
+ (BOOL)jx_regularPwdLength_6to20_with_aAtozZ_or_0to9:(NSString *)pwd;

// 验证 Email
+ (BOOL)jx_regularEmail:(NSString *)email;

// 验证 Url
+ (BOOL)jx_regularUrl:(NSString *)url;

// 验证正数
+ (BOOL)jx_regularPositiveNumber:(NSString *)number;

// 非负浮点数
+ (BOOL)jx_regularUnNegativeFloat:(NSString *)unNegativeFloat;

// 验证用户名 满足 6-20位 的a-z A-Z 0-9组成
+ (BOOL)jx_regularUserNameLength_3to20_with_aAtozZ_or_0to9:(NSString *)userName;

// 验证手机号
+ (BOOL)jx_regularMobile:(NSString *)mobile;

// 验证6位数字验证码
+ (BOOL)jx_regularAuthCode6:(NSString *)code6;

// 验证昵称 满足中文 大小写字母 数字
+ (BOOL)jx_regularNickName:(NSString *)nickName;

// 验证中文
+ (BOOL)jx_regularChinese:(NSString *)chinese;

// 验证是否有空格
+ (BOOL)jx_regularHaveSpace:(NSString *)string;

// 验证单个字符是否是 ASCII 码
+ (BOOL)jx_regularIsAscii:(NSString *)ascii;

// 验证是否 数字 大小写字母
+ (BOOL)jx_regularNumericAndLetter:(NSString *)string;

// 验证字母
+ (BOOL)jx_regularLetter:(NSString *)string;

// 昵称(满足中文 大小写字母 数字)的长度 (中文当两个字符, 数字 字母为一个字符)
+ (NSInteger)jx_regularLengthOfNickName:(NSString *)nickName;

// 验证 18 位身份证
+ (BOOL)jx_regularIDCard:(NSString *)idCard;

@end









