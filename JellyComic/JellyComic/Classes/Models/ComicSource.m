//
//  ComicSource.m
//  JellyComic
//
//  Created by 胡智超 on 15/11/11.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import "ComicSource.h"

@implementation ComicSource

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    } else {
        NSLog(@"\n******ErrorKey:%@", key);
    }
}

@end
