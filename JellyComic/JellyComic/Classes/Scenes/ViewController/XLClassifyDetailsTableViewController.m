//
//  XLClassifyDetailsTableViewController.m
//  测试1
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "XLClassifyDetailsTableViewController.h"
#import "XLClassifyDetailsTableViewCell.h"
#import "DataManager.h"
#import "MJRefresh.h"
#import "Comic.h"
#import "UIImageView+WebCache.h"
#import "SSDetailTableViewController.h"

@interface XLClassifyDetailsTableViewController ()
{
    int page;
    int page1;
    int page2;
    int i;
}
@property (nonatomic, strong) NSArray *topHotArray;
@property (nonatomic, strong) NSArray *timeArray;
@property (nonatomic, strong) NSArray *finishArray;
@property (nonatomic, strong) UIButton *menuButton;
@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, assign) BOOL show;
@property (nonatomic, strong) UIWindow *bgWindow;

@end

@implementation XLClassifyDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    page = 1;
    page1 = 1;
    page2 = 1;
    i = 1;
    self.title = self.categories.title;
    self.menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 62, 30)];
    self.menuButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    
    [self.menuButton setTitle:@"热门" forState:UIControlStateNormal];
    [self.menuButton setTitleColor:[UIColor colorWithRed:0.686 green:0.278 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    [self.menuButton setImage:[UIImage imageNamed:@"expandableImage"] forState:UIControlStateNormal];
    self.menuButton.imageEdgeInsets = UIEdgeInsetsMake(11, 52, 11, 0);

    [_menuButton addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_menuButton];

    UINib *cellNib = [UINib nibWithNibName:@"XLClassifyDetailsTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"b"];
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - 70;
    self.menuView = [[UIView alloc] initWithFrame:CGRectMake(screenWidth, 64, 60, 110)];
    self.menuView.backgroundColor = [UIColor colorWithRed:0.812 green:0.898 blue:1.000 alpha:1.000];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.898 green:0.945 blue:1.000 alpha:1.000];
    UIButton *hotButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 40, 30)];
    [hotButton setTitle:@"热门" forState:UIControlStateNormal];
    [hotButton setTitleColor:[UIColor colorWithRed:0.686 green:0.278 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    [hotButton addTarget:self action:@selector(hotAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.menuView addSubview:hotButton];
    
    UIButton *newButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 40, hotButton.frame.size.width, 30)];
    [newButton setTitle:@"最新" forState:UIControlStateNormal];
    [newButton setTitleColor:[UIColor colorWithRed:0.686 green:0.278 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    [newButton addTarget:self action:@selector(newAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.menuView addSubview:newButton];
    
    UIButton *finishButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 70, hotButton.frame.size.width, 30)];
    [finishButton setTitle:@"完结" forState:UIControlStateNormal];
    [finishButton setTitleColor:[UIColor colorWithRed:0.686 green:0.278 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    [finishButton addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.menuView addSubview:finishButton];
    self.bgWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.bgWindow.backgroundColor = [UIColor clearColor];
    self.bgWindow.windowLevel = UIWindowLevelAlert + 1;
    [self.bgWindow makeKeyAndVisible];
    
    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.bgView.backgroundColor = [UIColor clearColor];
    
    [self.bgWindow addSubview:_bgView];
    [self.bgView addSubview:_menuView];
    self.bgView.hidden = YES;
    self.bgWindow.hidden = YES;
    self.menuView.hidden = YES;
    if (i == 1) {
        [self initDataTableTopHot1];
        [self initDataSourceTopHot];
    }else if (i == 2) {
        [self initDataTableTime];
        [self initDataSourceTime];
    }else if (i == 3) {
        [self initDataTableFinish];
        [self initDataSourceFinish];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAction)];
    [self.bgView addGestureRecognizer:tap];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return"] style:UIBarButtonItemStyleDone target:self action:@selector(returnAction:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:0.686 green:0.278 blue:1.000 alpha:1.000];
    
}
- (void)returnAction:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)removeAction
{
    self.bgView.hidden = YES;
    self.bgWindow.hidden = YES;
    self.menuView.hidden = YES;
}
- (void)updateTable
{
    if (i == 1) {
        [self initDataTableTopHot];
        [self initDataSourceTopHot];
    }else if (i == 2) {
        [self initDataTableTime];
        [self initDataSourceTime];
    }else if (i == 3) {
        [self initDataTableFinish];
        [self initDataSourceFinish];
    }
}

- (void)initDataSourceTopHot
{
    [[DataManager sharedDataManager] loadCategoryDetailWithCategoryType:CategoryTypeTophot cateId:self.categories.cateId page:page completion:^{
        if (_topHotArray.count == [[DataManager sharedDataManager] categoryDetail].count && page != 1) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        _topHotArray = [[DataManager sharedDataManager] categoryDetail];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)initDataSourceTime
{
    [[DataManager sharedDataManager] loadCategoryDetailWithCategoryType:CategoryTypeTime cateId:self.categories.cateId page:page1 completion:^{
        if (_timeArray.count == [[DataManager sharedDataManager] categoryDetail].count && page1 != 1) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        _timeArray = [[DataManager sharedDataManager] categoryDetail];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)initDataSourceFinish
{
    [[DataManager sharedDataManager] loadCategoryDetailWithCategoryType:CategoryTypeFinished cateId:self.categories.cateId page:page2 completion:^{
        if (_finishArray.count == [[DataManager sharedDataManager] categoryDetail].count && page2 != 1) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        _finishArray = [[DataManager sharedDataManager] categoryDetail];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}
- (void)initDataTableTopHot1
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self initDataSourceTopHot];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page++;
        [self initDataSourceTopHot];
    }];
}

- (void)initDataTableTopHot
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self initDataSourceTopHot];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page++;
        [self initDataSourceTopHot];
    }];
}
- (void)initDataTableTime
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page1 = 1;
        [self initDataSourceTime];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page1++;
        [self initDataSourceTime];
    }];
}
- (void)initDataTableFinish
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page2 = 1;
        [self initDataSourceFinish];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page2++;
        [self initDataSourceFinish];
    }];
}
- (void)btnPressed:(id)sender
{
   
    
    [self btnHidden];
}
- (void)btnHidden
{
    self.menuView.hidden = NO;
    self.bgWindow.hidden = NO;
    self.bgView.hidden = NO;
    _show = YES;

}

