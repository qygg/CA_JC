//
//  XLReconmmendView.m
//  ad
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "XLReconmmendView.h"
#import "XLReconmmendCollectionViewCell.h"
#import "SDCycleScrollView.h"
#import "DataManager.h"
#import "UIImageView+WebCache.h"
#import "Comic.h"
#import "ScrollingImage.h"
#import "MJRefresh.h"
#import "SSDetailTableViewController.h"
#import "XLReconmmendViewController.h"
#define TOPHEIGHT 40
@interface XLReconmmendView ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,SDCycleScrollViewDelegate>
{
    int page;
    int page1;
    int page2;
    int page3;
}
// 整个视图的大小
@property (assign) CGRect mViewFrame;
// 下方的ScrollView
@property (nonatomic, strong) UIScrollView *scrollView;
// 上方的按钮数组
@property (nonatomic, strong) NSMutableArray *topViews;
// 下方的collectionView数组
@property (nonatomic, strong) NSMutableArray *scrollTableViews;
// collectionView数据源
@property (nonatomic, strong) NSMutableArray *dataSource;
// 轮播图
@property (nonatomic, strong) SDCycleScrollView *cucleScrollView;
// 当前选中页数
@property (assign) NSInteger currentPage;
// 上方的ScrollView
@property (nonatomic, strong) UIScrollView *topScrollView;
// 下面滑动的View
@property (nonatomic, strong) UIView *slideView;
// 上方的View
@property (nonatomic, strong) UIView *topMainView;

@property (nonatomic, strong) NSArray *hotArray;
@property (nonatomic, strong) NSArray *editorArray;
@property (nonatomic, strong) NSArray *hotHKArray;
@property (nonatomic, strong) NSArray *recentUpdateArray;
@property (nonatomic, strong) Comic *comic;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation XLReconmmendView
- (instancetype)initWithFrame:(CGRect)frame WithCount:(NSInteger)count
{
    self = [super initWithFrame:frame];
    if (self) {
        _mViewFrame = frame;
        _tabCount = count;
        _currentPage = 0;
        page = 1;
        page1 = 1;
        page2 = 1;
        page3 = 1;
        _topViews = [[NSMutableArray alloc] init];
        _scrollTableViews = [[NSMutableArray alloc] init];

        [self initScrollView];
        [self initTopTabs];
        
        [self initDownTable1];
        [self initDownTable2];
        [self initDownTable3];
        [self initDownTable4];

        [self initDataSource1];
        [self initDataSource2];
        [self initDataSource3];
        [self initDataSource4];
        
        [self initSlideView];

    }
    return self;
}




