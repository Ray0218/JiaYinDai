//
//  JYRedCardController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/14.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYRedCardController.h"
#import "JYTabBar.h"
#import "JYWebViewController.h"

@interface JYRedCardController ()<UITableViewDelegate,UITableViewDataSource>{
    
    
    BOOL rIsRedGift ;
    
    JYRedCardType rCardType ;
}

@property(nonatomic ,strong) UITableView *rTableView ;

@property(nonatomic ,strong) NSMutableArray *rBonuseArray ;
@property(nonatomic ,strong) NSMutableArray *rVouchesArray ;
@property(nonatomic ,strong) NSMutableArray *rOutBonusArray ;
@property(nonatomic ,strong) NSMutableArray *rOutVocherArray ;

@property (nonatomic, strong) JYTabBar *tabBarView;



@property(nonatomic ,strong) UIButton *rFootButtonView ;




@end

@implementation JYRedCardController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSAssert(0, @"使用initWithType") ;
    }
    return self;
}

- (instancetype)initWithType:(JYRedCardType)type
{
    self = [super init];
    if (self) {
        
        rCardType = type ;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"卡包" ;
    
    self.rBonuseArray = [NSMutableArray array] ;
    self.rVouchesArray = [NSMutableArray array] ;
    self.rOutBonusArray = [NSMutableArray array] ;
    self.rOutVocherArray = [NSMutableArray array] ;
    
    
    [self setNavRightButtonWithImage:nil title:@"使用说明"] ;
    
    
    [self buildSubViewUI];
    
    rIsRedGift = YES ;
    
    
    if (rCardType == JYRedCardTypeBoth) {
        [self pvt_loadData];
        
    }else{
        
        self.rTableView.emptyDataView = [DZNEmptyDataView emptyDataView];
        self.rTableView.emptyDataView.imageForNoData = [UIImage imageNamed:@"comm_noData"] ;
        self.rTableView.emptyDataView.showButtonForNoData = NO;
        self.rTableView.emptyDataView.requestSuccess = YES;
    }
    
    
    @weakify(self)
    [self.tabBarView.rac_signalForSelectedItem subscribeNext:^(JYTabBarItem *item) {
        @strongify(self)
        
        if (item.tag - 1000 == 0 && !rIsRedGift ) {
            rIsRedGift = YES ;
            self.rDataArray = self.rBonuseArray ;
            [self.rFootButtonView setTitle:@"查看已使用或过期红包" forState:UIControlStateNormal];
            [self.rTableView reloadData];
            
            
        }else if(rIsRedGift){
            rIsRedGift = NO ;
            
            self.rDataArray = self.rVouchesArray ;
            [self.rFootButtonView setTitle:@"查看已使用或过期抵用券" forState:UIControlStateNormal];
            
            [self.rTableView reloadData];
        }
    }] ;
    
}

-(void)pvt_loadData {
    
    
    @weakify(self)
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kCustomerBonusURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [JYProgressManager hideAlert] ;
        @strongify(self)
        NSArray *bonusArr = responseObject[@"data"][@"bonuses"] ;
        
        NSArray *bonusModelArr = [JYRedBonusModel arrayOfModelsFromDictionaries:bonusArr error:nil] ;
        
        NSArray *vochesArr = responseObject[@"data"][@"vouchers"] ;
        
        NSArray *vochesModelArr  = [JYRedBonusModel arrayOfModelsFromDictionaries:vochesArr error:nil] ;
        
        [self.rBonuseArray removeAllObjects];
        [self.rVouchesArray removeAllObjects];
        
        if (self.rClickNotBack) { //我的福利
            
            [self.rBonuseArray addObjectsFromArray:bonusModelArr] ;
            
            [self.rVouchesArray addObjectsFromArray:vochesModelArr] ;
            
        }else{
            
            for (JYRedBonusModel *model in bonusModelArr) {
                
                
                if ([self.rConditionAmount doubleValue] >= [model.conditionAmount doubleValue]  && [self.rContiueRepayCount integerValue] >= [model.conditionRepayPeriod integerValue]) { //连续还款期数和还款额度
                    
                    [self.rBonuseArray addObject:model];
                    
                }
                
                
            }
            
            
            if (self.rIsAllPay) {
                
                
                for (JYRedBonusModel *model in vochesModelArr) {
                    
                    
                    if ([model.couponsStatus isEqualToString:@"2"] &&[self.rConditionAmount doubleValue] >= [model.conditionAmount doubleValue]  && [self.rContiueRepayCount integerValue] >= [model.conditionRepayPeriod integerValue] ) { //全额红包、连续还款期数和还款额度
                        
                        [self.rVouchesArray addObject:model];
                        
                    }
                    
                }
                
                
                
            }else{
                
                
                for (JYRedBonusModel *model in vochesModelArr) {
                    
                    if ([model.couponsStatus isEqualToString:@"1"]&&[self.rConditionAmount doubleValue] >= [model.conditionAmount doubleValue]  && [self.rContiueRepayCount integerValue] >= [model.conditionRepayPeriod integerValue] ) { //单期红包、连续还款期数和还款额度
                        
                        [self.rVouchesArray addObject:model];
                        
                    }
                }
                
            }
        }
        
        
        
        
        NSArray *outBonusArr = responseObject[@"data"][@"outBonuses"] ;
        
        self.rOutBonusArray = [JYRedBonusModel arrayOfModelsFromDictionaries:outBonusArr error:nil ] ;
        NSArray *outVochesArr = responseObject[@"data"][@"outVouchers"] ;
        
        self.rOutVocherArray = [JYRedBonusModel arrayOfModelsFromDictionaries:outVochesArr error:nil] ;
        
        
        if (rCardType == JYRedCardTypeBoth) {
            if (rIsRedGift) {
                self.rDataArray = self.rBonuseArray ;
            }else{
                
                self.rDataArray = self.rVouchesArray ;
            }
        }else if (rCardType == JYRedCardTypeOutBonus){
            
            self.rDataArray = self.rOutBonusArray  ;
        }else{
            self.rDataArray = self.rOutVocherArray ;
        }
        
        
        [self.rTableView reloadData] ;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


#pragma mark - builUI
-(void)buildSubViewUI {
    
    
    
    if (rCardType == JYRedCardTypeBoth) {
        [self.view addSubview:self.rTableView];
        [self.view addSubview:self.tabBarView];
        
        [self.tabBarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.top.equalTo(self.view);
            make.height.mas_equalTo(45);
        }];
        [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tabBarView.mas_bottom).offset(-0.5);  // 偏移0.5, 处理2根分割线叠加问题
            make.left.and.right.and.bottom.equalTo(self.view);
        }];
        
    }else{
        
        [self.view addSubview:self.rTableView];
        [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero) ;
        }];
        
    }
    
    
}

