//
//  ZCBookshelfCollectionViewCell.h
//  JellyComic
//
//  Created by 胡智超 on 15/11/16.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SComic;

@interface ZCBookshelfCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *chapterLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateTimeLabel;
@property (nonatomic, strong) SComic *sComic;

@end
