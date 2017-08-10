//
//  JYPasswordSetController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/5.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPasswordSetController.h"
#import "JYWebViewController.h"

@interface JYPasswordSetController ()
<UITableViewDelegate,UITableViewDataSource>{
    
    JYLogFootViewType rFootType ;
    
}

@property(nonatomic ,strong) UITableView *rTableView ;

@property(nonatomic ,strong) UIView *rTableHeaderView ;

@property(nonatomic ,strong) JYLogFootView *rTableFootView ;

@property (nonatomic ,strong) UITextField *rFirstTextField ;
@property (nonatomic ,strong) UITextField *rSecondTextField ;

@property (nonatomic ,strong) JYLogInCell *rCodelCell ;


@end

@implementation JYPasswordSetController


- (instancetype)initWithLogType:(JYLogFootViewType) type
{
    self = [super init];
    if (self) {
        rFootType = type ;
    }
    return self;
}


-(void)viewDidAppear:(BOOL)animated  {
    [super viewDidAppear:animated];
    
    
    
    if (rFootType == JYLogFootViewTypeGetBackPass) { //找回登录密码
        
        [[self.rFirstTextField.rac_textSignal filter:^BOOL(NSString *value) { //手机号
            
            return value.length > 11 ;
            
        }]subscribeNext:^(NSString* x) {
            self.rFirstTextField.text = [x substringToIndex:11] ;
        }] ;
        
        
        [[self.rSecondTextField.rac_textSignal filter:^BOOL(NSString *value) { //验证码
            
            return value.length > 6 ;
            
        }]subscribeNext:^(NSString* x) {
            self.rSecondTextField.text = [x substringToIndex:6] ;
        }] ;
        
        
        [[RACSignal  combineLatest:@[
                                     self.rFirstTextField.rac_textSignal,
                                     self.rSecondTextField.rac_textSignal,
                                     ]
                            reduce:^(NSString *username,NSString *password) {
                                return @([username length] == 11   && [password length] == 6 );
                            }] subscribeNext:^(NSNumber* x) {
                                
                                self.rTableFootView.rCommitBtn.enabled = [x boolValue] ;
                            }];
        
        
        
    }else{ //密码 6- 16位
        
        
        self.rFirstTextField.keyboardType = self.rSecondTextField.keyboardType = UIKeyboardTypeAlphabet ;
        
        
        [[self.rFirstTextField.rac_textSignal filter:^BOOL(NSString *value) {
            
            return value.length > 16 ;
            
        }]subscribeNext:^(NSString* x) {
            self.rFirstTextField.text = [x substringToIndex:16] ;
        }] ;
        
        [[self.rSecondTextField.rac_textSignal filter:^BOOL(NSString *value) {
            
            return value.length > 16 ;
            
        }]subscribeNext:^(NSString* x) {
            self.rSecondTextField.text = [x substringToIndex:16] ;
        }] ;
        
        
        [[RACSignal  combineLatest:@[
                                     self.rFirstTextField.rac_textSignal,
                                     self.rSecondTextField.rac_textSignal,
                                     ]
                            reduce:^(NSString *username,NSString *password) {
                                return @([username length ] >= 6 && [password length] >= 6   );
                            }] subscribeNext:^(NSNumber* x) {
                                
                                self.rTableFootView.rCommitBtn.enabled = [x boolValue] ;
                            }];
        
        
    }
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildSubViewUI];
    
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
    return 2 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (rFootType == JYLogFootViewTypeGetBackPass) { //找回登录密码
        
        
        if (indexPath.row == 0) {
            
            static NSString *identifier = @"identifierPhone" ;
            
            JYLogInCell *cellTime = [tableView dequeueReusableCellWithIdentifier:identifier] ;
            if (cellTime == nil) {
                
                cellTime = [[JYLogInCell alloc]initWithCellType:JYLogCellTypeNormal reuseIdentifier:identifier];
                
                self.rFirstTextField = cellTime.rTextField ;
            }
            
            return cellTime ;
        }
        
        
        static NSString *identifier = @"identifierRegistr" ;
        
        JYLogInCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        if (cell  == nil) {
            
            cell = [[JYLogInCell alloc]initWithCellType:JYLogCellTypeCode reuseIdentifier:identifier];
            
            self.rSecondTextField = cell.rTextField ;
            
            self.rCodelCell = cell ;
            
            @weakify(self)
            [[cell.rRightBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
                @strongify(self)
                
                if (![self.rFirstTextField.text jy_stringCheckMobile]) {
                    
                    [JYProgressManager showBriefAlert:@"手机号码有误！"] ;
                    
                }else{
                    
                    [self.rSecondTextField becomeFirstResponder];
                    [self.rCodelCell startTimeGCD];
                    [self pvt_getCode];
                    
                }
                
                
            }] ;
            
        }
        
        return cell ;
        
        
    }else { //重置登录密码
        
        
        static NSString *identifier = @"identifierLogin" ;
        
        JYLogInCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        if (cell  == nil) {
            
            cell = [[JYLogInCell alloc]initWithCellType:JYLogCellTypePassword reuseIdentifier:identifier];
        }
        
        if (indexPath.row == 0) {
            self.rFirstTextField = cell.rTextField ;
            
            cell.rTextField.placeholder = @"请设置6-16位英文或数字及组合密码" ;
            cell.rLeftImgView.image = [UIImage imageNamed:@"password_icon"] ;
            self.rFirstTextField = cell.rTextField ;
            
        }else{
            self.rSecondTextField = cell.rTextField ;
            
            cell.rTextField.placeholder = @"确认登录密码" ;
            cell.rLeftImgView.image = [UIImage imageNamed:@"makesure_icon"] ;
            self.rSecondTextField = cell.rTextField ;
            
            
        }
        
        return cell ;
        
    }
    
    
    return nil ;
    
    
}


