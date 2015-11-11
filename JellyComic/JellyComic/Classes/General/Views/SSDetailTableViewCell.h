//
//  SSDetailTableViewCell.h
//  Cartoon
//
//  Created by lanou3g on 15/11/11.
//  Copyright © 2015年 石莎莎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSDetailTableViewCell : UITableViewCell

// 站点
@property (strong, nonatomic) IBOutlet UILabel *siteLabel;
// 最新更新
@property (strong, nonatomic) IBOutlet UILabel *upDateLabel;
// 日期
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;


@end
