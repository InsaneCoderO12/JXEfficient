//
//  JXInline.h
//  AFNetworking
//
//  Created by augsun on 4/24/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JXRegular.h"

static inline BOOL jx_isNullOrNil(id obj) {
    return !obj || [obj isKindOfClass:[NSNull class]] ? YES : NO;
}

// 是否 NSString 或 NSNumber
static inline BOOL jx_isStringOrNumber(id obj) {
    return [obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]];
}

// 是否 NSString
static inline BOOL jx_isStrObj(id obj) {
    return [obj isKindOfClass:[NSString class]] ? YES : NO;
}

// 是否 NSNumber
static inline BOOL jx_isNumObj(id obj) {
    return [obj isKindOfClass:[NSNumber class]] ? YES : NO;
}
// 是否 NSDictionary
static inline BOOL jx_isDicObj(id obj) {
    return [obj isKindOfClass:[NSDictionary class]] ? YES : NO;
}

// 是否 NSArray
static inline BOOL jx_isArrObj(id obj) {
    return [obj isKindOfClass:[NSArray class]] ? YES : NO;
}

// 2个字符串拼接 (可传入 NSString NSNumber)
static inline NSString *jx_strCat2(id value0, id value1) {
    return [NSString stringWithFormat:@"%@%@", jx_isStringOrNumber(value0) ? value0 : @"", jx_isStringOrNumber(value1) ? value1 : @""];
}

// 3个字符串拼接 (可传入 NSString NSNumber)
static inline NSString *jx_strCat3(id value0, id value1, id value2) {
    return jx_strCat2(jx_strCat2(value0, value1), jx_isStringOrNumber(value2) ? value2 : @"");
}

// 转 NSInteger
static inline NSInteger jx_intValue(id value) {
    return jx_isStringOrNumber(value) ? [value integerValue] : 0;
}

// 转 NSString
static inline NSString *jx_strValue(id value) {
    return jx_isStringOrNumber(value) ? [NSString stringWithFormat:@"%@", value] : nil;
}

// 转 NSUInteger
static inline NSUInteger jx_uIntValue(id value) {
    NSInteger num = jx_intValue(value);
    return num < 0 ? 0 : num;
}

// 转 long long
static inline long long jx_longlongValue(id value) {
    return jx_isStringOrNumber(value) ? [value longLongValue] : 0;
}

// 转 CGFloat
static inline CGFloat jx_floValue(id value) {
    return jx_isStringOrNumber(value) ? [value floatValue] : 0;
}

// 转 BOOL
static inline BOOL jx_booValue(id value) {
    return jx_isStringOrNumber(value) ? [value boolValue] : 0;
}

static inline BOOL jx_isHaveChinese(NSString *string) {
    for(int i = 0; i < string.length; i++){
        int a = [string characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

// 转 NSURL <目前以判断 value 中有中文为其进行 PercentEncoding<URLQueryAllowedCharacterSet> 转换>
// 需要对 URL 中所有部分进行编码 使用 URLEncodedString()
static inline NSURL *jx_URLValue(id value) {
    NSURL *tempURL = nil;
    if ([value isKindOfClass:[NSURL class]]) {
        tempURL = (NSURL *)value;
    }
    else if ([value isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)value;
        if (string.length > 0) {
            BOOL haveChinese = jx_isHaveChinese(string);
            if (haveChinese) {
                NSString *encodedString = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                if (encodedString.length > 0) {
                    tempURL = [NSURL URLWithString:encodedString];
                }
            }
            else {
                tempURL = [NSURL URLWithString:string];
            }
        }
    }
    return tempURL;
}

// 转 URLString <目前以判断 value 中有中文为其进行 PercentEncoding<URLQueryAllowedCharacterSet> 转换>
// 需要对 URL 中所有部分进行编码 使用 URLEncodedString()
static inline NSString *jx_URLStringValue(id value) {
    NSString *tempURLString = nil;
    if ([value isKindOfClass:[NSURL class]]) {
        NSURL *URL = (NSURL *)value;
        tempURLString = URL.absoluteString;
    }
    else if ([value isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)value;
        BOOL haveChinese = jx_isHaveChinese(string);
        if (haveChinese) {
            tempURLString = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        }
        else {
            tempURLString = string;
        }
    }
    return tempURLString;
}

static NSString *const jx_kPercentEncodingCharacters = @"!*'();:@&=+$,/?%#[]";
// 编码 URLEncodedString <强制对 kPercentEncodingCharacters 进行 PercentEncoding 转换>
static inline NSString *URLEncodedString(id value) {
    NSString *tempEncoded = nil;
    if ([value isKindOfClass:[NSURL class]]) {
        NSURL *URL = (NSURL *)value;
        tempEncoded = URL.absoluteString;
    }
    else if ([value isKindOfClass:[NSString class]]) {
        tempEncoded = (NSString *)value;
    }
    
    if (tempEncoded) {
        NSString *charactersToEscape = jx_kPercentEncodingCharacters;
        NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
        tempEncoded = [tempEncoded stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    }
    return tempEncoded;
}

// 解码 URLDecodedString
static inline NSString *jx_URLDecodedString(id value) {
    NSString *tempDecoded = nil;
    if ([value isKindOfClass:[NSURL class]]) {
        NSURL *URL = (NSURL *)value;
        tempDecoded = URL.absoluteString;
    }
    else if ([value isKindOfClass:[NSString class]]) {
        tempDecoded = (NSString *)value;
    }
    
    if (tempDecoded) {
        tempDecoded = [tempDecoded stringByRemovingPercentEncoding];
    }
    return tempDecoded;
}

// 转 NSDictionary
static inline NSDictionary *jx_dicValue(id value) {
    return [value isKindOfClass:[NSDictionary class]] ? value : nil;
}

// 转 NSArray
static inline NSArray *jx_arrValue(id value) {
    return [value isKindOfClass:[NSArray class]] ? value : nil;
}

@interface JXInline : NSObject

@end
