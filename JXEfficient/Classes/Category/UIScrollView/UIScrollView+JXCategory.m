//
//  UIScrollView+JXCategory.m
//  MCUtilities_Example
//
//  Created by augsun on 3/2/18.
//  Copyright © 2018 452720799@qq.com. All rights reserved.
//

#import "UIScrollView+JXCategory.h"

@implementation UIScrollView (JXCategory)

- (void)jx_scrollToTop:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self setContentOffset:off animated:animated];
}

@end
