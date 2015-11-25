//
//  SSContentViewController.h
//  SSContent
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 石莎莎. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Chapter;


@class SSReusableView;
@class SComic;

@interface SSContentViewController : UIViewController


@property (strong, nonatomic) NSString *site;
@property (nonatomic, strong) Chapter *chapter;
@property (nonatomic, strong) NSArray *chapterArray;    // 章节数组
@property (nonatomic, assign) NSInteger index;          // 下标
@property (nonatomic, strong) NSString *chapterID;      // 章节ID
@property (nonatomic, assign) NSInteger contectPage;    // 当前页数


@property (nonatomic, strong) NSString *comicid;         // 漫画ID
@property (nonatomic, strong) SComic *xlSComic;          // 存储模型
@end