#pragma mark- UITableViewDataSource/UITableViewDelegate



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.rDataArray.count ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *identifier = @"identifierNormal" ;
    
    JYRedGiftCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYRedGiftCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        
        if (rCardType == JYRedCardTypeOutBonus) {
            
            [cell setTitlesColor: [UIColor lightGrayColor]] ;
            
        }else if (rCardType == JYRedCardTypeOutVouche){
            
            [cell setTitlesColor: [UIColor whiteColor]] ;
            
        }
    }
    
    
    
    cell.rDataModel = self.rDataArray[indexPath.row] ;
    if (rCardType == JYRedCardTypeBoth) {
        
        if (rIsRedGift) {
            
            cell.rUseInfoLabel.textColor = cell.rStatusLabel.textColor= kBlueColor ;
            cell.rTimeLabel.textColor = [UIColor whiteColor] ;
            
        }else{
            
            cell.rUseInfoLabel.textColor = cell.rStatusLabel.textColor=
            cell.rTimeLabel.textColor = kTextBlackColor ;
        }
    }
    
    
    return cell ;
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    JYRedGiftCell *cell = [tableView cellForRowAtIndexPath:indexPath] ;
    cell.selected = YES ;
    
    if (self.rClickNotBack) {
        return ;
    }
    
    
    JYRedBonusModel *model = self.rDataArray[indexPath.row] ;
    
    if ([self.rConditionAmount doubleValue] < [model.conditionAmount doubleValue] ) {
        
        [JYProgressManager showBriefAlert:[NSString stringWithFormat:@"还款额度达到%@元才能使用",model.conditionAmount]] ;
        
        return ;
    }
    
    
    if ([self.rContiueRepayCount integerValue] < [model.conditionRepayPeriod integerValue]) {
        
        [JYProgressManager showBriefAlert:[NSString stringWithFormat:@"连续还款%@期才能使用",model.conditionRepayPeriod]] ;
        
        return ;
    }
    
    
    
    if (self.rSelectBlock) {
        self.rSelectBlock(model) ;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- action


-(void)pvt_showHistoryData {
    
    
    JYRedCardController *control ;
    if (rIsRedGift) {
        control = [[JYRedCardController alloc]initWithType:JYRedCardTypeOutBonus] ;
        control.rDataArray = [self.rOutBonusArray copy] ;
    }else{
        control = [[JYRedCardController alloc]initWithType:JYRedCardTypeOutVouche] ;
        control.rDataArray = [self.rOutVocherArray copy] ;
    }
    
    control.rClickNotBack = YES ;
    
    [self.navigationController pushViewController:control animated:YES];
    
    
}

-(void)pvt_endRefresh{
    
    [self.rTableView.header endRefreshing];
}

-(void)pvt_clickButtonNavRight {
    
    JYWebViewController *webVC = [[JYWebViewController alloc]initWithUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@/boonInstructions",kServiceURL ]]] ;
    [self.navigationController pushViewController:webVC animated:YES];
    
}

#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = kBackGroundColor ;
        //        _rTableView.estimatedRowHeight = 145 ;
        _rTableView.rowHeight = 115 + 15 ;// UITableViewAutomaticDimension;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        
        if (rCardType == JYRedCardTypeBoth) {
            
            _rTableView.tableFooterView = self.rFootButtonView ;
            
        }else{
            
            _rTableView.tableFooterView = [UIView new] ;
            
        }
        _rTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        
        @weakify(self)
        [_rTableView addLegendHeaderWithRefreshingBlock:^{
            @strongify(self)
            [self pvt_loadData] ;
        }] ;
        
        
    }
    return _rTableView ;
}


