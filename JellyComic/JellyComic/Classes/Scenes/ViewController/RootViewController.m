//
//  RootViewController.m
//  JellyComic
//
//  Created by 胡智超 on 15/11/11.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import "RootViewController.h"
#import "DataManager.h"
#import "ScrollingImage.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[DataManager sharedDataManager] loadScrollingImageWithCompletion:^{
//        ScrollingImage *sImage = [[DataManager sharedDataManager] scrollingImage][0];
//        NSLog(@"%@", sImage.title);
//    }];
    
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