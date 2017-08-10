//
//  JYPayCommtController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/3/31.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPayCommtController.h"
#import "JYSuccessAlterController.h"
#import "JYPasswordView.h"
#import "JYPasswodSettingVC.h"
#import "LLPaySdk.h"
#import "JYLLPayMamager.h"


@interface JYPayCommtController ()<LLPaySdkDelegate>{
    
    
    JYPayCommitType rType ;
}

@property (nonatomic,strong) UIButton *rCommitBtn ;
@property (nonatomic,strong) UIButton *rForgetBtn ;

@property (nonatomic ,strong) JYPasswordView *rPassWordView  ;

@end

@implementation JYPayCommtController

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSAssert(0, @"initWithType初始化") ;
    }
    return self;
}

- (instancetype)initWithType:(JYPayCommitType)type
{
    self = [super init];
    if (self) {
        rType = type ;
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    [self.rPassWordView.textField becomeFirstResponder] ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"确认交易" ;
    
    [self buildSubViewsUI];
    
    [[RACSignal  combineLatest:@[ self.rPassWordView.textField.rac_textSignal
                                  ]
                        reduce:^(NSString *password) {
                            return @( password.length == 6 );
                        }] subscribeNext:^(NSNumber* x) {
                            
                            self.rCommitBtn.enabled = [x boolValue] ;
                        }];
    
}

#pragma mark- action

-(void)pvt_checkTradeWord {
    
    [JYProgressManager  showWaitingWithTitle:@"加载中..." inView:self.view] ;
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kCheckTradePassURL parameters:@{@"tradePassword":self.rPassWordView.textField.text} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self pvt_submitOrder];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
}


-(void)pvt_setLogDicType:(NSNumber*)type content:(NSString*)content dtail:(NSMutableDictionary*)detailDic {
    
    
    
    NSMutableDictionary *logDic = [NSMutableDictionary dictionary] ;
    
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
    
    [logDic setValue:type  forKey:@"type"] ;
    
    [logDic setValue:[NSString stringWithFormat:@"%@|%@|%@",user.realName,self.rOrderNo,content ] forKey:@"content"] ;
    
    
    [logDic setValue:[self getJonsString:detailDic] forKey:@"detail"] ;
    
    [self pvt_SaveLog:logDic] ;
    
    
}

-(NSString*)getJonsString:(NSMutableDictionary*)dic {
    
    
    NSString *risk_itemStr = dic[@"risk_item"] ;
    
    
    if (risk_itemStr.length) {
        
        NSData *jsonData = [risk_itemStr dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *err;
        
        NSDictionary *risk_itemDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                      
                                                                     options:NSJSONReadingMutableContainers
                                      
                                                                       error:&err];
        [dic setValue:risk_itemDic forKey:@"risk_item"] ;
    }
    
    
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic  options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    return jsonString;
    
}


-(void)pvt_submitOrder {
    
    
    if (rType == JYPayCommitTypeDraw) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
        [dic setValue:self.rBankModel.rBankMoney forKey:@"amount"] ;
        [dic setValue:self.rBankModel.cardNo forKey:@"cardNo"] ;
        [dic setValue:self.rBankModel.bankName forKey:@"bankName"] ;
        
        
        
        [[AFHTTPSessionManager jy_sharedManager]POST:kDrawURL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [JYProgressManager showBriefAlert:@"提现申请已提交！"] ;
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kShowTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }] ;
        
        
    }else if (rType == JYPayCommitTypeCharge){
        
        //预充值
        [self predictCharge];
        
        
    }else if (rType == JYPayCommitTypeLoan){
        
        
        [[AFHTTPSessionManager jy_sharedManager]POST:kSubmitLoanURL parameters:self.rLoanDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self pvt_showSuccessVC] ;
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }] ;
        
    }else if (rType == JYPayCommitTypePayBackAcount || rType == JYPayCommitTypePayBackAllAcount){ //账户余额还款
        
        NSString *urlStr = nil ;
        
        if (rType == JYPayCommitTypePayBackAllAcount) {
            
            urlStr = kBalanceAllPayURL ;
            
        }else{
            urlStr = kBalancePayURL ;
            
        }
        
        
        [[AFHTTPSessionManager jy_sharedManager]POST:urlStr parameters:self.rLoanDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self pvt_showSuccessVC] ;
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }] ;
        
    }else if (rType == JYPayCommitTypePayBackBank) { //银行卡单期还款
        
        
        NSDateFormatter* formate = [[JYDateFormatter shareFormatter]jy_getFormatterWithType:JYDateFormatTypHMS] ;
        NSString *timeSpac = [formate stringFromDate:[NSDate date]] ;
        
        self.rOrderNo =  [NSString stringWithFormat:@"%@_%@_%@_%@",self.rLoanDic[@"applyNo"],self.rLoanDic[@"repayId"],self.rLoanDic[@"customerBonusId"]?self.rLoanDic[@"customerBonusId"]:@"0",timeSpac] ;
        
        [self gotoCharge];
        
    }else if (rType == JYPayCommitTypePayAllBackBank){ //银行卡全部还款
        
        NSDateFormatter* formate = [[JYDateFormatter shareFormatter]jy_getFormatterWithType:JYDateFormatTypHMS] ;
        NSString *timeSpac = [formate stringFromDate:[NSDate date]] ;
        
        self.rOrderNo =  [NSString stringWithFormat:@"%@_%@_%@_%@",self.rLoanDic[@"applyNo"],self.rLoanDic[@"repayId"],self.rLoanDic[@"customerBonusId"]?self.rLoanDic[@"customerBonusId"]:@"0",timeSpac] ;
        
        
        [self gotoCharge];
    }
    
}

