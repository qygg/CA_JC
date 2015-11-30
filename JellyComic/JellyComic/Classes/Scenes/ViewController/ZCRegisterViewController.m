//
//  ZCRegisterViewController.m
//  JellyComic
//
//  Created by 胡智超 on 15/11/20.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import "ZCRegisterViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface ZCRegisterViewController () <UITextFieldDelegate>

- (IBAction)registerAction:(UIButton *)sender;

@property (nonatomic, strong) UIView *hudView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation ZCRegisterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.userNameTextField becomeFirstResponder];
}

- (void)loadView {
    [super loadView];
    self.hudView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    self.hudView.backgroundColor = [UIColor blackColor];
    self.hudView.alpha = 0.1;
    [self.view addSubview:self.hudView];
    
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    CGPoint point = CGPointMake(self.view.center.x, self.view.center.y - 64);
    self.indicatorView.center = point;
    [self.hudView addSubview:self.indicatorView];
    
    self.hudView.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userNameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.rePasswordTextField.delegate = self;
    self.rePasswordTextField.tag = 102;
    self.passwordTextField.tag = 103;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)registerAction:(UIButton *)sender {
    [self.view endEditing:YES];
    if (![self.passwordTextField.text isEqualToString:self.rePasswordTextField.text]) {
        self.hintLabel.text = @"两次输入的密码不相同";
        return;
    }
    self.hudView.hidden = NO;
    [self.indicatorView startAnimating];
    AVUser *user = [AVUser user];
    user.username = self.userNameTextField.text;
    user.password = self.passwordTextField.text;
    user.email = user.username;
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            AVObject *userInfo = [AVObject objectWithClassName:@"UserInfo"];
            [userInfo setObject:user.username forKey:@"userName"];
            [userInfo setObject:@"果冻用户" forKey:@"nickName"];
            NSData *data = UIImagePNGRepresentation([UIImage imageNamed:@"userdef"]);
            AVFile *file = [AVFile fileWithName:@"photo.png" data:data];
//            [userInfo setObject:data forKey:@"photo"];
            [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [userInfo setObject:file forKey:@"photo"];
                    [userInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        self.hudView.hidden = YES;
                        [self.indicatorView stopAnimating];
                        if (succeeded) {
                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注册成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                [self.navigationController popViewControllerAnimated:YES];
                            }];
                            [alertController addAction:ok];
                            [self showDetailViewController:alertController sender:nil];
                        } else {
                            self.hintLabel.text = [NSString stringWithFormat:@"%@(%ld)", error.localizedDescription, error.code];
                        }
                    }];
                } else if (error.code == 28) {
                    self.hintLabel.text = @"连接超时，请重试";
                } else if (error.code == 6 || error.code == 206) {
                    self.hintLabel.text = @"无法连接服务器";
                } else {
                    self.hintLabel.text = [NSString stringWithFormat:@"%@(%ld)", error.localizedDescription, error.code];
                }
            }];
        } else {
            self.hudView.hidden = YES;
            [self.indicatorView stopAnimating];
            if (error.code == 125) {
                self.hintLabel.text = @"请输入正确的邮箱地址";
            } else if (error.code == 203) {
                self.hintLabel.text = @"邮箱已被使用";
            } else if (error.code == 28) {
                self.hintLabel.text = @"连接超时，请重试";
            } else if (error.code == 6 || error.code == 206) {
                self.hintLabel.text = @"无法连接服务器";
            } else if (error.code == 218) {
                self.hintLabel.text = @"密码不能为空";
            } else {
                self.hintLabel.text = [NSString stringWithFormat:@"%@(%ld)", error.localizedDescription, error.code];
            }
        }
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.hintLabel.text = @"";
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 102) {
        [textField resignFirstResponder];
        [self registerAction:nil];
    } else if (textField.tag == 103) {
        [self.rePasswordTextField becomeFirstResponder];
    } else {
        [self.passwordTextField becomeFirstResponder];
    }
    return YES;
}

@end





















