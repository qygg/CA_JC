//
//  SSChapterViewController.h
//  Cartoon
//
//  Created by lanou3g on 15/11/11.
//  Copyright © 2015年 石莎莎. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SComic;
@interface SSChapterViewController : UIViewController


@property (nonatomic, strong) NSString *comicSoureID;
@property (nonatomic, strong) NSString *comicID;
@property (nonatomic, strong) NSString *siteText;
@property (nonatomic, strong) NSString *ncTitle;

@property (nonatomic, strong) SComic *xlSComic;

@end
