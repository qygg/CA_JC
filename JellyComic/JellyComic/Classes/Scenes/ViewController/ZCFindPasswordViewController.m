//
//  ZCFindPasswordViewController.m
//  JellyComic
//
//  Created by 胡智超 on 15/11/20.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import "ZCFindPasswordViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface ZCFindPasswordViewController () <UITextFieldDelegate>

- (IBAction)findPasswordAction:(UIButton *)sender;

@property (nonatomic, strong) UIView *hudView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation ZCFindPasswordViewController

- (void)viewWillAppear:(BOOL)animated {
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

- (IBAction)findPasswordAction:(UIButton *)sender {
    [self.view endEditing:YES];
    self.hudView.hidden = NO;
    [self.indicatorView startAnimating];
    [AVUser requestPasswordResetForEmailInBackground:self.userNameTextField.text block:^(BOOL succeeded, NSError *error) {
        self.hudView.hidden = YES;
        [self.indicatorView stopAnimating];
        if (succeeded) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"邮件发送成功，请注意查收" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alertController addAction:ok];
            [self showDetailViewController:alertController sender:nil];
        } else {
            if (error.code == 204) {
                self.hintLabel.text = @"请输入邮箱地址";
            } else if (error.code == 205) {
                self.hintLabel.text = @"此用户不存在";
            } else if (error.code == 28) {
                self.hintLabel.text = @"连接超时，请重试";
            } else if (error.code == 1) {
                self.hintLabel.text = @"发送过多邮件，请稍后再试";
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
    [textField resignFirstResponder];
    [self findPasswordAction:nil];
    return YES;
}

@end











































