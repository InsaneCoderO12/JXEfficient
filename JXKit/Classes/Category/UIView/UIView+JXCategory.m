//
//  UIView+JXCategory.m
//  ShiBa
//
//  Created by shiba_iosJX on 6/2/16.
//  Copyright © 2016 ShiBa. All rights reserved.
//

#import "UIView+JXCategory.h"
#import "UIView+JXToastAndProgressHUD.h"
//#import "JXInline.h"
//#import "MBProgressHUD.h"
//#import "Masonry.h"
//#import "JXMacro.h"

static BOOL kRet = NO;

static CGFloat const JXMsgViewMinEdgeToScreen   = 12.f;         // 提示消息距离屏幕边缘(左和右)的最小距离
static CGFloat const JXMsgEdge                  = 12.f;         // 提示文字距离提示边框的距离
static CGFloat const JXMsgMinWidth              = 80.f;         // 提示边框的最小宽度
static CGFloat const JXMsgShowAnimTime          = .15f;         // 提示框渐显时间
static CGFloat const JXMsgHideAnimTime          = .35f;         // 提示框渐隐时间
static CGFloat const JXMsgShowDuration          = 1.6f;         // 提示框显示时长

//// ====================================================================================================
//#pragma mark - JXMsgView
//@interface JXMsgView : UIView
//
//- (void)showMsg:(NSString *)msg inRect:(CGRect)rect;
//
//@end
//
//@interface JXMsgView ()
//
//@property (nonatomic, strong) UILabel *lblMsg;
//
//@end
//
//@implementation JXMsgView
//
//- (UILabel *)lblMsg {
//    if (!_lblMsg) {
//        _lblMsg = [[UILabel alloc] init];
//        [self addSubview:_lblMsg];
//        _lblMsg.numberOfLines = 0;
//        _lblMsg.textColor = [UIColor whiteColor];
//        _lblMsg.font = [UIFont systemFontOfSize:14.f];
//        _lblMsg.textAlignment = NSTextAlignmentCenter;
//    }
//    return _lblMsg;
//}
//
//- (instancetype)init {
//    if (self = [super init]) {
//        self.backgroundColor = COLOR_RGBA(34, 34, 34, .65f);
//        self.layer.cornerRadius = 4.f;
//        self.clipsToBounds = YES;
//        self.alpha = .0f;
//    }
//    return self;
//}
//
//- (void)showMsg:(NSString *)msg inRect:(CGRect)rect {
//    self.lblMsg.text = msg;
//    CGSize thatSize = [self.lblMsg sizeThatFits:CGSizeMake(rect.size.width - 2 * (JXMsgViewMinEdgeToScreen + JXMsgEdge), CGFLOAT_MAX)];
//    thatSize.width = thatSize.width < JXMsgMinWidth ? JXMsgMinWidth : thatSize.width;
//    self.lblMsg.frame = CGRectMake(JXMsgEdge, JXMsgEdge, thatSize.width, thatSize.height);
//    self.jx_width = thatSize.width + 2 * JXMsgEdge;
//    self.jx_height = thatSize.height + 2 * JXMsgEdge;
//}
//
//@end

//// ====================================================================================================
//#pragma mark - JXProgressView (JXProgressView)
//@interface JXProgressView : UIView
//
//@property (nonatomic, strong) UIImageView *imgView;
//
//
//@end
//
//@implementation JXProgressView
//
//- (instancetype)init {
//    if (self = [super init]) {
//
//        self.imgView = [[UIImageView alloc] init];
//        [self addSubview:self.imgView];
//        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(self);
//        }];
//
//        NSMutableArray *loadingImages = [[NSMutableArray alloc] init];
//        for (NSUInteger i = 0; i < 200; i++) {
//            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%03ld", i]];
//            if (!image) {
//                break;
//            }
//            [loadingImages addObject:image];
//        }
//        self.imgView.animationImages = loadingImages;
//        self.imgView.animationDuration = loadingImages.count * (1.f / 12); // 20fps
////        [self.imgView startAnimating];
//        self.imgView.animationRepeatCount = NSUIntegerMax;
//
//    }
//    return self;
//}
//
//@end

