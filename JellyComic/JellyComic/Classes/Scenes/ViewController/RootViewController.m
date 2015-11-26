//
//  RootViewController.m
//  JellyComic
//
//  Created by 胡智超 on 15/11/11.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import "RootViewController.h"
#import "XLLocalDataManager.h"
#import "SComic.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view layoutIfNeeded];
    self.tabBar.tintColor = [UIColor colorWithRed:0.682 green:0.278 blue:1.000 alpha:1.000];
    self.tabBar.items[0].image = [UIImage imageNamed:@"tab1"];
    self.tabBar.items[1].image = [UIImage imageNamed:@"tab2"];
    self.tabBar.items[2].image = [UIImage imageNamed:@"tab3"];
    self.tabBar.items[3].image = [UIImage imageNamed:@"tab4"];
    
    
    
    
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
