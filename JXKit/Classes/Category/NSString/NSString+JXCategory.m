//
//  NSString+JXCategory.m
//  mixc
//
//  Created by augsun on 8/3/16.
//  Copyright © 2016 crland. All rights reserved.
//

#import "NSString+JXCategory.h"
#import <CommonCrypto/CommonDigest.h>
#import "JXInline.h"

@implementation NSString (JXCategory)

- (NSString *)jx_md5String {
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [mutableString appendFormat:@"%02x", bytes[i]];
    }
    return [NSString stringWithString:mutableString];

}

- (NSComparisonResult)compareToVersionString:(NSString *)version {

    NSMutableArray *leftFields  = [[NSMutableArray alloc] initWithArray:[self  componentsSeparatedByString:@"."]];
    NSMutableArray *rightFields = [[NSMutableArray alloc] initWithArray:[version componentsSeparatedByString:@"."]];
    
    if ([leftFields count] < [rightFields count]) {
        while ([leftFields count] != [rightFields count]) {
            [leftFields addObject:@"0"];
        }
    } else if ([leftFields count] > [rightFields count]) {
        while ([leftFields count] != [rightFields count]) {
            [rightFields addObject:@"0"];
        }
    }
    
    for (NSUInteger i = 0; i < [leftFields count]; i++) {
        NSComparisonResult result = [[leftFields objectAtIndex:i] compare:[rightFields objectAtIndex:i] options:NSNumericSearch];
        if (result != NSOrderedSame) {
            return result;
        }
    }
    
    return NSOrderedSame;
}

