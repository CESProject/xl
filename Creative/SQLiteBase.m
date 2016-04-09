//
//  SQLiteBase.m
//  Creative
//
//  Created by Mr Wei on 16/1/7.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "SQLiteBase.h"
#import "placeModel.h"

#import <sqlite3.h>

// 创建指针变量
static SQLiteBase *_sqliteBase = nil;
///准备数据库
static sqlite3 *dateBase;

@implementation SQLiteBase

/// 获得数据库路径
- (NSString *)getSqliteDataBasePath
{
    NSString *homePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    // 数据库路径
    NSString *dbPath = [homePath stringByAppendingPathComponent:@"SQLiteBase.sqlite"];
    NSLog(@"dbPath ＝ %@",dbPath);
    return dbPath;
}

/// 打开数据库
- (void)openDataPath
{
    // 1. 获取数据库路径
    self.dataBasePath = [self getSqliteDataBasePath];
    
    if (sqlite3_config(SQLITE_CONFIG_SERIALIZED) == SQLITE_ERROR)
    {
        NSLog(@"couldn't set serialized mode");
    }
    
    // 2. 根据该路径
    int result = sqlite3_open(self.dataBasePath.UTF8String, &dateBase);
    if (result == SQLITE_OK) {
        //        NSLog(@"数据库打开成功");
    }else{
        NSLog(@"数据库打开失败 %d", result);
    }
    
}

/// 关闭数据库
- (void)closeDataBase
{
    if (dateBase)
    {
        int result = sqlite3_close(dateBase);
        if (result == SQLITE_OK) {
//                    NSLog(@"数据库关闭成功");
        }else{
            NSLog(@"数据库关闭失败 %d",result);
        }
    }
    
}

/// 创建数据库的单利方法
+ (SQLiteBase *)ShareSQLiteBaseSave
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sqliteBase = [[SQLiteBase  alloc]init];
    });
    return _sqliteBase;
}

#pragma mark - 创建一张表
/**
 * 创建表
 */
- (BOOL)createWithTableName:(NSString *)tableName
{
    // 打开数据库
    [self openDataPath];
    // 准备创建表的sqlite语句
    NSString *sql = [NSString stringWithFormat:@"create table IF NOT EXISTS %@(strID text primary key not null,areaLevel Integer,areaName text not null,createBy Integer,createDate Integer,delDate Integer,delFlg text,parentId text,updateBy Integer,updateDate Integer)",tableName];
    
    
    // 开始执行sql 语句
    int result = sqlite3_exec(dateBase, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        //        NSLog(@"创建表成功");
        [self closeDataBase];
        return YES;
    }else{
        NSLog(@"创建表失败---%d--", result);
        [self closeDataBase];
        return NO;
    }
}

/**
 * 插入一条数据
 */
- (BOOL)createWithTableName:(NSString *)tableName withModel:(id)model
{
    /// 打开数据库
    [self openDataPath];
    /// 转变数据类型
    placeModel *plces = (placeModel *)model;
    NSString *sql = [NSString stringWithFormat:@"insert into %@(strID,areaLevel,areaName,createBy,createDate,delDate,delFlg,parentId,updateBy,updateDate) values('%@','%ld','%@','%ld','%ld','%ld','%@','%@','%ld','%ld')",tableName,plces.strID,(long)plces.areaLevel,plces.areaName,(long)plces.createBy,(long)plces.createDate,(long)plces.delDate,plces.delFlg,plces.parentId,(long)plces.updateBy,(long)plces.updateDate];
    //执行sql语句
    int result = sqlite3_exec(dateBase, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        //                NSLog(@"数据插入成功");
        [self closeDataBase];
        return YES;
    }else{
        NSLog(@"数据插入失败---%d---",result);
        [self closeDataBase];
        return NO;
    }
}

/**
 * 删除表中的某一条数据
 */
- (BOOL)deletaOneDataFromTableName:(NSString *)tableName withModel:(id)model
{
    //打开数据库
    [self openDataPath];
    
    
    placeModel *pl = (placeModel *)model;
    
    //准备sql语句
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where strID = '%@'", tableName ,pl.strID];
    //执行数据可能语句
    int result = sqlite3_exec(dateBase, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"删除一条数据成功");
        [self closeDataBase];
        return YES;
    }else{
        NSLog(@"删除一条数据失败---%d--", result);
        [self closeDataBase];
        return NO;
    }
    
}

/**
 * 删除相应表中所有的数据
 */
- (BOOL)deleteAllDataFromTableName:(NSString *)tableName
{
    //打开数据库
    [self openDataPath];
    //准备sql语句
    NSString *sql = [NSString stringWithFormat:@"delete from %@",tableName];
    //执行SQL语句
    int result = sqlite3_exec(dateBase, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"删除所有数据成功");
        [self closeDataBase];
        return YES;
    }else{
        NSLog(@"删除所有数据失败---%d--", result);
        [self closeDataBase];
        return NO;
    }
    
}
/**
 * 查询相应表中的数据
 */
