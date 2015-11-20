//
//  SSChapterViewController.m
//  Cartoon
//
//  Created by lanou3g on 15/11/11.
//  Copyright © 2015年 石莎莎. All rights reserved.
//

#import "SSChapterViewController.h"
#import "SSChapterTableViewCell.h"
#import "DataManager.h"
#import "Chapter.h"
#import "SSContentViewController.h"
#import "SComic.h"
@interface SSChapterViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UIView *headerView;              // headerView
@property (strong, nonatomic) IBOutlet UITableView *tableView;          // tableView
@property (strong, nonatomic) IBOutlet UIView *footerView;              // footerView
@property (strong, nonatomic) IBOutlet UIButton *downLoadLabel;         // 缓存
@property (strong, nonatomic) IBOutlet UIButton *taskButton;            // 管理任务
@property (strong, nonatomic) IBOutlet UILabel *siteLabel;              // 站点

@property (strong, nonatomic) NSMutableArray *chapterMutArray;
//@property (strong, nonatomic) NSArray *chapterArr;


@property (strong, nonatomic) NSArray *chapterArray;

@property (assign, nonatomic) BOOL isSorting;

@end

@implementation SSChapterViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.siteLabel.text = self.siteText;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self requestChapterData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.ncTitle;
   
    // 设置代理、代码源
    _tableView.delegate = self;
    _tableView.dataSource = self;
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:@"SSChapterTableViewCell" bundle:nil] forCellReuseIdentifier:@"chapter"];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    _isSorting = NO;
}

- (void)requestChapterData
{
    [[DataManager sharedDataManager] loadChapterWithComicsrcid:self.comicSoureID comicid:self.comicID completion:^{
        self.chapterArray = [NSArray arrayWithArray:[DataManager sharedDataManager].chapter];
        for (int i = (int)self.chapterArray.count - 1; i >= 0; i--) {
            [self.chapterMutArray addObject:self.chapterArray[i]];
        }
        [self.tableView reloadData];
    }];
    
}


// 返回
- (IBAction)comeBackSSDetailTableViewControllerAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



// 章节顺序
- (IBAction)sortOfChaptersAction:(UIButton *)sender
{
    if (self.isSorting) {
        self.isSorting = NO;
    } else {
        self.isSorting = YES;
    }
    [self.tableView reloadData];
}




#pragma mark -  UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chapterArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSChapterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chapter" forIndexPath:indexPath];
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithWhite:0.974 alpha:1.000];
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    Chapter *chapter = nil;
    if (!self.isSorting) {
        chapter = self.chapterArray[indexPath.row];
    } else {
        chapter = self.chapterMutArray[indexPath.row];
    }
    cell.chapterLabel.text = chapter.title;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SSContentViewController *contentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];
    
    Chapter *chapter = [Chapter new];
    if (!self.isSorting) {
        chapter = self.chapterArray[indexPath.row];
    } else {
        chapter = self.chapterMutArray[indexPath.row];
    }
    
    contentVC.chapterID = chapter.ID;
    contentVC.site = self.siteText;

   self.xlSComic.chapterID = chapter.ID;
    contentVC.xlSComic = self.xlSComic;
    NSLog(@"--------%@",contentVC.chapterID);
    [self.navigationController pushViewController:contentVC animated:YES];
}




#pragma mark - 懒加载
- (NSArray *)chapterArray
{
    if (!_chapterArray) {
        self.chapterArray = [NSArray new];
    }
    return _chapterArray;
}

- (NSMutableArray *)chapterMutArray {
    if (!_chapterMutArray) {
        _chapterMutArray = [NSMutableArray array];
    }
    return _chapterMutArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
