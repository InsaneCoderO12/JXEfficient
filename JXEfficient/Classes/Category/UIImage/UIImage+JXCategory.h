//
//  UIImage+JXCategory.h
//  JXEfficient
//
//  Created by augsun on 7/28/16.
//  Copyright © 2016 CoderSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JXCategory)

// 纯色直角图片 且 UIImageResizingModeStretch 且 scale 边为 3pt
+ (UIImage *)jx_imageWithColor:(UIColor *)color;

// 纯色圆角图片 且 UIImageResizingModeStretch 且 scale 边为 (radius * 2 + 1) 圆角为 radius
+ (UIImage *)jx_imageFromColor:(UIColor *)color radius:(CGFloat)radius;

// 纯色带描边图片 且 UIImageResizingModeStretch 且 scale 边为 (radius * 2 + 1) 圆角为 radius 描边宽 borderWidth 描边颜色 borderColor
+ (UIImage *)jx_imageFromColor:(UIColor *)color radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

// 按比例重置图片尺寸 minSize 为期望的最小边长 retina 为是否为 minSize 的 2x 或 3x
- (UIImage *)jx_minSideto:(CGFloat)minSize retina:(BOOL)retina; // 按比例压至小边为 minSize
- (UIImage *)jx_maxSideto:(CGFloat)maxSize retina:(BOOL)retina; // 按比例压至大边为 maxSize

// 圆角图片
- (UIImage *)cd_imageWithRoundedCornerAndSize:(CGSize)sizeToFit radius:(CGFloat)radius;

+ (UIImage *)jx_PDFImage:(id)dataOrPath;

// QRCode
+ (NSString *)jx_QRCodeStringFromImageOfBase64String:(NSString *)base64String; // 根据 base64 编码后的二维码 返回二维码字符串
+ (NSString *)jx_QRCodeStringFromImage:(UIImage *)image; // 根据图片 返回二维码字符串
+ (UIImage *)jx_QRCodeImageFromString:(NSString *)string pt_sideLength:(CGFloat)pt_sideLength; // 指定边长返回二维码图片

@end
