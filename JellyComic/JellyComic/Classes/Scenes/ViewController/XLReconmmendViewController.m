//
//  XLReconmmendViewController.m
//  JellyComic
//
//  Created by lanou3g on 15/11/14.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import "XLReconmmendViewController.h"
#import "XLReconmmendView.h"
@interface XLReconmmendViewController ()
@property (nonatomic, strong) XLReconmmendView *xlRecommendView;
@property (assign) NSInteger tabCount;
@end

@implementation XLReconmmendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tabCount = 4;
    [self initSlideWithCount:_tabCount];
}

- (void)initSlideWithCount:(NSInteger)count
{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    _xlRecommendView = [[XLReconmmendView alloc] initWithFrame:screenBound WithCount:count];
    _xlRecommendView.xlReconmmendViewController = self;
    [self.view addSubview:_xlRecommendView];
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
