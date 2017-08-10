//
//  JYLoanDetailController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/12.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoanDetailController.h"
#import "JYLoanDetailHeader.h"
#import "JYPayBackController.h"
#import "JYRecordPayController.h"
#import "JYOrderModel.h"
#import "JYWebViewController.h"





@interface JYLoanDetailController ()<UITableViewDelegate,UITableViewDataSource>{
    
    BOOL rIsOver ;
}

@property(nonatomic ,strong) UITableView *rTableView ;


@property (nonatomic ,strong) JYLoanDetailHeader *rHeaderView ;

@property (nonatomic ,strong) JYLoanDetailModel  *rOrderModel ;


@property (nonatomic ,strong) NSMutableArray *rRepaysArray ;


@property (nonatomic ,strong) NSArray *rThreeTitles ; //应还总额
@property (nonatomic ,strong) NSString *rHaveRepayCount ;//已还期数

@property (nonatomic ,strong) NSString *rCurrentPayMoney ;//本期应还

@property (nonatomic ,strong) NSString *rSumDueAmount ;//滞纳金


@property (nonatomic ,strong) UIView *rFootView ;






@end

@implementation JYLoanDetailController

-(instancetype)initWithOver:(BOOL) isOver{
    
    self = [super init] ;
    if (self) {
        rIsOver = isOver ;
    }
    return self ;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //    self.navigationController.navigationBar.barTintColor = kBlueColor;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage jy_imageWithColor:kBlueColor] forBarMetrics:UIBarMetricsDefault];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated] ;
    
    if (rIsOver) {
        
        //        self.navigationController.navigationBar.barTintColor = kOrangewColor;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage jy_imageWithColor:kOrangewColor] forBarMetrics:UIBarMetricsDefault];
        
    }else{
        //        self.navigationController.navigationBar.barTintColor = kBlueColor;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage jy_imageWithColor:kBlueColor] forBarMetrics:UIBarMetricsDefault];
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"借贷详情" ;
    
    self.rOrderModel = [[JYLoanDetailModel alloc]init];
    
    self.rRepaysArray = [NSMutableArray array] ;
    
    [self buildSubViewUI];
    
    [self pvt_loadData];
    
    
    self.rThreeTitles = @[@"借款期限（月）",@"综合月利（%）",@"最低还款金额（元）"] ;
    
}


-(void)pvt_loadData {
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
    [dic setValue:self.rApplyNo forKey:@"applyNo"] ;
    
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kPayBackDetailURL parameters:dic  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dataDic = responseObject[@"data"] ;
        
        
        [self.rOrderModel mergeFromDictionary:dataDic useKeyMapping:NO  error:nil] ;
        
        self.rHeaderView.rMoneyLabel.text = [NSString stringWithFormat:@"%.2f",[self.rOrderModel.totalRepayment doubleValue] ];
        
        
        NSArray *reaypsArray = dataDic[@"repays"] ;
        
        if (reaypsArray.count) {
            [self.rRepaysArray addObjectsFromArray:[JYRepayModel arrayOfModelsFromDictionaries:reaypsArray error:nil]] ;
        }
        
        
        
        NSString *firstStr = self. rOrderModel.creditOrder.repayPeriod ;
        NSString *secondStr = [NSString stringWithFormat:@"%.2f",[self.rOrderModel.yearInterest floatValue] /12.0 + [self.rOrderModel.manageRate floatValue]*100 ];
        NSString *thirdStr = [NSString stringWithFormat:@"%.2f",[self.rOrderModel.creditOrder.repayPerAmount doubleValue]] ;
        
        UILabel *firsLabel = self.rHeaderView.rTitlesArray[0] ;
        UILabel *secondLabel = self.rHeaderView.rTitlesArray[1] ;
        UILabel *thirdLabel = self.rHeaderView.rTitlesArray[2] ;
        
        
        firsLabel.text = [NSString stringWithFormat:@"%@\n%@",kTitles[0],firstStr] ;
        
        [self jychangeLineSpaceForLabel:firsLabel baseString:kTitles[0] WithSpace:5] ;
        
        secondLabel.text = [NSString stringWithFormat:@"%@\n%@",kTitles[1],secondStr] ;
        [self jychangeLineSpaceForLabel:secondLabel baseString:kTitles[1] WithSpace:5] ;
        
        thirdLabel.text = [NSString stringWithFormat:@"%@\n%@",kTitles[2],thirdStr] ;
        [self jychangeLineSpaceForLabel:thirdLabel baseString:kTitles[2] WithSpace:5] ;
        
        
        self.rThreeTitles = @[firsLabel.text,secondLabel.text,thirdLabel.text] ;
        
        UILabel*label = [self.rFootView viewWithTag:999] ;
        label.text = [NSString stringWithFormat:@"利息总计：%.2f元",[self.rOrderModel.creditOrder.repayInterest doubleValue]] ;
        
        
        [self.rTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
}


#pragma mark- action

-(void)pvt_beginPayBack { //开始还款
    
    JYPayBackController *vc = [[JYPayBackController alloc]init];
    vc.rThreeTitles = self.rThreeTitles ;
    vc.rTotalRepayment = [NSString stringWithFormat:@"%.2f",[self.rOrderModel.totalRepayment doubleValue]] ;
    vc.rNotHaveRepayCount = self.rOrderModel.notHaveRepay ;
    
    vc.rHaveRepayCount = self.rHaveRepayCount ;
    vc.rCurrentPayMoney = self.rCurrentPayMoney;
    vc.rSumDueAmount = self.rSumDueAmount ;
    
    vc.rapplyNo = self.rApplyNo ;
    vc.repayId =  self.rOrderModel.repay.id ;
    
    [self.navigationController pushViewController:vc animated:YES] ;
}

//预约还款
-(void)pvt_recordPayBack {
    
    JYRecordPayController *vc = [[JYRecordPayController alloc]init];
    vc.rThreeTitles = self.rThreeTitles ;
    vc.rTotalRepayment = self.rOrderModel.totalRepayment ;
    vc.rHaveRepayCount = self.rHaveRepayCount ;
    vc.rCurrentPayMoney = self.rOrderModel.creditOrder.repayPerAmount;
    vc.rSumDueAmount = self.rSumDueAmount ;
    
    
    vc.rapplyNo = self.rApplyNo ;
    vc.repayId =  self.rOrderModel.repay.id ;
    [self.navigationController pushViewController:vc animated:YES] ;
}

#pragma mark - builUI
-(void)buildSubViewUI {
    
    
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }];
}

