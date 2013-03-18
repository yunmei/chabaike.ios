//
//  BaiteDB.m
//  chabaike
//
//  Created by Mac on 12-4-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DBsqlite.h"

@implementation DBsqlite

@synthesize link;
// 获取数据库文件路径
- (NSString *)dataFilePath:(NSString *)dbname
{
    NSString *documentPath =@"";
    //NSLog(@"dbname %@",dbname);
    if([dbname isEqualToString:DBNAME])
    {
        documentPath= [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    }
    else {
        documentPath= [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    }
    
    NSString *realPath = [documentPath stringByAppendingPathComponent:dbname];
    
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:[dbname stringByReplacingOccurrencesOfString:@".sqlite" withString:@""] ofType:@"sqlite"];
    //NSLog(@"sourcePath is %@",sourcePath);
    //NSLog(@"realPath is %@",realPath);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:realPath]) {
        NSError *error;
        if (![fileManager copyItemAtPath:sourcePath toPath:realPath error:&error]) {
            NSLog(@"%@",[error localizedDescription]);
        }
    }
    
    return realPath;
}
// 连接数据库
- (BOOL)connect
{
    return [self connectapp:DBNAME];
}
// 连接数据库转换
- (BOOL)connectapp:(NSString *)app
{
    if (sqlite3_open([[self dataFilePath:app] UTF8String], &link) != SQLITE_OK)
    {
        sqlite3_close(link);
        return NO;
    }
    return YES;
}
// 连接收藏数据库
- (BOOL)connectFav
{
    return [self connectapp:DBNAMEFAV];
}
- (BOOL)connectSearch
{
    return [self connectapp:DBNAMESEARCH];
}
// 执行Sql语句
- (BOOL)exec:(NSString *)sql
{
    char *errorMsg;
    if (sqlite3_exec(link, [sql UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
        return NO;
    }
    return YES;
}
// 返回记录总数
-(NSString *)count:(NSString *)tableName
{
    NSString *sql=[NSString stringWithFormat:@"SELECT COUNT(*) count FROM %@", tableName];
    NSMutableDictionary *result = [self fetchOne:sql];
    return [result objectForKey:@"count"];
}

// 获取一条记录
- (NSMutableDictionary *)fetchOne:(NSString *)sql
{
    sqlite3_stmt *statement;
    NSMutableDictionary *dicData = [[NSMutableDictionary alloc]init];
    if(sqlite3_prepare_v2(link, [sql UTF8String], -1, &statement, nil) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW) {
            int count = sqlite3_column_count(statement);
            NSString *value = [[NSString alloc]init];
            NSString *columnName = [[NSString alloc]init];
            int type;
            for (int i=0; i<count; i++) {
                type = sqlite3_column_type(statement, i);
                if (type == SQLITE_INTEGER) {
                    value = [NSString stringWithFormat:@"%d", sqlite3_column_int(statement, i)];
                } else if (type == SQLITE_TEXT) {
                    value = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, i)];
                } else {
                    value = @"";
                }
                columnName = [NSString stringWithFormat:@"%s", (char *)sqlite3_column_name(statement, i)];
                [dicData setObject:value forKey:columnName];
            }
        }
        sqlite3_finalize(statement);
    }
    return dicData;
}
// 获取多条记录
- (NSMutableArray *)fetchAll:(NSString *)sql 
{
    sqlite3_stmt *statement;
    NSMutableArray *dicArray = [[NSMutableArray alloc]init];
    if(sqlite3_prepare_v2(link, [sql UTF8String], -1, &statement, nil) == SQLITE_OK)
    {
        NSMutableDictionary *dicData = [[NSMutableDictionary alloc]init];
        while (sqlite3_step(statement) == SQLITE_ROW) {
            dicData = [[NSMutableDictionary alloc]init];
            int count = sqlite3_column_count(statement);
            NSString *value = [[NSString alloc]init];
            NSString *columnName = [[NSString alloc]init];
            int type;
            for (int i=0; i<count; i++) {
                type = sqlite3_column_type(statement, i);
                if (type == SQLITE_INTEGER) {
                    value = [NSString stringWithFormat:@"%d", sqlite3_column_int(statement, i)];
                } else if (type == SQLITE_TEXT) {
                    value = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, i)];
                } else if (type == SQLITE_FLOAT) {
                    value = [NSString stringWithFormat:@"%f", sqlite3_column_double(statement, i)];
                } else {
                    value = nil;
                }
                columnName = [NSString stringWithFormat:@"%s", (char *)sqlite3_column_name(statement, i)];
                [dicData setObject:value forKey:columnName];
            }
            [dicArray addObject:dicData];
        }
        sqlite3_finalize(statement);
    }
    return dicArray;
}

// 关闭数据库
- (void)close
{
    sqlite3_close(link);
}
@end
