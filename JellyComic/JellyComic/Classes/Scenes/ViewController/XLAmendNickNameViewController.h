//
//  XLAmendNickNameViewController.h
//  测试3
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ReturnBlock)(NSString *string);
@interface XLAmendNickNameViewController : UIViewController
@property (nonatomic, strong) UITextField *nickName;
@property (nonatomic, copy) ReturnBlock returnBlock;
@end
