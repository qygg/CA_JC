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

@interface SSChapterViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UIView *headerView;              // headerView
@property (strong, nonatomic) IBOutlet UITableView *tableView;          // tableView
@property (strong, nonatomic) IBOutlet UIView *footerView;              // footerView
@property (strong, nonatomic) IBOutlet UILabel *siteLabel;              // 站点
@property (strong, nonatomic) IBOutlet UIButton *downLoadLabel;         // 缓存
@property (strong, nonatomic) IBOutlet UIButton *taskButton;            // 管理任务


@property (strong, nonatomic) NSMutableArray *chapterArray;

@property (assign, nonatomic) BOOL isSorting;

@property (nonatomic, strong) Chapter *chapter;

@end

@implementation SSChapterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置代理、代码源
    _tableView.delegate = self;
    _tableView.dataSource = self;
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:@"SSChapterTableViewCell" bundle:nil] forCellReuseIdentifier:@"chapter"];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    
//    for (int i = 0; i < 10; i++) {
//        NSString *string = [NSString stringWithFormat:@"第%d章",i];
//        [self.chapterArray addObject:string];
//    }
    
    _isSorting = NO;
}

- (void)requestChapterData
{
    [[DataManager sharedDataManager] loadChapterWithComicsrcid:self.comicSoureID comicid:self.comicID completion:^{
        NSLog(@"[DataManager sharedDataManager].chapter = %ld",[DataManager sharedDataManager].chapter.count);
        [self.chapterArray addObjectsFromArray:[DataManager sharedDataManager].chapter];
    
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
    
}

// 缓存
- (IBAction)downloadAction:(UIBarButtonItem *)sender
{
    
}

// 管理任务
- (IBAction)managerOfTaskAction:(UIButton *)sender
{
    
}



#pragma mark -  UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"self.chapterArray.count == %ld",self.chapterArray.count);
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
    NSString *text = self.chapterArray[indexPath.row];
    cell.chapterLabel.text = text;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}




#pragma mark - 懒加载
- (NSMutableArray *)chapterArray
{
    if (!_chapterArray) {
        self.chapterArray = [NSMutableArray new];
    }
    return _chapterArray;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
