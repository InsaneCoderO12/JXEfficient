//
//  JXEfficient.m
//  JXEfficient_Example
//
//  Created by augsun on 6/1/18.
//  Copyright © 2018 452720799@qq.com. All rights reserved.
//

#import "JXEfficient.h"
#import "JXInline.h"

@implementation JXEfficient

+ (NSBundle *)efficientBundle {
    static NSBundle *efficientBundle = nil;
    if (efficientBundle == nil) {
        efficientBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[JXEfficient class]] pathForResource:@"JXEfficient" ofType:@"bundle"]];
    }
    return efficientBundle;
}

+ (UIImage *)imageNamed:(NSString *)name {
    if (jx_strValue(name).length == 0) {
        return nil;
    }
    UIImage *img = [UIImage imageNamed:name inBundle:[self efficientBundle] compatibleWithTraitCollection:nil];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return img;
}

+ (UIImage *)PDFImageNamed:(NSString *)name {
    if (jx_strValue(name).length == 0) {
        return nil;
    }
    NSString *imagePath = [[self efficientBundle] pathForResource:name ofType:@"pdf"];
    UIImage *img = [UIImage jx_PDFImage:imagePath];
    return img;
}

@end
