//
//  JYPayBackController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/13.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPayBackController.h"
#import "JYLoanDetailHeader.h"
#import "JYLogInCell.h"
#import "JYPayBackCell.h"
#import "JYBankCardController.h"
#import "JYRedCardController.h"
#import "JYPayCommtController.h"


@interface JYPayBackController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong) UITableView *rTableView ;


@property (nonatomic ,strong) JYLoanDetailHeader *rHeaderView ;

@property (nonatomic ,strong) JYLogFootView *rFooterView ;
@property (nonatomic ,strong) JYBankModel *rBankModel ;

@property (nonatomic ,strong) JYRedBonusModel *rRedModel ;

@property (nonatomic ,strong) UITextField *rMoneyTextField ; //输入框

@property (nonatomic ,strong) UILabel *rBankCardLabel ; //余额、借记卡


@property (nonatomic ,assign)  BOOL rIsAllPay ;//全额还款


@property (nonatomic ,strong)  NSString *rContiueRepayPeriod ;//连续还款期数
@property (nonatomic ,strong)  NSString *rPerInterest ;//单期利息
@property (nonatomic ,strong)  NSString *rSurplusInterest ;//剩余未还款的利息




@end

@implementation JYPayBackController

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"借贷详情" ;
    [self buildSubViewUI];
    self.rIsAllPay = NO ;
    
    
    self.rHeaderView.rMoneyLabel.text =  self.rTotalRepayment  ;
    
    
    UILabel *firsLabel = self.rHeaderView.rTitlesArray[0] ;
    UILabel *secondLabel = self.rHeaderView.rTitlesArray[1] ;
    UILabel *thirdLabel = self.rHeaderView.rTitlesArray[2] ;
    
    
    firsLabel.text = self.rThreeTitles[0] ;
    
    [self jychangeLineSpaceForLabel:firsLabel baseString:kTitles[0] WithSpace:5] ;
    
    secondLabel.text = self.rThreeTitles[1] ;
    [self jychangeLineSpaceForLabel:secondLabel baseString:kTitles[0] WithSpace:5] ;
    
    thirdLabel.text = self.rThreeTitles[2] ;
    [self jychangeLineSpaceForLabel:thirdLabel baseString:kTitles[0] WithSpace:5] ;
    
    [self loadContinuRepayCount] ;
}


-(void) loadContinuRepayCount { //连续还款期数
    
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kContinuRepayPeriodURL parameters:@{@"applyNo":self.rapplyNo} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        self.rContiueRepayPeriod = [NSString stringWithFormat:@"%@",responseObject[@"contiueRepayPeriod"]] ;
        self.rPerInterest = [NSString stringWithFormat:@"%@",responseObject[@"perInterest"]] ;
        
        self.rSurplusInterest = [NSString stringWithFormat:@"%@",responseObject[@"surplusInterest"]] ;
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
    
    
}

#pragma mark - builUI
-(void)buildSubViewUI {
    
    
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }];
    
}



