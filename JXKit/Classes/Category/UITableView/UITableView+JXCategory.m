//
//  UITableView+JXCategory.m
//  mixc
//
//  Created by augsun on 3/7/17.
//  Copyright © 2017 crland. All rights reserved.
//

#import "UITableView+JXCategory.h"

@implementation UITableView (JXCategory)

- (void)jx_regCellNib:(Class)cellClass identifier:(NSString *)identifier {
    [self jx_regCellNib:cellClass identifier:identifier bundle:nil];
}

- (void)jx_regCellNib:(Class)cellClass identifier:(NSString *)identifier bundle:(NSBundle *)bundle {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:bundle];
    [self registerNib:nib forCellReuseIdentifier:identifier];
}

- (void)jx_regHeaderFooterNib:(Class)cellClass identifier:(NSString *)identifier {
    [self jx_regHeaderFooterNib:cellClass identifier:identifier bundle:nil];
}

- (void)jx_regHeaderFooterNib:(Class)cellClass identifier:(NSString *)identifier bundle:(NSBundle *)bundle {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:bundle];
    [self registerNib:nib forHeaderFooterViewReuseIdentifier:identifier];
}

@end
