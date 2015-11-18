//
//  DataManager.m
//  JellyComic
//
//  Created by 胡智超 on 15/11/11.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import "DataManager.h"
#import "URLs.h"
#import "MJExtension.h"
#import "ScrollingImage.h"
#import "Comic.h"
#import "ComicDetail.h"
#import "Chapter.h"
#import "Content.h"
#import "Categories.h"
#import "ComicSource.h"

@interface DataManager ()

@property (nonatomic, strong) NSMutableArray<Comic *> *hotListArray;
@property (nonatomic, strong) NSMutableArray<Comic *> *editorListArray;
@property (nonatomic, strong) NSMutableArray<Comic *> *hotHkListArray;
@property (nonatomic, strong) NSMutableArray<Comic *> *recentUpdateArray;
@property (nonatomic, strong) NSMutableArray<ScrollingImage *> *scrollingImageArray;
@property (nonatomic, strong) NSMutableArray<Chapter *> *chapterArray;
@property (nonatomic, strong) NSMutableArray<Comic *> *authorListArray;
@property (nonatomic, strong) NSMutableArray<Categories *> *categoryArray;
@property (nonatomic, strong) NSMutableArray<Comic *> *categoryDetailArray;
@property (nonatomic, strong) NSMutableArray<Comic *> *searchResultArray;

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation DataManager

+ (instancetype)sharedDataManager {
    static DataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [DataManager new];
    });
    return manager;
}

- (void)loadScrollingImageWithCompletion:(Callback)completion {
    NSURL *url = [NSURL URLWithString:kScrollingImage_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        [self.scrollingImageArray removeAllObjects];
        for (NSDictionary *dic in dict[@"data"]) {
            ScrollingImage *sImage = [ScrollingImage mj_objectWithKeyValues:dic];
            [self.scrollingImageArray addObject:sImage];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion();
        });
    }];
    [dataTask resume];
}

- (void)loadHotlistWithPage:(NSInteger)page completion:(Callback)completion {
    NSURL *url = [NSURL URLWithString:[kHotlist_URL stringByAppendingFormat:@"&page=%ld", page]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (page == 1) {
            [self.hotListArray removeAllObjects];
        }
        [Comic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"lastCharpter_id": @"lastCharpter.id",
                     @"lastCharpter_title": @"lastCharpter.title"
                     };
        }];
        for (NSDictionary *dic in dict[@"data"]) {
            Comic *comic = [Comic mj_objectWithKeyValues:dic];
            [self.hotListArray addObject:comic];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion();
        });
    }];
    [dataTask resume];
}

- (void)loadEditorlistWithPage:(NSInteger)page completion:(Callback)completion {
    NSURL *url = [NSURL URLWithString:[kEditorlist_URL stringByAppendingFormat:@"&page=%ld", page]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (page == 1) {
            [self.editorListArray removeAllObjects];
        }
        [Comic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"lastCharpter_id": @"lastCharpter.id",
                     @"lastCharpter_title": @"lastCharpter.title"
                     };
        }];
        for (NSDictionary *dic in dict[@"data"]) {
            Comic *comic = [Comic mj_objectWithKeyValues:dic];
            [self.editorListArray addObject:comic];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion();
        });
    }];
    [dataTask resume];
}

- (void)loadHothklistWithPage:(NSInteger)page completion:(Callback)completion {
    NSURL *url = [NSURL URLWithString:[kHothklist_URL stringByAppendingFormat:@"&page=%ld", page]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (page == 1) {
            [self.hotHkListArray removeAllObjects];
        }
        [Comic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"lastCharpter_id": @"lastCharpter.id",
                     @"lastCharpter_title": @"lastCharpter.title"
                     };
        }];
        for (NSDictionary *dic in dict[@"data"]) {
            Comic *comic = [Comic mj_objectWithKeyValues:dic];
            [self.hotHkListArray addObject:comic];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion();
        });
    }];
    [dataTask resume];
}

