//
//  UICollectionView+JXCategory.m
//  mixc
//
//  Created by augsun on 9/28/17.
//  Copyright © 2017 crland. All rights reserved.
//

#import "UICollectionView+JXCategory.h"

@implementation UICollectionView (JXCategory)

- (void)jx_regCellNib:(Class)cellClass identifier:(NSString *)identifier {
    [self jx_regCellNib:cellClass identifier:identifier bundle:nil];
}

- (void)jx_regCellNib:(Class)cellClass identifier:(NSString *)identifier bundle:(NSBundle *)bundle {
    UINib *cellNib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:bundle];
    [self registerNib:cellNib forCellWithReuseIdentifier:identifier];
}

@end
