//
//  XLAmendNickNameViewController.m
//  测试3
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "XLAmendNickNameViewController.h"

@interface XLAmendNickNameViewController ()

@end

@implementation XLAmendNickNameViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0.898 green:0.945 blue:1.000 alpha:1.000];
    self.title = @"修改昵称";
    self.nickName = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, self.view.frame.size.width - 20, 40)];
    self.nickName.borderStyle = UITextBorderStyleRoundedRect;
    self.nickName.text = self.string;
    [self.nickName becomeFirstResponder];
    [self.view addSubview:_nickName];
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    submitButton.backgroundColor = [UIColor colorWithRed:0.812 green:0.898 blue:1.000 alpha:1.000];
    submitButton.tintColor = [UIColor colorWithRed:0.686 green:0.278 blue:1.000 alpha:1.000];
    submitButton.frame = CGRectMake(10, 140, self.view.frame.size.width - 20, 40);
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return"] style:UIBarButtonItemStyleDone target:self action:@selector(returnAction:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:0.686 green:0.278 blue:1.000 alpha:1.000];
}

- (void)returnAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)submitAction:(UIButton *)sender
{
    if (self.returnBlock != nil) {
        self.returnBlock(self.nickName.text);
    }
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