-(UIButton*)rFootButtonView {
    
    if (_rFootButtonView == nil) {
        _rFootButtonView =  [UIButton buttonWithType:UIButtonTypeCustom] ;
        _rFootButtonView.backgroundColor = [UIColor clearColor] ;
        [_rFootButtonView setTitle:@"查看已使用或过期红包" forState:UIControlStateNormal] ;
        [_rFootButtonView setTitleColor:kTextBlackColor forState:UIControlStateNormal] ;
        _rFootButtonView.titleLabel.font = [UIFont systemFontOfSize:14] ;
        [_rFootButtonView setTitleEdgeInsets:UIEdgeInsetsMake(20, 0, 0, 0)] ;
        _rFootButtonView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80) ;
        @weakify(self)
        [[_rFootButtonView rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            
            [self pvt_showHistoryData] ;
        }] ;
    }
    
    return _rFootButtonView ;
}


- (JYTabBar *)tabBarView {
    if (_tabBarView == nil) {
        JYTabBarItem *unfinishedItem = [[JYTabBarItem alloc] initWithTitle:@"红包"];
        JYTabBarItem *completedItem = [[JYTabBarItem alloc] initWithTitle:@"抵用券"];
        
        _tabBarView = [[JYTabBar alloc] init];
        _tabBarView.items = @[ unfinishedItem, completedItem ];
    }
    return _tabBarView;
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
