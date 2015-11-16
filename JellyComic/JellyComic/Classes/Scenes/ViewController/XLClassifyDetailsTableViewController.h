//
//  XLClassifyDetailsTableViewController.h
//  测试1
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Categories.h"
@class Comic;

@interface XLClassifyDetailsTableViewController : UITableViewController
@property (nonatomic, strong) NSString *cateId;

@property (nonatomic, strong) Comic *comic;
@property (nonatomic, strong) Categories *categories;
@end
