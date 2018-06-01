//
//  UIView+JXCategory.m
//  ShiBa
//
//  Created by shiba_iosJX on 6/2/16.
//  Copyright © 2016 ShiBa. All rights reserved.
//

#import "UIView+JXCategory.h"
#import "UIView+JXToastAndProgressHUD.h"

@implementation UIView (JXCategory)

#pragma mark createFromXib
+ (instancetype)jx_createFromXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+ (instancetype) jx_createFromXibInBundle:(NSBundle *)bundle {
    if (bundle == nil) {
        bundle = [NSBundle mainBundle];
    }
    return [[bundle loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+ (instancetype)jx_createFromXibWithFrame:(CGRect)frame {
    UIView *view = [self jx_createFromXib];
    view.frame = frame;
    return view;
}

+ (instancetype)jx_createFromXibWithFrame:(CGRect)frame inBundle:(NSBundle *)bundle {
    UIView *view = [self  jx_createFromXibInBundle:bundle];
    view.frame = frame;
    return view;
}

#pragma mark getter setter
- (CGFloat)jx_x { return self.frame.origin.x; }
- (void)setJx_x:(CGFloat)jx_x { CGRect rect = self.frame; rect.origin.x = jx_x; self.frame = rect; }

- (CGFloat)jx_y { return self.frame.origin.y; }
- (void)setJx_y:(CGFloat)jx_y { CGRect rect = self.frame; rect.origin.y = jx_y; self.frame = rect; }

- (CGFloat)jx_width { return self.frame.size.width; }
- (void)setJx_width:(CGFloat)jx_width { CGRect rect = self.frame; rect.size.width = jx_width; self.frame = rect; }

- (CGFloat)jx_height { return self.frame.size.height; }
- (void)setJx_height:(CGFloat)jx_height { CGRect rect = self.frame; rect.size.height = jx_height; self.frame = rect; }

- (CGPoint)jx_origin { return self.frame.origin; }
- (void)setJx_origin:(CGPoint)jx_origin { CGRect rect = self.frame; rect.origin = jx_origin; self.frame = rect; }

- (CGSize)jx_size { return self.frame.size; }
- (void)setJx_size:(CGSize)jx_size { CGRect rect = self.frame; rect.size = jx_size; self.frame = rect; }

-(CGFloat)jx_centerX { return self.center.x; }
- (void)setJx_centerX:(CGFloat)jx_centerX { self.center = CGPointMake(jx_centerX, self.center.y); }

- (CGFloat)jx_bottom { return self.frame.origin.y + self.frame.size.height; }
- (void)setJx_bottom:(CGFloat)bottom { CGRect frame = self.frame; frame.origin.y = bottom - frame.size.height; self.frame = frame; }

- (CGFloat)jx_right { return self.frame.origin.x + self.frame.size.width; }
- (void)setJx_right:(CGFloat)jx_right { CGRect frame = self.frame; frame.origin.x = jx_right - frame.size.width; self.frame = frame; }




#pragma mark 消息弹窗提示
- (void)jx_showMsg:(NSString *)msg animated:(BOOL)animated {
    [self jx_showMsg:msg animated:animated yCenter:YES yLocation:0 complete:nil];
}

- (void)jx_showMsg:(NSString *)msg animated:(BOOL)animated complete:(void (^)(void))complete {
    [self jx_showMsg:msg animated:animated yCenter:YES yLocation:0 complete:complete];
}

- (void)jx_showMsg:(NSString *)msg animated:(BOOL)animated yLocation:(CGFloat)yLocation {
    [self jx_showMsg:msg animated:animated yCenter:NO yLocation:yLocation complete:nil];
}

- (void)jx_showMsg:(NSString *)msg animated:(BOOL)animated yLocation:(CGFloat)yLocation complete:(void (^)(void))complete {
    [self jx_showMsg:msg animated:animated yCenter:NO yLocation:yLocation complete:complete];
}

- (void)jx_showHttpError:(NSError *)error msg:(NSString *)msg animated:(BOOL)animated {
    [self jx_showHttpError:error msg:msg animated:animated yCenter:YES yLocation:0];
}

- (void)jx_showHttpError:(NSError *)error msg:(NSString *)msg animated:(BOOL)animated yLocation:(CGFloat)yLocation {
    [self jx_showHttpError:error msg:msg animated:animated yCenter:NO yLocation:yLocation];
}

- (void)jx_showHttpError:(NSError *)error msg:(NSString *)msg animated:(BOOL)animated yCenter:(BOOL)yCenter yLocation:(CGFloat)yLocation {
    if (error.code == -1009)        { [self jx_showMsg:@"网络似乎已断开, 请检查网络 ~" animated:animated yCenter:yCenter yLocation:yLocation]; }
    else if (error.code == -1001)   { [self jx_showMsg:@"网络请求超时 ~" animated:animated yCenter:yCenter yLocation:yLocation]; }
    else                            { [self jx_showMsg:msg animated:animated yCenter:yCenter yLocation:yLocation]; }
}

- (void)jx_showMsg:(NSString *)msg animated:(BOOL)animated yCenter:(BOOL)yCenter yLocation:(CGFloat)yLocation {
    [self jx_showMsg:msg animated:animated yCenter:yCenter yLocation:yLocation complete:nil];
}

- (void)jx_showMsg:(NSString *)msg animated:(BOOL)animated yCenter:(BOOL)yCenter yLocation:(CGFloat)yLocation complete:(void (^)(void))complete {
    
    if (yCenter) {
        [self jx_showToast:msg animated:animated complete:complete];
    }
    else {
        [self jx_showToast:msg animated:animated yOffset:yLocation complete:complete];
    }
}

- (void)jx_hideMsg {
    [self hideToastImmediately];
}

- (void)jx_subviewsHidden:(BOOL)hidden {
    for (UIView *viewEnum in self.subviews) {
        viewEnum.hidden = hidden;
    }
}

- (void)jx_removeAllSubviews {
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

@end









