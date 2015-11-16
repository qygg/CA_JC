//
//  XLClassifyDetailsTableViewCell.h
//  ad
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLClassifyDetailsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *comicShowImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bestNewLabel;

@end