#pragma mark- UITableViewDataSource/UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.rRepaysArray.count + 2 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
        
        static NSString *identifier = @"identifierLoanDeail" ;
        
        JYLoanDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            
            if (rIsOver ) {
                
                cell = [[JYLoanDetailCell alloc]initWithCellType:JYLoanDetailCellTypeOverButton reuseIdentifier:identifier];
            }else{
                cell = [[JYLoanDetailCell alloc]initWithCellType:JYLoanDetailCellTypeButton reuseIdentifier:identifier];
            }
            @weakify(self)
            [[cell.rcommitButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
                @strongify(self)
                
                [self pvt_beginPayBack ] ;
            }] ;
            /*
             [[cell.rOrderButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
             @strongify(self)
             
             [self pvt_recordPayBack] ;
             }] ;
             */
        }
        if (rIsOver) {
            
            
            //            cell.rOverLabel.text
            NSString* overStr  = [NSString stringWithFormat:@"滞纳金（元）%.2f",[self.rOrderModel.repay.overdueAmount doubleValue]] ;
            
            cell.rOverLabel.attributedText = TTThreeFormateString(overStr, 3, 3, 14, 12, 19, kOrangewColor, kBlackColor, kTextBlackColor) ;
            
            self.rCurrentPayMoney  = [NSString stringWithFormat:@"%.2f",[self.rOrderModel.repay.repayAmount doubleValue] + [self.rOrderModel.repay.overdueAmount doubleValue]] ;
            
            NSString*baseeStr  =[NSString stringWithFormat:@"本期应还款（含滞纳金/元）%.2f",[self.rOrderModel.repay.repayAmount doubleValue] + [self.rOrderModel.repay.overdueAmount doubleValue ]] ;
            cell.rMoneyLabel.attributedText = TTThreeFormateString(baseeStr, 5, 8, 14, 12, 19, kBlueColor, kBlackColor, kTextBlackColor) ;
            self.rSumDueAmount = self.rOrderModel.repay.overdueAmount ;
            
        }else{
            
            self.rCurrentPayMoney  = [NSString stringWithFormat:@"%.2f",[self.rOrderModel.repay.repayAmount doubleValue] + [self.rOrderModel.repay.overdueAmount doubleValue]] ;
            
            NSString *baseStr  =[NSString stringWithFormat:@"本期应还款（元）%.2f",[self.rOrderModel.repay.repayAmount doubleValue] ] ;
            
            cell.rMoneyLabel.attributedText = TTThreeFormateString(baseStr, 5, 3, 14, 12, 19, kBlueColor, kBlackColor, kTextBlackColor) ;
            self.rSumDueAmount =  @"";

        }
        
        
        
        self.rHaveRepayCount = [NSString stringWithFormat:@"已还期数%zd/%zd", [self.rOrderModel.haveRepayPeriod integerValue],[self.rOrderModel.creditOrder.repayPeriod integerValue]];
        cell.rTimesLabel.text = self.rHaveRepayCount;
        
        
        return cell ;
        
    }
    
    if (indexPath.row == 1) {
        static NSString *identifier = @"identifierLoanHeaer" ;
        
        JYLoanTimesCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYLoanTimesCell alloc]initWithCellType:JYLoanCllTypeHeader reuseIdentifier:identifier];
            
        }
        
        return cell ;
        
    }
    
    
    static NSString *identifier = @"identifierLoanNormal" ;
    
    JYLoanTimesCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYLoanTimesCell alloc]initWithCellType:JYLoanCllTypeNormal reuseIdentifier:identifier];
        
    }
    
    
    
    cell.rRepyModel =  self.rRepaysArray[indexPath.row - 2] ;
    
    
    
    return cell ;
    
    
}


