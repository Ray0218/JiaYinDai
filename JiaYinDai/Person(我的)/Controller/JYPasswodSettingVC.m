//
//  JYPasswodSettingVC.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/7.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPasswodSettingVC.h"
#import "JYLogInCell.h"
#import "JYPasswordCell.h"
#import "JYLogInViewController.h"
#import "JYTabBarController.h"


@interface JYPasswodSettingVC ()<UITableViewDataSource,UITableViewDelegate>{
    
    JYPassVCType rVCType ;
    
    NSArray *rTitleArray ;
}

@property (nonatomic ,strong) UITableView *rTableView ;


@property (nonatomic,strong) JYLogFootView *rTableFootView ;

@property(nonatomic ,strong) UITextField *rFirstTextField ;
@property(nonatomic ,strong) UITextField *rSecondTextField ;

@property(nonatomic ,strong) UITextField *rThirdTextField ;

@property(nonatomic ,strong) UITextField *rCodeTextField ;


@property (nonatomic ,strong) JYPasswordCell *rCodelCell ;

@end

@implementation JYPasswodSettingVC

- (instancetype)initWithVCType:(JYPassVCType)type
{
    self = [super init];
    if (self) {
        rVCType = type ;
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated  {
    [super viewDidAppear:animated];
    
    
    
    if (rVCType == JYPassVCTypeChangeLogPass) {
        
        
        self.rFirstTextField.keyboardType = self.rSecondTextField.keyboardType = self.rThirdTextField.keyboardType = UIKeyboardTypeAlphabet ;
        
        self.rFirstTextField.secureTextEntry = self.rSecondTextField.secureTextEntry = self.rThirdTextField.secureTextEntry = YES ;
        
        [[self.rFirstTextField.rac_textSignal filter:^BOOL(NSString* value) { //密码6 ~ 16
            
            return value.length > 16 ;
            
        }]subscribeNext:^(NSString* x) {
            
            self.rFirstTextField.text = [x substringToIndex:16] ;
            
        }] ;
        
        [[self.rSecondTextField.rac_textSignal filter:^BOOL(NSString* value) { //密码6 ~ 16
            
            return value.length > 16 ;
            
        }]subscribeNext:^(NSString* x) {
            
            self.rSecondTextField.text = [x substringToIndex:16] ;
            
        }] ;
        
        [[self.rThirdTextField.rac_textSignal filter:^BOOL(NSString* value) { //密码6 ~ 16
            
            return value.length > 16 ;
            
        }]subscribeNext:^(NSString* x) {
            
            self.rThirdTextField.text = [x substringToIndex:16] ;
            
        }] ;
        
        [[RACSignal  combineLatest:@[
                                     self.rFirstTextField.rac_textSignal,
                                     self.rSecondTextField.rac_textSignal,
                                     self.rThirdTextField.rac_textSignal,
                                     
                                     ]
                            reduce:^(NSString *oldPassString,NSString *newPassword,NSString *sureString) {
                                return @(oldPassString .length && newPassword.length >=6 && sureString.length>=6 );
                            }] subscribeNext:^(NSNumber* x) {
                                
                                self.rTableFootView.rCommitBtn.enabled = [x boolValue] ;
                            }];
        
        
    }else if (rVCType == JYPassVCTypeChangePass){
        
        self.rSecondTextField.keyboardType = UIKeyboardTypeAlphabet ;
        
        self.rFirstTextField.rMaxLength = 8 ;
        
        [[self.rFirstTextField rac_signalForControlEvents:UIControlEventEditingChanged]subscribeNext:^(UITextField *x) {
            
            [self.rFirstTextField jy_nametextViewEditChanged] ;
        }] ;
        
        [[self.rSecondTextField.rac_textSignal filter:^BOOL(NSString* value) {
            
            return value.length > 18 ;
            
        }]subscribeNext:^(NSString* x) {
            
            self.rSecondTextField.text = [x substringToIndex:18] ;
            
        }] ;
        
        [[RACSignal  combineLatest:@[
                                     self.rFirstTextField.rac_textSignal,
                                     self.rSecondTextField.rac_textSignal,
                                     self.rThirdTextField.rac_textSignal,
                                     self.rCodeTextField.rac_textSignal,
                                     
                                     ]
                            reduce:^(NSString *nameString,NSString *userCardString,NSString *telString,NSString *codeString) {
                                return @(nameString .length && userCardString.length && telString.length && codeString.length );
                            }] subscribeNext:^(NSNumber* x) {
                                
                                self.rTableFootView.rCommitBtn.enabled = [x boolValue] ;
                            }];
        
        
        
        
    }else if (rVCType == JYPassVCTypeSetPass){
        
        self.rFirstTextField.keyboardType = self.rSecondTextField.keyboardType = UIKeyboardTypeNumberPad ;
        
        
        [[ self.rFirstTextField.rac_textSignal filter:^BOOL(NSString* value) {
            return value.length > 6 ;
        }]subscribeNext:^(NSString* x) {
            self.rFirstTextField.text = [x substringToIndex:6] ;
        }] ;
        
        [[ self.rSecondTextField.rac_textSignal filter:^BOOL(NSString* value) {
            return value.length > 6 ;
        }]subscribeNext:^(NSString* x) {
            self.rSecondTextField.text = [x substringToIndex:6] ;
        }] ;
        
        
        [[RACSignal  combineLatest:@[
                                     self.rFirstTextField.rac_textSignal,
                                     self.rSecondTextField.rac_textSignal,
                                     
                                     ]
                            reduce:^(NSString *newPassword,NSString *sureString) {
                                return @(newPassword.length == 6 && sureString.length== 6  );
                            }] subscribeNext:^(NSNumber* x) {
                                
                                self.rTableFootView.rCommitBtn.enabled = [x boolValue] ;
                            }];
        
        
    }else if(rVCType == JYPassVCTypeChangeTelNum) {
        
        self.rSecondTextField.keyboardType = UIKeyboardTypeAlphabet ;
        self.rFirstTextField.rMaxLength = 6 ;
        
        [[self.rFirstTextField rac_signalForControlEvents:UIControlEventEditingChanged]subscribeNext:^(UITextField *x) {
            
            [self.rFirstTextField jy_nametextViewEditChanged] ;
        }] ;
        
        [[RACSignal  combineLatest:@[
                                     self.rFirstTextField.rac_textSignal,
                                     self.rSecondTextField.rac_textSignal,
                                     self.rThirdTextField.rac_textSignal,
                                     self.rCodeTextField.rac_textSignal,
                                     
                                     ]
                            reduce:^(NSString *nameString,NSString *userCardString,NSString *telString,NSString *codeString) {
                                return @(nameString .length && userCardString.length && telString.length == 11 && codeString.length );
                            }] subscribeNext:^(NSNumber* x) {
                                
                                self.rTableFootView.rCommitBtn.enabled = [x boolValue] ;
                            }];
        
        [[self.rSecondTextField.rac_textSignal filter:^BOOL(NSString* value) {
            
            return value.length > 18 ;
            
        }]subscribeNext:^(NSString* x) {
            
            self.rSecondTextField.text = [x substringToIndex:18] ;
            
        }] ;
        
        
        
        
    }else if (rVCType == JYPassVCTypeSureChangeTelNum ){
        
        self.rFirstTextField.keyboardType = UIKeyboardTypeNumberPad ;
        
        [[self.rFirstTextField.rac_textSignal filter:^BOOL(NSString* value) {
            
            return value.length > 11 ;
            
        }]subscribeNext:^(NSString* x) {
            
            self.rFirstTextField.text = [x substringToIndex:11] ;
            
        }] ;
        
        [[RACSignal  combineLatest:@[
                                     self.rFirstTextField.rac_textSignal,
                                     
                                     ]
                            reduce:^(NSString *telNumStr ) {
                                return @(telNumStr.length == 11 );
                            }] subscribeNext:^(NSNumber* x) {
                                
                                self.rTableFootView.rCommitBtn.enabled = [x boolValue] ;
                            }];
        
    }
    
    
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeTableView] ;
    
    
    switch (rVCType) {
        case JYPassVCTypeSetPass:{
            self.title = @"设置交易密码" ;
            [self.rTableFootView.rCommitBtn setTitle:@"确认" forState:UIControlStateNormal];
            
            rTitleArray = [NSArray arrayWithObjects:@[ [[JYPasswordSetModel alloc]initWithTitle:@"交易密码" fieldText:@"" placeHolder:@"设置6位数字交易密码" hasCode:NO] , [[JYPasswordSetModel alloc]initWithTitle:@"确认交易密码" fieldText:@"" placeHolder:@"确认交易密码" hasCode:NO]  ], nil] ;
        } break;
        case JYPassVCTypeChangePass:{
            self.title = @"修改交易密码" ;
            [self.rTableFootView.rCommitBtn setTitle:@"下一步" forState:UIControlStateNormal];
            
            rTitleArray = [NSArray arrayWithObjects:@[ [[JYPasswordSetModel alloc]initWithTitle:@"姓名" fieldText:@"" placeHolder:@"输入本人姓名" hasCode:NO] , [[JYPasswordSetModel alloc]initWithTitle:@"身份证" fieldText:@"" placeHolder:@"输入本人身份证号" hasCode:NO]  ],@[ [[JYPasswordSetModel alloc]initWithTitle:@"手机号" fieldText:@"" placeHolder:@"138****0978" hasCode:NO] , [[JYPasswordSetModel alloc]initWithTitle:@"验证码" fieldText:@"" placeHolder:@"请输入验证码" hasCode:YES]  ], nil] ;
        }break ;
        case JYPassVCTypeChangeLogPass:{
            self.title = @"修改登录密码" ;
            [self.rTableFootView.rCommitBtn setTitle:@"完成" forState:UIControlStateNormal];
            
            rTitleArray = [NSArray arrayWithObjects:@[ [[JYPasswordSetModel alloc]initWithTitle:@"原密码" fieldText:@"" placeHolder:@"请输入原密码" hasCode:NO] , [[JYPasswordSetModel alloc]initWithTitle:@"新密码" fieldText:@"" placeHolder:@"请设置6-16位英文或数字及组合密码" hasCode:NO],[[JYPasswordSetModel alloc]initWithTitle:@"确认密码" fieldText:@"" placeHolder:@"确认新密码" hasCode:NO]  ], nil] ;
            
        }break ;
        case JYPassVCTypeSureChangeTelNum:{
            self.title = @"更换手机" ;
            [self.rTableFootView.rCommitBtn setTitle:@"确认提交" forState:UIControlStateNormal];
            
            rTitleArray = [NSArray arrayWithObjects:@[ [[JYPasswordSetModel alloc]initWithTitle:@"手机号码" fieldText:@"" placeHolder:@"请输入新手机号" hasCode:NO] ], nil] ;
            
            
            
        }break ;
            
        case JYPassVCTypeChangeTelNum:{
            self.title = @"更换手机" ;
            [self.rTableFootView.rCommitBtn setTitle:@"下一步" forState:UIControlStateNormal];
            rTitleArray = [NSArray arrayWithObjects:@[ [[JYPasswordSetModel alloc]initWithTitle:@"姓名" fieldText:@"" placeHolder:@"输入本人姓名" hasCode:NO] , [[JYPasswordSetModel alloc]initWithTitle:@"身份证" fieldText:@"" placeHolder:@"输入本人身份证号" hasCode:NO]  ],@[ [[JYPasswordSetModel alloc]initWithTitle:@"手机号码" fieldText:@"" placeHolder:@"请输入新手机号" hasCode:NO] , [[JYPasswordSetModel alloc]initWithTitle:@"验证码" fieldText:@"" placeHolder:@"请输入验证码" hasCode:YES]  ], nil] ;
            
            
        }break ;
            
        default:
            break;
    }
    
}

-(void)initializeTableView {
    
    
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }] ;
}

