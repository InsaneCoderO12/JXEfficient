//
//  JXNaviView.m
//  mixc
//
//  Created by augsun on 8/28/17.
//  Copyright © 2017 crland. All rights reserved.
//

#import "JXNaviView.h"
#import "JXEfficient.h"

static UIImage *JXNaviView_white_img_ = nil;
static UIImage *JXNaviView_black_img_ = nil;

@interface JXNaviView ()

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIButton *backButton;
- (IBAction)btnBackClick:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *leftButton;
- (IBAction)leftButtonClick:(id)sender;
@property (nonatomic, assign) BOOL leftButtonIsTitle; // 是否是标题

@property (weak, nonatomic) IBOutlet UIButton *rightSubButton;
- (IBAction)btnRightSubClick:(id)sender;
@property (nonatomic, assign) BOOL rightSubButtonIsTitle; // 是否是标题

@property (weak, nonatomic) IBOutlet UIButton *rightButton;
- (IBAction)rightButtonClick:(id)sender;
@property (nonatomic, assign) BOOL rightButtonIsTitle; // 是否是标题

@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *h_bottomLineView;

//
@property (nonatomic, strong) UIImage *back_white_img;
@property (nonatomic, strong) UIImage *back_black_img;

@end

@implementation JXNaviView

+ (instancetype)naviView {
    return [JXNaviView jx_createFromXibInBundle:[JXEfficient efficientBundle]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    self.backgroundColor = [UIColor whiteColor];
    
    _defaultStyleTitleColor = COLOR_GRAY(51);
    _bottomLineColor = COLOR_GRAY(222);
    
    //
    self.leftButton.tintColor = self.defaultStyleTitleColor;
    [self.leftButton setTitle:nil forState:UIControlStateNormal];

    //
    self.titleLabel.textColor = self.defaultStyleTitleColor;

    //
    self.rightButton.tintColor = self.defaultStyleTitleColor;
    [self.rightButton setTitle:nil forState:UIControlStateNormal];
    
    //
    self.rightSubButton.tintColor = self.defaultStyleTitleColor;
    [self.rightSubButton setTitle:nil forState:UIControlStateNormal];
    
    //
    self.bottomLineView.backgroundColor = self.bottomLineColor;
    self.h_bottomLineView.constant = JX_ONE_SCREEN_PIX;
    self.bottomLineView.hidden = YES;
    
    //
    self.bgColorStyle = NO;
    
    //
    self.backButton.hidden = NO;
    self.leftButton.hidden = YES;
    self.titleLabel.hidden = YES;
    self.rightSubButton.hidden = YES;
    self.rightButton.hidden = YES;
    [self reFrame];
    
    // TEST
//    self.rightButton.backgroundColor = COLOR_RANDOM;
//    self.rightSubButton.backgroundColor = COLOR_RANDOM;
//    self.titleLabel.backgroundColor = COLOR_RANDOM;
//    self.leftButton.backgroundColor = COLOR_RANDOM;
//    self.backButton.backgroundColor = COLOR_RANDOM;
    

}

- (UIImage *)back_white_img {
    if (!JXNaviView_white_img_) {
        JXNaviView_white_img_ = [JXEfficient PDFImageNamed:@"JXNaviView_white"];
    }
    return JXNaviView_white_img_;
}

- (UIImage *)back_black_img {
    if (!JXNaviView_black_img_) {
        JXNaviView_black_img_ = [JXEfficient PDFImageNamed:@"JXNaviView_black"];
    }
    return JXNaviView_black_img_;
}

- (void)setDefaultStyleTitleColor:(UIColor *)defaultStyleTitleColor {
    if (defaultStyleTitleColor) {
        _defaultStyleTitleColor = defaultStyleTitleColor;
        if (!self.bgColorStyle) {
            self.bgColorStyle = NO;
        }
    }
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor {
    if (bottomLineColor) {
        _bottomLineColor = bottomLineColor;
        self.bottomLineView.backgroundColor = bottomLineColor;
    }
}

- (void)setBgColorStyle:(BOOL)bgColorStyle {
    _bgColorStyle = bgColorStyle;
    if (bgColorStyle) {
        self.titleLabel.textColor = [UIColor whiteColor];
        [self.backButton setImage:self.back_white_img forState:UIControlStateNormal];
        [self.leftButton jx_titleColorStyleNormalColor:[UIColor whiteColor] highlightedColor:[UIColor whiteColor] disabledColor:[UIColor whiteColor]];
        [self.rightButton jx_titleColorStyleNormalColor:[UIColor whiteColor] highlightedColor:[UIColor whiteColor] disabledColor:[UIColor whiteColor]];
        [self.rightSubButton jx_titleColorStyleNormalColor:[UIColor whiteColor] highlightedColor:[UIColor whiteColor] disabledColor:[UIColor whiteColor]];
    }
    else {
        [self.backButton setImage:self.back_black_img forState:UIControlStateNormal];
        self.titleLabel.textColor = self.defaultStyleTitleColor;
        [self.leftButton jx_titleColorStyleNormalColor:self.defaultStyleTitleColor highlightedColor:COLOR_GRAY(204) disabledColor:COLOR_GRAY(204)];
        [self.rightButton jx_titleColorStyleNormalColor:self.defaultStyleTitleColor highlightedColor:COLOR_GRAY(204) disabledColor:COLOR_GRAY(204)];
        [self.rightSubButton jx_titleColorStyleNormalColor:self.defaultStyleTitleColor highlightedColor:COLOR_GRAY(204) disabledColor:COLOR_GRAY(204)];
    }
}

- (void)setBottomLineHidden:(BOOL)bottomLineHidden {
    _bottomLineHidden = bottomLineHidden;
    self.bottomLineView.hidden = bottomLineHidden;
}

- (void)setBackButtonHidden:(BOOL)backButtonHidden {
    _backButtonHidden = backButtonHidden;
    self.backButton.hidden = backButtonHidden;
    
    [self reFrame];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
    
    if (jx_strValue(title).length == 0) {
        self.titleLabel.hidden = YES;
    }
    else {
        self.titleLabel.hidden = NO;
    }
    
    [self reFrame];
}

- (void)setLeftButtonTitle:(NSString *)leftButtonTitle {
    _leftButtonTitle = leftButtonTitle;
    [self.leftButton setTitle:leftButtonTitle forState:UIControlStateNormal];
    [self.leftButton setImage:nil forState:UIControlStateNormal];

    if (leftButtonTitle.length > 0) {
        self.leftButton.hidden = NO;
        self.leftButtonIsTitle = YES;
        self.leftButton.enabled = YES;
        [self.leftButton setContentEdgeInsets:UIEdgeInsetsMake(0, 10.f, 0, 12.f)];
    }
    else {
        self.leftButton.hidden = YES;
        self.leftButton.enabled = NO;
    }
    
    [self reFrame];
}

- (void)setLeftButtonImage:(UIImage *)leftButtonImage {
    _leftButtonImage = leftButtonImage;
    [self.leftButton setImage:leftButtonImage forState:UIControlStateNormal];
    [self.leftButton setTitle:nil forState:UIControlStateNormal];
    
    if (leftButtonImage) {
        self.leftButton.hidden = NO;
        self.leftButtonIsTitle = NO;
        self.leftButton.enabled = YES;
        [self.leftButton setContentEdgeInsets:UIEdgeInsetsMake(0, 10.f, 0, 12.f)];
    }
    else {
        self.leftButton.hidden = YES;
        self.leftButton.enabled = NO;
    }
    
    [self reFrame];
}

- (void)setLeftButtonHidden:(BOOL)leftButtonHidden {
    _leftButtonHidden = leftButtonHidden;
    self.leftButton.hidden = leftButtonHidden;
    
    [self reFrame];
}

- (void)setRightButtonTitle:(NSString *)rightButtonTitle {
    _rightButtonTitle = rightButtonTitle;
    [self.rightButton setTitle:rightButtonTitle forState:UIControlStateNormal];
    [self.rightButton setImage:nil forState:UIControlStateNormal];

    if (rightButtonTitle.length > 0) {
        self.rightButton.hidden = NO;
        self.rightButtonIsTitle = YES;
        self.rightButton.enabled = YES;
    }
    else {
        self.rightButton.hidden = YES;
        self.rightButton.enabled = NO;
    }
    
    [self reFrame];
}

- (void)setRightButtonImage:(UIImage *)rightButtonImage {
    _rightButtonImage = rightButtonImage;
    [self.rightButton setImage:rightButtonImage forState:UIControlStateNormal];
    [self.rightButton setTitle:nil forState:UIControlStateNormal];
    
    if (rightButtonImage) {
        self.rightButton.hidden = NO;
        self.rightButtonIsTitle = NO;
        self.rightButton.enabled = YES;
    }
    else {
        self.rightButton.hidden = YES;
        self.rightButton.enabled = NO;
    }
    
    [self reFrame];
}

- (void)setRightButtonHidden:(BOOL)rightButtonHidden {
    _rightButtonHidden = rightButtonHidden;
    self.rightButton.hidden = rightButtonHidden;
    
    [self reFrame];
}

- (void)setRightSubButtonTitle:(NSString *)rightSubButtonTitle {
    _rightSubButtonTitle = rightSubButtonTitle;
    [self.rightSubButton setTitle:rightSubButtonTitle forState:UIControlStateNormal];
    [self.rightSubButton setImage:nil forState:UIControlStateNormal];

    if (rightSubButtonTitle.length > 0) {
        self.rightSubButton.hidden = NO;
        self.rightSubButtonIsTitle = YES;
        self.rightSubButton.enabled = YES;
    }
    else {
        self.rightSubButton.hidden = YES;
        self.rightSubButton.enabled = NO;
    }
    
    [self reFrame];
}

- (void)setRightSubButtonImage:(UIImage *)rightSubButtonImage {
    _rightSubButtonImage = rightSubButtonImage;
    [self.rightSubButton setImage:rightSubButtonImage forState:UIControlStateNormal];
    [self.rightSubButton setTitle:nil forState:UIControlStateNormal];
    if (rightSubButtonImage) {
        self.rightSubButton.hidden = NO;
        self.rightSubButtonIsTitle = NO;
        self.rightSubButton.enabled = YES;
    }
    else {
        self.rightSubButton.hidden = YES;
        self.rightSubButton.enabled = NO;
    }
    
    [self reFrame];
}

- (void)setRightSubButtonHidden:(BOOL)rightSubButtonHidden {
    _rightSubButtonHidden = rightSubButtonHidden;
    self.rightSubButton.hidden = rightSubButtonHidden;
    
    [self reFrame];
}

#pragma mark 重新布局
- (void)reFrame {
    // 返回键 左边键 ====================================================================================================

    BOOL back_show = !self.backButton.hidden;
    BOOL left_show = !self.leftButton.hidden;

    // N N
    if (!back_show && !left_show) {

    }
    // Y N
    else if (back_show && !left_show) {
        [self reFreme_backButton];
    }
    // Y Y
    else if (back_show && left_show) {
        [self reFreme_backButton];
        [self reFreme_leftButtonWithBackShow:YES];
        [self.leftButton setContentEdgeInsets:UIEdgeInsetsMake(0, 5.f, 0, 15.f)];
    }
    // N Y
    else if (!back_show && left_show) {
        [self reFreme_leftButtonWithBackShow:NO];
        [self.leftButton setContentEdgeInsets:UIEdgeInsetsMake(0, 15.f, 0, 15.f)];
    }

    // 右2键 右1键 ====================================================================================================

    BOOL right_show = !self.rightButton.hidden;
    BOOL rightSub_show = !self.rightSubButton.hidden;

    // Y Y
    if (rightSub_show && right_show) {
        //
        [self reFreme_rightButton];
        
        if (self.rightButtonIsTitle)    { [self.rightButton setContentEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 12.f)]; }
        else                            { [self.rightButton setContentEdgeInsets:UIEdgeInsetsMake(0, 8.f, 0, 15.f)]; }

        //
        [self reFreme_rightSubButtonWithRightShow:YES];
        
        if (self.rightSubButtonIsTitle) { [self.rightSubButton setContentEdgeInsets:UIEdgeInsetsMake(0, 8.f, 0, 5.f)]; }
        else                            { [self.rightSubButton setContentEdgeInsets:UIEdgeInsetsMake(0, 8.f, 0, 8.f)]; }
    }
    // N Y
    else if (!rightSub_show && right_show) {
        [self reFreme_rightButton];
        
        if (self.rightButtonIsTitle)    { [self.rightButton setContentEdgeInsets:UIEdgeInsetsMake(0, 10.f, 0, 12.f)]; }
        else                            { [self.rightButton setContentEdgeInsets:UIEdgeInsetsMake(0, 8.f, 0, 15.f)]; }
    }
    // Y N
    else if (rightSub_show && !right_show) {
        [self reFreme_rightSubButtonWithRightShow:NO];
        
        if (self.rightSubButtonIsTitle) { [self.rightSubButton setContentEdgeInsets:UIEdgeInsetsMake(0, 10.f, 0, 12.f)]; }
        else                            { [self.rightSubButton setContentEdgeInsets:UIEdgeInsetsMake(0, 8.f, 0, 15.f)]; }
    }
    // N N
    else {

    }

    // 标题 ====================================================================================================

    // 标题
    if (!self.titleLabel.hidden) {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        // H
        [self.titleLabel addConstraints:@[
                                          [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeHeight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:1.0 constant:44.0]
                                          ]];
        
        // B
        [self.bgView addConstraints:@[
                                      [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.bgView attribute:NSLayoutAttributeBottom
                                                                  multiplier:1.0 constant:0.0],
                                      ]];
        
        // centerX
        NSLayoutConstraint *con_centerX = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.bgView attribute:NSLayoutAttributeCenterX
                                                                      multiplier:1.0 constant:0.0];
        con_centerX.priority = UILayoutPriorityDefaultHigh;
        [self.bgView addConstraints:@[
                                      con_centerX,
                                      ]];
        
        // L
        // 有左按钮
        if (left_show) {
            [self.bgView addConstraints:@[
                                          [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft
                                                                       relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                          toItem:self.leftButton attribute:NSLayoutAttributeRight
                                                                      multiplier:1.0 constant:5.0],
                                          ]];
        }
        // 有返回按钮
        else if (back_show) {
            [self.bgView addConstraints:@[
                                          [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft
                                                                       relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                          toItem:self.backButton attribute:NSLayoutAttributeRight
                                                                      multiplier:1.0 constant:4.0],
                                          ]];
        }
        // 都没有
        else {
            [self.bgView addConstraints:@[
                                          [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft
                                                                       relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                          toItem:self.bgView attribute:NSLayoutAttributeLeft
                                                                      multiplier:1.0 constant:10.0],
                                          ]];
        }

        // R
        // 有右2
        if (rightSub_show) {
            [self.bgView addConstraints:@[
                                          [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationLessThanOrEqual
                                                                          toItem:self.rightSubButton attribute:NSLayoutAttributeLeft
                                                                      multiplier:1.0 constant:-5.0],
                                          ]];
        }
        // 有右1
        else if (right_show) {
            [self.bgView addConstraints:@[
                                          [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationLessThanOrEqual
                                                                          toItem:self.rightButton attribute:NSLayoutAttributeLeft
                                                                      multiplier:1.0 constant:-5.0],
                                          ]];
        }
        // 都没有
        else {
            [self.bgView addConstraints:@[
                                          [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationLessThanOrEqual
                                                                          toItem:self.bgView attribute:NSLayoutAttributeRight
                                                                      multiplier:1.0 constant:-10.0],
                                          ]];
        }
    }
}

