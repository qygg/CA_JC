//
//  XLLoginDetailTableViewController.h
//  测试3
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XLChangeHeadTableViewCell;
@class XLDetialTableViewCell;
@interface XLLoginDetailTableViewController : UITableViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UIImageView *contextImageView;
@property (nonatomic, strong) NSString *context;
@property (nonatomic, strong) NSString *lastChosenMediaType;
@property (nonatomic, strong) XLChangeHeadTableViewCell *headCell;
@property (nonatomic, strong) XLDetialTableViewCell *nickCell;
@end
