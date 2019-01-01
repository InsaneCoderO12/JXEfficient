//
//  UIViewController+JXCategory.h
//  JXEfficient
//
//  Created by augsun on 1/1/19.
//

#import <UIKit/UIKit.h>

@interface UIViewController (JXCategory)

// 默认 push <hidesBottomBarWhenPushed: YES && animated:YES>
- (void)jx_pushVC:(UIViewController *)vc;

// 
- (void)jx_pushVC:(UIViewController *)vc hidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed animated:(BOOL)animated;

@end
