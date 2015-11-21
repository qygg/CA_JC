//
//  SSDetailTableViewController.h
//  Cartoon
//
//  Created by lanou3g on 15/11/11.
//  Copyright © 2015年 石莎莎. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ComicDetail;
@class SComic;
@interface SSDetailTableViewController : UITableViewController

@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIImageView *imgView;               // 图片
@property (strong, nonatomic) UILabel *titleLabel;                // 标题
@property (strong, nonatomic) UIButton *authorButton;             // 作者
@property (strong, nonatomic) UILabel *regionLabel;               // 地区
@property (strong, nonatomic) UILabel *typeLabel;                 // 种类
@property (strong, nonatomic) UIButton *collectButton;            // 收藏按钮
@property (strong, nonatomic) UIButton *startReadButton;          // 阅读按钮
@property (strong, nonatomic) UILabel *introduceLabel;            // 简介
@property (strong, nonatomic) UILabel *hintLabel;                 // 提示
@property (strong, nonatomic) UILabel *arrowLabel;


@property (strong, nonatomic) NSString  *comicId;                  // 漫画id



@end
