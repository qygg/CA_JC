//
//  ZCBookshelfViewController.m
//  JellyComic
//
//  Created by 胡智超 on 15/11/16.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import "ZCBookshelfViewController.h"
#import "ZCBookshelfCollectionViewCell.h"
#import "ZCBookshelfTableViewCell.h"
#import "ZCBookshelfSelectedTableViewCell.h"
#import "XLLocalDataManager.h"
#import "SSDetailTableViewController.h"
#import "SComic.h"

@interface ZCBookshelfViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
@property (weak, nonatomic) IBOutlet UIButton *historyButton;

@property (nonatomic, assign) NSInteger selectedRow;

@property (nonatomic, strong) NSMutableArray<SComic *> *collectArray;
@property (nonatomic, strong) NSMutableArray<SComic *> *historyArray;

@property (nonatomic, strong) UIView *sliderView;
@property (nonatomic, strong) UILabel *collectHintLabel;
@property (nonatomic, strong) UILabel *historyHintLabel;

@end

@implementation ZCBookshelfViewController

static NSString * const reuseTVID = @"booktv";
static NSString * const reuseSTVID = @"bookstv";
static NSString * const reuseCVID = @"bookcv";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.historyHintLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    CGPoint point = self.view.center;
    point.y -= 60;
    self.historyHintLabel.center = point;
    self.historyHintLabel.text = @"还未阅读任何漫画";
    self.historyHintLabel.textColor = [UIColor grayColor];
    self.historyHintLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightLight];
    self.historyHintLabel.textAlignment = NSTextAlignmentCenter;
    self.historyHintLabel.hidden = YES;
    [self.tableView addSubview:self.historyHintLabel];
    
    self.collectHintLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    self.collectHintLabel.center = point;
    self.collectHintLabel.text = @"还未收藏任何漫画";
    self.collectHintLabel.textColor = [UIColor grayColor];
    self.collectHintLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightLight];
    self.collectHintLabel.textAlignment = NSTextAlignmentCenter;
    self.collectHintLabel.hidden = YES;
    [self.collectionView addSubview:self.collectHintLabel];
    
    [self.headerView layoutIfNeeded];
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(self.headerView.frame.size.width - 80, self.headerView.frame.origin.y + 38, 40, 2)];
    self.sliderView.backgroundColor = [UIColor colorWithRed:0.686 green:0.278 blue:1.000 alpha:1.000];
    [self.headerView addSubview:self.sliderView];
    
    self.selectedRow = -1;
    
    [[XLLocalDataManager shareManager] open];
    self.collectArray = [NSMutableArray arrayWithArray:[[XLLocalDataManager shareManager] selectAllSComic:tableListcollect]];
    self.historyArray = [NSMutableArray arrayWithArray:[[XLLocalDataManager shareManager] selectAllSComic:tableListhistory]];
    [[XLLocalDataManager shareManager] close];
    
    self.scrollView.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZCBookshelfTableViewCell" bundle:nil] forCellReuseIdentifier:reuseTVID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZCBookshelfSelectedTableViewCell" bundle:nil] forCellReuseIdentifier:reuseSTVID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZCBookshelfCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseCVID];
    
    self.flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width / 3 - 10, (self.view.bounds.size.width / 3 - 10) / 3 * 4 + 40);
    self.flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    [self.collectButton addTarget:self action:@selector(collectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.historyButton addTarget:self action:@selector(historyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userCenterAction:)];
    UITapGestureRecognizer *tapGR2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userCenterAction:)];
    [self.userPhoto addGestureRecognizer:tapGR];
    [self.userNameLabel addGestureRecognizer:tapGR2];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadCollect) name:@"collectchange" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadHistory) name:@"historychange" object:nil];
    
}

- (void)reloadCollect {
    [[XLLocalDataManager shareManager] open];
    self.collectArray = [NSMutableArray arrayWithArray:[[XLLocalDataManager shareManager] selectAllSComic:tableListcollect]];
    [[XLLocalDataManager shareManager] close];
    [self.collectionView reloadData];
}

- (void)reloadHistory {
    [[XLLocalDataManager shareManager] open];
    self.historyArray = [NSMutableArray arrayWithArray:[[XLLocalDataManager shareManager] selectAllSComic:tableListhistory]];
    [[XLLocalDataManager shareManager] close];
    [self.tableView reloadData];
}

- (void)userCenterAction:(id)sender {
    [self showViewController:[[UIStoryboard storyboardWithName:@"ZCLoginStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"loginNC"] sender:nil];
}

- (void)collectButtonAction:(UIButton *)sender {
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)historyButtonAction:(UIButton *)sender {
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width, 0) animated:YES];
}

#pragma mark - 历史详情按钮点击方法
- (void)detailButtonAction:(UIButton *)sender {
    
    SSDetailTableViewController *SSDetailTVC = [[UIStoryboard storyboardWithName:@"SSDetail" bundle:nil] instantiateViewControllerWithIdentifier:@"ssDetailTVC"];
    SComic *comic = self.historyArray[self.selectedRow];
    SSDetailTVC.comicId = comic.comicID;
    UINavigationController *SSDeatilNC = [[UINavigationController alloc] initWithRootViewController:SSDetailTVC];
    [self showViewController:SSDeatilNC sender:nil];
}

- (void)deleteButtonAction:(UIButton *)sender {
    [[XLLocalDataManager shareManager] open];
    [[XLLocalDataManager shareManager] deleteWithSComic:self.historyArray[self.selectedRow].comicID tableList:tableListhistory];
    [[XLLocalDataManager shareManager] close];
    [self.historyArray removeObjectAtIndex:self.selectedRow];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.selectedRow inSection:0];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    self.selectedRow = -1;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource & Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.historyArray.count == 0) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.historyHintLabel.hidden = NO;
        self.tableView.scrollEnabled = NO;
    } else {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.historyHintLabel.hidden = YES;
        self.tableView.scrollEnabled = YES;
    }
    return self.historyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.selectedRow) {
        ZCBookshelfSelectedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseSTVID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.sComic = self.historyArray[indexPath.row];
        [cell.detailButton addTarget:self action:@selector(detailButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    ZCBookshelfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseTVID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.sComic = self.historyArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.selectedRow) {
        self.selectedRow = -1;
    } else {
        self.selectedRow = indexPath.row;
    }
    [tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.selectedRow) {
        return 170;
    }
    return 100;
}

#pragma mark - UICollectionViewDataSource & Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.collectArray.count == 0) {
        self.collectHintLabel.hidden = NO;
    } else {
        self.collectHintLabel.hidden = YES;
    }
    return self.collectArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCBookshelfCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseCVID forIndexPath:indexPath];
    cell.sComic = self.collectArray[indexPath.item];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));
    CGFloat scale = scrollView.contentOffset.x / scrollView.contentSize.width;
    if (scale) {
        self.sliderView.transform = CGAffineTransformMakeTranslation(scale * 80, 0);
    }
}

#pragma mark - 收藏item点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SSDetailTableViewController *SSDetailTVC = [[UIStoryboard storyboardWithName:@"SSDetail" bundle:nil] instantiateViewControllerWithIdentifier:@"ssDetailTVC"];
    SComic *comic = self.collectArray[indexPath.row];
    SSDetailTVC.comicId = comic.comicID;
    UINavigationController *SSDeatilNC = [[UINavigationController alloc] initWithRootViewController:SSDetailTVC];
    [self showViewController:SSDeatilNC sender:nil];
    
    
}

@end



































