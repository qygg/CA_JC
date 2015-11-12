//
//  DataManager.h
//  JellyComic
//
//  Created by 胡智超 on 15/11/11.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ComicDetail, Content;

typedef void (^Callback)();
// 分类类型
typedef enum : NSUInteger {
    CategoryTypeTophot,  // 热门
    CategoryTypeTime,  // 最新
    CategoryTypeFinished  // 完结
} CategoryType;

@interface DataManager : NSObject

+ (instancetype)sharedDataManager;
// 轮播图
- (void)loadScrollingImageWithCompletion:(Callback)completion;
// 热门连载
- (void)loadHotlistWithPage:(NSInteger)page completion:(Callback)completion;
// 小编推荐
- (void)loadEditorlistWithPage:(NSInteger)page completion:(Callback)completion;
// 精彩港漫
- (void)loadHothklistWithPage:(NSInteger)page completion:(Callback)completion;
// 最近更新
- (void)loadRecentUpdateWithPage:(NSInteger)page completion:(Callback)completion;
// 漫画详情
- (void)loadDetailWithComicid:(NSString *)comicid completion:(Callback)completion;
// 章节列表
- (void)loadChapterWithComicsrcid:(NSString *)comicsrcid comicid:(NSString *)comicid completion:(Callback)completion;
// 章节内容
- (void)loadContentWithCharpterid:(NSString *)charpterid completion:(Callback)completion;
// 作者作品
- (void)loadAuthorlistWithComicid:(NSString *)comicid page:(NSInteger)page completion:(Callback)completion;
// 分类
- (void)loadCategoryWithCompletion:(Callback)completion;
// 分类详情
- (void)loadCategoryDetailWithCategoryType:(CategoryType)type cateId:(NSString *)cateId page:(NSInteger)page completion:(Callback)completion;
// 搜索结果
- (void)loadSearchResultWithKeyword:(NSString *)keyword page:(NSInteger)page completion:(Callback)completion;


// 获取轮播图
- (NSArray *)scrollingImage;
// 获取热门连载
- (NSArray *)hotList;
// 获取小编推荐
- (NSArray *)editorList;
// 获取精彩港漫
- (NSArray *)hotHkList;
// 获取最近更新
- (NSArray *)recentUpdate;
// 获取漫画详情
@property (nonatomic, strong) ComicDetail *comicDetail;
// 获取章节列表
- (NSArray *)chapter;
// 获取章节内容
@property (nonatomic, strong) Content *content;
// 获取作者作品
- (NSArray *)authorList;
// 获取分类
- (NSArray *)category;
// 获取分类详情
- (NSArray *)categoryDetail;
// 获取搜索结果
- (NSArray *)searchResult;

@end









