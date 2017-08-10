//
//  JYBillViewController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/21.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYBillViewController.h"
#import "JYBillCell.h"
#import "JYBillDetailController.h"



@interface JYBillViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong) UITableView *rTableView ;

@property(nonatomic ,strong) UITableView *rAlterTableView ;

@property(nonatomic ,strong) NSMutableArray *rDataArray ;


@property(nonatomic ,strong) NSMutableArray *rBaseDataAray ;
@property(nonatomic ,strong) NSMutableArray *rLoanDataAray ;
@property(nonatomic ,strong) NSMutableArray *rPayBackDataAray ;
@property(nonatomic ,strong) NSMutableArray *rDrawDataAray ;
@property(nonatomic ,strong) NSMutableArray *rChargeDataAray ;
@property(nonatomic ,strong) NSMutableArray *rCommisionDataAray ;



@property(nonatomic ,assign) NSInteger rCurrentPage ;

@property(nonatomic ,assign) NSInteger rBaseCurrentPage ;
@property(nonatomic ,assign) NSInteger rLoanCurrentPage ;
@property(nonatomic ,assign) NSInteger rPayBackCurrentPage ;
@property(nonatomic ,assign) NSInteger rDrawCurrentPage ;
@property(nonatomic ,assign) NSInteger rChargeCurrentPage ;
@property(nonatomic ,assign) NSInteger rCommiCurrentPage ;

@property(nonatomic ,assign) BOOL rBaseHasNext ;
@property(nonatomic ,assign) BOOL rLoanHasNext ;
@property(nonatomic ,assign) BOOL rPayBackHasNext ;
@property(nonatomic ,assign) BOOL rDrawHasNext ;
@property(nonatomic ,assign) BOOL rChargeHasNext ;
@property(nonatomic ,assign) BOOL rCommiHasNext ;


@property(nonatomic ,assign) NSInteger rType ;



@end

@implementation JYBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的账单" ;
    self.rDataArray = [NSMutableArray array] ;
    
    
    self.rBaseDataAray = [NSMutableArray array] ;
    self.rLoanDataAray = [NSMutableArray array] ;
    self.rPayBackDataAray = [NSMutableArray array] ;
    self.rDrawDataAray = [NSMutableArray array] ;
    self.rChargeDataAray = [NSMutableArray array] ;
    self.rCommisionDataAray = [NSMutableArray array] ;
    
    self.rDataArray = self.rBaseDataAray ;
    
    [self initializeTableView];
    
    [self setNavRightButtonWithImage:[UIImage imageNamed:@"nav_select"] title:@""] ;
    
    
    self.rBaseCurrentPage = self.rLoanCurrentPage = self.rPayBackCurrentPage = self.rDrawCurrentPage = self.rChargeCurrentPage = self.rCommiCurrentPage = 1 ;
    
    self.rBaseHasNext = self.rLoanHasNext = self.rPayBackHasNext = self.rDrawHasNext = self.rChargeHasNext = self.rCommiHasNext = NO ;
    
    self.rCurrentPage = 1 ;
    self.rType = 0 ;
    [self pvt_loadData];
}


-(void)pvt_loadData {
    
    @weakify(self)
    [[AFHTTPSessionManager jy_sharedManager]POST:kBillListURL parameters:@{@"pageNumber":@(self.rCurrentPage),@"pageSize":@(15),@"type":@(self.rType)} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @strongify(self)
        NSArray *dataArr = responseObject[@"data"] ;
        
        
        BOOL hasNextPage = [responseObject[@"hasNextPage"] boolValue];
        
        if (hasNextPage) {
            [self pvt_addFootRefresh] ;
        }else{
            [self.rTableView removeFooter];
        }
        
        
        NSInteger pageNum  = [responseObject[@"pageNum"] integerValue] ;
        
        [self pvt_refreshCurrentPage:pageNum next:hasNextPage];
        
        
        if (pageNum == 1) {
            [self.rDataArray removeAllObjects];
        }
        
        
        NSArray *modelArr =[JYBillListModel arrayOfModelsFromDictionaries:dataArr error:nil] ;
        
        [self.rDataArray addObjectsFromArray:modelArr];
        
        [self.rTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
}

-(void)initializeTableView {
    
    
    self.rTableView.emptyDataView = [DZNEmptyDataView emptyDataView];
    self.rTableView.emptyDataView.imageForNoData = [UIImage imageNamed:@"comm_noData"] ;
    self.rTableView.emptyDataView.showButtonForNoData = NO;
    self.rTableView.emptyDataView.requestSuccess = YES;
    
    
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }] ;
    
    
    [self.view addSubview:self.rAlterTableView];
    [self.rAlterTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }] ;
    
}

