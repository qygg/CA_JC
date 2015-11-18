//
//  SComic.m
//  JellyComic
//
//  Created by 胡智超 on 15/11/18.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import "SComic.h"

@implementation SComic

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_comicID forKey:@"comicID"];
    [aCoder encodeObject:_comicsrcID forKey:@"comicsrcID"];
    [aCoder encodeObject:_chapterID forKey:@"chapterID"];
    [aCoder encodeInteger:_contentPage forKey:@"contentPage"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _comicID = [aDecoder decodeObjectForKey:@"comicID"];
        _comicsrcID = [aDecoder decodeObjectForKey:@"comicsrcID"];
        _chapterID = [aDecoder decodeObjectForKey:@"chapterID"];
        _contentPage = [aDecoder decodeIntegerForKey:@"contentPage"];
    }
    return self;
}

@end