- (void)reFreme_backButton {
    self.backButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    // L B
    [self.bgView addConstraints:@[
                                  [NSLayoutConstraint constraintWithItem:self.backButton attribute:NSLayoutAttributeLeft
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.bgView attribute:NSLayoutAttributeLeft
                                                              multiplier:1.0 constant:0.0],
                                  [NSLayoutConstraint constraintWithItem:self.backButton attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.bgView attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0 constant:0.0],
                                  ]];
    
    // W H
    [self.backButton addConstraints:@[
                                      [NSLayoutConstraint constraintWithItem:self.backButton attribute:NSLayoutAttributeWidth
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1.0 constant:55.0],
                                      [NSLayoutConstraint constraintWithItem:self.backButton attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1.0 constant:44.0]
                                      ]];
}

- (void)reFreme_leftButtonWithBackShow:(BOOL)back_show {
    self.leftButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    // L
    if (back_show) {
        [self.bgView addConstraints:@[
                                      [NSLayoutConstraint constraintWithItem:self.leftButton attribute:NSLayoutAttributeLeft
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.backButton attribute:NSLayoutAttributeRight
                                                                  multiplier:1.0 constant:0.0],
                                      ]];
    }
    else {
        [self.bgView addConstraints:@[
                                      [NSLayoutConstraint constraintWithItem:self.leftButton attribute:NSLayoutAttributeLeft
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.bgView attribute:NSLayoutAttributeLeft
                                                                  multiplier:1.0 constant:0.0],
                                      ]];
    }
    
    // B
    [self.bgView addConstraints:@[
                                  [NSLayoutConstraint constraintWithItem:self.leftButton attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.bgView attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0 constant:0.0],
                                  ]];
    // W H
    [self.leftButton addConstraints:@[
                                      [NSLayoutConstraint constraintWithItem:self.leftButton attribute:NSLayoutAttributeWidth
                                                                   relatedBy:NSLayoutRelationLessThanOrEqual
                                                                      toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1.0 constant:90.0],
                                      [NSLayoutConstraint constraintWithItem:self.leftButton attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1.0 constant:44.0]
                                      ]];
}