#pragma mark- action
-(void)pvt_selectIndex:(NSInteger)row section:(NSInteger)section{
    
    [self pvt_endRefresh];
    
    if ( section == 0) {
        
        self.rType = row ;
        
    }else{
        
        self.rType = row  + 3;
        
    }
    
    BOOL hasNext = NO ;
    NSString *title = @"" ;
    switch (self.rType) {
        case 0: {
            hasNext = self.rBaseHasNext ;
            self.rDataArray = self.rBaseDataAray ;
            self.rCurrentPage = self.rBaseCurrentPage ;
            title = @"" ;
        } break;
        case 1: {
            hasNext = self.rLoanHasNext ;
            self.rDataArray = self.rLoanDataAray ;
            self.rCurrentPage = self.rLoanCurrentPage ;
            title = @"借款" ;
        } break;
        case 2: {
            hasNext = self.rPayBackHasNext ;
            self.rDataArray = self.rPayBackDataAray ;
            self.rCurrentPage = self.rPayBackCurrentPage ;
            title = @"还款" ;
        } break;
        case 3: {
            hasNext = self.rDrawHasNext ;
            self.rDataArray = self.rDrawDataAray ;
            self.rCurrentPage = self.rDrawCurrentPage ;
            title = @"提现" ;
        } break;
        case 4: {
            hasNext = self.rChargeHasNext ;
            self.rDataArray = self.rChargeDataAray ;
            self.rCurrentPage = self.rChargeCurrentPage ;
            title = @"充值" ;
        } break;
        case 5: {
            hasNext = self.rCommiHasNext ;
            self.rDataArray = self.rCommisionDataAray ;
            self.rCurrentPage = self.rCommiCurrentPage ;
            title = @"佣金" ;
        } break;
            
        default:
            break;
    }
    
    [self setNavRightButtonWithImage:[UIImage imageNamed:@"nav_select"] title:title] ;

    
    if (hasNext) {
        [self pvt_addFootRefresh];
    }else{
        if (self.rTableView.footer) {
            [self.rTableView removeFooter];
        }
    }
    
    [self.rTableView reloadData];
    
    if (self.rDataArray.count <= 0) {
        
        self.rCurrentPage = 1 ;
        [self pvt_loadData];
    }
    
    
    
    
}

 
-(void)pvt_clickButtonNavRight{
    
    self.rAlterTableView.hidden = !self.rAlterTableView.hidden ;
    
}
-(void)pvt_disMiss {
    self.rAlterTableView.hidden = YES ;
}

-(void)pvt_endRefresh {
    
    [self.rTableView.header endRefreshing];
    [self.rTableView.footer endRefreshing];
    
}
-(void)pvt_refreshCurrentPage:(NSInteger)page next:(BOOL)hasNext {
    
    self.rCurrentPage = page ;
    
    switch (self.rType) {
        case 0: {
            
            self.rBaseCurrentPage = page ;
            self.rBaseHasNext = hasNext ;
        } break;
        case 1: {
            
            self.rLoanCurrentPage = page ;
            self.rLoanHasNext = hasNext ;
        } break;
        case 2: {
            
            self.rPayBackCurrentPage = page ;
            self.rPayBackHasNext = hasNext ;
        } break;
        case 3: {
            
            self.rDrawCurrentPage = page ;
            self.rDrawHasNext = hasNext ;
        } break;
        case 4: {
            
            self.rChargeCurrentPage = page ;
            self.rChargeHasNext = hasNext ;
        } break;
        case 5: {
            
            self.rCommiCurrentPage = page ;
            self.rCommiHasNext = hasNext ;
        } break;
            
        default:
            break;
    }
    
}

-(void)pvt_addRefreshFooter {
    
    if (self.rTableView.footer) {
        return ;
    }
    
    @weakify(self)
    [self.rTableView addLegendFooterWithRefreshingBlock:^{
        @strongify(self)
        switch (self.rType) {
            case 0: {
                
                self.rCurrentPage = self.rBaseCurrentPage+ 1 ;
            } break;
            case 1: {
                
                self.rCurrentPage = self.rLoanCurrentPage+ 1 ;
            } break;
            case 2: {
                
                self.rCurrentPage = self.rPayBackCurrentPage+ 1 ;
            } break;
            case 3: {
                
                self.rCurrentPage = self.rDrawCurrentPage+ 1 ;
            } break;
            case 4: {
                
                self.rCurrentPage = self.rChargeCurrentPage+ 1 ;
            } break;
            case 5: {
                
                self.rCurrentPage = self.rCommiCurrentPage+ 1 ;
            } break;
                
                
            default:
                break;
        }
        [self pvt_loadData];
    }] ;
    
}


