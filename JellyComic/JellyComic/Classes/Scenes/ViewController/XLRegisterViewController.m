
//
//  XLRegisterViewController.m
//  测试3
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "XLRegisterViewController.h"

@interface XLRegisterViewController ()



@end

@implementation XLRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return"] style:UIBarButtonItemStyleDone target:self action:@selector(returnAction:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor orangeColor];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userName"]];
    imgView.frame = CGRectMake(10, 82, self.view.frame.size.width * 0.07, 30);
    [self.view addSubview:imgView];
    
    self.userName = [[UITextField alloc] initWithFrame:CGRectMake(20 + imgView.frame.size.width, 80, self.view.frame.size.width - imgView.frame.size.width - 40, 40)];
    _userName.placeholder = @"账号";
    _userName.textAlignment = NSTextAlignmentLeft;
    _userName.borderStyle = UITextBorderStyleBezel;
    _userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_userName];
    UIImageView *pwdImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"key"]];
    pwdImageView.frame = CGRectMake(10, 142, self.view.frame.size.width * 0.07, 30);
    [self.view addSubview:pwdImageView];
    self.pwdName = [[UITextField alloc] initWithFrame:CGRectMake(20 + imgView.frame.size.width, 140, self.userName.frame.size.width, 40)];
    _pwdName.secureTextEntry = YES;
    _pwdName.placeholder = @"密码";
    _pwdName.textAlignment = NSTextAlignmentLeft;
    _pwdName.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdName.borderStyle = UITextBorderStyleBezel;
    [self.view addSubview:_pwdName];
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    registerButton.frame = CGRectMake(_userName.frame.origin.x + 10, 200, self.view.frame.size.width - _userName.frame.origin.x - 40, 40);
    registerButton.backgroundColor = [UIColor orangeColor];
    registerButton.tintColor = [UIColor whiteColor];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
}
- (void)registerAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)returnAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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

@end
