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

@interface DataManager ()

@property (nonatomic, strong) NSMutableArray *hotListArray;
@property (nonatomic, strong) NSMutableArray *editorListArray;
@property (nonatomic, strong) NSMutableArray *hotHkListArray;
@property (nonatomic, strong) NSMutableArray *recentUpdateArray;
@property (nonatomic, strong) NSMutableArray *scrollingImageArray;
@property (nonatomic, strong) NSMutableArray *chapterArray;
@property (nonatomic, strong) NSMutableArray *authorListArray;
@property (nonatomic, strong) NSMutableArray *categoryArray;
@property (nonatomic, strong) NSMutableArray *categoryDetailArray;
@property (nonatomic, strong) NSMutableArray *searchResultArray;

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
        completion();
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
        completion();
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
        completion();
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
        completion();
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
        completion();
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
        self.comicDetail = [ComicDetail mj_objectWithKeyValues:dict[@"data"]];
        completion();
    }];
    [dataTask resume];
}

- (void)loadChapterWithComicsrcid:(NSString *)comicsrcid comicid:(NSString *)comicid completion:(Callback)completion {
    NSURL *url = [NSURL URLWithString:[kChapter_URL stringByAppendingFormat:@"?comicsrcid=%@&comicid=%@", comicsrcid, comicid]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        [self.chapterArray removeAllObjects];
        for (NSDictionary *dic in dict[@"data"]) {
            Chapter *chapter = [Chapter mj_objectWithKeyValues:dic];
            [self.chapterArray addObject:chapter];
        }
        completion();
    }];
    [dataTask resume];
}

- (void)loadContentWithCharpterid:(NSString *)charpterid completion:(Callback)completion {
    NSURL *url = [NSURL URLWithString:[kContent_URL stringByAppendingFormat:@"?charpterid=%@", charpterid]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.content = [Content mj_objectWithKeyValues:dict];
        completion();
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
        for (NSDictionary *dic in dict[@"data"]) {
            Comic *comic = [Comic mj_objectWithKeyValues:dic];
            [self.authorListArray addObject:comic];
        }
        completion();
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
        completion();
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
        completion();
    }];
    [dataTask resume];
}

- (void)loadSearchResultWithKeyword:(NSString *)keyword page:(NSInteger)page completion:(Callback)completion {
    NSURL *url = [NSURL URLWithString:[kSearch_URL stringByAppendingFormat:@"&keyword=%@&page=%ld", [keyword stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]], page]];
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
            [self.searchResultArray removeAllObjects];
        }
        for (NSDictionary *dic in dict[@"data"]) {
            Comic *comic = [Comic mj_objectWithKeyValues:dic];
            [self.categoryDetailArray addObject:comic];
        }
        completion();
    }];
    [dataTask resume];
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

- (NSArray *)hotList {
    return [self.hotListArray copy];
}

- (NSArray *)editorList {
    return [self.editorListArray copy];
}

- (NSArray *)hotHkList {
    return [self.hotHkListArray copy];
}

- (NSArray *)recentUpdate {
    return [self.recentUpdateArray copy];
}

- (NSArray *)scrollingImage {
    return [self.scrollingImageArray copy];
}

- (NSArray *)chapter {
    return [self.chapterArray copy];
}

- (NSArray *)authorList {
    return [self.authorListArray copy];
}

- (NSArray *)category {
    return [self.categoryArray copy];
}

- (NSArray *)categoryDetail {
    return [self.categoryDetailArray copy];
}

- (NSArray *)searchResult {
    return [self.searchResultArray copy];
}

@end























