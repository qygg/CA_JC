//
//  XLFindPwdViewController.m
//  测试3
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "XLFindPwdViewController.h"

@interface XLFindPwdViewController ()

@end

@implementation XLFindPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"果冻漫画-找回密码";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return"] style:UIBarButtonItemStyleDone target:self action:@selector(returnAction:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor orangeColor];
    self.emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 240, self.view.frame.size.width - 40, 40)];
    self.emailTextField.borderStyle = UITextBorderStyleBezel;
    self.emailTextField.placeholder = @"邮箱";
    self.emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_emailTextField];
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    submitButton.frame = CGRectMake(20, 300, self.view.frame.size.width - 40, 40);
    submitButton.backgroundColor = [UIColor orangeColor];
    submitButton.tintColor = [UIColor whiteColor];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
}
#pragma mark - button点击事件
- (void)submitAction:(UIButton *)sender
{
    
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
