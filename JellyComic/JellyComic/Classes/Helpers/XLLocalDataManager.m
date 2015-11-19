//
//  XLLocalDataManager.m
//  本地数据库
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "XLLocalDataManager.h"

@implementation XLLocalDataManager
+ (instancetype)shareManager
{
    static XLLocalDataManager *dbManager = nil;
    if (dbManager == nil) {
        dbManager = [XLLocalDataManager new];
    }
    return dbManager;
}
static sqlite3 *db = nil;
- (void)open
{
    if (db != nil) {
        return;
    }
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"SComic.sqlite"];
    int result = sqlite3_open(path.UTF8String, &db);
    if (result == SQLITE_OK) {
        NSLog(@"打开成功");
    }else
    {
        NSLog(@"打开失败");
    }
}
- (void)createTable
{
    NSString *sqlString = @"CREATE  TABLE IF NOT EXISTS 'scomic' ('comicID' TEXT PRIMARY KEY NOT NULL, 'comicsrcID' TEXT NOT NULL, 'chapterID' TEXT NOT NULL, 'contentPage'INTEGER NOT NULL)";
    char *error = nil;
    sqlite3_exec(db, sqlString.UTF8String, nil, nil, &error);
    if (error == nil) {
        NSLog(@"创建成功");
    }else
    {
        NSLog(@"创建失败,失败操作数== '%s'",error);
    }
}
- (void)insertSComic:(SComic *)sComic
{
    NSString *sqlString = [NSString stringWithFormat:@"insert into 'scomic' (comicID,comicsrcID,chapterID,contentPage) values ('%@','%@','%@','%ld')",sComic.comicID,sComic.comicsrcID,sComic.chapterID,sComic.contentPage];
    char *error = nil;
    sqlite3_exec(db, sqlString.UTF8String, nil, nil, &error);
    if (error == nil) {
        NSLog(@"插入成功");
    }else
    {
        NSLog(@"插入失败");
    }
}
- (void)deleteWithSComic:(NSString *)comicID
{
    NSString *sqlString = [NSString stringWithFormat:@"delete from 'scomic' where comicID = '%@'",comicID];
    char *error = nil;
    sqlite3_exec(db, sqlString.UTF8String, nil, nil, &error);
    if (error == nil) {
        NSLog(@"删除成功");
    }else
    {
        NSLog(@"删除失败");
    }
}
- (NSArray *)selectAllSComic
{
    NSMutableArray *array = nil;
    sqlite3_stmt *stmt = nil;
    NSString *sqlString = @"select *from 'scomic'";
    int result = sqlite3_prepare(db, sqlString.UTF8String, -1, &stmt, nil);
    if (result == SQLITE_OK) {
        array = [[NSMutableArray alloc] initWithCapacity:20];
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            SComic *s = [SComic new];
            s.comicID = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            s.comicsrcID = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            s.chapterID = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            s.contentPage = sqlite3_column_int(stmt, 3);
            [array addObject:s];
        }
    }else{
        NSLog(@"查询失败，失败操作数为%d",result);
    }
    for (SComic *s in array) {
        NSLog(@"%@",s);
    }
    sqlite3_finalize(stmt);
    return array;
}
- (SComic *)selectWithComicID:(NSString *)comicID
{
    SComic *s = [SComic new];
    NSString *sqlString = [NSString stringWithFormat:@"select * from 'scomic' where comicID = '%@'",comicID];
    static sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare(db, sqlString.UTF8String, -1, &stmt, nil);
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            s.comicID = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            s.comicsrcID = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            s.chapterID = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            s.contentPage = sqlite3_column_int(stmt, 3);
        }
    }
    sqlite3_finalize(stmt);
    return s;
}
- (void)close
{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        db = nil;
        NSLog(@"关闭成功");
    }else
    {
        NSLog(@"关闭失败");
    }
}
@end
