//
//  XLReconmmendCollectionViewCell.m
//  ad
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "XLReconmmendCollectionViewCell.h"
#import "Comic.h"
@implementation XLReconmmendCollectionViewCell

- (void)setComic:(Comic *)comic
{
    
    _nameLabel.text = comic.title;
    _episodeLabel.text = comic.lastCharpter_id;
}


- (void)awakeFromNib {
    // Initialization code
}

@end