#pragma mark- 预充值

-(void)predictCharge {
    
    //预充值
    NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
    [dic setValue:self.rBankModel.rBankMoney  forKey:@"amount"] ;
    
    [dic setValue:self.rBankModel.cardNo forKey:@"cardNo"] ;
    
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kChargeURL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.rOrderNo = responseObject[@"orderNo"] ;
        
        [self gotoCharge];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
}

-(void)gotoCharge { //充值
    [JYProgressManager hideAlert] ;
    
    NSString *notifyStr = @"";
    
    NSNumber *logType = nil ;
    NSString *logContent = nil ;
    
    
    if (rType == JYPayCommitTypeCharge) {
        notifyStr = kChargeNotify ;
        
        logType = [NSNumber numberWithInt:3]  ;
        
        logContent =  @"充值";
        
        
    }else if (rType == JYPayCommitTypePayAllBackBank){ //银行卡全部还款
        notifyStr = kPayAllNotify ;
         
        logType = [NSNumber numberWithInt:2]  ;
        
        logContent =  @"银行卡全额还款";
        
        
    }else if(rType == JYPayCommitTypePayBackBank){
        notifyStr = kPayPerNotify ;
        
        logType = [NSNumber numberWithInt:2]  ;
        
        logContent =  @"银行卡单期还款";
        
        
    }
    
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
    
    NSDictionary *resultDic = [JYLLPayMamager  jycreateJiaYuanRechargeOrderWithOrderNO:self.rOrderNo moneyNO:self.rBankModel.rBankMoney userName:user.realName  userIdNO:user.idcard bankCardNO:self.rBankModel.cardNo bankNO:self.rBankModel.bankNo notifyURL:notifyStr];
    
    
    [LLPaySdk sharedSdk].sdkDelegate = self ;
    [[LLPaySdk sharedSdk] presentLLPaySDKInViewController:self withPayType:LLPayTypeVerify andTraderInfo:resultDic];
    
    
    [self pvt_setLogDicType:logType content:logContent dtail:[NSMutableDictionary dictionaryWithDictionary:resultDic]];
    
}




-(void)pvt_showSuccessVC {
    
    [JYProgressManager hideAlert] ;
    
    JYSuccessAlterController *successVC = [[JYSuccessAlterController alloc]init];
    
    if (rType == JYPayCommitTypeLoan) { //借款
        
        successVC.rTitleLabel.text = [NSString stringWithFormat:@"您本次借贷申请%@元，申请成功。\n审核将在2-3个工作日内完成，请随时查看进度中心审核进度",self.rLoanDic[@"principal"]]  ;
        
        [successVC.rCommitBtn setTitle:@"查看审核进度" forState:UIControlStateNormal] ;
        successVC.rControlName = @"JYLoanApplyController" ;
        
    }else{ //还款
        
        successVC.rTitleLabel.text = [NSString stringWithFormat:@"还款成功，实际还款%.2f元",[self.rLoanDic[@"currentRepay"] doubleValue]]  ;
        
        [successVC.rCommitBtn setTitle:@"查看还款账单" forState:UIControlStateNormal] ;
        successVC.rControlName = @"JYBillViewController" ;
        
    }
    
    
    [self jy_showViewController:successVC completion:nil];
    
}

