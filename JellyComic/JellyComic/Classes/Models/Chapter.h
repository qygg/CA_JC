//
//  Chapter.h
//  JellyComic
//
//  Created by 胡智超 on 15/11/11.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

// 章节
@interface Chapter : NSObject

@property (nonatomic, copy) NSString *title;
// 章节id
@property (nonatomic, assign) NSInteger sid;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, assign) CGFloat size;

@property (nonatomic, assign) NSInteger counts;

@property (nonatomic, assign) CGFloat iszm;

@property (nonatomic, copy) NSString *surl;

@end
