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

@interface DataManager ()

@property (nonatomic, strong) NSMutableArray *hotListArray;
@property (nonatomic, strong) NSMutableArray *editorListArray;
@property (nonatomic, strong) NSMutableArray *hotHkListArray;
@property (nonatomic, strong) NSMutableArray *recentUpdateArray;
@property (nonatomic, strong) NSMutableArray *scrollingImageArray;

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

@end























