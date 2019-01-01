//
//  UIViewController+JXCategory.h
//  JXEfficient
//
//  Created by augsun on 1/1/19.
//

#import <UIKit/UIKit.h>

@interface UIViewController (JXCategory)

#pragma mark pushVC
- (void)jx_pushVC:(UIViewController *)vc; // 默认 push <hidesBottomBarWhenPushed:YES && animated:YES>
- (void)jx_pushVC:(UIViewController *)vc hidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed animated:(BOOL)animated;

#pragma mark popVC
- (UIViewController *)jx_popVC; // 默认 pop <animated:YES>
- (UIViewController *)jx_popVCAnimated:(BOOL)animated;

@end