#pragma mark- UITableViewDataSource/UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView == self.rAlterTableView) {
        return 2 ;
    }
    return 1 ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.rAlterTableView) {
        return 1 ;
    }
    
    
    return self.rDataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (tableView == self.rAlterTableView) {
        static NSString *identifier = @"identifierLpayBack" ;
        
        JYBillAlterCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYBillAlterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            @weakify(self)
            cell.rBlock = ^(NSInteger index, JYBillAlterCell *curCell) {
                @strongify(self)
                
                self.rAlterTableView.hidden = YES ;
                NSIndexPath *path = [self.rAlterTableView indexPathForCell:curCell] ;
                
                NSLog(@"%zd, ==== %zd",index,path.section) ;
                [self pvt_selectIndex:index section:path.section];
                
            } ;
        }
        
        if (indexPath.section == 0) {
            [cell setTitles:@[@"  全部",@"  借款",@"  还款"] images:@[@"bill_state1",@"bill_state2",@"bill_state3"]] ;
        }else{
            [cell setTitles:@[@"  提现",@"  充值",@"  佣金"] images:@[@"bill_state4",@"bill_state5",@"bill_state6"]] ;
            
        }
        
        
        
        return cell ;
        
    }
    
    static NSString *identifier = @"identifierLogin" ;
    
    JYBillCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYBillCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    JYBillListModel *model = self.rDataArray[indexPath.row] ;
    cell.rDataModel = model ;
    
    return cell ;
    
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    if (tableView == self.rTableView) {
        
        
        static NSString *headerIdentifier = @"headerIdentifier" ;
        
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
        if (headerView == nil) {
            headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
            headerView.backgroundView = ({
                
                UIView *view = [[UIView alloc]init];
                view.backgroundColor = [UIColor clearColor] ;
                view ;
            }) ;
            headerView.contentView.backgroundColor = [UIColor clearColor];
            
            
            
        }
        
        return headerView ;
        
    }
    
    static NSString *headerIdentifier = @"headerIdentifierAlter" ;
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
        headerView.contentView.backgroundColor =  kBackGroundColor;
        
    }
    
    return headerView ;
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (self.rTableView == tableView ) {
        
        JYBillListModel *model = self.rDataArray[indexPath.row] ;
        
        JYBillDetailController *billdetail = [[JYBillDetailController alloc]initWithType:[model.accountType intValue]];
        billdetail.rBillId = model.id ;
        [self.navigationController pushViewController:billdetail animated:YES];
        
    }
}

-(void)pvt_addFootRefresh {
    
    if (!self.rTableView.footer) {
        @weakify(self)
        [self.rTableView addLegendFooterWithRefreshingBlock:^{
            @strongify(self)
            self.rCurrentPage += 1 ;
            [self pvt_loadData];
        }] ;
    }
}

#pragma getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = [UIColor  clearColor] ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        _rTableView.estimatedRowHeight = 45 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension ;
        _rTableView.tableFooterView =  [UIView new] ;
        
        @weakify(self)
        [_rTableView addLegendHeaderWithRefreshingBlock:^{
            @strongify(self)
            self.rCurrentPage = 1 ;
            [self pvt_loadData] ;
        }] ;
        
    }
    return _rTableView ;
}

-(UITableView*)rAlterTableView {
    
    if (_rAlterTableView == nil) {
        
        _rAlterTableView = [[UITableView alloc]init];
        _rAlterTableView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6] ;
        _rAlterTableView.delegate = self ;
        _rAlterTableView.dataSource = self ;
        
        _rAlterTableView.sectionHeaderHeight = 15 ;
        
        _rAlterTableView.separatorInset = UIEdgeInsetsZero ;
        _rAlterTableView.rowHeight = 49 ;
        _rAlterTableView.tableFooterView =  ({
            
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)] ;
            
            view.backgroundColor = kBackGroundColor ;
            view ;
            
            
        }) ;
        _rAlterTableView.hidden = YES ;
        _rAlterTableView.scrollEnabled = NO ;
        [_rAlterTableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pvt_disMiss)]] ;
        
    }
    
    return _rAlterTableView ;
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