- (void)loadRecentUpdateWithPage:(NSInteger)page completion:(Callback)completion {
    NSURL *url = [NSURL URLWithString:[kRecentUpdate_URL stringByAppendingFormat:@"&page=%ld", page]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (page == 1) {
            [self.recentUpdateArray removeAllObjects];
        }
        [Comic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"lastCharpter_id": @"lastCharpter.id",
                     @"lastCharpter_title": @"lastCharpter.title"
                     };
        }];
        for (NSDictionary *dic in dict[@"data"]) {
            Comic *comic = [Comic mj_objectWithKeyValues:dic];
            [self.recentUpdateArray addObject:comic];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion();
        });
    }];
    [dataTask resume];
}

- (void)loadDetailWithComicid:(NSString *)comicid completion:(Callback)completion {
    NSURL *url = [NSURL URLWithString:[kDetail_URL stringByAppendingFormat:@"&comicid=%@", comicid]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        [ComicDetail mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"comicSrc": @"ComicSource"
                     };
        }];
        [ComicSource mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"ID": @"id"
                     };
        }];
        self.comicDetail = [ComicDetail mj_objectWithKeyValues:dict[@"data"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion();
        });
    }];
    [dataTask resume];
}

- (void)loadChapterWithComicsrcid:(NSString *)comicsrcid comicid:(NSString *)comicid completion:(Callback)completion {
    NSURL *url = [NSURL URLWithString:[kChapter_URL stringByAppendingFormat:@"?comicsrcid=%@&comicid=%@", comicsrcid, comicid]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        [self.chapterArray removeAllObjects];
        [Chapter mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"ID": @"id"
                     };
        }];
        for (NSDictionary *dic in dict[@"data"]) {
            Chapter *chapter = [Chapter mj_objectWithKeyValues:dic];
            [self.chapterArray addObject:chapter];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion();
        });
    }];
    [dataTask resume];
}

- (void)loadContentWithCharpterid:(NSString *)charpterid completion:(Callback)completion {
    NSURL *url = [NSURL URLWithString:[kContent_URL stringByAppendingFormat:@"?charpterid=%@", charpterid]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.content = [Content mj_objectWithKeyValues:dict];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion();
        });
    }];
    [dataTask resume];
}

- (void)loadAuthorlistWithComicid:(NSString *)comicid page:(NSInteger)page completion:(Callback)completion {
    NSURL *url = [NSURL URLWithString:[kAuthorlist_URL stringByAppendingFormat:@"&comicid=%@&page=%ld", comicid, page]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (page == 1) {
            [self.authorListArray removeAllObjects];
        }
        if (![dict[@"data"] isEqual:[NSNull null]]) {
            for (NSDictionary *dic in dict[@"data"]) {
                Comic *comic = [Comic mj_objectWithKeyValues:dic];
                [self.authorListArray addObject:comic];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion();
        });
    }];
    [dataTask resume];
}

- (void)loadCategoryWithCompletion:(Callback)completion {
    NSURL *url = [NSURL URLWithString:kCategory_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        [self.categoryArray removeAllObjects];
        for (NSDictionary *dic in dict[@"data"]) {
            Categories *category = [Categories mj_objectWithKeyValues:dic];
            [self.categoryArray addObject:category];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion();
        });
    }];
    [dataTask resume];
}

- (void)loadCategoryDetailWithCategoryType:(CategoryType)type cateId:(NSString *)cateId page:(NSInteger)page completion:(Callback)completion {
    NSString *categoryType = nil;
    switch (type) {
        case CategoryTypeTophot:
            categoryType = @"tophot";
            break;
        case CategoryTypeTime:
            categoryType = @"time";
            break;
        case CategoryTypeFinished:
            categoryType = @"finished";
            break;
    }
    NSURL *url = [NSURL URLWithString:[kCategoryDetail_URL stringByAppendingFormat:@"&%@=1&cateId=%@&page=%ld", categoryType, cateId, page]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        [Comic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"lastCharpter_id": @"lastCharpter.id",
                     @"lastCharpter_title": @"lastCharpter.title"
                     };
        }];
        if (page == 1) {
            [self.categoryDetailArray removeAllObjects];
        }
        for (NSDictionary *dic in dict[@"data"]) {
            Comic *comic = [Comic mj_objectWithKeyValues:dic];
            [self.categoryDetailArray addObject:comic];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion();
        });
    }];
    [dataTask resume];
}

