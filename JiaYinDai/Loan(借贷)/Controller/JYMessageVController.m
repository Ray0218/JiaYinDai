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
#import "JYMessageCell.h"
#import "JYImproveInfoController.h"


@interface JYMessageVController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) JYTabBar *tabBarView;
@property (nonatomic, strong) UITableView *rTableView;

@property (nonatomic,strong) NSString *rCategory ;

@property (nonatomic,assign) NSInteger rSysCurrentPage ;

@property (nonatomic,assign) BOOL rSysHasNextPage ;

@property (nonatomic,assign) NSInteger rActCurrentPage ;

@property (nonatomic,assign) BOOL rActHasNextPage ;

@property (nonatomic,assign) NSInteger rTradeCurrentPage ;

@property (nonatomic,assign) BOOL rTradeHasNextPage ;

@property (nonatomic,assign) NSInteger rCurrentPage ;



@property (nonatomic,strong) NSMutableArray *rDataArray ;


@property (nonatomic,strong) NSMutableArray *rSystemArray ;
@property (nonatomic,strong) NSMutableArray *rActionArray ;
@property (nonatomic,strong) NSMutableArray *rTradeArray ;



@end

@implementation JYMessageVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息中心" ;
    
    self.rCategory = @"1" ;
    self.rSystemArray = [NSMutableArray array] ;
    self.rActionArray = [NSMutableArray array] ;
    self.rTradeArray = [NSMutableArray array] ;
    
    
    self.rDataArray = self.rSystemArray ;
    
    [self.view addSubview:self.tabBarView];
    [self.view addSubview:self.rTableView];
    
    [self makeViewConstraints];
    
    self.rSysCurrentPage = self.rActCurrentPage = self.rTradeCurrentPage = 1 ;
    self.rSysHasNextPage = self.rActHasNextPage = self.rTradeHasNextPage = NO ;
    
    [self setNavRightButtonWithImage:nil title:@"全部已读"] ;
    
    
    @weakify(self) ;
    [self.tabBarView.rac_signalForSelectedItem subscribeNext:^(JYTabBarItem* item) {
        
        NSLog(@"%@",item) ;
        @strongify(self) ;
        
        NSInteger index = self.tabBarView.selectedIndex ;
        
        if (index == 0) {
            self.rDataArray = self.rSystemArray ;
            self.rCategory = @"1" ;
            self.rCurrentPage = self.rSysCurrentPage ;
            if (self.rSysHasNextPage) {
                [self pvt_addFooterRefresh] ;
            }else{
                [self.rTableView removeFooter];
            }
            
            
        }else if (index == 1){
            self.rDataArray = self.rActionArray ;
            self.rCategory = @"2" ;
            self.rCurrentPage = self.rActCurrentPage ;
            if (self.rActHasNextPage) {
                [self pvt_addFooterRefresh] ;
            }else{
                [self.rTableView removeFooter];
            }
            
        }else {
            self.rDataArray = self.rTradeArray ;
            self.rCategory = @"3" ;
            self.rCurrentPage = self.rTradeCurrentPage ;
            if (self.rTradeHasNextPage) {
                [self pvt_addFooterRefresh];
            }else{
                [self.rTableView removeFooter];
            }
        }
        
        if (self.rDataArray.count <= 0) {
            self.rCurrentPage = 1 ;
            [self loadData];
        }
        
        [self.rTableView reloadData] ;
        
    }] ;
    
    
    self.rCurrentPage = 1 ;
    
    [self loadData] ;
    
}

