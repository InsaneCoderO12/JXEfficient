//
//  UIImage+JXCategory.m
//  JXEfficient
//
//  Created by augsun on 7/28/16.
//  Copyright © 2016 CoderSun. All rights reserved.
//

#import "UIImage+JXCategory.h"

@implementation UIImage (JXCategory)

+ (UIImage *)jx_imageWithColor:(UIColor *)color {
    CGSize size = CGSizeMake(3, 3);
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) resizingMode:UIImageResizingModeStretch];
    return image;
}

+ (UIImage *)jx_imageFromColor:(UIColor *)color radius:(CGFloat)radius {
    CGFloat side = radius * 2 + 1;
    CGSize size = CGSizeMake(side, side);

    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (radius > 0) {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
        CGContextAddPath(UIGraphicsGetCurrentContext(),
                         [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath
                         );
        CGContextClip(UIGraphicsGetCurrentContext());
        [image drawInRect:rect];
        
        UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        image = outputImage;
    }
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(radius, radius, radius, radius) resizingMode:UIImageResizingModeTile];
    return image;
}

+ (UIImage *)jx_imageFromColor:(UIColor *)color radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    
    CGFloat side = radius * 2 + 1;
    
    //
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, side, side)];
    view.layer.cornerRadius = radius;
    view.layer.borderWidth = borderWidth;
    view.layer.borderColor = borderColor.CGColor;
    view.backgroundColor = color;
    view.clipsToBounds = YES;
    
    //
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(side, side), NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(radius, radius, radius, radius) resizingMode:UIImageResizingModeTile];
    
    UIGraphicsEndImageContext();
    return image;
}


- (UIImage *)jx_minSideto:(CGFloat)minSize retina:(BOOL)retina {
    return [self jx_sideto:minSize max:NO retina:retina];
}

- (UIImage *)jx_maxSideto:(CGFloat)maxSize retina:(BOOL)retina {
    return [self jx_sideto:maxSize max:YES retina:retina];
}

- (UIImage *)jx_sideto:(CGFloat)size max:(BOOL)max retina:(BOOL)retina {
    size *= retina ? [UIScreen mainScreen].scale : 1;
    CGFloat wOriginal = self.size.width;
    CGFloat hOriginal = self.size.height;
    if (wOriginal <= size || hOriginal <= size) {
        return self;
    }
    else {
        CGFloat wNew;
        CGFloat hNew;
        if (wOriginal == hOriginal) {
            wNew = size;
            hNew = size;
        }
        else {
            if ((max && hOriginal > wOriginal) ||
                (!max && hOriginal < wOriginal)) {
                hNew = size;
                wNew = wOriginal * hNew / hOriginal;
            }
            else {
                wNew = size;
                hNew = hOriginal * wNew / wOriginal;
            }
        }
        UIGraphicsBeginImageContext(CGSizeMake(roundf(wNew), roundf(hNew)));
        [self drawInRect:CGRectMake(0, 0, roundf(wNew) + 1.f, roundf(hNew) + 1.f)];
        UIImage* imgScaled = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return imgScaled;
    }
}

- (UIImage *)cd_imageWithRoundedCornerAndSize:(CGSize)sizeToFit radius:(CGFloat)radius {
    CGRect rect = (CGRect){0.f, 0.f, sizeToFit};
    
    UIGraphicsBeginImageContextWithOptions(sizeToFit, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath
                     );
    CGContextClip(UIGraphicsGetCurrentContext());
    [self drawInRect:rect];
    
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

+ (UIImage *)jx_PDFImage:(id)dataOrPath {
    CGPDFDocumentRef pdf = NULL;
    if ([dataOrPath isKindOfClass:[NSData class]]) {
        CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)dataOrPath);
        pdf = CGPDFDocumentCreateWithProvider(provider);
        CGDataProviderRelease(provider);
    } else if ([dataOrPath isKindOfClass:[NSString class]]) {
        pdf = CGPDFDocumentCreateWithURL((__bridge CFURLRef)[NSURL fileURLWithPath:dataOrPath]);
    }
    if (!pdf) return nil;
    
    CGPDFPageRef page = CGPDFDocumentGetPage(pdf, 1);
    if (!page) {
        CGPDFDocumentRelease(pdf);
        return nil;
    }
    
    CGRect pdfRect = CGPDFPageGetBoxRect(page, kCGPDFCropBox);
    CGSize pdfSize = pdfRect.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(NULL, pdfSize.width * scale, pdfSize.height * scale, 8, 0, colorSpace, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    if (!ctx) {
        CGColorSpaceRelease(colorSpace);
        CGPDFDocumentRelease(pdf);
        return nil;
    }
    
    CGContextScaleCTM(ctx, scale, scale);
    CGContextTranslateCTM(ctx, -pdfRect.origin.x, -pdfRect.origin.y);
    CGContextDrawPDFPage(ctx, page);
    CGPDFDocumentRelease(pdf);
    
    CGImageRef image = CGBitmapContextCreateImage(ctx);
    UIImage *pdfImage = [[UIImage alloc] initWithCGImage:image scale:scale orientation:UIImageOrientationUp];
    CGImageRelease(image);
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    return [pdfImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (NSString *)jx_QRCodeStringFromImageOfBase64String:(NSString *)base64String {
    NSData *QRData = [[NSData alloc] initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    if (QRData.length <= 0) {
        return nil;
    }
    UIImage *image = [UIImage imageWithData:QRData];
    if (image.size.width <= 0 && image.size.height <= 0) {
        return nil;
    }
    NSString *QRCodeString = [self jx_QRCodeStringFromImage:image];
    return QRCodeString;
}

+ (NSString *)jx_QRCodeStringFromImage:(UIImage *)image {
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode
                                              context:nil
                                              options:@{
                                                        CIDetectorAccuracy: CIDetectorAccuracyHigh
                                                        }];
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    if (!ciImage) {
        return nil;
    }
    NSArray *features = [detector featuresInImage:ciImage];
    if (features.count <= 0) {
        return nil;
    }
    CIQRCodeFeature *feature = features.firstObject;
    NSString *QRCodeString = feature.messageString;
    return QRCodeString;
}

+ (UIImage *)jx_QRCodeImageFromString:(NSString *)string pt_sideLength:(CGFloat)pt_sideLength {
    CGFloat screenScale = [UIScreen mainScreen].scale;
    CGFloat px_sideLength = pt_sideLength * screenScale;
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    //
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [filter setValue:data forKeyPath:@"inputMessage"];
    CIImage *ciImage = [filter outputImage];
    
    //
    CGRect extent = CGRectIntegral(ciImage.extent);
    CGFloat scale = MIN(px_sideLength/CGRectGetWidth(extent), px_sideLength/CGRectGetHeight(extent));

    //
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    //
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    UIImage *uiImage = [UIImage imageWithCGImage:scaledImage scale:screenScale orientation:UIImageOrientationUp];
    return uiImage;
}

@end









