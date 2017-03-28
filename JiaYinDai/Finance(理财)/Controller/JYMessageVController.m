//
//  JYMessageVController.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/23.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYMessageVController.h"
#import "JYTabBar.h"
#import <OAStackView.h>
#import "JYMessageModel.h"
#import "JYMessageCell.h"


@interface JYMessageVController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) JYTabBar *tabBarView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) OAStackView *stackView;
@property (nonatomic, strong) NSArray *tableViews;
@property (nonatomic, strong) JYMessageModel *viewModel;

@end

@implementation JYMessageVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息中心" ;
    
    [self.view addSubview:self.tabBarView];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.stackView];
    
    [self makeViewConstraints];
    
    @weakify(self) ;
    [self.tabBarView.rac_signalForSelectedItem subscribeNext:^(JYTabBarItem* item) {
        
        NSLog(@"%@",item) ;
        @strongify(self) ;
        [self.scrollView scrollRectToVisible:CGRectMake(self.tabBarView.selectedIndex*CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.bounds)) animated:YES];
        
    }] ;
    
    [[self rac_signalForSelector:@selector(scrollViewDidEndDecelerating:) fromProtocol:@protocol(UIScrollViewDelegate)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        if (self.scrollView == tuple.first) {
            NSInteger index = self.scrollView.contentOffset.x / CGRectGetWidth(self.scrollView.frame);
            JYTabBarItem *item = self.tabBarView.items[index];
            self.tabBarView.selectedItem = item;
        }
    }];
    
    
    
}

#pragma mark - Layout

- (void)makeViewConstraints {
    [self.tabBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tabBarView.mas_bottom).offset(-0.5);  // 偏移0.5, 处理2根分割线叠加问题
        make.left.and.right.and.bottom.equalTo(self.view);
    }];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        
    }];
    [self.view bringSubviewToFront:self.tabBarView];
    
    for (UITableView *tableView in self.tableViews) {
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.scrollView);
            make.height.equalTo(self.scrollView);
        }];
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 31;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier" ;
    JYMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
    if (cell == nil) {
        cell = [[JYMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.row %3 == 0) {
        cell.rDetailLabel.text = [NSString stringWithFormat:@"================当前行数 == %zd",indexPath.row] ;
//        cell.rBackgroundView.highlighted = YES ;
        
    }else{
//        cell.rBackgroundView.highlighted = NO ;
        
    }
    return cell ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JYMessageDetailController *detailVC = [[JYMessageDetailController  alloc]init];
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

- (JYTabBar *)tabBarView {
    if (_tabBarView == nil) {
        JYTabBarItem *unfinishedItem = [[JYTabBarItem alloc] initWithTitle:@"系统消息"];
        JYTabBarItem *completedItem = [[JYTabBarItem alloc] initWithTitle:@"活动消息"];
        JYTabBarItem *attentionItem = [[JYTabBarItem alloc] initWithTitle:@"交易消息"];
        
        _tabBarView = [[JYTabBar alloc] init];
        _tabBarView.items = @[ unfinishedItem, completedItem, attentionItem ];
    }
    return _tabBarView;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.directionalLockEnabled = YES ;
        
        
        _scrollView.alwaysBounceVertical = NO;
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor orangeColor] ;
    }
    return _scrollView;
}

- (OAStackView *)stackView {
    if (_stackView == nil) {
        _stackView = [[OAStackView alloc] initWithArrangedSubviews:self.tableViews];
        _stackView.alignment =   OAStackViewAlignmentFill;
        _stackView.distribution =   OAStackViewDistributionFillEqually;
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.backgroundColor = [UIColor greenColor] ;
    }
    return _stackView;
}



- (JYMessageModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[JYMessageModel alloc] init ];
    }
    return _viewModel;
}


- (NSArray *)tableViews {
    if (_tableViews == nil) {
        UITableView *unfinishedTable = [self generateTableViewWithMessageType:JYMessageTypeSystem];
        UITableView *completedTable = [self generateTableViewWithMessageType:JYMessageTypeAction];
        UITableView *attentionTable = [self generateTableViewWithMessageType:JYMessageTypeDeal];
        unfinishedTable.sectionHeaderHeight = 25;
        completedTable.sectionHeaderHeight = 25;
        attentionTable.sectionHeaderHeight = 0;
        _tableViews = @[ unfinishedTable, completedTable, attentionTable ];
    }
    return _tableViews;
}


- (UITableView *)generateTableViewWithMessageType:(JYMessageType)type {
    UITableView *tableView = [[UITableView alloc] init ];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = kBackGroundColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 15, 0) ;
    tableView.alwaysBounceVertical = NO;
    tableView.directionalLockEnabled = NO;
    tableView.scrollsToTop = YES;
    tableView.tag = type ;
    
    tableView.estimatedRowHeight = 80 ;
    tableView.rowHeight = UITableViewAutomaticDimension;
    
    tableView.tableFooterView = [[UIView alloc] init];
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:self.viewModel.rSystemIdentifier];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:self.viewModel.rActionIdentifier];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:self.viewModel.rDealIndentifier];
    return tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end




@interface JYMessageDetailController ()

@end

@implementation JYMessageDetailController

-(void)viewDidLoad{
    [super viewDidLoad];
}


@end