- (void)reFreme_rightButton {
    self.rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    // R B
    [self.bgView addConstraints:@[
                                  [NSLayoutConstraint constraintWithItem:self.rightButton attribute:NSLayoutAttributeRight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.bgView attribute:NSLayoutAttributeRight
                                                              multiplier:1.0 constant:0.0],
                                  [NSLayoutConstraint constraintWithItem:self.rightButton attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.bgView attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0 constant:0.0],
                                  ]];
    // W H
    [self.rightButton addConstraints:@[
                                      [NSLayoutConstraint constraintWithItem:self.rightButton attribute:NSLayoutAttributeWidth
                                                                   relatedBy:NSLayoutRelationLessThanOrEqual
                                                                      toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1.0 constant:90.0],
                                      [NSLayoutConstraint constraintWithItem:self.rightButton attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1.0 constant:44.0]
                                      ]];
}

- (void)reFreme_rightSubButtonWithRightShow:(BOOL)right_show {
    self.rightSubButton.translatesAutoresizingMaskIntoConstraints = NO;
    // R
    if (right_show) {
        [self.bgView addConstraints:@[
                                      [NSLayoutConstraint constraintWithItem:self.rightSubButton attribute:NSLayoutAttributeRight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.rightButton attribute:NSLayoutAttributeLeft
                                                                  multiplier:1.0 constant:0.0],
                                      ]];
    }
    else {
        [self.bgView addConstraints:@[
                                      [NSLayoutConstraint constraintWithItem:self.rightSubButton attribute:NSLayoutAttributeRight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.bgView attribute:NSLayoutAttributeRight
                                                                  multiplier:1.0 constant:0.0],
                                      ]];
    }
    // B
    [self.bgView addConstraints:@[
                                  [NSLayoutConstraint constraintWithItem:self.rightSubButton attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.bgView attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0 constant:0.0],
                                  ]];
    // W H
    [self.rightSubButton addConstraints:@[
                                       [NSLayoutConstraint constraintWithItem:self.rightSubButton attribute:NSLayoutAttributeWidth
                                                                    relatedBy:NSLayoutRelationLessThanOrEqual
                                                                       toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1.0 constant:90.0],
                                       [NSLayoutConstraint constraintWithItem:self.rightSubButton attribute:NSLayoutAttributeHeight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1.0 constant:44.0]
                                       ]];
}

#pragma mark 点击事件
- (IBAction)btnBackClick:(id)sender {
    !self.backClick ? : self.backClick();
}

- (IBAction)leftButtonClick:(id)sender {
    !self.leftButtonTap ? : self.leftButtonTap();
}

- (IBAction)rightButtonClick:(id)sender {
    !self.rightButtonTap ? : self.rightButtonTap();
}

- (IBAction)btnRightSubClick:(id)sender {
    !self.rightSubButtonTap ? : self.rightSubButtonTap();
}

@end

















