//
//  JYLoanRecordController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/12.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoanRecordController.h"
#import "JYLoanRecordCell.h"
#import "JYMYFinanceHeader.h"
#import "JYLoanDetailController.h"
#import "JYPayRecordController.h"
#import "JYTabBarController.h"
#import "JYLogInViewController.h"


@interface JYLoanRecordController ()<UITableViewDelegate,UITableViewDataSource>{
    
}

@property(nonatomic ,strong) UITableView *rTableView ;

@property(nonatomic ,strong) JYMYFinanceHeader *rTableHeaderView ;

@property (nonatomic ,strong) JYOrderModel *rDataModel ;



@end

@implementation JYLoanRecordController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel;
    if (user) {
        
        [self loadData] ;
        
    }else{
        
        
        [[JYSingtonCenter shareCenter]pvt_autoLoginSuccess:^{
            
            [self loadData] ;
            
        } failure:^{
            
            [self pvt_logIn];
            
        }] ;
        
        
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItems = nil ;
    
    self.navigationItem.title = @"我的贷款" ;
    [self buildSubViewUI];
    
}


-(void)loadData {
    
    JYUserModel * user = [JYSingtonCenter shareCenter].rUserModel ;
    
    if (!user) {
        return ;
    }
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kPayBackURL parameters:nil  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *data = responseObject[@"data"] ;
        
        
        
        self.rDataModel = [[JYOrderModel alloc]initWithDictionary:data error:nil] ;
        
        
        self.rTableHeaderView.rTotalIncomeField.text= [NSString stringWithFormat:@"%.2f",[self.rDataModel.totalRepayment doubleValue]] ;
        
        self.rTableHeaderView.rLeftLabel.text = [NSString stringWithFormat:@"累计借款%zd元",[self.rDataModel.principalSum integerValue]] ;
        
        self.rTableHeaderView.rRightLabel.text = [NSString stringWithFormat:@"成功借出%zd笔",[self.rDataModel.successCnt  integerValue]] ;
        
        
        //        if (self.rDataModel.creditOrder.applyNo.length <= 0 ) {
        //            self.rNoDataView.hidden = NO ;
        //        }else{
        //            self.rNoDataView.hidden = YES ;
        //        }
        
        [self.rTableView reloadData];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
}




#pragma mark - builUI
-(void)buildSubViewUI {
    
    [self setNavRightButtonWithImage:nil title:@"还款记录"] ;
    
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }];
    
    
}

#pragma mark -action

-(void)pvt_logIn {
    
    JYLogInViewController *logVC =[[JYLogInViewController alloc]initWithLogType:JYLogFootViewTypeLogIn];
    UINavigationController *nvc =[[UINavigationController alloc]initWithRootViewController:logVC] ;
    
    [self presentViewController:nvc animated:YES completion:^{
    }] ;
    
}


-(void)pvt_clickButtonNavRight {
    
    JYPayRecordController *recordVC =[[JYPayRecordController alloc]init];
    [self.navigationController pushViewController:recordVC animated:YES] ;
}

#pragma mark- UITableViewDataSource/UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.rDataModel.creditOrder.applyNo.length) {
        return 1 ;
    }
    
    return 0 ;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *identifier = @"identifierLogin" ;
    
    JYLoanRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYLoanRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    cell.rDataModel = self.rDataModel ;
    
    return cell ;
    
    
}



-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    static NSString *headerIdentifier = @"headerIddentifier" ;
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
        headerView.contentView.backgroundColor = [UIColor clearColor];
        
        headerView.backgroundView = ({
            
            UIView *view= [[UIView alloc]init];
            view.backgroundColor = kBackGroundColor;
            view ;
        }) ;
        
        UILabel *labe = [self jyCreateLabelWithTitle:@"近期还款计划" font:14 color:kBlackSecColor align:NSTextAlignmentLeft] ;
        [headerView.contentView addSubview:labe];
        [labe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(headerView.contentView) ;
            make.left.equalTo(headerView.contentView).offset(15) ;
        }] ;
        
    }
    
    
    return headerView ;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BOOL over = [self.rDataModel.recentRepay.overdue integerValue] ;
    
    JYLoanDetailController *recordVC = [[JYLoanDetailController alloc]initWithOver:over ];
    
    JYOrderModel *model = self.rDataModel ;
    
    recordVC.rApplyNo = model.creditOrder.applyNo ;
    
    
    
    [self.navigationController pushViewController:recordVC animated:YES];
}


#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = kBackGroundColor ;
        _rTableView.estimatedRowHeight = 45 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
        _rTableView.tableHeaderView = self.rTableHeaderView ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.sectionHeaderHeight = 45 ;
        _rTableView.tableFooterView = [UIView new] ;
        _rTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        
        DZNEmptyDataView *emptyView = [DZNEmptyDataView emptyDataView];
        emptyView.verticalOffset = 44 ;
        _rTableView.emptyDataView =  emptyView ;
        
        
        _rTableView.emptyDataView.imageForNoData = [UIImage imageNamed:@"loan_noData"] ;
        _rTableView.emptyDataView.showButtonForNoData = YES;
        _rTableView.emptyDataView.requestSuccess = YES;
        
        self.rTableView.emptyDataView.buttonTappedEvent = ^(DZNEmptyDataViewType type){
            switch (type) {
                case DZNEmptyDataViewTypeNoData:
                {
                    
                    JYTabBarController *tab= (JYTabBarController*)[[[UIApplication sharedApplication]keyWindow ]rootViewController] ;
                    
                    [tab setSelectedIndex:0] ;
                    
                }
                    break;
                case DZNEmptyDataViewTypeFailure:
                {
                }
                    break;
                case DZNEmptyDataViewTypeNoNetwork:
                {
                }
                    break;
                default:
                    break;
            }
        };
        
    }
    return _rTableView ;
}

-(JYMYFinanceHeader*)rTableHeaderView {
    
    if (_rTableHeaderView == nil) {
        _rTableHeaderView = [[JYMYFinanceHeader alloc]init];
        _rTableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
        _rTableHeaderView.backgroundColor = kBlueColor ;
        
        
    }
    
    return _rTableHeaderView ;
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











