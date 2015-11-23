//
//  SComic.h
//  JellyComic
//
//  Created by 胡智超 on 15/11/18.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SComic : NSObject <NSCoding>

@property (nonatomic, copy) NSString *comicID;
@property (nonatomic, copy) NSString *comicsrcID;
@property (nonatomic, copy) NSString *chapterID;
@property (nonatomic, assign) NSInteger contentPage;
@property (nonatomic, copy) NSString *comicTitle;
@property (nonatomic, copy) NSString *comicsrcTitle;
@property (nonatomic, copy) NSString *chapterTitle;
@property (nonatomic, copy) NSString *comicImageUrl;
// 更新时间
@property (nonatomic, copy) NSString *updateTime;

@end