#pragma mark- action

-(void)pvt_setLogPAssword {
    
    
    
    if (![self.rFirstTextField.text isEqualToString:self.rSecondTextField.text]) {
        [JYProgressManager showBriefAlert:@"新密码输入不一致！请重新输入。"];
        
        return ;
    }
    
    @weakify(self)
    [[AFHTTPSessionManager jy_sharedManager]POST:kRegisterURL parameters:@{@"cellphone":self.rTelPhone,@"password":self.rFirstTextField.text} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @strongify(self)
        [JYProgressManager showBriefAlert:@"注册成功！"];
        
        NSArray *arr =  [SSKeychain accountsForService:kSSKeyService ] ;
        
        if (arr.count) {
            
            for (NSDictionary *dic in arr) {
                
                NSString *telStr = dic[@"acct"] ;
                
                [SSKeychain deletePasswordForService:kSSKeyService account:telStr] ;
            }
            
        }

        [SSKeychain setPassword:self.rFirstTextField.text forService:kSSKeyService account:self.rTelPhone] ;
        
        [[TMDiskCache sharedCache]setObject:self.rTelPhone  forKey:kTelNumCache] ;

        [[TMDiskCache sharedCache]setObject:[NSDate date] forKey:kLogInTimeCache];

        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self gotoLoagin];
            
        });
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
    
}

-(void)gotoLoagin {
    
    [[AFHTTPSessionManager jy_sharedManager ] POST:kLogInURL parameters:@{@"cellphone":self.rTelPhone,@"password":self.rFirstTextField.text} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [JYProgressManager hideAlert] ;
        
        NSDictionary *dataDic = responseObject[@"data"] ;
        
        
        [JYSingtonCenter shareCenter].rUserModel =  [[JYUserModel alloc]initWithDictionary:dataDic error:nil];
        
        
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
}


-(void)pvt_resetLoginPassword {
    
    if (![self.rFirstTextField.text isEqualToString:self.rSecondTextField.text]) {
        
        [JYProgressManager showBriefAlert:@"新密码输入不一致！请重新输入。"];
        
        return ;
    }
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kReSetLogPasswordURL parameters:@{@"cellphone":self.rTelPhone,@"password":self.rFirstTextField.text,@"key":kSignKey} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 0) {
            
            [JYProgressManager showBriefAlert:@"重置登录密码成功"] ;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            });
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
}



-(void)pvt_getCode {
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    long long totalMilliseconds = interval*1000 ;
    
    NSDictionary *dic = @{@"cellphone":self.rFirstTextField.text,@"type":@"login",@"timestamp":[NSString stringWithFormat:@"%lld",totalMilliseconds],@"key":kSignKey} ;
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kCodeURL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject) ;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error) ;
    }] ;
    
}




-(void)pvt_checkSMS { //校验验证码
    
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kVertifySMSURL parameters:@{@"cellphone":self.rFirstTextField.text,@"type":@"login",@"smsCaptcha":self.rSecondTextField.text} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        JYPasswordSetController *reSetPassVC = [[JYPasswordSetController alloc]initWithLogType:JYLogFootViewTypeReSetPassword];
        reSetPassVC.rTelPhone = self.rFirstTextField.text ;
        reSetPassVC.title = @"重置登录密码" ;
        [self.navigationController pushViewController:reSetPassVC animated:YES];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
    
}


#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = kBackGroundColor ;
        _rTableView.estimatedRowHeight = 180 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
        _rTableView.tableFooterView = [[UIView alloc]init];
        //        _rTableView.tableHeaderView = self.rTableHeaderView ;
        _rTableView.tableFooterView = self.rTableFootView ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.sectionHeaderHeight = 20 ;
        
    }
    return _rTableView ;
}

-(UIView*)rTableHeaderView {
    
    if (_rTableHeaderView == nil) {
        _rTableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
        _rTableHeaderView.backgroundColor = kBlueColor ;
    }
    
    return _rTableHeaderView ;
}

-(JYLogFootView*)rTableFootView {
    if (_rTableFootView == nil) {
        
        
        @weakify(self)
        if (rFootType == JYLogFootViewTypeSetPassword) { //设置密码
            _rTableFootView = [[JYLogFootView alloc]initWithType:JYLogFootViewTypeSetPassword] ;
            _rTableFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120) ;
            @weakify(self)
            [[_rTableFootView.rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
                @strongify(self)
                
                if (_rTableFootView.rAgreeView.rImageButton.selected) {
                    [self pvt_setLogPAssword] ;
                }else{
                    
                    [JYProgressManager showBriefAlert:@"您未认可嘉银贷的用户协议，如需注册请阅读并同意"] ;
                }
                
            }] ;
            
            
            [[_rTableFootView.rAgreeView.rAgreeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                
                @strongify(self)
                JYWebViewController *webVC = [[JYWebViewController alloc]initWithUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@/customerAgree",kServiceURL ]]] ;
                [self.navigationController pushViewController:webVC animated:YES];
                
            }] ;
            
            
            
        }else if (rFootType == JYLogFootViewTypeReSetPassword){ //重置密码
            _rTableFootView = [[JYLogFootView alloc]initWithType:JYLogFootViewTypeReSetPassword] ;
            _rTableFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100) ;
            
            [[_rTableFootView.rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                @strongify(self)
                
                [self pvt_resetLoginPassword] ;
                
            }] ;
            
        } else{ //找回密码
            _rTableFootView = [[JYLogFootView alloc]initWithType:JYLogFootViewTypeReSetPassword] ;
            _rTableFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100) ;
            
            [[_rTableFootView.rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                @strongify(self)
                
                [self pvt_checkSMS] ;
                
            }] ;
            
        }
        
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