#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _rTableView.backgroundColor = kBackGroundColor ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        
        _rTableView.estimatedRowHeight = 45 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
        
        _rTableView.separatorInset = UIEdgeInsetsZero ;
        _rTableView.tableFooterView = self.rTableFootView ;
    }
    return _rTableView ;
}


#pragma mark- action

-(void)pvt_changeTelNum { //更换手机
    
    
    
    if (![self.rSecondTextField.text jy_stringCheckIDCard]) {
        [JYProgressManager showBriefAlert:@"身份证格式有误" ];
        return ;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
    
    
    [dic setValue:self.rFirstTextField.text forKey:@"realName"] ;
    [dic setValue:self.rSecondTextField.text forKey:@"idcard"] ; //身份证
    [dic setValue:self.rThirdTextField.text forKey:@"cellphone"] ;
    [dic setValue:self.rCodeTextField.text forKey:@"smsCaptcha"] ;
    
    [dic setValue:@"trade" forKey:@"type"] ; //验证码类型
    
    
    @weakify(self)
    [[AFHTTPSessionManager jy_sharedManager]POST:kCheckSmsURL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @strongify(self)
        JYPasswodSettingVC *vc = [[JYPasswodSettingVC alloc]initWithVCType:JYPassVCTypeSureChangeTelNum];
        [self.navigationController pushViewController:vc animated:YES];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
    
    
}
#pragma mark- 更换手机号提交

-(void)changeTelPhoneCommit {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
    [dic setValue:self.rFirstTextField.text forKey:@"cellphone"] ;
    
    
    @weakify(self)
    [[AFHTTPSessionManager jy_sharedManager]POST:kModifyCellPhoneURL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        @strongify(self)
        [JYProgressManager showBriefAlert:@"更换手机号成功"] ;
        
        [self pvt_backToSetController] ;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
    
}

-(void) pvt_changeTelNumSure { //确认更换手机
    
    
    NSString *telNum = self.rFirstTextField.text ;
    
    
    if (![telNum jy_stringCheckMobile]) {
        
        [JYProgressManager showBriefAlert:@"手机号码有误!"] ;
        
        return ;
    }
    
    
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kCellPhoneExistURL parameters:@{@"cellphone":self.rFirstTextField.text} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self changeTelPhoneCommit];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
    
}

-(void)pvt_changePassword { //交易密码修改
    
    
    
    if (![self.rSecondTextField.text jy_stringCheckIDCard]) {
        [JYProgressManager showBriefAlert:@"身份证格式有误" ];
        return ;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
    
    
    [dic setValue:self.rFirstTextField.text forKey:@"realName"] ;
    [dic setValue:self.rSecondTextField.text forKey:@"idcard"] ; //身份证
    [dic setValue:self.rThirdTextField.text forKey:@"cellphone"] ;
    [dic setValue:self.rCodeTextField.text forKey:@"smsCaptcha"] ;
    
    [dic setValue:@"trade" forKey:@"type"] ; //验证码类型
    
    
    
    @weakify(self)
    [[AFHTTPSessionManager jy_sharedManager]POST:kCheckSmsURL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @strongify(self)
        JYPasswodSettingVC *changeVC = [[JYPasswodSettingVC alloc]initWithVCType:JYPassVCTypeSetPass] ;
        [self.navigationController pushViewController:changeVC animated:YES];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
    
    
    
}

-(void)pvt_setPassword {
    
    
    if (![self.rFirstTextField.text isEqualToString:self.rSecondTextField.text]) {
        
        [JYProgressManager showBriefAlert:@"新密码输入不一致！请重新输入。"];
        
        return ;
    }
    
    
    
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kTradePasswordURL parameters:@{@"cellphone":user.cellphone,
                                                                                @"password":self.rSecondTextField.text,
                                                                                @"key":kSignKey
                                                                                } progress:nil
                                         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                             
                                             if ([responseObject[@"code"] integerValue] == 0) {
                                                 [JYProgressManager showBriefAlert:@"交易密码设置成功"] ;
                                                 
                                                 [self pvt_backToSetController] ;
                                             }
                                             
                                             
                                         }
                                         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                             
                                         }] ;
    
    
    
}



-(void)pvt_changeLoginPassword {//登录密码修改
    
    
    
    if (![self.rSecondTextField.text isEqualToString:self.rThirdTextField.text]) {
        [JYProgressManager showBriefAlert:@"新密码输入不一致！请重新输入。"];
        
        return ;
    }
    
    
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kChageLogPasswordURL parameters:@{@"cellphone":user.cellphone,
                                                                                   @"originalPassword":self.rFirstTextField.text,
                                                                                   @"password":self.rSecondTextField.text} progress:nil
                                         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                             
                                             if ([responseObject[@"code"] integerValue] == 0) {
                                                 [JYProgressManager showBriefAlert:@"修改登录密码成功"] ;
                                                 
                                                 
                                                 [SSKeychain deletePasswordForService:kSSKeyService account:user.cellphone] ;
                                                 [JYSingtonCenter shareCenter].rUserModel = nil ;
                                                 
                                                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                     
                                                     JYTabBarController *tab= (JYTabBarController*)[[[UIApplication sharedApplication]keyWindow ]rootViewController] ;
                                                     
                                                     UINavigationController *navc = tab.selectedViewController ;
                                                     
                                                     [tab setSelectedIndex:0] ;
                                                     
                                                     [navc popToRootViewControllerAnimated:NO] ;
                                                     
                                                     [self pvt_logIn];
                                                     
                                                 });
                                                 
                                             }
                                             
                                             
                                         }
                                         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                             
                                         }] ;
    
}


