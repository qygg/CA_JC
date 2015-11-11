//
//  Comic.h
//  JellyComic
//
//  Created by 胡智超 on 15/11/11.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import <Foundation/Foundation.h>

// 漫画
@interface Comic : NSObject

@property (nonatomic, copy) NSString *title;
// 封面地址
@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *comicid;
// 作者
@property (nonatomic, copy) NSString *authorName;
// 类型
@property (nonatomic, copy) NSString *comicType;
// 最新章节id
@property (nonatomic, copy) NSString *lastCharpter_id;
// 最新章节title
@property (nonatomic, copy) NSString *lastCharpter_title;

@end
