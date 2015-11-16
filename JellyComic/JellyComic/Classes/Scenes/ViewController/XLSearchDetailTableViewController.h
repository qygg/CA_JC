//
//  XLSearchDetailTableViewController.h
//  JellyComic
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Comic;
@interface XLSearchDetailTableViewController : UITableViewController
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) Comic *comic;
@end