- (void)loadSearchResultWithKeyword:(NSString *)keyword page:(NSInteger)page completion:(Callback)completion {
    NSURL *url = [NSURL URLWithString:[kSearch_URL stringByAppendingFormat:@"&keyword=%@&page=%ld", [keyword stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]], page]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    [self.dataTask cancel];
    self.dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (page == 1) {
            [self.searchResultArray removeAllObjects];
        }
        if (data != nil) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            [Comic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{
                         @"lastCharpter_id": @"lastCharpter.id",
                         @"lastCharpter_title": @"lastCharpter.title"
                         };
            }];
            if (![dict[@"data"] isEqual:[NSNull null]]) {
                for (NSDictionary *dic in dict[@"data"]) {
                    Comic *comic = [Comic mj_objectWithKeyValues:dic];
                    [self.searchResultArray addObject:comic];
                }
            }
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion();
        });
    }];
    [self.dataTask resume];
}

- (NSMutableArray *)hotListArray {
    if (!_hotListArray) {
        _hotListArray = [NSMutableArray array];
    }
    return _hotListArray;
}

- (NSMutableArray *)editorListArray {
    if (!_editorListArray) {
        _editorListArray = [NSMutableArray array];
    }
    return _editorListArray;
}

- (NSMutableArray *)hotHkListArray {
    if (!_hotHkListArray) {
        _hotHkListArray = [NSMutableArray array];
    }
    return _hotHkListArray;
}

- (NSMutableArray *)recentUpdateArray {
    if (!_recentUpdateArray) {
        _recentUpdateArray = [NSMutableArray array];
    }
    return _recentUpdateArray;
}

- (NSMutableArray *)scrollingImageArray {
    if (!_scrollingImageArray) {
        _scrollingImageArray = [NSMutableArray array];
    }
    return _scrollingImageArray;
}

- (NSMutableArray *)chapterArray {
    if (!_chapterArray) {
        _chapterArray = [NSMutableArray array];
    }
    return _chapterArray;
}

- (NSMutableArray *)authorListArray {
    if (!_authorListArray) {
        _authorListArray = [NSMutableArray array];
    }
    return _authorListArray;
}

- (NSMutableArray *)categoryArray {
    if (!_categoryArray) {
        _categoryArray = [NSMutableArray array];
    }
    return _categoryArray;
}

- (NSMutableArray *)categoryDetailArray {
    if (!_categoryDetailArray) {
        _categoryDetailArray = [NSMutableArray array];
    }
    return _categoryDetailArray;
}

- (NSMutableArray *)searchResultArray {
    if (!_searchResultArray) {
        _searchResultArray = [NSMutableArray array];
    }
    return _searchResultArray;
}

- (NSArray<Comic *> *)hotList {
    return [self.hotListArray copy];
}

- (NSArray<Comic *> *)editorList {
    return [self.editorListArray copy];
}

- (NSArray<Comic *> *)hotHkList {
    return [self.hotHkListArray copy];
}

- (NSArray<Comic *> *)recentUpdate {
    return [self.recentUpdateArray copy];
}

- (NSArray<ScrollingImage *> *)scrollingImage {
    return [self.scrollingImageArray copy];
}

- (NSArray<Chapter *> *)chapter {
    return [self.chapterArray copy];
}

- (NSArray<Comic *> *)authorList {
    return [self.authorListArray copy];
}

- (NSArray<Categories *> *)category {
    return [self.categoryArray copy];
}

- (NSArray<Comic *> *)categoryDetail {
    return [self.categoryDetailArray copy];
}

- (NSArray<Comic *> *)searchResult {
    return [self.searchResultArray copy];
}

@end



















