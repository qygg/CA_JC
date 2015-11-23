//
//  SSContentViewController.m
//  SSContent
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 石莎莎. All rights reserved.
//

#import "SSContentViewController.h"
#import "DataManager.h"
#import "Content.h"

#import "UIImageView+WebCache.h"
#import "Chapter.h"
#import "SSSettingTableViewController.h"



#import "XLLocalDataManager.h"

@interface SSContentViewController ()<UIScrollViewDelegate>
{
    BOOL isHidden;
    BOOL isRotation;
}

// 整个视图的大小
@property (assign) CGRect mViewFrame;
// 下方的表格数组
@property (strong, nonatomic) NSMutableArray *scrollImageViews;
// TableViews的数据源
@property (strong, nonatomic) NSMutableArray *dataSource;
// 下方的ScrollView
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *comicImage;


@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIView *footerView;
@property (strong, nonatomic) UIView *brightnessView;        // 亮度
@property (strong, nonatomic) UIView *middleView;            // 点击区域
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;  // 底部状态栏
@property (assign, nonatomic) NSInteger currentPage;         // 当前页数
@property (assign, nonatomic) NSInteger nowIndex;
@property (strong, nonatomic) NSMutableArray *chapArray;
// 标题
@property (strong, nonatomic) UILabel *titleLabel;
@property (assign, nonatomic) NSInteger nowPage;
@property (assign, nonatomic) CGRect mFrame;

@end

@implementation SSContentViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mFrame = [UIScreen mainScreen].bounds;
    
    isHidden = YES;
    isRotation = NO;
    _currentPage = 1;
    
    self.scrollImageViews = [[NSMutableArray alloc] init];
    self.chapter = [Chapter new];
    
    
    
    Chapter *chap1 = self.chapterArray[0];
    Chapter *chap2 = self.chapterArray[1];
    if (chap1.sid < chap2.sid) {
        [self.chapArray addObjectsFromArray:self.chapterArray];
        self.nowIndex = self.index;
    }else
    {
        for (int i = (int)self.chapterArray.count - 1; i >= 0; i--)
        {
        [self.chapArray addObject:self.chapterArray[i]];
        }
        self.nowIndex = (self.chapArray.count - 1- self.index);
    }
    self.chapter = _chapArray[_nowIndex];
    [self reloadData];
}


// 请求数据
- (void)reloadData
{
    _dataSource = [[NSMutableArray alloc] initWithCapacity:10];
    
    [[DataManager sharedDataManager] loadContentWithCharpterid:self.chapterID completion:^{
        for (NSString *url in [DataManager sharedDataManager].content.addrs)
        {
            [_dataSource addObject:url];
        }
        [self initScrollViewToRightWithCounts:_dataSource.count];
        [self initDownImageViews];
        
        [self updateFromLeftWithPageNumber:0 dataSource:_dataSource];
    
        [self reloadView];
        return ;
    }];
}




// 隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

// 加载视图
- (void)reloadView
{
    [self reloadHeaderView];
    [self reloadFooterView];
    [self reloadBrightnessView];
    [self reloadMiddleView];
    [self reloadBottomState];
    
}

#pragma mark - HeaderView
- (void)reloadHeaderView
{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mFrame.size.width, 60)];
    _headerView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_headerView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5,self.mFrame.size.width - 100, 25)];
    self.titleLabel.text = [NSString stringWithFormat:@"%@ 1/%ld", [DataManager sharedDataManager].content.title,_dataSource.count];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:_titleLabel];
    
    UILabel *siteLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, _headerView.frame.size.width - 120, 25)];
    siteLabel.text = [NSString stringWithFormat:@"站源:%@",self.site];
    siteLabel.font = [UIFont systemFontOfSize:15];
    siteLabel.textColor = [UIColor whiteColor];
    siteLabel.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:siteLabel];
    
    
    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [backButton setTitle:@"返回" forState:(UIControlStateNormal)];
    [backButton setFrame:CGRectMake(10, 5, 50, 50)];
    [backButton addTarget:self action:@selector(comeBackAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_headerView addSubview:backButton];
    _headerView.hidden = YES;
}


