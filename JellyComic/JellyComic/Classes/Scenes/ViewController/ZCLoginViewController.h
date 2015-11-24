//
//  ZCLoginViewController.h
//  JellyComic
//
//  Created by 胡智超 on 15/11/19.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;

@end