- (NSString *)jx_URLEncoded {
    NSString *charactersToEscape = @"!*'();:@&=+$,/?%#[]";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedUrl = [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodedUrl;

    // deprecated in iOS 9.0
//    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
//                                                                                 (CFStringRef)self,
//                                                                                 NULL,
//                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
//                                                                                 kCFStringEncodingUTF8));
}

- (NSString *)jx_URLDecoded {
    NSString *decoded = [self stringByRemovingPercentEncoding];
    return decoded;
    
    // deprecated in iOS 9.0
//    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
//                                                                                                 (__bridge CFStringRef)self,
//                                                                                                 CFSTR(""),
//                                                                                                 CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
}

- (NSString *)jx_URLDecoded_loop {
    BOOL didRight = NO;
    NSString *preStr = self;
    for (NSInteger i = 0; i < 10; i ++) {
        NSString *nowStr = [preStr jx_URLDecoded];
        didRight = [nowStr isEqualToString:preStr];
        if (didRight) {
            break;
        }
        else {
            preStr = nowStr;
        }
    }
    return preStr;
}

- (NSString *)jx_URLAddParameters:(NSDictionary *)parameters {
    if (!parameters || parameters.allKeys.count == 0) {
        return self;
    }
    NSURLComponents *comps = [NSURLComponents componentsWithString:self];
    if (!comps) {
        return self;
    }
    
    // haveURLTypeQueryItems 为解决如下问题:
    // 当 URL 里含有 URLEncode 过的 URL 样式的参数, 解决 NSURLComponents.URL.absoluteString 返回时对该参数部分 URLDecode 的问题
    // 如
    // https://app.mixcapp.com/h5/share/templates/shop.html?shopId=L0124N03&mallNo=1102A001&mixcNativeUrl=mixc%3a%2f%2fapp%2fshopDetail%3fshopId%3dL0124N03
    // 返回时 变成
    // https://app.mixcapp.com/h5/share/templates/shop.html?shopId=L0124N03&mallNo=1102A001&mixcNativeUrl=mixc://app/shopDetail?shopId%3DL0124N03&appVersion=2.3.2&mallNo=410100A001&timestamp=1516858139577
    // 即
    // mixc%3a%2f%2fapp%2fshopDetail%3fshopId%3dL0124N03 -> mixc://app/shopDetail?shopId%3DL0124N03

    NSMutableDictionary *tempURLEncodedParams = [[NSMutableDictionary alloc] init]; // 存放需要单独 URLEncoded 的参数
    
    // 分析 URL 中的参数
    NSMutableArray <NSURLQueryItem *> *tempItems = [[NSMutableArray alloc] init];
    for (NSURLQueryItem *itemEnum in comps.queryItems) {
        NSString *name = itemEnum.name;
        NSString *value = itemEnum.value;
        
        // 参数值中满足以下条件需要单独 URLEncoded <注: 解析出来已经是 URLDecoded, 下面再次独立进行 URLEncoded 拼接>
        if (
//            [value hasPrefix:@"http://"] ||
//            [value hasPrefix:@"https://"] ||
            [value hasPrefix:@"mixc://"]
            ) {
            tempURLEncodedParams[name] = value;
        }
        else {
            NSURLQueryItem *queryItem  = [[NSURLQueryItem alloc] initWithName:name value:value];
            [tempItems addObject:queryItem];
        }
    }
    
    // 添加的参数
    for (NSString *keyEnum in parameters.allKeys) {
        NSString *dicKey = strValue(keyEnum);
        NSString *dicObj = parameters[keyEnum];
        
        if (!dicKey || !dicObj) {
            continue;
        }
        
        // 参数值有 Encoded 过的需要先 URLDecoded <注: 下面再次独立进行 URLEncoded 拼接>
        NSString *URLDecoded = [dicObj jx_URLDecoded_loop];
        if (![dicObj isEqualToString:URLDecoded]) {
            tempURLEncodedParams[dicKey] = URLDecoded;
        }
        else {
            NSURLQueryItem *item = [NSURLQueryItem queryItemWithName:dicKey value:dicObj];
            [tempItems addObject:item];
        }

    }

    //
    comps.queryItems = [tempItems copy];
    
    // <独立进行 URLEncoded 拼接>
    BOOL needExtraAppend = tempURLEncodedParams.allKeys.count > 0;
    if (needExtraAppend) {
        NSMutableString *tempURL = [comps.URL.absoluteString mutableCopy];
        if (!tempURL) {
            return nil;
        }
        for (NSDictionary *keyEnum in tempURLEncodedParams) {
            NSString *key = strValue(keyEnum);
            NSString *value = strValue(tempURLEncodedParams[keyEnum]);
            value = [value jx_URLEncoded];
            if (key && value) {
                NSString *param = [NSString stringWithFormat:@"&%@=%@", key, value];
                [tempURL appendString:param];
            }
        }
        return tempURL;
    }
    else {
        return comps.URL.absoluteString;
    }
}

+ (NSDictionary *)jx_paramsForURLString:(NSString *)URL {
    NSURLComponents *comps = [NSURLComponents componentsWithString:URL];
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
    for (NSURLQueryItem *itemEnum in comps.queryItems) {
        tempDic[itemEnum.name] = itemEnum.value;
    }
    return [tempDic copy];
}

- (CGFloat)jx_widthForFont:(UIFont *)font {
    
    CGSize size = CGSizeMake(HUGE, HUGE);
    NSLineBreakMode lineBreakMode = NSLineBreakByWordWrapping;
    
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result.width;
}

+ (NSString *)jx_decimalStyle:(CGFloat)num {
    return [NSNumberFormatter localizedStringFromNumber:@(num) numberStyle:NSNumberFormatterDecimalStyle];
}

+ (NSString *)jx_priceString:(CGFloat)num {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.minimumIntegerDigits = 1;
    formatter.maximumFractionDigits = 2;
    formatter.minimumFractionDigits = 0;
    return [formatter stringFromNumber:@(num)];
}

+ (NSString *)jx_priceStyleString:(CGFloat)num {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.minimumIntegerDigits = 1;
    formatter.maximumFractionDigits = 2;
    formatter.minimumFractionDigits = 0;
    formatter.positivePrefix = @"¥";
    formatter.negativePrefix = @"¥";
    return [formatter stringFromNumber:@(num)];
}

+ (NSString *)jx_priceDecimalString:(CGFloat)num {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.minimumIntegerDigits = 1;
    formatter.maximumFractionDigits = 2;
    formatter.minimumFractionDigits = 0;
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    return [formatter stringFromNumber:@(num)];
}

+ (NSString *)jx_priceDecimalStyleString:(CGFloat)num {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.minimumIntegerDigits = 1;
    formatter.maximumFractionDigits = 2;
    formatter.minimumFractionDigits = 0;
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.positivePrefix = @"¥";
    formatter.negativePrefix = @"¥";
    return [formatter stringFromNumber:@(num)];
}

@end










