//
//  XLLoginDetailViewController.h
//  测试5
//
//  Created by lanou3g on 15/11/23.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AVObject;

@interface XLLoginDetailViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) AVObject *userInfo;

@end