- (void)initSlideView
{
    CGFloat width = _mViewFrame.size.width / 4;
    if (self.tabCount <= 4) {
        width = _mViewFrame.size.width / self.tabCount;
    }
    
    _slideView = [[UIView alloc] initWithFrame:CGRectMake(0, TOPHEIGHT - 5, width, 5)];
    [_slideView setBackgroundColor:[UIColor orangeColor]];
    [_topScrollView addSubview:_slideView];
}
- (void)initDataSource1
{
    [[DataManager sharedDataManager] loadHotlistWithPage:page completion:^{
        if (_hotArray.count == [[DataManager sharedDataManager] hotList].count) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        NSLog(@"1 %d",page);
        _hotArray = nil;
        _hotArray = [[DataManager sharedDataManager] hotList];
        [_collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];

}
- (void)initDataSource2
{
    [[DataManager sharedDataManager] loadEditorlistWithPage:page1 completion:^{
        if (_editorArray.count == [[DataManager sharedDataManager] editorList].count) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];

            return;
        }
        NSLog(@"2 %d",page1);
        _editorArray = nil;
        _editorArray = [[DataManager sharedDataManager] editorList];
        [_collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];

}
- (void)initDataSource3
{
    [[DataManager sharedDataManager] loadHothklistWithPage:page2 completion:^{
        if (_hotHKArray.count == [[DataManager sharedDataManager] hotHkList].count) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        NSLog(@"3 %d",page2);
        _hotHKArray = nil;
        _hotHKArray = [[DataManager sharedDataManager] hotHkList];
        [_collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
}
- (void)initDataSource4
{
    [[DataManager sharedDataManager] loadRecentUpdateWithPage:page3 completion:^{
        if (_recentUpdateArray.count == [[DataManager sharedDataManager] recentUpdate].count) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        NSLog(@"4 %d",page3);
        _recentUpdateArray = nil;
        _recentUpdateArray = [[DataManager sharedDataManager] recentUpdate];
        [_collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];

}
- (void)initScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, _mViewFrame.size.width, _mViewFrame.size.height - TOPHEIGHT - 20)];
    _scrollView.contentSize = CGSizeMake(_mViewFrame.size.width * _tabCount, _mViewFrame.size.height - 60);
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
}
- (void)initTopTabs
{
    CGFloat width = _mViewFrame.size.width / 4;
    if (self.tabCount <= 4) {
        width = _mViewFrame.size.width / self.tabCount;
    }
    
    _topMainView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, _mViewFrame.size.width, TOPHEIGHT)];
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _mViewFrame.size.width, TOPHEIGHT)];
    _topScrollView.showsHorizontalScrollIndicator = NO;
    _topScrollView.showsVerticalScrollIndicator = YES;
    _topScrollView.bounces = NO;
    _topScrollView.delegate = self;
    if (_tabCount >= 4) {
        _topScrollView.contentSize = CGSizeMake(width * _tabCount, TOPHEIGHT);
    }else
    {
        _topScrollView.contentSize = CGSizeMake(_mViewFrame.size.width, TOPHEIGHT);
    }
    [self addSubview:_topMainView];
    [_topMainView addSubview:_topScrollView];
    for (int i = 0; i < _tabCount; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * width, 0, width, TOPHEIGHT)];
        view.backgroundColor = [UIColor lightGrayColor];
        if (i %2) {
            view.backgroundColor = [UIColor grayColor];
        }
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, TOPHEIGHT)];
        button.tag = i;
        if (i == 0) {
            [button setTitle:@"热门连载" forState:UIControlStateNormal];
        }else if (i == 1)
        {
            [button setTitle:@"小编推荐" forState:UIControlStateNormal];
        }else if (i == 2)
        {
            [button setTitle:@"精彩港漫" forState:UIControlStateNormal];
        }else
        {
            [button setTitle:@"最近更新" forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(tabButton:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        [_topViews addObject:view];
        [_topScrollView addSubview:view];
    }
}

- (void)tabButton:(id)sender
{
    UIButton *button = sender;
    [_scrollView setContentOffset:CGPointMake(button.tag * _mViewFrame.size.width, 0) animated:YES];
}
- (void)initDownTable1
{
    UICollectionViewFlowLayout *flowout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat aa = (self.frame.size.width / 3) - 8;
    CGFloat bb = (self.frame.size.height / 3) - 8;
    flowout.itemSize = CGSizeMake(aa, bb);
    [flowout setScrollDirection:UICollectionViewScrollDirectionVertical];

    flowout.sectionInset = UIEdgeInsetsMake(5, 2, 1, 2);
    flowout.headerReferenceSize = CGSizeMake(self.frame.size.width, 190);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 60) collectionViewLayout:flowout];
    // 下拉刷新
    self.collectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self initDataSource1];
    }];
    // 上拉加载
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page++;
        [self initDataSource1];
        [self.collectionView.mj_footer endRefreshing];
    }];
    
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [_scrollTableViews addObject:self.collectionView];
    [_scrollView addSubview:self.collectionView];
    
    _cucleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.frame.size.width, 190) imageURLStringsGroup:nil];
    
    _cucleScrollView.delegate = self;
    _cucleScrollView.autoScrollTimeInterval = 3.0;
    _cucleScrollView.dotColor = [UIColor whiteColor];
    _cucleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    [self.collectionView addSubview:_cucleScrollView];
    
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *titles = [NSMutableArray array];
    [[DataManager sharedDataManager] loadScrollingImageWithCompletion:^{
        for (ScrollingImage *image in [[DataManager sharedDataManager] scrollingImage]) {
            if ([image.recom_type isEqualToString:@"0"]){
                [array addObject:image.thumb];
                [titles addObject:image.title];
            }
        }
        
        _cucleScrollView.titlesGroup = titles;
        _cucleScrollView.imageURLStringsGroup = array;
    }];
}