- (NSMutableArray *)searchAllDataFromTableName:(NSString *)tableName
{
    NSMutableArray *array = [NSMutableArray array];
    //打开数据库
    [self openDataPath];
    //准备数据库语言
    NSString *sql = [NSString stringWithFormat:@"select * from %@",tableName];
    //准备stmt 临时存储对象
    sqlite3_stmt *stmt = nil;
    //准备检测sql语句
    sqlite3_prepare(dateBase, sql.UTF8String, -1, &stmt, NULL);
    //判断数据库能否往下一个读取
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        //准备model
        placeModel *adBook = [placeModel new];
        adBook.strID = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
        adBook.areaLevel = (NSInteger)sqlite3_column_int(stmt, 1);
        adBook.areaName = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
        adBook.createBy = (NSInteger)sqlite3_column_int(stmt, 3);
        adBook.createDate = (NSInteger)sqlite3_column_int(stmt, 4);
        adBook.delDate = (NSInteger)sqlite3_column_int(stmt, 5);
        adBook.delFlg = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 6)];
        adBook.parentId = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 7)];
        adBook.updateBy = (NSInteger)sqlite3_column_int(stmt, 8);
        adBook.updateDate = (NSInteger)sqlite3_column_int(stmt, 9);
        
        [array addObject:adBook];
        
    }
    //清空临时对像
    sqlite3_finalize(stmt);
    //关闭数据库
    [self closeDataBase];
    
    return array;
}

/**
 * 创建搜索表  路演搜索表（SearchList） 活动搜索表（ActiviteList） 项目搜索表（ProjectList）
 */
- (BOOL)createWithSearchTableName:(NSString *)tableNames
{
    // 打开数据库
    [self openDataPath];
    // 准备创建表的sqlite语句
    // IF NOT EXISTS 判断表是否存在
    NSString *sql = [NSString stringWithFormat:@"create table IF NOT EXISTS %@(sqlLine text primary key not null,cityId text,cityName text,directionType text,directTypeName text,theme text,strType text,isFree text,activityType text,timeType text,startTime text,endTime text,name text,cooperationStage text,strMoneyType text,teamNum text,existingFundsType text,partnerType text,ageType text)",tableNames];
    
    // 开始执行sql 语句
    int result = sqlite3_exec(dateBase, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        //        NSLog(@"创建表成功");
        [self closeDataBase];
        return YES;
    }else{
        NSLog(@"创建表失败---%d--", result);
        
        [self closeDataBase];
        return NO;
    }

    return YES;
}

/**
 * 给搜索表插入一条数据
 */
- (BOOL)createWithSearchTableName:(NSString *)tableNames withModel:(id)model
{
    /// 打开数据库
    [self openDataPath];
    /// 转变数据类型
    placeModel *plces = (placeModel *)model;
    NSString *sql = [NSString stringWithFormat:@"insert into %@(sqlLine,cityId,cityName,directionType,directTypeName,theme,strType,isFree,activityType,timeType,startTime,endTime,name,cooperationStage,strMoneyType,teamNum,existingFundsType,partnerType,ageType) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",tableNames,plces.sqlLine,plces.cityId,plces.cityName,plces.directionType,plces.directTypeName,plces.theme,plces.strType,plces.isFree,plces.activityType,plces.timeType,plces.startTime,plces.endTime,plces.name,plces.cooperationStage,plces.strMoneyType,plces.teamNum,plces.existingFundsType,plces.partnerType,plces.ageType];
    //执行sql语句
    int result = sqlite3_exec(dateBase, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        //        NSLog(@"数据插入成功");
        [self closeDataBase];
        return YES;
    }else{
        NSLog(@"数据插入失败---%d---",result);
        if (result == 19) {
            showAlertView(@"请检查是否重复命名");
        }
        [self closeDataBase];
        return NO;
    }

}

/**
 * 删除搜索表中的某一条数据
 */
- (BOOL)deletaOneDataFromSearchTableName:(NSString *)tableNames withModel:(id)model
{
    //打开数据库
    [self openDataPath];
    
    
    placeModel *pl = (placeModel *)model;
    
    //准备sql语句
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where sqlLine = '%@'",tableNames,pl.sqlLine];
    //执行数据可能语句
    int result = sqlite3_exec(dateBase, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"删除一条数据成功");
        [self closeDataBase];
        return YES;
    }else{
        NSLog(@"删除一条数据失败---%d--", result);
        [self closeDataBase];
        return NO;
    }
    
}


/**
 * 查询搜索表中的数据
 */
- (NSMutableArray *)searchAllDataFromSearchTableName:(NSString *)tableNames
{
    NSMutableArray *array = [NSMutableArray array];
    //打开数据库
    [self openDataPath];
    //准备数据库语言
    NSString *sql = [NSString stringWithFormat:@"select * from %@",tableNames];
    //准备stmt 临时存储对象
    sqlite3_stmt *stmt = nil;
    //准备检测sql语句
    sqlite3_prepare(dateBase, sql.UTF8String, -1, &stmt, NULL);
    //判断数据库能否往下一个读取
    while (sqlite3_step(stmt) == SQLITE_ROW)
    {
        //准备model
        placeModel *adBook = [placeModel new];
        adBook.sqlLine = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
        adBook.cityId = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
        adBook.cityName = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
        adBook.directionType = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
        adBook.directTypeName = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
        
        adBook.theme = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
        adBook.strType = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 6)];
        adBook.isFree = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 7)];
        adBook.activityType = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 8)];
        adBook.timeType = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 9)];
        adBook.startTime = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 10)];
        adBook.endTime = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 11)];
        adBook.name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 12)];
        adBook.cooperationStage = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 13)];
        adBook.strMoneyType = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 14)];
        adBook.teamNum =  [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 15)];
        adBook.existingFundsType =  [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 16)];
        adBook.partnerType =  [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 17)];
        adBook.ageType = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 18)];
        [array addObject:adBook];
        
    }
    //清空临时对像
    sqlite3_finalize(stmt);
    //关闭数据库
    [self closeDataBase];
    
    return array;
}


@end
