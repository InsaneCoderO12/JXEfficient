//
//  MCCoreDataManager.h
//  JXEfficient
//
//  Created by augsun on 1/4/19.
//  Copyright © 2019 CoderSun. All rights reserved.
//

/*
 使用
 1, 新建 XXX_NAME.xcdatamodeld 文件
 2, 在 XXX_NAME.xcdatamodeld 创建 XXX_Entity
 3, 在 Show the File Inspector 中将 Code Generation / Language 设置为 Objective-C
 4, 为 XXX_Entity 添加表单字段
 */

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "JXCoreDataBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXCoreData : NSObject

/*
 初始化
 xcdatamodeldName: XXX_NAME.xcdatamodeld 文件保存位置
 inBundle: 文件所在 bundle 一般为 nil
 path: 数据库保存位置
 */
- (nullable instancetype)initWithXcdatamodeldName:(NSString *)xcdatamodeldName inBundle:(nullable NSBundle *)inBundle storePath:(NSString *)path;

// 增
- (__kindof JXCoreDataBaseModel *)insertNewObjectForEntityForName:(NSString *)entityName;

// 查 改<查询到的数据可以修改>
- (nullable NSArray <id> *)fetchRequestWithEntityName:(NSString *)entityName predicate:(nullable NSPredicate *)predicate;

// 删除
- (void)deleteObject:(__kindof JXCoreDataBaseModel *)object;

// [增 删 改] 后需调用 save
- (BOOL)save:(NSError * _Nullable __autoreleasing * _Nullable)error;

@end

NS_ASSUME_NONNULL_END
