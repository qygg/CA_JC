//
//  ZCCategoryViewController.m
//  JellyComic
//
//  Created by 胡智超 on 15/11/12.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import "ZCCategoryViewController.h"
#import "ZCCategoryCollectionViewCell.h"
#import "DataManager.h"

@interface ZCCategoryViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;


@end

@implementation ZCCategoryViewController

static NSString * const reuseID = @"category";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width / 3-7, 200);
    NSLog(@"%lf,%lf", self.flowLayout.minimumLineSpacing, self.flowLayout.minimumInteritemSpacing);
//    self.flowLayout.minimumInteritemSpacing = 0;
//    self.flowLayout.minimumLineSpacing = 0;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZCCategoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseID];
    
    [[DataManager sharedDataManager] loadCategoryWithCompletion:^{
        [self.collectionView reloadData];
    }];
//    UICollectionViewFlowLayout
    
}

#pragma mark - UICollectionViewDelegate & DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [DataManager sharedDataManager].category.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    cell.category = [DataManager sharedDataManager].category[indexPath.item];
    return cell;
}


@end























