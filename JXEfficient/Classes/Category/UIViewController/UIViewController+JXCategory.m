//
//  UIViewController+JXCategory.m
//  JXEfficient
//
//  Created by augsun on 1/1/19.
//

#import "UIViewController+JXCategory.h"

@implementation UIViewController (JXCategory)

- (void)jx_pushVC:(UIViewController *)vc {
    [self jx_pushVC:vc hidesBottomBarWhenPushed:YES animated:YES];
}

- (void)jx_pushVC:(UIViewController *)vc hidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed animated:(BOOL)animated {
    vc.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed;
    [self.navigationController pushViewController:vc animated:animated];
}

@end