#pragma mark- getter

-(JYLoanDetailHeader*)rHeaderView {
    
    if (_rHeaderView == nil) {
        _rHeaderView = [[JYLoanDetailHeader alloc]init ];
        _rHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160) ;
        
        if (rIsOver) {
            _rHeaderView.rBgView.backgroundColor = kOrangewColor ;
            _rHeaderView.rSateLabel.text = @"已逾期" ;
            _rHeaderView.rLeftImg.image = [UIImage imageNamed:@"loan_yellow"] ;
        }else{
            _rHeaderView.rBgView.backgroundColor = kBlueColor ;
        }
    }
    
    return _rHeaderView ;
}


#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = [UIColor clearColor] ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.tableFooterView = self.rFootView;
        _rTableView.separatorInset = UIEdgeInsetsZero ;
        _rTableView.estimatedRowHeight = 45 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension ;
        _rTableView.tableHeaderView = self.rHeaderView ;
        
    }
    return _rTableView ;
}


-(UIView*)rFootView {
    
    if (_rFootView == nil) {
        _rFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        
        
        
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:@"查看《借款协议》" attributes:@{NSForegroundColorAttributeName:kBlueColor}]  ;
        [attStr addAttribute:NSForegroundColorAttributeName value:kBlackColor range:NSMakeRange(0, 2)] ;
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [btn setAttributedTitle:attStr  forState:UIControlStateNormal] ;
        [btn setTitleColor:kBlueColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12] ;
        
        @weakify(self)
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            @strongify(self)
            JYWebViewController *webVC = [[JYWebViewController alloc]initWithUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@/borrowAgree",kServiceURL ]]] ;
            [self.navigationController pushViewController:webVC animated:YES];
        }] ;
        
        
        [_rFootView addSubview:btn];
        
        
        UILabel *labe= [self jyCreateLabelWithTitle:@"利息总计：0.00元" font:14 color:kBlackColor align:NSTextAlignmentRight] ;
        labe.tag = 999 ;
        
        [_rFootView addSubview:labe];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_rFootView).offset(15) ;
            make.centerY.equalTo(_rFootView) ;
        }] ;
        
        [labe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_rFootView).offset(-15) ;
            make.centerY.equalTo(_rFootView) ;
        }] ;
        
        
    }
    
    return _rFootView ;
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