#pragma mark - FooterView
- (void)reloadFooterView
{
    _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.mFrame.size.height - 60, self.mFrame.size.width, 60)];
    _footerView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_footerView];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 20, _footerView.frame.size.width - 150, 20)];
    slider.backgroundColor = [UIColor whiteColor];
    [slider setMaximumValue:[DataManager sharedDataManager].content.counts];
    [slider setMinimumValue:1];
    [slider addTarget:self action:@selector(sliderChanged:) forControlEvents:(UIControlEventValueChanged)];
    [_footerView addSubview:slider];
    
    UIButton *screenButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [screenButton setTitle:@"横屏" forState:(UIControlStateNormal)];
    [screenButton setFrame:CGRectMake(slider.frame.size.width + 20, 5, 50, 50)];
    [screenButton addTarget:self action:@selector(changeScreenAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_footerView addSubview:screenButton];
    
    UIButton *settingButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [settingButton setTitle:@"设置" forState:(UIControlStateNormal)];
    [settingButton setFrame:CGRectMake(slider.frame.size.width + 75, 5, 50, 50)];
    [settingButton addTarget:self action:@selector(settingAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_footerView addSubview:settingButton];
    _footerView.hidden = YES;
}


#pragma mark - BrightnessView
- (void)reloadBrightnessView
{
    _brightnessView = [[UIView alloc] initWithFrame:CGRectMake(0, self.mFrame.size.height / 2 - 60, 60, 60)];
    _brightnessView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_brightnessView];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setFrame:CGRectMake(0, 0, 60, 60)];
    [button setTitle:@"亮度" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(brightnessAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_brightnessView addSubview:button];
    _brightnessView.hidden = YES;
}


#pragma mark - MiddleView
- (void)reloadMiddleView
{
    _middleView = [[UIView alloc] initWithFrame:CGRectMake(0, self.mFrame.size.height / 2 - 80, self.view.frame.size.width, 150)];
    [self.view insertSubview:_middleView belowSubview:_brightnessView];
    // 轻拍手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureGrecognizerAction:)];
    [self.view addGestureRecognizer:tapGesture];
    
}

#pragma  mark - 底部状态栏
- (void)reloadBottomState
{
    // 当前时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    NSLog(@"----------------%@",dateTime);
    // 获取电量
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    CGFloat deviceLevel = -[UIDevice currentDevice].batteryLevel * 100;
    
    NSLog(@"deviceLevel == %f",deviceLevel);
    
    
    self.stateLabel.text = [NSString stringWithFormat:@"%@  %@  %.f%%     ",[DataManager sharedDataManager].content.title,dateTime,deviceLevel];
    
    [self.view addSubview:_stateLabel];
    
}


 // 亮度
- (void)brightnessAction:(UIButton *)sender
{
    
    
//    [[UIScreen mainScreen] setBrightness:value];
    NSLog(@"亮度");
}
 
 // 返回
- (void)comeBackAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"返回");
}


 // 设置横屏竖屏
- (void)changeScreenAction:(UIButton *)sender
{
    if (isRotation == NO) {
        [self horizontalScreen];
        isRotation = YES;
    }else
    {
        [self verticalScreen];
        isRotation = NO;
    }
    
    
   
    
}

# pragma nmark - 旋转
// 横屏
- (void)horizontalScreen
{
    
    [self.headerView removeFromSuperview];
    [self.footerView removeFromSuperview];
    [self.brightnessView removeFromSuperview];
    [self.middleView removeFromSuperview];

    // 设置屏幕 只是旋转当前的View
    //    [[UIApplication sharedApplication] setStatusBarOrientation:<#(UIInterfaceOrientation)#>]
    self.view.transform = CGAffineTransformMakeRotation(M_PI / 2);
    //    self.mFrame = [UIScreen mainScreen].bounds;
    self.view.bounds = CGRectMake(0, 0, self.mFrame.size.height, self.mFrame.size.width);
    self.mFrame = self.view.bounds;
    
    NSLog(@"横屏");
    
    //    _scrollView.pagingEnabled = NO;
        [self reloadView];
    //    [self initScrollViewToLeftWithCounts:_dataSource.count];
    //    [self initScrollViewToRightWithCounts:_dataSource.count];
}

// 竖屏
- (void)verticalScreen
{
    [self.headerView removeFromSuperview];
    [self.footerView removeFromSuperview];
    [self.brightnessView removeFromSuperview];
    [self.middleView removeFromSuperview];
    self.view.transform = CGAffineTransformMakeRotation(M_PI * 2);
    self.view.bounds = CGRectMake(0, 0, self.mFrame.size.height, self.mFrame.size.width);
    self.mFrame = self.view.bounds;
    [self reloadView];
}


//
//// 自动旋转设为NO
//- (BOOL)shouldAutorotate
//{
//    return NO;
//}

 // 设置
