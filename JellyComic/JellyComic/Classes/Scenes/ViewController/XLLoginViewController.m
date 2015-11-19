//
//  XLLoginViewController.m
//  测试3
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "XLLoginViewController.h"
#import "XLRegisterViewController.h"
#import "XLFindPwdViewController.h"
#import "XLLoginDetailTableViewController.h"
@interface XLLoginViewController ()

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *registerButton;
@end

@implementation XLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"登陆";
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
    
    self.pwdName = [[UITextField alloc] initWithFrame:CGRectMake(20 + imgView.frame.size.width, 140, self.view.frame.size.width - _userName.frame.origin.x - 20, 40)];
    _pwdName.secureTextEntry = YES;
    _pwdName.placeholder = @"密码";
    _pwdName.textAlignment = NSTextAlignmentLeft;
    _pwdName.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdName.borderStyle = UITextBorderStyleBezel;
    [self.view addSubview:_pwdName];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    loginButton.frame = CGRectMake(_userName.frame.origin.x + 10, 200, self.view.frame.size.width - _userName.frame.origin.x - 40, 40);
    loginButton.backgroundColor = [UIColor orangeColor];
    loginButton.tintColor = [UIColor whiteColor];
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    registerButton.frame = CGRectMake(self.view.frame.size.width - 60, self.view.frame.size.height - 30, 50, 20);
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    UIButton *findPwdButton = [UIButton buttonWithType:UIButtonTypeSystem];
    findPwdButton.frame = CGRectMake(10, registerButton.frame.origin.y, 80, 20);
    [findPwdButton setTitle:@"找回密码" forState:UIControlStateNormal];
    [findPwdButton addTarget:self action:@selector(findPwdAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:findPwdButton];
}
#pragma mark - 找回密码点击事件
- (void)findPwdAction:(UIButton *)sender
{
    XLFindPwdViewController *xlFindPwd = [XLFindPwdViewController new];
    [self.navigationController pushViewController:xlFindPwd animated:YES];
}
#pragma mark - 注册点击事件
- (void)registerButtonAction:(UIButton *)sender
{
    XLRegisterViewController *xlRegister = [XLRegisterViewController new];
    [self.navigationController pushViewController:xlRegister animated:YES];
}
#pragma mark - 登陆点击事件
- (void)loginButtonAction:(UIButton *)sender
{
    XLLoginDetailTableViewController *xlLoginDetail = [XLLoginDetailTableViewController new];
    [self.navigationController pushViewController:xlLoginDetail animated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.pwdName resignFirstResponder];
    
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
