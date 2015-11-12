//
//  SSDetailTableViewController.m
//  Cartoon
//
//  Created by lanou3g on 15/11/11.
//  Copyright © 2015年 石莎莎. All rights reserved.
//

#import "SSDetailTableViewController.h"
#import "SSDetailTableViewCell.h"
#import "SSDetailTableViewController.h"

@interface SSDetailTableViewController ()<UIGestureRecognizerDelegate>

// 是否展开
@property (assign, nonatomic) BOOL expand;

@end

@implementation SSDetailTableViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _expand = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载视图
    [self reloadView];
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:@"SSDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"detail"];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // 打开Label用户交互
    _introduceLabel.userInteractionEnabled = YES;
    
    // 手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction:)];
    tapGesture.delegate = self;
    tapGesture.numberOfTapsRequired = 1;
    [self.introduceLabel addGestureRecognizer:tapGesture];
}

- (void)reloadView
{
    // headerView
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width,320)];
    
    // 图片
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(_headerView.frame.origin.x + 12, _headerView.frame.origin.y + 12, _headerView.frame.size.width /2.85,_headerView.frame.size.height / 1.85)];
    _imgView.image = [UIImage imageNamed:@"image_1.jpg"];
    [_headerView addSubview:_imgView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.frame.size.width + 25, _imgView.frame.origin.y, _headerView.frame.size.width - _imgView.frame.size.width - 30, 30)];
    _titleLabel.text = @"花悸";
    _titleLabel.font = [UIFont systemFontOfSize:20];
    [_headerView addSubview:_titleLabel];
    
    // 作者
    UILabel *authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y + 35,40, 25)];
    authorLabel.text = @"作者:";
    authorLabel.font = [UIFont systemFontOfSize:15];
    [_headerView addSubview:authorLabel];
    
    _authorButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _authorButton.frame = CGRectMake(authorLabel.frame.origin.x + 40, authorLabel.frame.origin.y, _titleLabel.frame.size.width - 50, 25);
    [_authorButton setTitle:@"大行道动漫" forState:UIControlStateNormal];
    _authorButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_authorButton setTitleColor:[UIColor colorWithRed:0.221 green:0.579 blue:0.148 alpha:1.000] forState:(UIControlStateNormal)];
    _authorButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
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
    _regionLabel.text = @"本地";
    _regionLabel.font = [UIFont systemFontOfSize:15];
    [_headerView addSubview:_regionLabel];
    
    // 类型
    UILabel *type = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.frame.origin.x, _regionLabel.frame.origin.y + 30, _titleLabel.frame.size.width, 25)];
    type.text = @"类型:";
    type.font = [UIFont systemFontOfSize:15];
    [_headerView addSubview:type];
    
    _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(type.frame.origin.x + 40, region.frame.origin.y + 30, _titleLabel.frame.size.width - 30, 25)];
    _typeLabel.text = @"侦探,恐怖,综合其他";
    _typeLabel.font = [UIFont systemFontOfSize:15];
    [_headerView addSubview:_typeLabel];
    
    // 添加收藏
    _collectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_collectButton setTitle:@"添加收藏" forState:(UIControlStateNormal)];
    [_collectButton setFrame:CGRectMake(_titleLabel.frame.origin.x, (_imgView.frame.origin.y + _imgView.frame.size.height) - 35, 80, 35)];
    _collectButton.tintColor = [UIColor whiteColor];
    _collectButton.backgroundColor = [UIColor colorWithRed:0.077 green:0.250 blue:1.000 alpha:1.000];
    _collectButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_headerView addSubview:_collectButton];
    
    // 开始阅读
    _startReadButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_startReadButton setTitle:@"开始阅读" forState:(UIControlStateNormal)];
    [_startReadButton setFrame:CGRectMake(_collectButton.frame.origin.x + 95, (_imgView.frame.origin.y + _imgView.frame.size.height) - 35, 80, 35)];
    _startReadButton.tintColor = [UIColor whiteColor];
    _startReadButton.backgroundColor = [UIColor colorWithRed:1.000 green:0.456 blue:0.092 alpha:1.000];
    _startReadButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_headerView addSubview:_startReadButton];
    
    // 内容介绍
    _introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.frame.origin.x, _imgView.frame.size.height + 20, _headerView.frame.size.width - 30, 54)];
    _introduceLabel.text = @"        原本打算自己手动设置tabview中的第一行cell，但是需要修改的地方太多了，看到有兄台使用tableHeaderView进行设置，很简单，于是也对其进行了自定义，效果不错。UITableView 的 cell 默认出现在 uitableview 的第一行，如果你想自定义 UITableViewCell 与导航条间距的话，可以使用下面这行代码";
    _introduceLabel.numberOfLines = 0;
    _introduceLabel.font = [UIFont systemFontOfSize:15];
    [_headerView addSubview:_introduceLabel];
    
    _arrowLabel = [[UILabel alloc] initWithFrame:CGRectMake (self.tableView.frame.size.width - 30,_introduceLabel.frame.origin.y + 55, 14, 15)];
    _arrowLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"arrow.png"]];
//    arrowLabel.backgroundColor = [UIColor redColor];
    [_headerView addSubview:_arrowLabel];
    
    // 提示
    _hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(_hintLabel.frame.origin.x, _introduceLabel.frame.origin.y + 75, _headerView.frame.size.width, 40)];
    _hintLabel.text = @"    请选择漫画站进行阅读或者缓存。";
    _hintLabel.textColor = [UIColor colorWithRed:0.934 green:0.461 blue:0.008 alpha:1.000];
    _hintLabel.font = [UIFont systemFontOfSize:15 weight:1];
    _hintLabel.backgroundColor = [UIColor colorWithWhite:0.889 alpha:1.000];
    [_headerView addSubview:_hintLabel];

    self.tableView.tableHeaderView = _headerView;
    
   
    
    
    
    
}


- (void)tapGestureRecognizerAction:(UITapGestureRecognizer *)recognizer
{
    
    if (NO == _expand  ) {
        
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


// 添加收藏
- (void)addCollectAction:(UIButton *)sender
{
    
}

// 开始阅读
- (void)startReadingAction:(UIButton *)sender
{
    
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detail" forIndexPath:indexPath];
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSDetailTableViewController *detailTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SSChapterVC"];
    [self.navigationController pushViewController:detailTVC animated:YES];
}



@end