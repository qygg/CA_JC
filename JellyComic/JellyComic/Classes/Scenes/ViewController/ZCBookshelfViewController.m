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

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, strong) UIView *sliderView;

@end

@implementation ZCBookshelfViewController

static NSString * const reuseTVID = @"booktv";
static NSString * const reuseSTVID = @"bookstv";
static NSString * const reuseCVID = @"bookcv";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.headerView layoutIfNeeded];
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(self.headerView.frame.size.width - 80, self.headerView.frame.origin.y + 38, 40, 2)];
    self.sliderView.backgroundColor = [UIColor colorWithRed:0.686 green:0.278 blue:1.000 alpha:1.000];
    [self.headerView addSubview:self.sliderView];
    
    self.selectedRow = -1;
    
    self.array = [NSMutableArray arrayWithArray:@[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"]];
    
    self.scrollView.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZCBookshelfTableViewCell" bundle:nil] forCellReuseIdentifier:reuseTVID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZCBookshelfSelectedTableViewCell" bundle:nil] forCellReuseIdentifier:reuseSTVID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZCBookshelfCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseCVID];
    
    self.flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width / 3 - 10, 200);
    self.flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    [self.collectButton addTarget:self action:@selector(collectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.historyButton addTarget:self action:@selector(historyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)collectButtonAction:(UIButton *)sender {
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)historyButtonAction:(UIButton *)sender {
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width, 0) animated:YES];
}

- (void)deleteButtonAction:(UIButton *)sender {
    [self.array removeObjectAtIndex:self.selectedRow];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.selectedRow inSection:0];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    self.selectedRow = -1;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource & Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.selectedRow) {
        ZCBookshelfSelectedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseSTVID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.testLabel.text = self.array[indexPath.row];
        [cell.deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    ZCBookshelfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseTVID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.testLabel.text = self.array[indexPath.row];
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
        return 150;
    }
    return 80;
}

#pragma mark - UICollectionViewDataSource & Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCBookshelfCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseCVID forIndexPath:indexPath];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));
    CGFloat scale = scrollView.contentOffset.x / scrollView.contentSize.width;
    if (scale) {
        self.sliderView.transform = CGAffineTransformMakeTranslation(scale * 80, 0);
    }
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



































