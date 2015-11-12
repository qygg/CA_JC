//
//  ComicDetail.h
//  JellyComic
//
//  Created by 胡智超 on 15/11/11.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ComicSource;

// 漫画详情
@interface ComicDetail : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *comicId;
// 封面地址
@property (nonatomic, copy) NSString *thumb;
// 作者
@property (nonatomic, copy) NSString *autherName;
// 类型
@property (nonatomic, copy) NSString *comicType;
// 地区
@property (nonatomic, copy) NSString *areaName;
// 更新时间
@property (nonatomic, copy) NSString *updateTime;
// 漫画来源
@property (nonatomic, strong) NSArray<ComicSource *> *comicSrc;
// 评论数
@property (nonatomic, copy) NSString *tucaos;
// 简介
@property (nonatomic, copy) NSString *intro;
// 未知参数
@property (nonatomic, copy) NSString *charpters;


@end
