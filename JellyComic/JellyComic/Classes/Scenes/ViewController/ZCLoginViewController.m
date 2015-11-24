//
//  ZCLoginViewController.m
//  JellyComic
//
//  Created by 胡智超 on 15/11/19.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import "ZCLoginViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "XLLoginDetailViewController.h"

@interface ZCLoginViewController () <UITextFieldDelegate>

- (IBAction)loginAction:(UIButton *)sender;
- (IBAction)backAction:(UIBarButtonItem *)sender;

@property (nonatomic, strong) UIView *hudView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation ZCLoginViewController

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
    
    self.userNameTextField.tag = 101;
    
    self.userNameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    
    
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

- (IBAction)loginAction:(UIButton *)sender {
    [self.view endEditing:YES];
    self.hudView.hidden = NO;
    [self.indicatorView startAnimating];
    [AVUser logInWithUsernameInBackground:self.userNameTextField.text password:self.passwordTextField.text block:^(AVUser *user, NSError *error) {
        self.hudView.hidden = YES;
        [self.indicatorView stopAnimating];
        if (user != nil) {
            XLLoginDetailViewController *XLLoginDetailVC = [[UIStoryboard storyboardWithName:@"XLLoginDetailViewControllerStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"loginDetail"];
            XLLoginDetailVC.userName = user.username;
            [self showViewController:XLLoginDetailVC sender:nil];

        } else {
            if (error.code == 211) {
                self.hintLabel.text = @"此用户不存在";
            } else if (error.code == 210) {
                self.hintLabel.text = @"用户名或密码错误";
            } else if (error.code == 1) {
                self.hintLabel.text = @"登录失败次数超过限制，请稍候再试，或者通过忘记密码重设密码";
            } else if (error.code == 28) {
                self.hintLabel.text = @"连接超时，请重试";
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
    if (textField.tag == 101) {
        [self.passwordTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
        [self loginAction:nil];
    }
    return YES;
}

- (IBAction)backAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

@end

















































