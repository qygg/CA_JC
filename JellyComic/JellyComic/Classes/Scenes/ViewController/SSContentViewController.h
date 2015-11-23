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
@property (nonatomic, strong) NSArray *chapterArray;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSString *chapterID;
@property (nonatomic, assign) NSInteger contectPage;


@property (nonatomic, strong) NSString *comicid;
@property (nonatomic, strong) SComic *xlSComic;
@end
