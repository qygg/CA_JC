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

@interface SSContentViewController ()<UIScrollViewDelegate>
{
   BOOL isHidden;
}



@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIView *footerView;
@property (strong, nonatomic) UIView *brightnessView;     // 亮度
@property (strong, nonatomic) UIView *middleView;         // 点击区域

@property (assign, nonatomic) NSInteger tabCount;         //
@property (assign, nonatomic) NSInteger currentPage;      // 当前页数

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSArray *chapterArray;


@end

@implementation SSContentViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadData];
    
    self.dataSource = [NSMutableArray array];
    self.currentPage = 0;
    isHidden = YES;
    
    
    UISwipeGestureRecognizer *leftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftGestureRecognizer:)];
    leftGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:leftGesture];
}



- (void)leftGestureRecognizer:(UISwipeGestureRecognizer *)recognizer
{
    NSLog(@"*******************");
}


// 请求数据
- (void)reloadData
{
    _dataSource = [[NSMutableArray alloc] initWithCapacity:_tabCount];
    [[DataManager sharedDataManager] loadContentWithCharpterid:self.chapterID completion:^{
        for (NSString *url in [DataManager sharedDataManager].content.addrs)
        {
            [_dataSource addObject:url];
        }
        [self reloadView];
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

}


- (void)reloadHeaderView
{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    _headerView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_headerView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, _headerView.frame.size.width - 100, 25)];
    titleLabel.text = [NSString stringWithFormat:@"%@ %ld/%ld",[DataManager sharedDataManager].content.title,self.currentPage,[DataManager sharedDataManager].content.counts];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:titleLabel];
    
    UILabel *siteLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, _headerView.frame.size.width - 120, 25)];
    siteLabel.text = [NSString stringWithFormat:@"站源:%@",self.site];
    siteLabel.font = [UIFont systemFontOfSize:15];
    siteLabel.textColor = [UIColor whiteColor];
    siteLabel.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:siteLabel];
    
    /*
    UIButton *errorButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [errorButton setTitle:@"报错" forState:(UIControlStateNormal)];
    [errorButton setFrame:CGRectMake(siteLabel.frame.size.width + 50, 5, 50, 50)];
    [errorButton setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
    errorButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [errorButton addTarget:self action:@selector(errorButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_headerView addSubview:errorButton];
    */
     
    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [backButton setTitle:@"返回" forState:(UIControlStateNormal)];
    [backButton setFrame:CGRectMake(10, 5, 50, 50)];
    [backButton addTarget:self action:@selector(comeBackAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_headerView addSubview:backButton];
    _headerView.hidden = YES;
}

- (void)reloadFooterView
{
    _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 60)];
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

- (void)reloadBrightnessView
{
    _brightnessView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 2 - 60, 60, 60)];
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

- (void)reloadMiddleView
{
    _middleView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 2 - 80, self.view.frame.size.width, 150)];
    [self.view insertSubview:_middleView belowSubview:_brightnessView];
    // 轻拍手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureGrecognizerAction:)];
    [self.middleView addGestureRecognizer:tapGesture];
    
}


- (void)leftSwipeGestureRecognizer:(UISwipeGestureRecognizer *)recognizer
{
    NSLog(@"左");
}

- (void)rightSwipeGestureRecognizer:(UISwipeGestureRecognizer *)recognizer
{
    NSLog(@"右");
}




// 亮度
- (void)brightnessAction:(UIButton *)sender
{
    NSLog(@"亮度");
}

// 报错
- (void)errorButtonAction:(UIButton *)sender
{
    NSLog(@"报错");
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
    NSLog(@"横屏");
}

// 设置
- (void)settingAction:(UIButton *)sender
{
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
    if (!isHidden) {
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
}









- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - 懒加载
- (NSArray *)chapterArray
{
    if (!_chapterArray) {
        self.chapterArray = [[NSArray alloc] init];
    }
    return _chapterArray;
}




@end
