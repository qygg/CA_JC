//
//  XLAmendPwdViewController.m
//  测试3
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "XLAmendPwdViewController.h"

@interface XLAmendPwdViewController ()

@end

@implementation XLAmendPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"修改密码";
    self.view.backgroundColor = [UIColor whiteColor];
    self.pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, self.view.frame.size.width - 20, 40)];
    self.pwdTextField.placeholder = @"输入密码";
    self.pwdTextField.secureTextEntry = YES;
    self.pwdTextField.borderStyle = UITextBorderStyleBezel;
    self.pwdTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_pwdTextField];
    
    self.aginPwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 140, self.view.frame.size.width - 20, 40)];
    self.aginPwdTextField.placeholder = @"请输入新密码";
    self.aginPwdTextField.secureTextEntry = YES;
    self.aginPwdTextField.borderStyle = UITextBorderStyleBezel;
    self.aginPwdTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_aginPwdTextField];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    submitButton.frame = CGRectMake(10, 200, self.view.frame.size.width - 20, 40);
    submitButton.backgroundColor = [UIColor orangeColor];
    submitButton.tintColor = [UIColor whiteColor];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return"] style:UIBarButtonItemStyleDone target:self action:@selector(returnAction:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor orangeColor];
    
}

- (void)returnAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)submitAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.aginPwdTextField resignFirstResponder];
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
