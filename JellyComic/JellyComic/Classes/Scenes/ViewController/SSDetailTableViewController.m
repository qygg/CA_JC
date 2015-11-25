//
//  SSDetailTableViewController.m
//  Cartoon
//
//  Created by lanou3g on 15/11/11.
//  Copyright © 2015年 石莎莎. All rights reserved.
//

#import "SSDetailTableViewController.h"
#import "SSDetailTableViewCell.h"
#import "SSChapterViewController.h"
#import "DataManager.h"
#import "ComicDetail.h"
#import "UIImageView+WebCache.h"
#import "ComicSource.h"
#import "XLAuthorDetailTableViewController.h"
#import "SComic.h"
#import "XLLocalDataManager.h"
#import "Chapter.h"
#import "SSContentViewController.h"
#import "SSRollingBtn.h"
#import "SSContentViewController.h"

@interface SSDetailTableViewController ()<UIGestureRecognizerDelegate>
{
    BOOL isRead;
    
}

// 是否展开
@property (nonatomic, assign) BOOL expand;
@property (nonatomic, strong) ComicDetail *comicDetail;
@property (nonatomic, strong) NSMutableArray *comicStrArray;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) NSString *xlUpdate;

@end

@implementation SSDetailTableViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    _expand = YES;
    isRead = NO;
    
    [[XLLocalDataManager shareManager] open];
    NSArray *array = [[XLLocalDataManager shareManager] selectAllSComic:tableListhistory];
    for (SComic *s in array) {
        if ([s.comicID isEqualToString:self.comicId]) {
            NSLog(@"%@",s.chapterTitle);
            NSString *string = @"续看：";
            NSString *string1 = [string stringByAppendingString:s.chapterTitle];
            _startReadButton.textString = string1;
//            [_startReadButton setTextString:string1];
            NSLog(@"%@",_startReadButton.textString);
//            [_startReadButton setRollingSpeed:40.f];
//            _startReadButton.contentLabel.textColor = [UIColor whiteColor];
//            _startReadButton.contentLabel.font = [UIFont systemFontOfSize:14];
//            [_startReadButton start];
            isRead = YES;
        }
    }
    [[XLLocalDataManager shareManager] close];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.682 green:0.886 blue:1.000 alpha:1.000];
    self.view.backgroundColor = [UIColor colorWithRed:0.898 green:0.945 blue:1.000 alpha:1.000];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return"] style:UIBarButtonItemStyleDone target:self action:@selector(comebackXLReconmmendVC)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor colorWithRed:0.686 green:0.278 blue:1.000 alpha:1.000]];
    [self requestComicDetailData];
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:@"SSDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"detail"];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}




- (void)requestComicDetailData
{
    [[DataManager sharedDataManager] loadDetailWithComicid:self.comicId completion:^{
        self.comicDetail = [DataManager sharedDataManager].comicDetail;
        for (ComicSource *comicSource in self.comicDetail.comicSrc) {
            [self.comicStrArray addObject:comicSource];
        }
        // 加载视图
        [self reloadView];
    }];
}

