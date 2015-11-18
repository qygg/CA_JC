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

@end
