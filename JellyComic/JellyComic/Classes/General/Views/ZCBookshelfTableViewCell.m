//
//  ZCBookshelfTableViewCell.m
//  JellyComic
//
//  Created by 胡智超 on 15/11/16.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import "ZCBookshelfTableViewCell.h"
#import "SComic.h"
#import "UIImageView+WebCache.h"

@implementation ZCBookshelfTableViewCell

- (void)setSComic:(SComic *)sComic {
    self.titleLabel.text = sComic.comicTitle;
    self.sourceLabel.text = [NSString stringWithFormat:@"站点：%@", sComic.comicsrcTitle];
    self.chapterLabel.text = [NSString stringWithFormat:@"看到 %@", sComic.chapterTitle];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:sComic.comicImageUrl]];
}

@end