-(void)loadData {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
    [dic setValue:self.rCategory forKey:@"category"] ;
    [dic setValue:@(15) forKey:@"pageSize"] ;
    [dic setValue:@(self.rCurrentPage) forKey:@"pageNumber"] ;
    
    
    @weakify(self)
    [[AFHTTPSessionManager jy_sharedManager]POST:kGetMessageURL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @strongify(self)
        
        NSDictionary *dataDic = responseObject[@"data"] ;
        
        if (dataDic) {
            
            NSArray *rows =dataDic[@"rows"] ;
            
            NSArray * modelArra = [JYMessageModel arrayOfModelsFromDictionaries:rows error:nil] ;
            
            BOOL hasNext = [dataDic[@"hasNextPage"] boolValue] ;
            
            if (!hasNext && self.rTableView.footer) {
                [self.rTableView removeFooter];
            }else{
                if (hasNext) {
                    
                    [self pvt_addFooterRefresh] ;
                }
            }
            
            NSInteger pageNum = [dataDic[@"pageNum"] integerValue] ;
            
            if ([self.rCategory isEqualToString:@"1"]) {
                
                if (pageNum == 1) {
                    [self.rSystemArray removeAllObjects];
                }
                
                
                [self.rSystemArray addObjectsFromArray:modelArra] ;
                self.rDataArray = self.rSystemArray ;
                
                self.rSysCurrentPage = pageNum ;
                self.rSysHasNextPage = hasNext ;
                
                
            }else if ([self.rCategory isEqualToString:@"2"]){
                if (pageNum == 1) {
                    
                    [self.rActionArray removeAllObjects];
                }
                [self.rActionArray addObjectsFromArray:modelArra] ;
                self.rDataArray = self.rActionArray ;
                self.rActHasNextPage = hasNext ;
                self.rActCurrentPage = pageNum ;
                
                
            }else{
                if (pageNum == 1) {
                    [self.rTradeArray removeAllObjects];
                }
                [self.rTradeArray addObjectsFromArray:modelArra] ;
                self.rDataArray = self.rTradeArray ;
                self.rTradeHasNextPage = hasNext ;
                self.rTradeCurrentPage = pageNum ;
                
            }
            [self.rTableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
}



#pragma mark- action

-(void)pvt_clickButtonNavRight {
    
    NSMutableArray *idList = [NSMutableArray array] ;
    
    for (JYMessageModel *model  in self.rDataArray) {
        NSString *idStr = model.id ;
        
        if ([model.status isEqualToString:@"0"] && idStr) {
            [idList addObject:idStr];
        }
    }
    
    
    if (idList.count <= 0) {
        return ;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
    [dic setValue:[idList componentsJoinedByString:@","] forKey:@"idList"] ;
    [dic setValue:@"1" forKey:@"status"] ;
    
    @weakify(self)
    [[AFHTTPSessionManager jy_sharedManager]POST:kMessageReadURL parameters:dic  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @strongify(self)
        
        for (JYMessageModel *model  in self.rDataArray) {
            
            model.status= @"1" ;
        }
        
        [JYProgressManager showBriefAlert:@"全部标记为已读"] ;
        
        [self.rTableView reloadData] ;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
    
    
    
}

#pragma mark - Layout

- (void)makeViewConstraints {
    [self.tabBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(self.view);
        make.height.equalTo(@45);
    }];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tabBarView.mas_bottom).offset(-0.5);  // 偏移0.5, 处理2根分割线叠加问题
        make.left.and.right.and.bottom.equalTo(self.view);
    }];
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.rDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentify" ;
    JYMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
    if (cell == nil) {
        cell = [[JYMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    cell.rDataModel = self.rDataArray[indexPath.row] ;
    
    
    return cell ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JYMessageModel *model = self.rDataArray[indexPath.row] ;
    
    if ([model.status isEqualToString:@"0"]) {
        model.status = @"1" ;
        [self.rTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone] ;
    }
    
    JYMessageDetailController *detailVC = [[JYMessageDetailController  alloc]init];
    //    detailVC.title = model.title ;
    detailVC.rId  = model.id ;
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




-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        
        
        _rTableView = [[UITableView alloc] init ];
        _rTableView.delegate = self;
        _rTableView.dataSource = self;
        _rTableView.backgroundColor = kBackGroundColor;
        _rTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        _rTableView.contentInset = UIEdgeInsetsMake(0, 0, 15, 0) ;
        _rTableView.alwaysBounceVertical = NO;
        _rTableView.directionalLockEnabled = NO;
        _rTableView.scrollsToTop = YES;
        
        _rTableView.estimatedRowHeight = 80 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
        
        _rTableView.tableFooterView = [UIView new];
        @weakify(self)
        [_rTableView addLegendHeaderWithRefreshingBlock:^{
            @strongify(self)
            
            self.rCurrentPage = 1 ;
            [self loadData] ;
        }] ;
        
        
        
        _rTableView.emptyDataView = [DZNEmptyDataView emptyDataView];
        _rTableView.emptyDataView.imageForNoData = [UIImage imageNamed:@"comm_noData"] ;
        _rTableView.emptyDataView.showButtonForNoData = NO;
        _rTableView.emptyDataView.requestSuccess = YES;
    }
    
    return _rTableView ;
}



-(void)pvt_addFooterRefresh {
    
    if (self.rTableView.footer) {
        
        return ;
    }
    
    @weakify(self) ;
    [self.rTableView addLegendFooterWithRefreshingBlock:^{
        @strongify(self)
        
        if ([self.rCategory isEqualToString:@"1"]) {
            
            self.rCurrentPage = self.rSysCurrentPage +1 ;
            
        }else if ([self.rCategory isEqualToString:@"2"]){
            ;
            self.rCurrentPage = self.rActCurrentPage + 1;
            
        }else{
            self.rCurrentPage = self.rTradeCurrentPage + 1 ;
            
        }
        
        [self loadData];
    }] ;
    
}

-(void)pvt_endRefresh {
    
    [self.rTableView.header endRefreshing];
    [self.rTableView.footer endRefreshing];
    
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




@interface JYMessageDetailController (){
    UIScrollView *_rScrollView ;
    
    JYMessType rType ;
    
}


@property (nonatomic ,strong) UIView *rContentView ;
@property (nonatomic ,strong) UILabel *rTitleLabel ;
@property (nonatomic ,strong) UILabel *rDetailLabel ;

@property (nonatomic ,strong) UILabel *rCompanyLabel ;
@property (nonatomic ,strong) UILabel *rTimeLabel ;

@property (nonatomic ,strong) UIImageView *rNoDataImgView ;


@end

@implementation JYMessageDetailController

- (instancetype)initWithType:(JYMessType) type
{
    self = [super init];
    if (self) {
        rType = type ;
    }
    return self;
}


-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"消息详情" ;
    
    self.rContentView.hidden = YES ;
    
    [self buildSubViewUI];
    
    [self pvt_loadData];
    
}

-(void)pvt_loadData {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
    [dic setValue:self.rId  forKey:@"id"] ;
    
    
    NSString *posStr = kMessageDetail ;
    
    if (rType == JYMessTypeNote) {
        posStr = kNoteDetailURL  ;
        
        [dic setValue:[NSNumber numberWithInt:[self.rId intValue]]  forKey:@"id"] ;
        
    }
    
    self.rNoDataImgView.hidden = NO ;
    
    @weakify(self) ;
    [[AFHTTPSessionManager jy_sharedManager]POST:posStr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @strongify(self)
        self.rContentView.hidden = NO  ;
        self.rNoDataImgView.hidden = YES ;
        
        NSDictionary *dataDic = responseObject[@"data"] ;
        
        self.rTitleLabel.text = dataDic[@"title"] ;
        
        
        if ([self.rTitleLabel.text isEqualToString:@"申请退回"]) {
            
            [self setNavRightButtonWithImage:nil title:@"去补录"] ;
        }
        
        
        
        self.rDetailLabel.text = dataDic[@"content"] ;
        
        self.rTimeLabel.text = TTTimeString([NSString stringWithFormat:@"%@",dataDic[@"createTime"]]) ;
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        self.rNoDataImgView.hidden = NO ;
    }] ;
    
}



-(void)pvt_clickButtonNavRight {
    
    JYImproveInfoController *vc = [[JYImproveInfoController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


-(void)buildSubViewUI {
    
    
    _rScrollView = [[UIScrollView alloc]init];
    _rScrollView.showsVerticalScrollIndicator = NO ;
    _rScrollView.backgroundColor = [UIColor clearColor] ;
    [self.view addSubview:_rScrollView];
    
    [_rScrollView addSubview:self.rContentView];
    
    
    [self.rContentView addSubview:self.rTitleLabel];
    [self.rContentView addSubview:self.rDetailLabel];
    [self.rContentView addSubview:self.rCompanyLabel];
    [self.rContentView addSubview:self.rTimeLabel];
    
    
    [self.view addSubview:self.rNoDataImgView];
    
    
    [self.view setNeedsUpdateConstraints];
    
}

-(void)updateViewConstraints {
    
    [_rScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(15, 15, 15, 15)) ;
        
    }] ;
    
    [self.rContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_rScrollView);
        make.height.mas_greaterThanOrEqualTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH-30) ;
        
    }];
    
    
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rContentView).offset(15) ;
        make.centerX.equalTo(self.rContentView) ;
        make.left.equalTo(self.rContentView).offset(15) ;
        make.right.equalTo(self.rContentView).offset(-15) ;
    }] ;
    
    [self.rDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(25) ;
        make.right.equalTo(self.rContentView).offset(-25) ;
        make.top.equalTo(self.rTitleLabel.mas_bottom).offset(10) ;
    }] ;
    
    
    [self.rCompanyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rDetailLabel) ;
        make.top.equalTo(self.rDetailLabel.mas_bottom).offset(25) ;
    }] ;
    
    [self.rTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rDetailLabel) ;
        make.top.equalTo(self.rCompanyLabel.mas_bottom).offset(10) ;
        make.bottom.equalTo(self.rContentView).offset(-15) ;
    }] ;
    
    
    [self.rNoDataImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view) ;
        
        make.centerY.equalTo(self.view) ;
        
    }] ;
    
    
    [super updateViewConstraints];
    
}

