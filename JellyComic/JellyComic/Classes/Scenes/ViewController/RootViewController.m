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
//    [[XLLocalDataManager shareManager] open];
//   NSArray *array = [[XLLocalDataManager shareManager] selectAllSComic:tableListhistory];
//    for (SComic *s in array) {
//        NSLog(@"%@",s.updateTime);
//    }
//    [[XLLocalDataManager shareManager] close];
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