- (void)initDownTable2
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    CGFloat a = (self.frame.size.width / 3) - 8;
    CGFloat b = (self.frame.size.height / 3) - 8;
    flow.itemSize = CGSizeMake(a, b);
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];

    flow.sectionInset = UIEdgeInsetsMake(5, 2, 1, 2);
    UICollectionView *reusecollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height - 60) collectionViewLayout:flow];
    reusecollectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page1 = 1;
        [reusecollectionView.mj_header beginRefreshing];
        [self initDataSource2];
    }];
    reusecollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        page1++;
        [self initDataSource2];
        
    }];
    
    
    reusecollectionView.backgroundColor = [UIColor whiteColor];
    reusecollectionView.delegate = self;
    reusecollectionView.dataSource = self;
    
    [_scrollTableViews addObject:reusecollectionView];
    [_scrollView addSubview:reusecollectionView];

}
- (void)initDownTable3
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    CGFloat a = (self.frame.size.width / 3) - 8;
    CGFloat b = (self.frame.size.height / 3) - 8;
    flow.itemSize = CGSizeMake(a, b);
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];

    flow.sectionInset = UIEdgeInsetsMake(5, 2, 1, 2);
    UICollectionView *reusecollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.frame.size.width * 2, 0, self.frame.size.width, self.frame.size.height - 60) collectionViewLayout:flow];
    reusecollectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page2 = 1;
        [self initDataSource3];
    }];
    
    reusecollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page2++;
        [self initDataSource3];
        
    }];
    reusecollectionView.backgroundColor = [UIColor whiteColor];
    reusecollectionView.delegate = self;
    reusecollectionView.dataSource = self;
    
    [_scrollTableViews addObject:reusecollectionView];
    [_scrollView addSubview:reusecollectionView];

}
- (void)initDownTable4
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    CGFloat a = (self.frame.size.width / 3) - 8;
    CGFloat b = (self.frame.size.height / 3) - 8;
    flow.itemSize = CGSizeMake(a, b);
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];

    flow.sectionInset = UIEdgeInsetsMake(5, 2, 1, 2);
    UICollectionView *reusecollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.frame.size.width * 3, 0, self.frame.size.width, self.frame.size.height - 60) collectionViewLayout:flow];
    reusecollectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page3 = 1;
        [self initDataSource4];
    }];
    
    reusecollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page3++;
        
        [self initDataSource4];
        
    }];
    reusecollectionView.backgroundColor = [UIColor whiteColor];
    reusecollectionView.delegate = self;
    reusecollectionView.dataSource = self;
    [_scrollTableViews addObject:reusecollectionView];
    [_scrollView addSubview:reusecollectionView];

}
#pragma mark - 轮播图点击方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{

    ScrollingImage *scrllingImage = [[DataManager sharedDataManager] scrollingImage][index];
    
    
    [self.xlReconmmendViewController showDetailViewController:[[UIStoryboard storyboardWithName:@"SSDetail" bundle:nil] instantiateViewControllerWithIdentifier:@"ssdetail"] sender:nil];
    
}
- (void)updateTableWithPageNumber:(NSUInteger)pageNumber
{
    int tabViewTag = pageNumber % 4;
    CGRect collectionViewnewFrame = CGRectMake(pageNumber * _mViewFrame.size.width, 0, _mViewFrame.size.width, _mViewFrame.size.height - TOPHEIGHT - 20);
    
    self.collectionView = _scrollTableViews[tabViewTag];
    _collectionView.frame = collectionViewnewFrame;
    [_collectionView reloadData];
}