#pragma mark- getter

-(UILabel*)rTitleLabel {
    if (_rTitleLabel == nil) {
        _rTitleLabel = [self jyCreateLabelWithTitle:@"" font:17 color:kBlackColor align:NSTextAlignmentCenter] ;
        _rTitleLabel.numberOfLines = 0 ;
    }
    
    return _rTitleLabel ;
}

-(UILabel*)rTimeLabel {
    if (_rTimeLabel == nil) {
        _rTimeLabel = [self jyCreateLabelWithTitle:@"" font:12 color:kTextBlackColor align:NSTextAlignmentRight] ;
    }
    
    return _rTimeLabel ;
}

-(UILabel*)rDetailLabel {
    if (_rDetailLabel == nil) {
        
        _rDetailLabel = [self jyCreateLabelWithTitle:@"" font:14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
        
        _rDetailLabel.numberOfLines = 0 ;
    }
    
    return _rDetailLabel ;
}

-(UILabel*)rCompanyLabel {
    
    if (_rCompanyLabel == nil) {
        _rCompanyLabel = [self jyCreateLabelWithTitle:@"嘉银贷" font:14 color:kTextBlackColor align:NSTextAlignmentRight] ;
    }
    
    return _rCompanyLabel ;
}


-(UIView*)rContentView {
    if (_rContentView == nil) {
        _rContentView = [[UIView alloc]init];
        _rContentView.backgroundColor = [UIColor whiteColor] ;
        _rContentView.layer.cornerRadius = 5 ;
        _rContentView.layer.borderWidth = 1 ;
        _rContentView.layer.borderColor = kLineColor.CGColor ;
    }
    
    return _rContentView ;
}

-(UIImageView*)rNoDataImgView {
    
    
    if (_rNoDataImgView == nil) {
        _rNoDataImgView = [[UIImageView alloc]init];
        _rNoDataImgView.image =[ UIImage imageNamed:@"comm_noData"] ;
        
        _rNoDataImgView.backgroundColor = [UIColor clearColor] ;
        _rNoDataImgView.hidden = YES ;
    }
    
    return _rNoDataImgView ;
}





@end










