//
//  JYAddBankController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/21.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYAddBankController.h"
#import "JYPasswordCell.h"
#import "JYLogInCell.h"
#import "LLPaySdk.h"
#import "JYSupportBankController.h"
#import "JYLLPayMamager.h"
#import "JYHTTPRequestSerializer.h"

@interface JYAddBankController ()<LLPaySdkDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)NSArray *rDataArray ;

@property (nonatomic ,strong) JYLogFootView *rTableFootView ;

@property (nonatomic ,strong) UITableView *rTableView ;


@property (nonatomic ,strong) UITextField *rBankNameField ;
@property (nonatomic ,strong) UITextField *rBankCardField ;

@property (nonatomic ,strong) JYBankModel *rBankModel ;


@end

@implementation JYAddBankController

-(void)viewDidAppear:(BOOL)animated  {
    [super viewDidAppear:animated];
     
    
    [[RACSignal  combineLatest:@[
                                 self.rBankNameField.rac_textSignal,
                                 self.rBankCardField.rac_textSignal,
                                 
                                 ]
                        reduce:^(NSString *bankName,NSString *bankCard) {
                            return @( bankName.length && bankCard.length );
                            
                        }] subscribeNext:^(NSNumber* x) {
                            
                            self.rTableFootView.rCommitBtn.enabled = [x boolValue] ;
                        }];
    
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"添加储蓄卡" ;
    [self initializeTableView];
    
    self.rDataArray = [NSArray arrayWithObjects:
                       @[
                         [[JYPasswordSetModel alloc]initWithTitle:@"姓名" fieldText:@"" placeHolder:@"请填写本人姓名" hasCode:NO]
                         ],
                       @[
                         [[JYPasswordSetModel alloc]initWithTitle:@"开卡行" fieldText:@"" placeHolder:@"请选择开卡银行" hasCode:NO],[[JYPasswordSetModel alloc]initWithTitle:@"卡号" fieldText:@"" placeHolder:@"输入银行卡号" hasCode:NO]
                         ],
                       
                       nil];
    
    
}

-(void)initializeTableView {
    
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }] ;
}




#pragma mark- UITableViewDataSource/UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  2 ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1 ;
    }
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JYPasswordSetModel *model= self.rDataArray[indexPath.section][indexPath.row] ;
    
    if (indexPath.section == 1 && indexPath.row == 0 ) {
        static NSString *identifier = @"identifierArrow" ;
        
        JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYPasswordCell alloc] initWithCellType:JYPassCellTypeArrow reuseIdentifier:identifier];
            self.rBankNameField = cell.rTextField ;
            cell.rRightArrow.enabled = NO ;
        }
        
        [cell setDataModel:model];
        
        return cell ;
    }
    
    static NSString *identifier = @"identifierLogin" ;
    
    JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPasswordCell alloc] initWithCellType:JYPassCellTypeNormal reuseIdentifier:identifier];
        cell.rTextField.keyboardType = UIKeyboardTypeNumberPad ;
    }
    
    
    [cell setDataModel:model];
    
    if (indexPath.section == 0) {
        
        JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
        cell.rTextField.text = user.realName  ;
        cell.rTextField.enabled = NO ;
        
    }else{
        cell.rTextField.enabled = YES ;
        
        self.rBankCardField = cell.rTextField ;
    }
    
    
    
    return cell ;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __block JYPasswordCell *cell = [self.rTableView cellForRowAtIndexPath:indexPath] ;
    
    if (cell.rCellType != JYPassCellTypeArrow) {
        return ;
    }
    @weakify(self)
    JYSupportBankController *vc = [[JYSupportBankController alloc]init];
    vc.rSelectBlock = ^(JYBankModel *model) {
        @strongify(self)
        cell.rTextField.text = model.bankName ;
        self.rBankModel = model ;
    } ;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    static NSString *headerIdentifier = @"headerIdentifier" ;
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
        headerView.contentView.backgroundColor =  kBackGroundColor;
        headerView.backgroundView = ({
            UIView *view = [[UIView alloc]init] ;
            view.backgroundColor = [UIColor clearColor] ;
            view ;
        });
    }
    if (section == 0) {
        headerView.textLabel.text = @"    持卡人信息" ;
    }else{
        headerView.textLabel.text = @"    请填写本人的储蓄卡信息" ;
    }
    return headerView ;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return  0.01 ;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45 ;
}

