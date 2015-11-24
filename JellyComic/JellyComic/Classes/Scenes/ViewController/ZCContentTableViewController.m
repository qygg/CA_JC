//
//  ZCContentTableViewController.m
//  JellyComic
//
//  Created by 胡智超 on 15/11/21.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import "ZCContentTableViewController.h"
#import "DataManager.h"
#import "Content.h"
#import "ZCContentTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface ZCContentTableViewController ()

@property (nonatomic, strong) NSMutableArray *cellHeight;
@property (nonatomic, strong) NSMutableArray *isCellLoaded;

@end

@implementation ZCContentTableViewController

static NSString * const reuseID = @"zccontent";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZCContentTableViewCell" bundle:nil] forCellReuseIdentifier:reuseID];
    
    [[DataManager sharedDataManager] loadContentWithCharpterid:self.chapterID completion:^{
        for (int i = 0; i < [DataManager sharedDataManager].content.addrs.count; i++) {
            [self.cellHeight addObject:@([UIScreen mainScreen].bounds.size.height)];
            [self.isCellLoaded addObject:@NO];
        }
        [self.tableView reloadData];
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [DataManager sharedDataManager].content.addrs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[DataManager sharedDataManager].content.addrs[indexPath.row]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGFloat scale = image.size.width / image.size.height;
        CGFloat height = cell.bounds.size.width / scale;
        self.cellHeight[indexPath.row] = @(height);
        if (![self.isCellLoaded[indexPath.row] boolValue]) {
            self.isCellLoaded[indexPath.row] = @YES;
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellHeight[indexPath.row] doubleValue];
}

- (NSMutableArray *)cellHeight {
    if (!_cellHeight) {
        _cellHeight = [NSMutableArray array];
    }
    return _cellHeight;
}

- (NSMutableArray *)isCellLoaded {
    if (!_isCellLoaded) {
        _isCellLoaded = [NSMutableArray array];
    }
    return _isCellLoaded;
}

@end















