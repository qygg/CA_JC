//
//  SSChapterTableViewCell.h
//  Cartoon
//
//  Created by lanou3g on 15/11/11.
//  Copyright © 2015年 石莎莎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSChapterTableViewCell : UITableViewCell

// 章节
@property (strong, nonatomic) IBOutlet UILabel *chapterLabel;
// 缓存
@property (strong, nonatomic) IBOutlet UIButton *downloadLabel;


@end
