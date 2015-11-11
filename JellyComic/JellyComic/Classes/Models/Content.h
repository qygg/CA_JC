//
//  Content.h
//  JellyComic
//
//  Created by 胡智超 on 15/11/11.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

// 内容
@interface Content : NSObject

@property (nonatomic, copy) NSString *charpterId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *sid;

@property (nonatomic, assign) CGFloat updateTime;

@property (nonatomic, assign) NSInteger counts;

@property (nonatomic, assign) CGFloat size;
// 内容图片地址
@property (nonatomic, strong) NSArray<NSString *> *addrs;

@property (nonatomic, copy) NSString *surl;

@property (nonatomic, assign) CGFloat iszm;

@end
