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
#import "Categories.h"

@interface ZCCategoryViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@end

@implementation ZCCategoryViewController

static NSString * const reuseID = @"category";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar.backgroundColor = [UIColor clearColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width / 3 - 10, self.view.bounds.size.width / 3);
    self.flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZCCategoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseID];
    
    [[DataManager sharedDataManager] loadCategoryWithCompletion:^{
        [self.collectionView reloadData];
    }];

    
    
}

#pragma mark - UICollectionViewDelegate & DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [DataManager sharedDataManager].category.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    [cell layoutIfNeeded];
    cell.imgView.layer.cornerRadius = cell.imgView.bounds.size.width / 2;
    cell.imgView.layer.masksToBounds = YES;
    cell.category = [DataManager sharedDataManager].category[indexPath.item];
    return cell;
}

#pragma mark - item点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld:%@", indexPath.item, [DataManager sharedDataManager].category[indexPath.item].cateId);
}

@end