- (void)reloadView
{
    self.title = self.comicDetail.title;
    // headerView
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width,320)];
    _headerView.backgroundColor = [UIColor colorWithRed:0.898 green:0.945 blue:1.000 alpha:1.000];
    // 图片
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(_headerView.frame.origin.x + 12, _headerView.frame.origin.y + 12, _headerView.frame.size.width /2.85,_headerView.frame.size.height / 1.85)];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:self.comicDetail.thumb]];
    [_headerView addSubview:_imgView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.frame.size.width + 25, _imgView.frame.origin.y, _headerView.frame.size.width - _imgView.frame.size.width - 30, 30)];
    _titleLabel.text = self.comicDetail.title;
    _titleLabel.font = [UIFont systemFontOfSize:18];
    [_headerView addSubview:_titleLabel];
    
    // 作者
    UILabel *authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y + 35,40, 25)];
    authorLabel.text = @"作者:";
    authorLabel.font = [UIFont systemFontOfSize:15];
    [_headerView addSubview:authorLabel];
    
    
    _authorButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _authorButton.frame = CGRectMake(authorLabel.frame.origin.x + 40, authorLabel.frame.origin.y, _titleLabel.frame.size.width - 50, 25);
    [_authorButton setTitle:[NSString stringWithString:self.comicDetail.authorName] forState:UIControlStateNormal];
    _authorButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_authorButton setTitleColor:[UIColor colorWithRed:0.686 green:0.278 blue:1.000 alpha:1.000] forState:(UIControlStateNormal)];
    _authorButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_authorButton addTarget:self action:@selector(authorAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 设置下划线
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_authorButton.titleLabel.text];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [_authorButton setAttributedTitle:str forState:UIControlStateNormal];
    
    [_headerView addSubview:_authorButton];
   
    
    // 地区
    UILabel *region = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.frame.origin.x, authorLabel.frame.origin.y + 30, _titleLabel.frame.size.width, 25)];
    region.text = @"地区:";
    region.font = [UIFont systemFontOfSize:15];
    [_headerView addSubview:region];
    
    _regionLabel = [[UILabel alloc] initWithFrame:CGRectMake(region.frame.origin.x + 40, authorLabel.frame.origin.y + 30, _titleLabel.frame.size.width - 30, 25)];
    _regionLabel.text = self.comicDetail.areaName;
    _regionLabel.font = [UIFont systemFontOfSize:15];
    [_headerView addSubview:_regionLabel];
    
    // 类型
    UILabel *type = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.frame.origin.x, _regionLabel.frame.origin.y + 30, _titleLabel.frame.size.width, 25)];
    type.text = @"类型:";
    type.font = [UIFont systemFontOfSize:15];
    [_headerView addSubview:type];
    
    _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(type.frame.origin.x + 40, region.frame.origin.y + 30, _titleLabel.frame.size.width - 30, 25)];
    _typeLabel.text = self.comicDetail.comicType;
    _typeLabel.font = [UIFont systemFontOfSize:15];
    [_headerView addSubview:_typeLabel];
    
    // 添加收藏
    _collectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [[XLLocalDataManager shareManager] open];
    BOOL flag = NO;
    NSArray *array1 = [[XLLocalDataManager shareManager] selectAllSComic:tableListcollect];
    for (SComic *s in array1) {
        if ([s.comicID isEqualToString:self.comicId]) {
            [_collectButton setTitle:@"已经收藏" forState:UIControlStateNormal];
            [[XLLocalDataManager shareManager] close];
            flag = YES;
        }
    }
    if (flag == NO) {
        [_collectButton setTitle:@"添加收藏" forState:(UIControlStateNormal)];
    }
    [_collectButton setFrame:CGRectMake(_titleLabel.frame.origin.x, (_imgView.frame.origin.y + _imgView.frame.size.height) - 35, 80, 35)];
    _collectButton.tintColor = [UIColor whiteColor];
    _collectButton.backgroundColor = [UIColor colorWithRed:0.077 green:0.250 blue:1.000 alpha:1.000];
    _collectButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_collectButton addTarget:self action:@selector(addCollectAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:_collectButton];
    
    // 开始阅读
    _startReadButton = [SSRollingBtn buttonWithType:(UIButtonTypeCustom)];
    [_startReadButton setFrame:CGRectMake(_collectButton.frame.origin.x + 95, (_imgView.frame.origin.y + _imgView.frame.size.height) - 35, 80, 35)];
    _startReadButton.tintColor = [UIColor whiteColor];
    _startReadButton.backgroundColor = [UIColor colorWithRed:1.000 green:0.456 blue:0.092 alpha:1.000];
    _startReadButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [[XLLocalDataManager shareManager] open];
    NSArray *array = [[XLLocalDataManager shareManager] selectAllSComic:tableListhistory];
    for (SComic *s in array) {
        if ([s.comicID isEqualToString:self.comicId]) {
            NSLog(@"%@",s.chapterTitle);
            NSString *string = @"续看：";
            NSString *string1 = [string stringByAppendingString:s.chapterTitle];
            [_startReadButton setTextString:string1];
            [_startReadButton setRollingSpeed:40.f];
            _startReadButton.contentLabel.textColor = [UIColor whiteColor];
            _startReadButton.contentLabel.font = [UIFont systemFontOfSize:14];
            [_startReadButton start];
            [[XLLocalDataManager shareManager] close];
            isRead = YES;
        }
    }
    if (isRead == NO) {
        [_startReadButton setTitle:@"开始阅读" forState:(UIControlStateNormal)];
    }
    [_startReadButton addTarget:self action:@selector(startReadingAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:_startReadButton];
    
    // 内容介绍
    _introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.frame.origin.x, _imgView.frame.size.height + 20, _headerView.frame.size.width - 30, 54)];
    _introduceLabel.text = self.comicDetail.intro;
    _introduceLabel.numberOfLines = 0;
    _introduceLabel.font = [UIFont systemFontOfSize:15];
    [_headerView addSubview:_introduceLabel];
    
    // 打开Label用户交互
    self.introduceLabel.userInteractionEnabled = YES;
    
    // 手势
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction:)];
    [self.introduceLabel addGestureRecognizer:_tapGesture];
    
    _arrowLabel = [[UILabel alloc] initWithFrame:CGRectMake (self.tableView.frame.size.width - 30,_introduceLabel.frame.origin.y + 55, 14, 15)];
    _arrowLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"arrow.png"]];
    [_headerView addSubview:_arrowLabel];
    
    // 提示
    _hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(_hintLabel.frame.origin.x, _introduceLabel.frame.origin.y + 75, _headerView.frame.size.width, 40)];
    _hintLabel.text = @"请选择漫画站进行阅读";
    _hintLabel.textAlignment = NSTextAlignmentCenter;
    _hintLabel.textColor = [UIColor colorWithRed:0.686 green:0.278 blue:1.000 alpha:1.000];
    _hintLabel.font = [UIFont systemFontOfSize:15 weight:1];
    _hintLabel.backgroundColor = [UIColor colorWithRed:0.750 green:0.837 blue:1.000 alpha:1.000];
    [_headerView addSubview:_hintLabel];

    self.tableView.tableHeaderView = _headerView;
    [self.tableView reloadData];
}

