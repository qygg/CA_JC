//
//  ZCChangePasswordViewController.m
//  JellyComic
//
//  Created by 胡智超 on 15/11/24.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import "ZCChangePasswordViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface ZCChangePasswordViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *rePasswordTextField;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
- (IBAction)submitAction:(UIButton *)sender;

@property (nonatomic, strong) UIView *hudView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation ZCChangePasswordViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.oldPasswordTextField becomeFirstResponder];
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
    self.hintLabel.hidden = YES;
    self.title = @"修改密码";
    
    self.oldPasswordTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.rePasswordTextField.delegate = self;
    self.oldPasswordTextField.tag = 104;
    self.passwordTextField.tag = 105;
    
    
}

- (IBAction)submitAction:(UIButton *)sender {
    [self.view endEditing:YES];
    self.hudView.hidden = NO;
    [self.indicatorView startAnimating];
    if ([self.passwordTextField.text isEqualToString:self.rePasswordTextField.text]) {
        [[AVUser currentUser] updatePassword:self.oldPasswordTextField.text newPassword:self.passwordTextField.text block:^(id object, NSError *error) {
            self.hudView.hidden = YES;
            [self.indicatorView stopAnimating];
            if (!error) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alertController addAction:ok];
                [self showDetailViewController:alertController sender:nil];
            } else if (error.code == 210) {
                self.hintLabel.hidden = NO;
                self.hintLabel.text = @"密码错误";
            } else if (error.code == 28) {
                self.hintLabel.hidden = NO;
                self.hintLabel.text = @"连接超时，请重试";
            } else if (error.code == 6 || error.code == 206) {
                self.hintLabel.text = @"无法连接服务器";
            } else if (error.code == 1) {
                self.hintLabel.hidden = NO;
                self.hintLabel.text = @"请输入密码";
            } else {
                self.hintLabel.hidden = NO;
                self.hintLabel.text = [NSString stringWithFormat:@"%@(%ld)", error.localizedDescription, error.code];
            }
        }];
    } else {
        self.hintLabel.hidden = NO;
        self.hintLabel.text = @"两次输入的密码不相同";
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.hintLabel.hidden = YES;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 104) {
        [self.passwordTextField becomeFirstResponder];
    } else if (textField.tag == 105) {
        [self.rePasswordTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
        [self submitAction:nil];
    }
    return YES;
}

@end




