#pragma mark- 返回

-(void)pvt_back {
    
    
    [JYProgressManager showBriefAlert:@"充值成功"] ;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kShowTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    });
    
    
}


#pragma -mark 支付结果 LLPaySdkDelegate
-(void)paymentEnd:(LLPayResult)resultCode withResultDic:(NSDictionary *)dic{
    
    NSLog(@"充值支付结果==dic======%@",dic);
    NSString *msg = @"";
    
    //  NSString *code = @"";
    switch (resultCode) {
        case kLLPayResultSuccess:
        {
            // 返回充值结果
            [self submitPayResult:dic];
        }
            break;
        case kLLPayResultFail:
        {
            msg = @"支付失败";
        }
            break;
        case kLLPayResultCancel:
        {
            msg = @"支付取消";
        }
            break;
        case kLLPayResultInitError:
        {
            msg = @"sdk初始化异常";
        }
            break;
        case kLLPayResultInitParamError:
        {
            NSLog(@"参数错误==%@",dic[@"rnet_msg"]);
            msg = dic[@"ret_msg"];
            
        }
            break;
        default:
            break;
    }
    if (![msg isEqualToString:@""]) {
        
        
        [JYProgressManager showBriefAlert:msg] ;
        
    }
    
    
    
    
}



//返回充值结果/////////////////////////////////////////////////////////////////////////////////////////
- (void)submitPayResult:(NSDictionary *)dic {
    
    
    if (rType == JYPayCommitTypeCharge) {
        [self pvt_back] ;
        
    }else{
        
        [self pvt_showSuccessVC];
    }
    
}


-(void)pvt_SaveLog:(NSMutableDictionary*)dic {
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kSaveLogURL parameters:dic  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"日志上传成功！") ;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
}


#pragma mark 创建UI

-(void)buildSubViewsUI {
    
    
    
    [self.view addSubview:self.rPassWordView] ;
    
    
    
    [self.view addSubview:self.rForgetBtn];
    [self.view addSubview:self.rCommitBtn];
    
    [self.rForgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15) ;
        make.top.equalTo(self.rPassWordView.mas_bottom).offset(10) ;
    }] ;
    
    [self.rCommitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rForgetBtn.mas_bottom).offset(25) ;
        make.left.equalTo(self.view).offset(15) ;
        make.right.equalTo(self.view).offset(-15) ;
        make.height.mas_equalTo(45) ;
    }];
    
}

#pragma mark- getter


-(JYPasswordView*)rPassWordView {
    
    if (_rPassWordView == nil) {
        _rPassWordView = [[JYPasswordView alloc]initWithFrame:CGRectMake(15, 30, SCREEN_WIDTH-30, 45)];
        
    }
    
    return _rPassWordView ;
}


-(UIButton*)rCommitBtn {
    
    if (_rCommitBtn == nil) {
        _rCommitBtn = [self jyCreateButtonWithTitle:@"确认"] ;
        _rCommitBtn.enabled = NO ;
        @weakify(self)
        [[_rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            
            [ self pvt_checkTradeWord] ;
            
        }] ;
    }
    
    return _rCommitBtn ;
}

-(UIButton*)rForgetBtn {
    
    if (_rForgetBtn  == nil) {
        _rForgetBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [_rForgetBtn setTitle:@"找回交易密码?" forState:UIControlStateNormal];
        [_rForgetBtn setTitleColor:kBlueColor forState:UIControlStateNormal];
        _rForgetBtn.titleLabel.font = [UIFont systemFontOfSize:14] ;
        @weakify(self)
        [[_rForgetBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            
            
            JYPasswodSettingVC *pasVC = [[JYPasswodSettingVC alloc]initWithVCType:JYPassVCTypeChangePass]
            ;
            [self.navigationController pushViewController:pasVC animated:YES];
            
        }] ;
    }
    
    return _rForgetBtn ;
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
