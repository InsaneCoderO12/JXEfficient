//
//  UICollectionView+JXCategory.h
//  mixc
//
//  Created by augsun on 9/28/17.
//  Copyright © 2017 crland. All rights reserved.
//

#import <UIKit/UIKit.h>

#define COLLECTIONVIEW_DEQUEUE(identifier) [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath]

#define COLLECTIONVIEW_DEQUEUE_HEADER(identifier) [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier forIndexPath:indexPath]

#define COLLECTIONVIEW_DEQUEUE_FOOTER(identifier) [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier forIndexPath:indexPath]

@interface UICollectionView (JXCategory)

- (void)jx_regCellNib:(Class)cellClass identifier:(NSString *)identifier;
- (void)jx_regCellNib:(Class)cellClass identifier:(NSString *)identifier bundle:(NSBundle *)bundle;

- (void)jx_regSectionHeader:(Class)headerClass identifier:(NSString *)identifier;
- (void)jx_regSectionHeader:(Class)headerClass identifier:(NSString *)identifier bundle:(NSBundle *)bundle;

- (void)jx_regSectionFooter:(Class)footerClass identifier:(NSString *)identifier;
- (void)jx_regSectionFooter:(Class)footerClass identifier:(NSString *)identifier bundle:(NSBundle *)bundle;

@end