-(void)pvt_logIn {
    
    
    JYTabBarController *tab= (JYTabBarController*)[[[UIApplication sharedApplication]keyWindow ]rootViewController] ;
    UINavigationController *navc = tab.selectedViewController ;
    
    
    JYLogInViewController *logVC =[[JYLogInViewController alloc]initWithLogType:JYLogFootViewTypeLogIn];
    UINavigationController *nvc =[[UINavigationController alloc]initWithRootViewController:logVC] ;
    
    [navc  presentViewController:nvc animated:YES completion:^{
    }] ;
    
}



-(void)pvt_checkTelePhone{
    
    NSString *telNum = self.rFirstTextField.text ;
    
    if (rVCType == JYPassVCTypeChangeTelNum || rVCType == JYPassVCTypeChangePass) {
        telNum = self.rThirdTextField.text ;
    }
    
    
    
    if (rVCType != JYPassVCTypeSureChangeTelNum) {
        
        [self.rCodelCell startTimeGCD];
        [self pvt_getCode];
        
        return ;
    }
    
    
    
    if (![telNum jy_stringCheckMobile]) {
        
        [JYProgressManager showBriefAlert:@"手机号码有误!"] ;
        
        return ;
    }
    
    
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kCellPhoneExistURL parameters:@{@"cellphone":telNum } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self.rCodelCell startTimeGCD];
        [self pvt_getCode];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
    
}

