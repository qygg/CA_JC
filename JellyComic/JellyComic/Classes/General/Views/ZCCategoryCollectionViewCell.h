//
//  ZCCategoryCollectionViewCell.h
//  JellyComic
//
//  Created by 胡智超 on 15/11/12.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Categories;

@interface ZCCategoryCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) Categories *category;

@end
