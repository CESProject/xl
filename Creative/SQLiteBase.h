//
//  SQLiteBase.h
//  Creative
//
//  Created by Mr Wei on 16/1/7.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLiteBase : NSObject

//用来接收数据库路径
@property (nonatomic , copy)NSString *dataBasePath;

/// 创建数据库的单利方法
+ (SQLiteBase *)ShareSQLiteBaseSave;
/**
 * 创建表
 */
- (BOOL)createWithTableName:(NSString *)tableName;
/**
 * 插入一条数据
 */
- (BOOL)createWithTableName:(NSString *)tableName withModel:(id)model;
/**
 * 查询相应表中的数据
 */
- (NSMutableArray *)searchAllDataFromTableName:(NSString *)tableName;
/**
 * 删除表中的某一条数据
 */
- (BOOL)deletaOneDataFromTableName:(NSString *)tableName withModel:(id)model;
/**
 * 删除相应表中所有的数据
 */
- (BOOL)deleteAllDataFromTableName:(NSString *)tableName;
/**
 * 创建搜索表  路演搜索表（SearchList）
 */
- (BOOL)createWithSearchTableName:(NSString *)tableNames;
/**
 * 给搜索表插入一条数据
 */
- (BOOL)createWithSearchTableName:(NSString *)tableNames withModel:(id)model;
/**
 * 删除搜索表中的某一条数据
 */
- (BOOL)deletaOneDataFromSearchTableName:(NSString *)tableNames withModel:(id)model;
/**
 * 查询搜索表中的数据
 */
- (NSMutableArray *)searchAllDataFromSearchTableName:(NSString *)tableNames;

@end