- (void)authorAction:(id)sender
{
    XLAuthorDetailTableViewController *xlAuthorDetailVC = [XLAuthorDetailTableViewController new];
    xlAuthorDetailVC.key = self.comicDetail.comicId;
    xlAuthorDetailVC.author = self.comicDetail.authorName;
    [self.navigationController pushViewController:xlAuthorDetailVC animated:YES];
}


- (void)comebackXLReconmmendVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 跳转评论页面
- (void)toCommentVC
{
    
}


- (void)tapGestureRecognizerAction:(UITapGestureRecognizer *)recognizer
{
    if (NO == _expand)
    {
        _headerView.frame = CGRectMake(0, 0, self.tableView.frame.size.width,320);
        
        _introduceLabel.frame = CGRectMake(_imgView.frame.origin.x, _imgView.frame.size.height + 20, _headerView.frame.size.width - 30, 54);
        
        _arrowLabel.frame = CGRectMake (self.tableView.frame.size.width - 30,_introduceLabel.frame.origin.y + 55, 14, 15);
        _arrowLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"arrow.png"]];
        
        
        _hintLabel.frame = CGRectMake(_hintLabel.frame.origin.x , _introduceLabel.frame.origin.y + 75, _headerView.frame.size.width, 40);
        self.tableView.tableHeaderView = _headerView;
        _expand = YES;
    } else{
        // 自适应
        CGFloat height = [self calcHeight];
        
        _headerView.frame = CGRectMake(0, 0, self.tableView.frame.size.width,320 + height - 60);
        _introduceLabel.frame = CGRectMake(_imgView.frame.origin.x, _imgView.frame.size.height + 20, _headerView.frame.size.width - 30, height);
        
        _arrowLabel.frame =  CGRectMake (self.tableView.frame.size.width - 30,_introduceLabel.frame.origin.y + 55 + (height - 60), 14, 15);
        _arrowLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"arrow1.png"]];
        _hintLabel.frame = CGRectMake(_hintLabel.frame.origin.x , _introduceLabel.frame.origin.y + 75 + (height - 60), _headerView.frame.size.width, 40);
        self.tableView.tableHeaderView = _headerView;
        
        _expand = NO;
    }
}

// 计算Label的高度
- (CGFloat)calcHeight
{
    CGSize maxSize = CGSizeMake(_introduceLabel.frame.size.width, 1000);
    NSDictionary *dict = @{
                           NSFontAttributeName:_introduceLabel.font
                           };
    CGRect frame = [_introduceLabel.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return frame.size.height;
}


#pragma mark -  添加收藏
- (void)addCollectAction:(UIButton *)sender
{
    [[XLLocalDataManager shareManager] open];
    [[XLLocalDataManager shareManager] createTable:tableListcollect];
    NSArray *array1 = [[XLLocalDataManager shareManager] selectAllSComic:tableListhistory];
    NSArray *array2 = [[XLLocalDataManager shareManager] selectAllSComic:tableListcollect];
    SComic *scomic = [SComic new];
    for (SComic *s in array2) {
        if ([s.comicID isEqualToString:self.comicId]) {
            [[XLLocalDataManager shareManager] deleteWithSComic:s.comicID tableList:tableListcollect];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"collectchange" object:nil];
            [_collectButton setTitle:@"添加收藏" forState:UIControlStateNormal];
            [[XLLocalDataManager shareManager] close];
            return;
        }
    }
    for (SComic *s in array1) {
        if ([s.comicID isEqualToString:self.comicId]) {
            [_collectButton setTitle:@"已经收藏" forState:UIControlStateNormal];
            [[XLLocalDataManager shareManager] insertSComic:s tableList:tableListcollect];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"collectchange" object:nil];
            [[XLLocalDataManager shareManager] close];
            return;
        }
    }
    scomic.comicID = self.comicId;
    scomic.updateTime = ((SSDetailTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).dateLabel.text;
    scomic.comicImageUrl = self.comicDetail.thumb;
    scomic.comicTitle = self.comicDetail.title;
    [[XLLocalDataManager shareManager] insertSComic:scomic tableList:tableListcollect];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"collectchange" object:nil];
    [_collectButton setTitle:@"已经收藏" forState:UIControlStateNormal];
    [[XLLocalDataManager shareManager] close];
}