#pragma mark- UITableViewDataSource/UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2 ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3  ;
    }
    
    if (self.rSumDueAmount.length) {
       
        return 1 ;
    }
    return 2 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        
        if ( indexPath.row == 0) {
            
            static NSString *identifier = @"identifierLpayBack" ;
            
            JYPayBackCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
            
            if (cell  == nil) {
                
                cell = [[JYPayBackCell alloc]initWithCellType:JYPayBackCellTypeHeader reuseIdentifier:identifier];
                
                cell.rRightLabel.textColor = kBlackColor ;
                
                cell.rTitleLabel.attributedText = TTFormateNumString(@"本期应还款（元）", 14, 12, 3) ;
            }

            
            cell.rMiddleLabel.text = self.rCurrentPayMoney ;
            
            cell.rRightLabel.text = self.rHaveRepayCount ;// @"已还款期数" ;
            
            return cell ;
            
        }
        
        if (indexPath.row == 2) {
            static NSString *identifier = @"identifierLoanHeaer" ;
            
            JYPayBackCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
            
            if (cell  == nil) {
                
                cell = [[JYPayBackCell alloc]initWithCellType:JYPayBackCellTypeTextField reuseIdentifier:identifier];
                cell.rTitleLabel.text  = @"还款金额" ;
                cell.rTextField.enabled = NO ;
                
                cell.rTextField.text = self.rCurrentPayMoney ;
                
                self.rMoneyTextField = cell.rTextField ;
            }
            
            cell.rTextField.text = [self calculateMoney] ;
            
            return cell ;
            
        }
        
        
        static NSString *identifier = @"identifierSwiych" ;
        
        JYPayBackCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            
            cell = [[JYPayBackCell alloc]initWithCellType:JYPayBackCellTypeSwitch reuseIdentifier:identifier];
            
            cell.rTitleLabel.text = @"全部还款" ;
            @weakify(self)
            [[cell.rSwitch rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(UISwitch *x) {
                @strongify(self)
                
                self.rIsAllPay = x.on ;
                
                self.rRedModel = nil ;
                self.rBankModel = nil ;
                self.rFooterView.rCommitBtn.enabled = NO ;

                [self.rTableView reloadData];

            }] ;
        }
        
        return cell ;
        
        
    }
    
    
    static NSString *identifier = @"identifierLoanNormal" ;
    
    JYPayBackCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPayBackCell alloc]initWithCellType:JYPayBackCellTypeNormal reuseIdentifier:identifier];
    }
    
    if (indexPath.row == 0) {
        cell.rTitleLabel.text = @"支付方式" ;
        
        if (self.rBankModel) {
            cell.rRightLabel.text =self.rBankModel.bankName ;

        }else{
        
        cell.rRightLabel.text = @"选择余额/借记卡" ;
        }
        
        self.rBankCardLabel = cell.rRightLabel ;
    }else{
        
        cell.rTitleLabel.text = @"选择优惠券" ;
        
        if (self.rRedModel ) {
            
            if (self.rRedModel.amount.length) {
                cell.rRightLabel.text =  [NSString stringWithFormat:@"%@元", self.rRedModel.amount] ;
                
            }else if(self.rRedModel.rate.length) {
                cell.rRightLabel.text = [NSString stringWithFormat:@"%@%%", self.rRedModel.rate] ;
                
            }

        }
        cell.rRightLabel.text = @"选择红包/优惠券" ;
        
    }
    
    return cell ;
    
    
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger) section {
    
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __block JYPayBackCell *cell = [self.rTableView cellForRowAtIndexPath:indexPath] ;
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
            
            JYBankCardController *vc =[[JYBankCardController alloc]initWithType:JYBankCardVCTypPay];
            @weakify(self)
            vc.rBankBlock = ^(JYBankModel *bankModel) {
                @strongify(self)
                
                cell.rRightLabel.text = bankModel.bankName ;
                
                self.rBankModel = bankModel ;
                
                self.rFooterView.rCommitBtn.enabled = YES ;
            } ;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            JYRedCardController *cardVC = [[JYRedCardController alloc]initWithType:JYRedCardTypeBoth];
            
            if (self.rIsAllPay) {
                
                if ([self.rNotHaveRepayCount integerValue] > 1 ) { //剩余还款次数大于1 才能算全额还款
                    cardVC.rIsAllPay = self.rIsAllPay ;
                    
                }else{
                    
                    cardVC.rIsAllPay = NO ;
                }
            }else{
                cardVC.rIsAllPay = self.rIsAllPay ;
                
            }
            
            
            
            cardVC.rConditionAmount = self.rMoneyTextField.text ;
            cardVC.rContiueRepayCount = self.rContiueRepayPeriod ;
            cardVC.rSelectBlock = ^(JYRedBonusModel *model) {
                
                self.rRedModel = model ;
                
                if (model.amount.length) {
                    cell.rRightLabel.text =  [NSString stringWithFormat:@"%@元", model.amount] ;
                    
                }else if(model.rate.length) {
                    cell.rRightLabel.text = [NSString stringWithFormat:@"%@%%", model.rate] ;
                    
                }
                
                self.rMoneyTextField.text = [self calculateMoney] ;
                
            } ;
            [self.navigationController pushViewController:cardVC animated:YES];
            
            
        }
    }
}
#pragma mark- 计算还款金额

-(NSString*)calculateMoney {
    
    NSString *rMoneyStr = self.rCurrentPayMoney ;
    
    if (self.rIsAllPay) {
        
        rMoneyStr = self.rTotalRepayment ;
    }
    
    if ([self.rRedModel.givenType isEqualToString:@"2"]) { //抵用券
        
        if (self.rIsAllPay && [self.rRedModel.couponsStatus isEqualToString:@"2"]) { //全额 ，，，选的是全额还款优惠券
            
            CGFloat interestAll = 0.0 ;
            
            
            if (self.rRedModel.amount.length) {
                
                interestAll =  [self.rSurplusInterest doubleValue] - [self.rRedModel.amount doubleValue] ;
                
                interestAll = MAX(interestAll, 0.0) ;
            }else if(self.rRedModel.rate.length) {
                
                interestAll =  [self.rSurplusInterest doubleValue] * (1 - [self.rRedModel.rate doubleValue]/100.0) ;
                interestAll = MAX(interestAll, 0.0) ;
                
            }
            
            
            rMoneyStr = [NSString stringWithFormat:@"%.2f",[rMoneyStr doubleValue] - [self.rSurplusInterest doubleValue] +interestAll ] ;
            
            
        }else{ //全额-单期优惠券 ，单期-单期优惠券
            
            CGFloat interestPer = 0.0 ;
            
            if (self.rRedModel.amount.length) {
                
                interestPer =  [self.rPerInterest doubleValue] - [self.rRedModel.amount doubleValue] ;
                
                interestPer = MAX(interestPer, 0.0) ;
            }else if(self.rRedModel.rate.length) {
                
                interestPer =  [self.rPerInterest doubleValue] * (1 - [self.rRedModel.rate doubleValue]/100.0) ;
                interestPer = MAX(interestPer, 0.0) ;
                
            }
            
            
            rMoneyStr = [NSString stringWithFormat:@"%.2f",[rMoneyStr doubleValue] - [self.rPerInterest doubleValue] +interestPer ] ;
        }
        
        
    }else{ //红包
        
        rMoneyStr =[ NSString stringWithFormat:@"%.2f",[rMoneyStr doubleValue] - [self.rRedModel.amount doubleValue]] ;
        
    }
    
    
    
    return rMoneyStr ;
    
}