// ====================================================================================================
#pragma mark - UIView (JXCategory)
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
    
    [self jx_showMsg:msg animated:animated yCenter:yCenter yLocation:yLocation complete:complete];
    
//    if (strValue(msg).length == 0) {
//        return;
//    }
//    
//    [self jx_hideMsg];
//    JXMsgView *msgView = [[JXMsgView alloc] init];
//    [msgView showMsg:msg inRect:self.frame];
//    msgView.jx_x = (self.bounds.size.width - msgView.jx_width) * .5f;
//    msgView.jx_y = yCenter ? (self.bounds.size.height - msgView.jx_height) * .5f : yLocation;
//    [self addSubview:msgView];
//    if (animated) {
//        [UIView animateWithDuration:JXMsgShowAnimTime animations:^{
//            msgView.alpha = 1.f;
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:JXMsgHideAnimTime delay:JXMsgShowDuration options:UIViewAnimationOptionTransitionNone animations:^{
//                msgView.alpha = 0.f;
//            } completion:^(BOOL finished) {
//                [msgView removeFromSuperview];
//                !complete ? : complete();
//            }];
//        }];
//    }
//    else {
//        msgView.alpha = 1.f;
//        [UIView animateWithDuration:JXMsgHideAnimTime delay:JXMsgShowDuration options:UIViewAnimationOptionTransitionNone animations:^{
//            msgView.alpha = 0.f;
//        } completion:^(BOOL finished) {
//            [msgView removeFromSuperview];
//            !complete ? : complete();
//        }];
//    }
}

- (void)jx_hideMsg {
    [self hideToastImmediately];
//    for (UIView *viewEnum in self.subviews) {
//        if ([viewEnum isKindOfClass:[JXMsgView class]]) { [viewEnum removeFromSuperview]; }
//    }
}

#pragma mark progresssHUD
//- (void)jx_showProgressHUD:(NSString *)title animation:(BOOL)animation {
//    if (kRet == NO) {
//        kRet = YES;
//        [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
//    }
//
//    [self jx_hideProgressHUD:NO];
//    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] init];
//    progressHUD.mode = MBProgressHUDModeIndeterminate;
//    progressHUD.animationType = MBProgressHUDAnimationZoomOut;
//    progressHUD.removeFromSuperViewOnHide = YES;
//    progressHUD.label.text = title;
//    progressHUD.label.textColor = [UIColor whiteColor];
//    progressHUD.bezelView.layer.cornerRadius = 4.f;
//    progressHUD.bezelView.color = COLOR_RGBA(34, 34, 34, .65f);
//    progressHUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//
//    progressHUD.label.font = [UIFont systemFontOfSize:14.f];
//    progressHUD.userInteractionEnabled = NO;
//    [self addSubview:progressHUD];
//    [progressHUD showAnimated:animation];
//
//    //
////    [self jx_hideProgressHUD:NO];
////    JXProgressView *progressHUDView = [[JXProgressView alloc] init];
////    [self addSubview:progressHUDView];
////    [progressHUDView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.center.mas_equalTo(self);
////        make.width.mas_equalTo(80.f);
////        make.height.mas_equalTo(50.f);
////    }];
////    [progressHUDView.imgView startAnimating];
//}

//- (void)jx_hideProgressHUD:(BOOL)animation {
//    for (UIView *viewEnum in self.subviews) {
//        if ([viewEnum isKindOfClass:[MBProgressHUD class]]) {
//            [MBProgressHUD hideHUDForView:self animated:animation];
//        }
//    }
//    
//    //
////    for (UIView *viewEnum in self.subviews) {
////        if ([viewEnum isKindOfClass:[JXProgressView class]]) {
////            if (animation) {
////                [viewEnum mas_updateConstraints:^(MASConstraintMaker *make) {
////                    make.width.mas_equalTo(0.f);
////                    make.height.mas_equalTo(0.f);
////                }];
////                [UIView animateWithDuration:.25f animations:^{
////                    viewEnum.alpha = 0.f;
////                    [viewEnum layoutIfNeeded];
////                } completion:^(BOOL finished) {
////                    [viewEnum removeFromSuperview];
////                }];
////            }
////            else {
////                [viewEnum removeFromSuperview];
////            }
////        }
////    }
//}

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









