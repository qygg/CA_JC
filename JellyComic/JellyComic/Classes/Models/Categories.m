//
//  Categories.m
//  JellyComic
//
//  Created by 胡智超 on 15/11/11.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import "Categories.h"

@implementation Categories

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"\n******ErrorKey:%@", key);
}

@end
