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


@interface JYPayCommtController ()<LLPaySdkDelegate>{

    JYPasswordView *_rPassWordView ;
}

@property (nonatomic,strong) UIButton *rCommitBtn ;
@property (nonatomic,strong) UIButton *rForgetBtn ;


@end

@implementation JYPayCommtController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"确认交易" ;
    
    [self buildSubViewsUI];
}

#pragma mark- action

-(void)pvt_submitOrder {
    
    
    
    [LLPaySdk sharedSdk].sdkDelegate = self ;
    [[LLPaySdk sharedSdk] presentLLPaySDKInViewController:self withPayType:LLPayTypeVerify andTraderInfo:nil];
    
    
    JYPasswodSettingVC *pasVC = [[JYPasswodSettingVC alloc]initWithVCType:JYPassVCTypeChangePass]
    ;
    [self.navigationController pushViewController:pasVC animated:YES];
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
            //[self submitPayResult:dic];
            
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
    NSLog(@"充值支付结果=%@",dic);
   /*
    IndividualInfoManage *user = [IndividualInfoManage currentAccount];
    //提交订单
    JiaYuanOrderCommitModel *order_model = [[JiaYuanOrderCommitModel alloc] init];
    order_model.principal = self.rechargeMoney;//交易金额
    NSLog(@"order_model.principal====%@",order_model.principal);
    order_model.orderTime = [DateHelper conversionLinkedTimewith:self.orderNumber];  //订单时间
    order_model.payType = @"2"; //{1=(web支付);2=(ios支付)；3=(Android支付)} //支付类型
    order_model.payResult = @"0";
    order_model.resultDescription = @"支付成功";
    
    NSString *customerId = user.idStr;
    NSString *orderNO = self.orderNumber; //订单号
    NSString *orderTime = order_model.orderTime;
    NSString *payType = order_model.payType;
    NSString *bankNO = self.bankNO; //银行编号
    NSString *idcard = self.idcardStr;
    NSString *name = self.nameStr; //姓名
    NSString *principal = order_model.principal;
    NSString *cardNO = self.cardNO;//银行账号
    NSString *payResult = order_model.payResult;
    NSString *resultDescription = order_model.resultDescription;
    
    NSLog(@"返回充值结果//==%@", cardNO);
    NSLog(@"bankNO==%@", bankNO);
    NSLog(@"principal==%@", principal);
    NSLog(@"nameStr==%@", name);
    NSLog(@"idcardStr==%@", idcard);
    NSLog(@"orderNumber==%@", orderNO);
    NSLog(@"orderTime==%@", orderTime);
    NSLog(@"payType==%@", payType);
    NSLog(@"customerId==%@", customerId);
    
    
    
    
    NSDictionary *signDic = NSDictionaryOfVariableBindings(customerId,orderNO,orderTime,payType,bankNO,idcard,name,principal,cardNO,payResult,resultDescription);
    NSString *sign = [SignHelper partnerSignOrder:signDic sig:_decodString];
    
    
    
    [[DataRequest sharedClient]achieveReturnResultCustomerId:customerId name:name idcard:idcard bankNO:bankNO orderNO:orderNO cardNO:cardNO principal:principal orderTime:orderTime payType:payType payResult:payResult resultDescription:resultDescription sign:sign callback:^(id obj) {
        
        //正常结果
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic=obj;
            if ([dic[@"code"] integerValue] == 0) {
                [SVProgressHUD showErrorWithStatus:@"充值成功!"];
                
                // 更新一下  用户最新信息
                [self achieveCurrentUserInfo:user];
            }
            
            
        }
        //需要授权
        if ([obj isKindOfClass:[WithoutAuthorization class]]) {
            [RequestOAth authenticationWithclient_id:user.idStr response_type:@"code" callback:^(BOOL succeedState) {
                if (succeedState) {
                    [self submitPayResult:dic];
                }
                //请求错误
                if (!succeedState) {
                    [SVProgressHUD showErrorWithStatus:@"授权失败,请重新登录!"];
                    [UserInfoUpdate clearUserLocalInfo];
                    LoginViewController *loginView = [[LoginViewController alloc] init];
                    [self.navigationController pushViewController:loginView animated:YES];
                }
            }];
        }
        if ([obj isKindOfClass:[NSError class]]) {
            [SVProgressHUD showErrorWithStatus:@"订单号请求出错！"];
        }
    }];
    
    */
}




#pragma mark 创建UI

-(void)buildSubViewsUI {
    
    
    _rPassWordView = [[JYPasswordView alloc]initWithFrame:CGRectMake(15, 30, SCREEN_WIDTH-30, 45)];
    [self.view addSubview:_rPassWordView] ;
    
    
    
    [self.view addSubview:self.rForgetBtn];
    [self.view addSubview:self.rCommitBtn];
    
    [self.rForgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15) ;
        make.top.equalTo(_rPassWordView.mas_bottom).offset(10) ;
    }] ;
    
    [self.rCommitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rForgetBtn.mas_bottom).offset(25) ;
        make.left.equalTo(self.view).offset(15) ;
        make.right.equalTo(self.view).offset(-15) ;
        make.height.mas_equalTo(45) ;
    }];
    
}

#pragma mark- getter



-(UIButton*)rCommitBtn {
    
    if (_rCommitBtn == nil) {
        _rCommitBtn = [self jyCreateButtonWithTitle:@"确认"] ;
        
        @weakify(self)
        [[_rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            JYSuccessAlterController *alterVC =[[ JYSuccessAlterController alloc]init];
            [self.navigationController jy_showViewController:alterVC completion:nil];
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
            
                      [ self pvt_submitOrder] ;
            
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
