//
//  XLReconmmendCollectionViewCell.h
//  ad
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Comic;
@interface XLReconmmendCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *comicShowImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *episodeLabel;
@property (nonatomic, strong) Comic *comic;
@end
