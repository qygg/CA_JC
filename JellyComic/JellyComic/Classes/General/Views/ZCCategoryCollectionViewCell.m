//
//  ZCCategoryCollectionViewCell.m
//  JellyComic
//
//  Created by 胡智超 on 15/11/12.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import "ZCCategoryCollectionViewCell.h"
#import "Categories.h"
#import "UIImageView+WebCache.h"

@implementation ZCCategoryCollectionViewCell

- (void)setCategory:(Categories *)category {
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:category.thumb]];
    self.titleLabel.text = category.title;
}

@end
