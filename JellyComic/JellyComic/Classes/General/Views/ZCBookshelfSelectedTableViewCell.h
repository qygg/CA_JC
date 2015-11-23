//
//  ZCBookshelfSelectedTableViewCell.h
//  JellyComic
//
//  Created by 胡智超 on 15/11/17.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SComic;

@interface ZCBookshelfSelectedTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *detailButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (nonatomic, strong) SComic *sComic;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *chapterLabel;

@end