- (void)settingAction:(UIButton *)sender
{
    SSSettingTableViewController *settingTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingTableViewController"];
    
    [self.navigationController pushViewController:settingTVC animated:YES];
    NSLog(@"设置");
}
 
 // 进度条
- (void)sliderChanged:(UISlider *)sender
{
    UISlider *slider = sender;
    self.currentPage = slider.value - 1;
}
 
 // 手势
- (void)tapGestureGrecognizerAction:(UITapGestureRecognizer *)recognizer
{
    if (!isHidden)
    {
        _headerView.hidden = YES;
        _footerView.hidden = YES;
        _brightnessView.hidden = YES;
        isHidden = YES;
    }else{
        _headerView.hidden = NO;
        _footerView.hidden = NO;
        _brightnessView.hidden = NO;
        isHidden = NO;
    }
    NSLog(@"轻点");
    self.titleLabel.text = [NSString stringWithFormat:@"%@ %ld/%ld", [DataManager sharedDataManager].content.title,_currentPage,_dataSource.count];
}


#pragma mark -- 实例化ScrollView
// 向左滚动
-(void) initScrollViewToLeftWithCounts:(NSInteger)counts
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, self.mFrame.size.width, self.mFrame.size.height)];
    _scrollView.contentSize = CGSizeMake(self.mFrame.size.width * (counts + 2), self.mFrame.size.height);
    _scrollView.contentOffset = CGPointMake(self.mFrame.size.width * counts, 0);
    _scrollView.backgroundColor = [UIColor whiteColor];
    
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
}

// 向右滚动
-(void) initScrollViewToRightWithCounts:(NSInteger)counts
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, self.mFrame.size.width, self.mFrame.size.height)];
    _scrollView.contentSize = CGSizeMake(self.mFrame.size.width * (counts + 2), self.mFrame.size.height);
    _scrollView.contentOffset = CGPointMake(self.mFrame.size.width, 0);
    _scrollView.backgroundColor = [UIColor whiteColor];
    
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
}


# pragma mark -横屏滚动
- (void)initScrollViewInAcrossScreenWithCounts:(NSInteger)counts
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, self.mFrame.size.width, self.mFrame.size.height)];
    _scrollView.contentSize = CGSizeMake(self.mFrame.size.width, self.mFrame.size.width * (counts + 2));
//    _scrollView.contentOffset = CGPointMake(0, 0);
    _scrollView.backgroundColor = [UIColor whiteColor];
    
//    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
}




#pragma mark --初始化下方的Views
- (void)initDownImageViews
{
    for (int i = 0; i < 3; i++)
    {
        UIImageView *comicImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 1, self.mFrame.size.width, self.mFrame.size.height)];
        comicImage.contentMode = UIViewContentModeScaleAspectFit;
        comicImage.tag = i;
        NSString *url = _dataSource[0];
        [_comicImage sd_setImageWithURL:[NSURL URLWithString:url]];
        [_scrollImageViews addObject:comicImage];
        [_scrollView addSubview:comicImage];
    }
}



#pragma mark --根据scrollView的滚动位置复用View，减少内存开支
-(void) updateFromLeftWithPageNumber: (NSUInteger) pageNumber dataSource:(NSMutableArray *)dataSource
{
    int tabviewTag = pageNumber % 3;
    CGRect tableNewFrame = CGRectMake((pageNumber + 1) * self.mFrame.size.width, 0, self.mFrame.size.width, self.mFrame.size.height);
    _comicImage = _scrollImageViews[tabviewTag];
    NSString *url = dataSource[pageNumber];
    [self.comicImage sd_setImageWithURL:[NSURL URLWithString:url]];
    _comicImage.frame = tableNewFrame;
}

-(void) updateFromRightWithPageNumber: (NSUInteger) pageNumber dataSource:(NSMutableArray *)dataSource
{
    int tabviewTag = pageNumber % 3;
    CGRect tableNewFrame = CGRectMake((pageNumber - 1) * self.mFrame.size.width, 0, self.mFrame.size.width, self.mFrame.size.height);
    _comicImage = _scrollImageViews[tabviewTag];
    NSString *url = dataSource[pageNumber];
    [self.comicImage sd_setImageWithURL:[NSURL URLWithString:url]];
    _comicImage.frame = tableNewFrame;
}


