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
#import "Comic.h"

@interface ZCCategoryViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation ZCCategoryViewController

static NSString * const reuseID = @"category";
static NSString * const tableViewReuseID = @"sysdef";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 40)];
    bgView.backgroundColor = [UIColor colorWithRed:0.682 green:0.886 blue:1.000 alpha:1.000];
    [self.view insertSubview:bgView belowSubview:self.searchBar];
    
    for (UIView *view in self.searchBar.subviews.firstObject.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [view removeFromSuperview];
            break;
        }
    }
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.searchBar.delegate = self;
    
    self.flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width / 3 - 10, self.view.bounds.size.width / 3);
    self.flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZCCategoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseID];
    
    [[DataManager sharedDataManager] loadCategoryWithCompletion:^{
        [self.collectionView reloadData];
    }];

    
}

- (void)keyboardWillShow:(NSNotification *)sender {
    NSDictionary *userInfo = [sender userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [aValue CGRectValue];
    NSInteger height = keyboardFrame.size.height;
    CGRect frame = self.tableView.frame;
    frame.size.height = [UIScreen mainScreen].bounds.size.height - 60 - height;
    self.tableView.frame = frame;
}

#pragma mark - UITableViewDataSource & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [DataManager sharedDataManager].searchResult.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewReuseID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [DataManager sharedDataManager].searchResult[indexPath.row].title;
    return cell;
}

#pragma mark - cell点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchBar resignFirstResponder];
    NSLog(@"%@", [DataManager sharedDataManager].searchResult[indexPath.row].title);
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

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.visualEffectView.hidden = NO;
    self.searchBar.showsCancelButton = YES;

    for (UIView *view in searchBar.subviews.firstObject.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            [((UIButton *)view) setTitle:@"取消" forState:UIControlStateNormal];
            break;
        }
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    self.visualEffectView.hidden = YES;
    self.searchBar.showsCancelButton = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - 搜索按钮点击方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    NSLog(@"%@", searchBar.text);
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [[DataManager sharedDataManager] loadSearchResultWithKeyword:searchText page:1 completion:^{
        [self.tableView reloadData];
    }];
}

- (UIVisualEffectView *)visualEffectView {
    if (!_visualEffectView) {
        _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
        _visualEffectView.frame = CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 109);
        [self.view addSubview:_visualEffectView];
        self.tableView = [[UITableView alloc] initWithFrame:_visualEffectView.bounds];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableViewReuseID];
        [_visualEffectView addSubview:_tableView];
    }
    return _visualEffectView;
}

@end























