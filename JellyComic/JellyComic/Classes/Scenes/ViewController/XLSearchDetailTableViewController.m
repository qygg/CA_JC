//
//  XLSearchDetailTableViewController.m
//  JellyComic
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import "XLSearchDetailTableViewController.h"
#import "DataManager.h"
#import "Comic.h"
#import "MJRefresh.h"
#import "XLClassifyDetailsTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "SSDetailTableViewController.h"

@interface XLSearchDetailTableViewController ()
{
    int page;
}
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation XLSearchDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.key;
    page = 1;
    [self initDataTable];
    [self initDataSource];
    UINib *cellNib = [UINib nibWithNibName:@"XLClassifyDetailsTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"b"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return"] style:UIBarButtonItemStyleDone target:self action:@selector(returnAction:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor orangeColor];
    
}

- (void)initDataSource
{
    [[DataManager sharedDataManager] loadSearchResultWithKeyword:self.key page:page completion:^{
        if (_dataArray.count == [[DataManager sharedDataManager] searchResult].count) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        _dataArray = [[DataManager sharedDataManager] searchResult];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)initDataTable
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self initDataSource];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page++;
        [self initDataSource];
    }];
}

- (void)returnAction:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XLClassifyDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"b" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.comic = _dataArray[indexPath.row];
    cell.nameLabel.text = _comic.title;
    cell.authorLabel.text = _comic.authorName;
    cell.typeLabel.text = _comic.comicType;
    cell.bestNewLabel.text = _comic.lastCharpter_title;
    [cell.comicShowImageView sd_setImageWithURL:[NSURL URLWithString:_comic.thumb]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
#pragma mark - tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSDetailTableViewController *SSDetailTVC = [[UIStoryboard storyboardWithName:@"SSDetail" bundle:nil] instantiateViewControllerWithIdentifier:@"ssDetailTVC"];
    Comic *comic = _dataArray[indexPath.row];
    SSDetailTVC.comicId = comic.comicId;
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