#pragma mark -- scrollView的代理方法

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (isHidden == NO) {
        _headerView.hidden = YES;
        _footerView.hidden = YES;
        _brightnessView.hidden = YES;
        isHidden = YES;
    }else{
        return;
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:_scrollView])
    {
        // 根据偏移量获取当前页数
        _currentPage = _scrollView.contentOffset.x /self.view.frame.size.width;
        if (_currentPage == 0)    // 如果当前页数为零
        {
            if (self.nowIndex <= 0)  // 如果是第一章
            {
                NSLog(@"已经是第一章");
            }else
            {
                self.nowIndex --;       // 当前下标减一 获取上一章内容
                [self.comicImage removeFromSuperview];
                [self.scrollView removeFromSuperview];
                [_scrollImageViews removeAllObjects];
                [_dataSource removeAllObjects];
                Chapter *chapter = _chapArray[self.nowIndex];
                [[DataManager sharedDataManager] loadContentWithCharpterid:chapter.ID completion:^{
                for (NSString *url in [DataManager sharedDataManager].content.addrs)
                {
                    [_dataSource addObject:url];
                }
                    
                    [self initScrollViewToLeftWithCounts:_dataSource.count];
                    [self initDownImageViews];
                    [self updateFromLeftWithPageNumber:_dataSource.count - 1 dataSource:_dataSource];
                    [self reloadView];
                    _currentPage = _dataSource.count;
                    return ;
                }];
                 
            }
        }else if (_currentPage == (_dataSource.count + 1))
        {
            if (self.nowIndex >= _chapterArray.count - 1)
            {
                NSLog(@"已经是最后一章");
            }else
            {
                 self.nowIndex ++;
                [self.comicImage removeFromSuperview];
                [self.scrollView removeFromSuperview];
                [_scrollImageViews removeAllObjects];
                [_dataSource removeAllObjects];
                [self.middleView removeFromSuperview];
                Chapter *chapter = _chapArray[self.nowIndex];
                [[DataManager sharedDataManager] loadContentWithCharpterid:chapter.ID completion:^{
                    for (NSString *url in [DataManager sharedDataManager].content.addrs)
                    {
                        [_dataSource addObject:url];
                    }
                    
                    [self initScrollViewToRightWithCounts:_dataSource.count];
                    [self initDownImageViews];
                    [self updateFromLeftWithPageNumber:0 dataSource:_dataSource];
                    [self reloadView];
                    _currentPage = 1;
                    return ;
                }];
                
            }
        }else
        {
            NSInteger nowPage = _currentPage;
            if (nowPage > _currentPage)
            {
                [self updateFromRightWithPageNumber:_currentPage - 1 dataSource:_dataSource];
            }else{
                [self updateFromLeftWithPageNumber:_currentPage - 1 dataSource:_dataSource];
            }
        }
        return;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - 懒加载
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        self.dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}


- (NSMutableArray *)chapArray
{
    if (!_chapArray) {
        self.chapArray = [NSMutableArray array];
    }
    return _chapArray;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.xlSComic.contentPage = _currentPage;
    self.xlSComic.comicsrcTitle = _site;
    [[XLLocalDataManager shareManager] open];
     [[XLLocalDataManager shareManager] createTable:tableListhistory];
    NSArray *array = [[XLLocalDataManager shareManager] selectAllSComic:tableListhistory];
    for (SComic *s in array) {


        if ([s.comicID isEqualToString:_comicid]) {
            if ([s.chapterID isEqualToString:self.chapter.ID] && s.contentPage == self.currentPage) {
                [[XLLocalDataManager shareManager] close];
                return;
            }else if ([s.chapterID isEqualToString:self.chapter.ID] && s.contentPage != _currentPage)
            {
                [[XLLocalDataManager shareManager] deleteWithSComic:s.comicID tableList:tableListhistory];
                [[XLLocalDataManager shareManager] insertSComic:self.xlSComic tableList:tableListhistory];
                [[XLLocalDataManager shareManager] close];
                return;
            }else if (![s.chapterID isEqualToString:self.chapter.ID])
            {
                [[XLLocalDataManager shareManager] deleteWithSComic:s.comicID tableList:tableListhistory];
                [[XLLocalDataManager shareManager] insertSComic:self.xlSComic tableList:tableListhistory];
                [[XLLocalDataManager shareManager] close];
                return;
            }
        }
    }
    

    [[XLLocalDataManager shareManager] insertSComic:self.xlSComic tableList:tableListhistory];
    
    [[XLLocalDataManager shareManager] close];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dbchange" object:nil];
    
}



@end

