//
//  SSContentViewController.h
//  SSContent
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 石莎莎. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SSReusableView;
@class SComic;
@interface SSContentViewController : UIViewController


@property (nonatomic, strong) NSString *chapterID;
@property (strong, nonatomic) SSReusableView *reusableView;
@property (strong, nonatomic) NSString *site;

@property (nonatomic, strong) SComic *xlSComic;
@end