- (void)modifyTopScrollViewPositiong:(UIScrollView *)scrollView
{
    if ([_topScrollView isEqual:scrollView]) {
        CGFloat contentOffsetX = _topScrollView.contentOffset.x;
        
        CGFloat width = _slideView.frame.size.width;
        
        int count = (int)contentOffsetX/(int)width;
        
        CGFloat step = (int)contentOffsetX%(int)width;
        
        CGFloat sumStep = width * count;
        
        if (step > width / 2) {
            
            sumStep = width * (count + 1);
            
        }
        
        [_topScrollView setContentOffset:CGPointMake(sumStep, 0) animated:YES];
        return;
    }
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidEndDecelerating:scrollView];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:_scrollView]) {
       
        
       
        _currentPage = _scrollView.contentOffset.x/_mViewFrame.size.width;
        

//        _currentPage = _scrollView.contentOffset.x/_mViewFrame.size.width;
        
        //    UITableView *currentTable = _scrollTableViews[_currentPage];
        //    [currentTable reloadData];
        
        [self updateTableWithPageNumber:_currentPage];
        
        return;
    }
    [self modifyTopScrollViewPositiong:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([_scrollView isEqual:scrollView]) {
        CGRect frame = _slideView.frame;
        
        if (self.tabCount <= 4) {
            frame.origin.x = scrollView.contentOffset.x/_tabCount;
        } else {
            frame.origin.x = scrollView.contentOffset.x/4;
            
        }
        _slideView.frame = frame;
    }
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_currentPage == 0) {
        return _hotArray.count;
    }else if (_currentPage == 1) {
        return _editorArray.count;
    }else if (_currentPage == 2) {
        return _hotHKArray.count;
    }else if (_currentPage == 3) {
        return _recentUpdateArray.count;
    }
    
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL nibsREgistered = NO;
    if (!nibsREgistered) {
        UINib *nib = [UINib nibWithNibName:@"XLReconmmendCollectionViewCell" bundle:nil];
        [collectionView registerNib:nib forCellWithReuseIdentifier:@"a"];
        nibsREgistered = YES;
    }
    XLReconmmendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"a" forIndexPath:indexPath];
   
    if (_currentPage == 0) {
        self.comic = _hotArray[indexPath.row];
        cell.nameLabel.text = _comic.title;
        cell.episodeLabel.text = _comic.lastCharpter_title;
        
        cell.episodeLabel.textColor = [UIColor whiteColor];
        [cell.comicShowImageView sd_setImageWithURL:[NSURL URLWithString:_comic.thumb]];
        cell.backImageView.image = [UIImage imageNamed:@"titlebg.png"];
    }else if (_currentPage == 1) {
        self.comic = _editorArray[indexPath.row];
        cell.nameLabel.text = _comic.title;
        cell.episodeLabel.text = _comic.lastCharpter_title;
        cell.episodeLabel.textColor = [UIColor whiteColor];
        [cell.comicShowImageView sd_setImageWithURL:[NSURL URLWithString:_comic.thumb]];
        cell.backImageView.image = [UIImage imageNamed:@"titlebg.png"];
    }else if (_currentPage == 2) {
        self.comic = _hotHKArray[indexPath.row];
        cell.nameLabel.text = _comic.title;
        
        cell.episodeLabel.text = _comic.lastCharpter_title;
        cell.episodeLabel.textColor = [UIColor whiteColor];;
        [cell.comicShowImageView sd_setImageWithURL:[NSURL URLWithString:_comic.thumb]];
        cell.backImageView.image = [UIImage imageNamed:@"titlebg.png"];
    }else
    {
        self.comic = _recentUpdateArray[indexPath.row];
        cell.nameLabel.text = _comic.title;
        cell.episodeLabel.text = _comic.lastCharpter_title;
        cell.episodeLabel.textColor = [UIColor whiteColor];
        [cell.comicShowImageView sd_setImageWithURL:[NSURL URLWithString:_comic.thumb]];
        cell.backImageView.image = [UIImage imageNamed:@"titlebg.png"];
    }
    return cell;
}
#pragma mark - cell点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
        if (_currentPage == 0) {
            Comic *comic = _hotArray[indexPath.row];
            SSDetailTableViewController *SSDetailTVC = [[UIStoryboard storyboardWithName:@"SSDetail" bundle:nil] instantiateViewControllerWithIdentifier:@"ssDetailTVC"];
            SSDetailTVC.comicId = comic.comicId;
            NSLog(@"SSDetailTVC.comicId ====== %@",SSDetailTVC.comicId);
            [self.xlReconmmendViewController showViewController:SSDetailTVC sender:nil];
        }
}


@end