//
//  ScrollingImage.h
//  JellyComic
//
//  Created by 胡智超 on 15/11/11.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import <Foundation/Foundation.h>

// 轮播图
@interface ScrollingImage : NSObject

@property (nonatomic, copy) NSString *title;
// 轮播图类型
@property (nonatomic, copy) NSString *recom_type;
// 返回comicid
@property (nonatomic, copy) NSString *recom_return;
// 图片地址
@property (nonatomic, copy) NSString *thumb;
// 轮播图索引
@property (nonatomic, copy) NSString *recom_index;

@end