#pragma mark -  开始阅读
- (void)startReadingAction:(UIButton *)sender
{
    SSContentViewController *contentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];
    
    if (isRead == NO) {
        ComicSource *comicSource = _comicStrArray[0];
        NSMutableArray *chapterArray = [NSMutableArray array];
        [[DataManager sharedDataManager] loadChapterWithComicsrcid:comicSource.ID comicid:self.comicId completion:^{
            [chapterArray addObjectsFromArray:[DataManager sharedDataManager].chapter];
            Chapter *chapter = chapterArray[0];
            contentVC.chapterID = chapter.ID;
            contentVC.chapterArray = [NSArray arrayWithArray:chapterArray];
            contentVC.index = 0;
            contentVC.site = comicSource.title;
        
            SComic *scomic = [SComic new];
            scomic.comicID = self.comicId;
            scomic.comicImageUrl = self.comicDetail.thumb;
            scomic.comicsrcID = comicSource.ID;
            scomic.comicTitle = self.comicDetail.title;
            scomic.updateTime = ((SSDetailTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).dateLabel.text;
            scomic.chapterTitle = chapter.title;
            scomic.chapterID = chapter.ID;
//            contentVC.xlSComic.chapterID = chapter.ID;
//            contentVC.xlSComic.chapterTitle = chapter.title;
            contentVC.comicid = self.comicId;

            contentVC.xlSComic = scomic;
            
            [self.navigationController pushViewController:contentVC animated:YES];
        }];
        isRead = YES;
    }else{
        ComicSource *comicSource = [ComicSource new];
        [[XLLocalDataManager shareManager] open];
        SComic *scomic = [[XLLocalDataManager shareManager] selectWithComicID:self.comicId tableList:tableListhistory];

        comicSource.ID = scomic.comicsrcID;
        contentVC.contectPage = scomic.contentPage;

        contentVC.chapterID = scomic.chapterID;

        contentVC.site = scomic.comicsrcTitle;
        contentVC.comicid = self.comicId;
        contentVC.xlSComic = scomic;
        [[XLLocalDataManager shareManager] close];
        
        NSMutableArray *chapterArray = [NSMutableArray array];
        [[DataManager sharedDataManager] loadChapterWithComicsrcid:comicSource.ID comicid:self.comicId completion:^{
            [chapterArray addObjectsFromArray:[DataManager sharedDataManager].chapter];
//            contentVC.chapterArray = [NSArray arrayWithArray:chapterArray];
            
            for (int i = 0; i < chapterArray.count - 1; i++) {
                Chapter *chapter = chapterArray[i];
                if ([contentVC.chapterID isEqualToString:chapter.ID]) {
                    contentVC.index = i;
                }
            }
            contentVC.chapterArray = [NSArray arrayWithArray:chapterArray];

            [self.navigationController pushViewController:contentVC animated:YES];
        }];
        
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.comicStrArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detail" forIndexPath:indexPath];
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithRed:0.812 green:0.898 blue:1.000 alpha:1.000];
    }else
    {
        cell.backgroundColor = [UIColor colorWithRed:0.898 green:0.945 blue:1.000 alpha:1.000];
    }

    
    ComicSource *comicSource = self.comicStrArray[indexPath.row];
    
    cell.siteLabel.text = comicSource.title;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:comicSource.lastCharpterUpdateTime];
    cell.dateLabel.text = [formatter stringFromDate:date];
   
    cell.upDateLabel.text = [NSString stringWithFormat:@"最新更新:%@",comicSource.lastCharpterTitle];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ComicSource *comicSource = self.comicStrArray[indexPath.row];
     SSChapterViewController *chapterVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SSChapterVC"];
    chapterVC.comicSoureID = comicSource.ID;
    chapterVC.comicID = self.comicId;
    chapterVC.siteText = comicSource.title;
    chapterVC.ncTitle = self.comicDetail.title;
    
    SComic *scomic = [SComic new];
    scomic.comicID = self.comicId;
    scomic.comicImageUrl = self.comicDetail.thumb;
    scomic.comicsrcID = comicSource.ID;
    scomic.comicTitle = self.comicDetail.title;
    scomic.updateTime = ((SSDetailTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).dateLabel.text;
    chapterVC.xlSComic = scomic;

    [self.navigationController pushViewController:chapterVC animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
}


#pragma mark - 懒加载
- (NSMutableArray *)comicStrArray
{
    if (!_comicStrArray) {
        self.comicStrArray = [NSMutableArray array];
    }
    return _comicStrArray;
}


@end
