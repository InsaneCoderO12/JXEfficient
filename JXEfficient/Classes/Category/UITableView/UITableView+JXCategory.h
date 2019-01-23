//
//  UITableView+JXCategory.h
//  JXEfficient
//
//  Created by augsun on 3/7/17.
//  Copyright © 2017 CoderSun. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TABLEVIEW_DEQUEUE(identifier) [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath]

@interface UITableView (JXCategory)

- (void)jx_regCellNib:(Class)cellClass identifier:(NSString *)identifier;
- (void)jx_regCellNib:(Class)cellClass identifier:(NSString *)identifier bundle:(NSBundle *)bundle;

- (void)jx_regHeaderFooterNib:(Class)cellClass identifier:(NSString *)identifier;
- (void)jx_regHeaderFooterNib:(Class)cellClass identifier:(NSString *)identifier bundle:(NSBundle *)bundle;

@end