#pragma mark- action

-(void)pvt_startPayBack {
    
    NSLog(@"开始还款") ;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
    
    [dic setValue:self.rMoneyTextField.text forKey:@"currentRepay" ] ;
    
    [dic setValue:self.rapplyNo forKey:@"applyNo" ] ;
    [dic setValue:self.repayId forKey:@"repayId" ] ;
    [dic setValue:self.rBankModel.id forKey:@"customerBankId" ] ;
    [dic setValue:self.rRedModel.id forKey:@"customerBonusId" ] ;
    
    
    if ([self.rBankModel.bankName isEqualToString:@"账户余额"]) { //余额还款
        
        
        JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
        
        if ([user.fundInfo.usableAmount doubleValue] < [self.rMoneyTextField.text doubleValue] ) {
            [JYProgressManager showBriefAlert:@"账户余额不足，请选择其他支付方式"] ;
            
            return ;
        }
        
        
        
        JYPayCommtController *payVC  ;
        
        if (self.rIsAllPay) {
            
            payVC = [[JYPayCommtController alloc]initWithType:JYPayCommitTypePayBackAllAcount] ;
            
        }else{
            
            payVC = [[JYPayCommtController alloc]initWithType:JYPayCommitTypePayBackAcount] ;
            
        }
        
        payVC.rLoanDic = dic ;
        
        [self.navigationController pushViewController:payVC animated:YES];
        
        
    }else{
        
        
        if (self.rIsAllPay) {
            
            
            [self gotoAllPay:dic];
            
            
            
        }else{
            
            [self gotoPerPay:dic] ;
            
  
         }
    }
    
}

-(void)gotoPerPay:(NSMutableDictionary*)dic {

    [[AFHTTPSessionManager jy_sharedManager]POST:kCheckPerDtaURL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        JYPayCommtController *payCommitVC = [[JYPayCommtController alloc]initWithType:JYPayCommitTypePayBackBank] ;
        
        self.rBankModel.rBankMoney = [NSString stringWithFormat:@"%.2f",[self.rMoneyTextField.text doubleValue]] ;
        
        payCommitVC.rBankModel = self.rBankModel ;
        
        payCommitVC.rLoanDic = dic ;
        
        
        [self.navigationController pushViewController:payCommitVC animated:YES];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;

}


-(void)gotoAllPay:(NSMutableDictionary*)dic {
    
    
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kCheckFullData parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        JYPayCommtController *payCommitVC = [[JYPayCommtController alloc]initWithType:JYPayCommitTypePayAllBackBank] ;
        
        self.rBankModel.rBankMoney = [NSString stringWithFormat:@"%.2f",[self.rMoneyTextField.text doubleValue]] ;
        
        payCommitVC.rBankModel = self.rBankModel ;
        
        payCommitVC.rLoanDic = dic ;

        
        [self.navigationController pushViewController:payCommitVC animated:YES];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
    
}

#pragma mark- getter

-(JYLoanDetailHeader*)rHeaderView {
    
    if (_rHeaderView == nil) {
        _rHeaderView = [[JYLoanDetailHeader alloc]init ];
        _rHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160) ;
        
    }
    
    return _rHeaderView ;
}



-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = [UIColor clearColor] ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.sectionFooterHeight = 15 ;
        _rTableView.tableFooterView = self.rFooterView ;
        _rTableView.separatorInset = UIEdgeInsetsZero ;
        _rTableView.estimatedRowHeight = 45 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension ;
        _rTableView.tableHeaderView = self.rHeaderView ;
        
        
    }
    return _rTableView ;
}


-(JYLogFootView*)rFooterView {
    if (_rFooterView == nil) {
        _rFooterView =[[JYLogFootView alloc]initWithType:JYLogFootViewTypeRegister];
        [_rFooterView.rCommitBtn setTitle:@"开始还款" forState:UIControlStateNormal];
        _rFooterView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80) ;
        _rFooterView.rCommitBtn.enabled = NO ;
        @weakify(self)
        [[_rFooterView.rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            
            [self pvt_startPayBack] ;
            
        }] ;
    }
    
    return _rFooterView ;
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