- (void)hiddenAction
{
    if (_show == NO) {
        self.menuView.hidden = NO;
        self.bgWindow.hidden = NO;
        self.bgView.hidden = NO;
        
        _show = YES;
        return;
    }else if (_show == YES)
    {
        self.menuView.hidden = YES;
        self.bgView.hidden = YES;
        self.bgWindow.hidden = YES;
        _show = NO;
        return;
    }
}

- (void)hotAction:(id)sender
{
    NSString *str = @"热门";
    [self.menuButton setTitle:str forState:UIControlStateNormal];

    i = 1;
    [self updateTable];
    [self hiddenAction];
}

- (void)newAction:(id)sender
{
    NSString *str = @"最新";
    [self.menuButton setTitle:str forState:UIControlStateNormal];

    i = 2;
    [self updateTable];
    [self hiddenAction];
}

- (void)finishAction:(id)sender
{
    NSString *str = @"完结";
    [self.menuButton setTitle:str forState:UIControlStateNormal];

    i = 3;
    [self updateTable];
    [self hiddenAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (i == 1) {
        return [_topHotArray count];
    }else if (i == 2){
        return [_timeArray count];
    }else if (i == 3){
        return [_finishArray count];
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XLClassifyDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"b" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithRed:0.812 green:0.898 blue:1.000 alpha:1.000];
    }else
    {
        cell.backgroundColor = [UIColor colorWithRed:0.898 green:0.945 blue:1.000 alpha:1.000];
    }
    if (i == 1) {
        self.comic = _topHotArray[indexPath.row];
        cell.nameLabel.text = _comic.title;
        cell.authorLabel.text = _comic.authorName;
        cell.bestNewLabel.text = _comic.lastCharpter_title;
        cell.typeLabel.text = _comic.comicType;
        [cell.comicShowImageView sd_setImageWithURL:[NSURL URLWithString:_comic.thumb]];
        return cell;
    }else if (i == 2) {
        self.comic = _timeArray[indexPath.row];
        cell.nameLabel.text = _comic.title;
        cell.authorLabel.text = _comic.authorName;
        cell.bestNewLabel.text = _comic.lastCharpter_title;
        cell.typeLabel.text = _comic.comicType;
        [cell.comicShowImageView sd_setImageWithURL:[NSURL URLWithString:_comic.thumb]];
        return cell;
    }else if (i == 3) {
        self.comic = _finishArray[indexPath.row];
        cell.nameLabel.text = _comic.title;
        cell.authorLabel.text = _comic.authorName;
        cell.bestNewLabel.text = _comic.lastCharpter_title;
        cell.typeLabel.text = _comic.comicType;
        [cell.comicShowImageView sd_setImageWithURL:[NSURL URLWithString:_comic.thumb]];
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
#pragma mark - tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSDetailTableViewController *SSDetailTVC = [[UIStoryboard storyboardWithName:@"SSDetail" bundle:nil] instantiateViewControllerWithIdentifier:@"ssDetailTVC"];
    
    switch (i) {
        case 1:
        {
            Comic *comic = _topHotArray[indexPath.row];
            SSDetailTVC.comicId = comic.comicId;
        }
            break;
        case 2:
        {
            Comic *comic = _timeArray[indexPath.row];
            SSDetailTVC.comicId = comic.comicId;
        }
            break;
        case 3:
        {
            Comic *comic = _finishArray[indexPath.row];
            SSDetailTVC.comicId = comic.comicId;
        }
            break;
        default:
            break;
    }
    UINavigationController *SSDeatilNC = [[UINavigationController alloc] initWithRootViewController:SSDetailTVC];

    [self showViewController:SSDeatilNC sender:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