-(void)pvt_getCode {
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    long long totalMilliseconds = interval*1000 ;
    
    
    NSString *telNum = self.rFirstTextField.text ;
    
    if (rVCType == JYPassVCTypeChangeTelNum || rVCType == JYPassVCTypeChangePass) {
        telNum = self.rThirdTextField.text ;
    }
    
    
    NSDictionary *dic = @{@"cellphone":telNum,@"type":@"trade",@"timestamp":[NSString stringWithFormat:@"%lld",totalMilliseconds],@"key":kSignKey} ;
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kCodeURL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject) ;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error) ;
    }] ;
    
}

-(void)pvt_backToSetController {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kShowTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray *viewControls = [self.navigationController viewControllers] ;
        
        [viewControls enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIViewController *vc = (UIViewController*)obj ;
            
            if (![vc isKindOfClass:[JYPasswodSettingVC class]]) {
                
                [self.navigationController popToViewController:vc animated:YES];
                
                *stop = YES ;
            }
        }] ;
        
    });
    
}


#pragma mark- UITableViewDataSource/UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return rTitleArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [rTitleArray[section] count] ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JYPasswordSetModel *model = rTitleArray[indexPath.section][indexPath.row] ;
    
    if (model.rHasCode) {
        static NSString *identifier = @"identifierNormal" ;
        
        JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeCode  reuseIdentifier:identifier];
            
            self.rCodeTextField = cell.rTextField ;
            cell.rTextField.keyboardType = UIKeyboardTypeNumberPad ;
            self.rCodelCell = cell ;
            
            @weakify(self)
            [[cell.rCodeButon rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
                
                @strongify(self)
                
                [self pvt_checkTelePhone];
                
            }] ;
            
            [[ cell.rTextField.rac_textSignal filter:^BOOL(NSString* value) {
                return value.length > 6 ;
            }]subscribeNext:^(NSString* x) {
                cell.rTextField.text = [x substringToIndex:6] ;
            }] ;
            
        }
        
        
        [cell setDataModel:model];
        return cell ;
        
    }
    
    if (rVCType == JYPassVCTypeSetPass) {
        static NSString *identifier = @"identifiersetpasssure" ;
        
        JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeEye  reuseIdentifier:identifier maxWidth:110];
        }
        
        if (indexPath.row == 0) {
            self.rFirstTextField = cell.rTextField ;
        }else if (indexPath.row == 1){
            
            self.rSecondTextField = cell.rTextField ;
        }
        
        [cell setDataModel:model];
        
        return cell ;
        
    }
    
    
    static NSString *identifier = @"identifierNormal" ;
    
    JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeNormal    reuseIdentifier:identifier];
    }
    
    [cell setDataModel:model];
    cell.rTextField.enabled = YES ;
    
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.rFirstTextField = cell.rTextField ;
        }else if (indexPath.row == 1){
            
            self.rSecondTextField = cell.rTextField ;
        }else{
            
            self.rThirdTextField = cell.rTextField ;
        }
    } else  {
        self.rThirdTextField = cell.rTextField ;
        
        if (rVCType == JYPassVCTypeChangePass || rVCType == JYPassVCTypeChangeTelNum  ) {
            
            JYUserModel *model = [JYSingtonCenter shareCenter].rUserModel ;
            cell.rTextField.text = model.cellphone ;
            cell.rTextField.enabled = NO ;
        }
        
        
    }
    
    
    
    
    return cell ;
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (rVCType == JYPassVCTypeChangePass && section == 0) {
        return 45 ;
    }
    
    return 15 ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01 ;
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
        
        UILabel *labe = [self jyCreateLabelWithTitle:@"验证身份信息" font:14 color:kBlackSecColor align:NSTextAlignmentLeft] ;
        [headerView.contentView addSubview:labe];
        [labe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(headerView.contentView) ;
            make.left.equalTo(headerView.contentView).offset(15) ;
        }] ;
        
        labe.tag = 999 ;
        
    }
    
    UILabel * label = [headerView.contentView viewWithTag:999] ;
    
    if (rVCType == JYPassVCTypeChangePass && section == 0) {
        
        label.text = @"验证身份信息" ;
    }else{
        label.text = @"" ;
    }
    
    return headerView ;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}




#pragma mark- getter
-(JYLogFootView*)rTableFootView {
    
    if (_rTableFootView == nil) {
        _rTableFootView = [[JYLogFootView alloc]initWithType:JYLogFootViewTypeGetBackPass] ;
        _rTableFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100) ;
        
        @weakify(self)
        [[_rTableFootView.rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            
            if (rVCType == JYPassVCTypeChangeTelNum) {
                
                [self pvt_changeTelNum] ;
                
            }else if (rVCType == JYPassVCTypeSureChangeTelNum){
                
                [self pvt_changeTelNumSure];
                
            } else if (rVCType == JYPassVCTypeChangeLogPass){
                
                [self pvt_changeLoginPassword] ;
                
            }else if (rVCType == JYPassVCTypeChangePass){
                
                [self pvt_changePassword ] ;
            }else if (rVCType == JYPassVCTypeSetPass){
                
                [self pvt_setPassword] ;
            }
            
            NSLog(@"点击") ;
            
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