#pragma mark- action

-(void)pvt_checkBankNum {
    
     
    
     NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
    
    [dic setValue:self.rBankCardField.text forKey:@"cardNO"] ;
    [dic setValue:self.rBankModel.bankNo forKey:@"bankNO"] ;

    [dic setValue:self.rBankModel.bankName forKey:@"bankName"] ;

    

    [[AFHTTPSessionManager jy_sharedManager]POST:kBankCardVertifyURL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
         
        [self pvt_getBankcardbindlist] ;
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;


}

-(void)pvt_getBankcardbindlist {
    
      
    [[AFHTTPSessionManager jy_sharedManager]POST:kBankBinListURL parameters:@{@"cardNo":self.rBankCardField.text} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSArray *agreementList = responseObject[@"data"] ;
        
        if (agreementList.count) {
            
            NSDictionary *dic = [agreementList firstObject];
            
            [self submitPayResult:dic];
            
        }else{
            
            [self pvt_LLPayBank] ;
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;

    
 
}


-(void)pvt_LLPayBank {
    
    
    
    [[LLPaySdk sharedSdk] setSdkDelegate:self] ;
    
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
    
    NSDictionary *resultDic = [JYLLPayMamager jyBankServiceWithUserName:user.realName  userIdNO:user.idcard bankCardNO:self.rBankCardField.text sig:kPay_md5_key] ;
    NSLog(@"resultDic=======%@",resultDic);
    
    [[LLPaySdk sharedSdk] presentLLPaySignInViewController: self withPayType:LLPayTypeInstalments
                                             andTraderInfo:resultDic] ;
    
}


 
#pragma -mark 支付结果 LLPaySdkDelegate
-(void)paymentEnd:(LLPayResult)resultCode withResultDic:(NSDictionary *)dic{
    NSLog(@"绑卡结果==dic======%@",dic);
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
        NSLog(@"msg=======%@",msg);
        
        
        [JYProgressManager showBriefAlert:msg] ;
        
    }
}

//返回充值结果///
- (void)submitPayResult:(NSDictionary *)dic {
    NSLog(@"充值支付结果=%@",dic);
    
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc]init];
    [paraDic setValue:self.rBankModel.bankNo forKey:@"bankNo"] ;
    [paraDic setValue:dic[@"no_agree"] forKey:@"bindId"] ;
    [paraDic setValue:self.rBankModel.bankName forKey:@"bankName"] ;
    [paraDic setValue:self.rBankModel.cardNo forKey:@"cardNo"] ;
    
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kSaveBankCardURL parameters:paraDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [JYProgressManager showBriefAlert:@"添加银行卡成功"] ;
        
        [self.navigationController popToRootViewControllerAnimated:YES] ;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
}




#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.backgroundColor = kBackGroundColor ;
        _rTableView.estimatedRowHeight = 45 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
        
        _rTableView.separatorInset = UIEdgeInsetsZero ;
        _rTableView.tableFooterView = self.rTableFootView ;
        
    }
    return _rTableView ;
}

-(JYLogFootView*)rTableFootView{
    
    if (_rTableFootView == nil) {
        _rTableFootView = [[JYLogFootView alloc]initWithType:JYLogFootViewTypeRegister] ;
        _rTableFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100) ;
        
        @weakify(self)
        [[_rTableFootView.rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            
            
            self.rBankModel.cardNo = self.rBankCardField.text ;
            
            [self pvt_checkBankNum] ;
            
        }] ;
    }
    
    return _rTableFootView ;
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


 
