//
//  ZCBookshelfCollectionViewCell.m
//  JellyComic
//
//  Created by 胡智超 on 15/11/16.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import "ZCBookshelfCollectionViewCell.h"
#import "SComic.h"
#import "UIImageView+WebCache.h"

@implementation ZCBookshelfCollectionViewCell

- (void)setSComic:(SComic *)sComic {
    self.titleLabel.text = sComic.comicTitle;
    self.updateTimeLabel.text = [NSString stringWithFormat:@"更新:%@", sComic.updateTime];
    if ([sComic.chapterTitle isEqualToString:@"(null)"]) {
        self.chapterLabel.text = @"未看";
    } else {
        self.chapterLabel.text = [NSString stringWithFormat:@"看到:%@", sComic.chapterTitle];
    }
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:sComic.comicImageUrl]];
}

@end
