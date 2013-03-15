//
//  BaiteDB.h
//  chabaike
//
//  Created by Mac on 12-4-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "Constants.h"
@interface DBsqlite : NSObject
@property (nonatomic) sqlite3 *link;

- (NSString *)dataFilePath:(NSString *)filename;    // 获取数据库文件路径
- (NSString *)count:(NSString *)tableName;          // 返回总数
- (BOOL)connect;                                    // 连接数据库
- (BOOL)connectapp:(NSString *)app;                 // 连接数据库转换接口
- (BOOL)connectFav;                                 // 连接收藏数据库
- (BOOL)connectSearch;                              // 连接搜索数据库

- (BOOL)exec:(NSString *)sql;                       // 执行Sql语句
- (NSMutableDictionary *)fetchOne:(NSString *)sql;  // 获取一条记录
- (NSMutableArray *)fetchAll:(NSString *)sql;       // 获取多条记录
- (void)close;                                      // 关闭连接
@end
