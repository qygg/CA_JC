//
//  ComicSource.h
//  JellyComic
//
//  Created by 胡智超 on 15/11/11.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

// 漫画来源
@interface ComicSource : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *ID;
// 最新章节title
@property (nonatomic, copy) NSString *lastCharpterTitle;
// 最新章节id
@property (nonatomic, copy) NSString *lastCharpterId;
// 最近更新时间（时间戳）
@property (nonatomic, assign) CGFloat lastCharpterUpdateTime;

@end
