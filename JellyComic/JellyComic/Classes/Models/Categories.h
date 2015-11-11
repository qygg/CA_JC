//
//  Categories.h
//  JellyComic
//
//  Created by 胡智超 on 15/11/11.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import <Foundation/Foundation.h>

// 分类
@interface Categories : NSObject

@property (nonatomic, copy) NSString *title;
// 图片地址
@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *cateId;

@end
