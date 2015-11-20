//
//  XLLocalDataManager.h
//  本地数据库
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "SComic.h"

typedef enum : NSUInteger {
    tableListhistory,
    tableListcollect
} tableList;

@interface XLLocalDataManager : NSObject

+ (instancetype)shareManager;
// 开启
- (void)open;
// 创建表
- (void)createTable:(tableList)type;
// 增
- (void)insertSComic:(SComic *)sComic tableList:(tableList)type;
// 删
- (void)deleteWithSComic:(NSString *)comicID tableList:(tableList)type;
// 查询全部
- (NSArray *)selectAllSComic:(tableList)type;
// 根据comicID查询数据模型
- (SComic *)selectWithComicID:(NSString *)comicID tableList:(tableList)type;
- (void)close;

@end
