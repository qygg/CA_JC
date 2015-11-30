//
//  XLMoreTableViewController.m
//  测试3
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "XLMoreTableViewController.h"
#import "XLMoreTableViewCell.h"
#import "XLLoginViewController.h"
#import "XLLoginDetailViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "SDImageCache.h"

@interface XLMoreTableViewController ()

@property (nonatomic, strong) AVUser *currentUser;

@end

@implementation XLMoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled = NO;
    UINib *cellNib = [UINib nibWithNibName:@"XLMoreTableViewCell" bundle:nil];

    self.tableView.layer.borderWidth = 20;
    self.tableView.backgroundColor = [UIColor colorWithRed:229 / 255. green:241 / 255. blue:255 / 255. alpha:1];
    self.tableView.layer.borderColor = [[UIColor colorWithRed:0.898 green:0.945 blue:1.000 alpha:1.000] CGColor];
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"xlMoreCell"];
    self.tableView.separatorColor = [UIColor colorWithRed:0.686 green:0.278 blue:1.000 alpha:1.000];
    self.tableView.tableFooterView = [UIView new];
    
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

    return 3;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XLMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xlMoreCell" forIndexPath:indexPath];
    

//    if (indexPath.row == 0) {
//        cell.tagLabel.text = @"软件设置";
//
//        cell.backImage.image = [UIImage imageNamed:@"set"];
//    }else if (indexPath.row == 1) {
//        cell.tagLabel.text = @"用户中心";
//
//        cell.backImage.image = [UIImage imageNamed:@"user"];
//    }else if (indexPath.row == 2) {
//        cell.tagLabel.text = @"意见反馈";
//
//        cell.backImage.image = [UIImage imageNamed:@"envelope"];
//    }else if (indexPath.row == 3) {
//        cell.tagLabel.text = @"关于我们";
//
//        cell.backImage.image = [UIImage imageNamed:@"we"];
//    }else if (indexPath.row == 4) {
//        cell.tagLabel.text = @"版本号：1.0";
//
//        cell.backImage.image = [UIImage imageNamed:@"version"];
//        
//    }
    
    
    if (indexPath.row == 0) {
        cell.tagLabel.text = @"用户中心";
        cell.backImage.image = [UIImage imageNamed:@"user"];
    } else if (indexPath.row == 1) {
        cell.tagLabel.text = @"清除缓存";
        cell.backImage.image = [UIImage imageNamed:@"qingchuhuancun"];
    } else {
        cell.tagLabel.text = @"版本号：1.0.0";
        cell.backImage.image = [UIImage imageNamed:@"version"];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    if (indexPath.row == 0) {
//        
//    }else if (indexPath.row == 1) {
//        self.currentUser = [AVUser currentUser];
//        if (self.currentUser != nil) {
//            XLLoginDetailViewController *XLLoginDetailVC = [[UIStoryboard storyboardWithName:@"XLLoginDetailViewControllerStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"loginDetail"];
//            XLLoginDetailVC.userName = self.currentUser.username;
//            UINavigationController *userNC = [[UINavigationController alloc] initWithRootViewController:XLLoginDetailVC];
//            userNC.navigationBar.barTintColor = [UIColor colorWithRed:0.682 green:0.886 blue:1.000 alpha:1.000];
//            userNC.navigationBar.tintColor = [UIColor colorWithRed:0.686 green:0.278 blue:1.000 alpha:1.000];
//            [self showViewController:userNC sender:nil];
//        } else {
//            [self showViewController:[[UIStoryboard storyboardWithName:@"ZCLoginStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"loginNC"] sender:nil];
//        }
//    }else if (indexPath.row == 2) {
//        
//    }else if (indexPath.row == 3) {
//        
//    }else if (indexPath.row == 4) {
//        
//    }
    
    if (indexPath.row == 0) {
        
        self.currentUser = [AVUser currentUser];
        if (self.currentUser != nil) {
            XLLoginDetailViewController *XLLoginDetailVC = [[UIStoryboard storyboardWithName:@"XLLoginDetailViewControllerStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"loginDetail"];
            XLLoginDetailVC.userName = self.currentUser.username;
            UINavigationController *userNC = [[UINavigationController alloc] initWithRootViewController:XLLoginDetailVC];
            userNC.navigationBar.barTintColor = [UIColor colorWithRed:0.682 green:0.886 blue:1.000 alpha:1.000];
            userNC.navigationBar.tintColor = [UIColor colorWithRed:0.686 green:0.278 blue:1.000 alpha:1.000];
            [self showViewController:userNC sender:nil];
        } else {
            [self showViewController:[[UIStoryboard storyboardWithName:@"ZCLoginStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"loginNC"] sender:nil];
        }
        
    } else if (indexPath.row == 1) {
        NSString *hint = [NSString stringWithFormat:@"清除缓存%@", [self fileSizeWithInteger:[[SDImageCache sharedImageCache] getSize]]];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:hint preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *clear = [UIAlertAction actionWithTitle:@"清除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[SDImageCache sharedImageCache] clearDisk];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:clear];
        [alert addAction:cancel];
        [self showDetailViewController:alert sender:nil];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSString *)fileSizeWithInteger:(NSInteger)size {
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB", (long)size];
    } else if (size < 1024 * 1024) {// 小于1m
        CGFloat aFloat = size / 1024;
        return [NSString stringWithFormat:@"%.0fK", aFloat];
    } else if (size < 1024 * 1024 * 1024) {// 小于1G
        CGFloat aFloat = size / (1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM", aFloat];
    } else {
        CGFloat aFloat = size / (1024 * 1024 * 1024);
        return [NSString stringWithFormat:@"%.1fG", aFloat];
    }
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
