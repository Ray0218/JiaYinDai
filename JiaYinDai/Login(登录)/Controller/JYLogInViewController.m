//
//  JYLogInViewController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/5.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLogInViewController.h"
#import "JYPasswordSetController.h"
#import "JYTabBarController.h"



@interface JYLogInViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    JYLogFootViewType rLogFootType ;
}

@property(nonatomic ,strong) UITableView *rTableView ;

@property(nonatomic ,strong) UIImageView *rTableHeaderView ;

@property(nonatomic ,strong) JYLogFootView *rTableFootView ;


@property(nonatomic ,strong) UITextField *rFirstTextField ;
@property(nonatomic ,strong) UITextField *rSecondTextField ;


@end

@implementation JYLogInViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSAssert(0, @"使用initWithLogType")  ;
    }
    return self;
}

- (instancetype)initWithLogType:(JYLogFootViewType) type
{
    self = [super init];
    if (self) {
        rLogFootType = type ;
        self.rFirstTextField = self.rSecondTextField = nil ;
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated  {
    [super viewDidAppear:animated];
    
    [[RACSignal  combineLatest:@[
                                 self.rFirstTextField.rac_textSignal,
                                 self.rSecondTextField.rac_textSignal,
                                 ]
                        reduce:^(NSString *username,NSString *password) {
                            return @([username length] == 11 && [password length] > 0 );
                        }] subscribeNext:^(NSNumber* x) {
                            
                            self.rTableFootView.rCommitBtn.enabled = [x boolValue] ;
                        }];
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildSubViewUI];
    
    
}

#pragma mark- action

-(void)pvt_login {
    
    [[AFHTTPSessionManager jy_sharedManager ] POST:kLogInURL parameters:@{@"cellphone":self.rFirstTextField.text,@"password":self.rSecondTextField.text} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dataDic = responseObject[@"data"] ;
        
        
        if ([responseObject[@"code"] integerValue] == 0) {
            
            [JYSingtonCenter shareCenter].rUserModel =  [[JYUserModel alloc]initWithDictionary:dataDic error:nil];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }  else{
            
            [JYProgressManager showBriefAlert:responseObject[@"msg"]] ;
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
}

-(void)pvt_register {
    
    [[AFHTTPSessionManager jy_sharedManager ] POST:kCodeVerifyURL parameters:@{@"cellphone":self.rFirstTextField.text,@"smsCaptcha":self.rSecondTextField.text} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        JYPasswordSetController *setPassVC = [[JYPasswordSetController alloc]initWithLogType:JYLogFootViewTypeSetPassword] ;
        setPassVC.title = @"设置登录密码" ;
        setPassVC.rTelPhone = self.rFirstTextField.text ;
        
        [self.navigationController pushViewController:setPassVC animated:YES];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
}

-(void)pvt_getCode {
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    long long totalMilliseconds = interval*1000 ;
    
    NSDictionary *dic = @{@"cellphone":self.rFirstTextField.text,@"type":@"reg",@"timestamp":[NSString stringWithFormat:@"%lld",totalMilliseconds],@"key":kSignKey} ;
    
    [[AFHTTPSessionManager jy_sharedManager]POST:@"/sms" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject) ;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error) ;
    }] ;
    
}

-(void)pvt_clickButtonNavLeft {
    if (rLogFootType == JYLogFootViewTypeLogIn) {
        
        
        JYTabBarController *tab= (JYTabBarController*)[[[UIApplication sharedApplication]keyWindow ]rootViewController] ;
        [tab setSelectedIndex:0] ;
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
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
    
    
    if (indexPath.row == 0) {
        
        static NSString *identifier = @"identifierPhone" ;
        
        JYLogInCell *cellTime = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        if (cellTime == nil) {
            
            cellTime = [[JYLogInCell alloc]initWithCellType:JYLogCellTypeNormal reuseIdentifier:identifier];
            
            self.rFirstTextField = cellTime.rTextField ;
            cellTime.rTextField.delegate = self ;
            
            [[[[cellTime.rTextField rac_signalForControlEvents:UIControlEventEditingChanged] map:^id(UITextField* value) {
                return value.text ;
                
            }] filter:^BOOL(id value) {
                
                NSLog(@"%@",value) ;
                
                
                
                return YES ;
            }] subscribeNext:^(id x) {
                
                
                NSLog(@"%@",x) ;
                
            }] ;
            
        }
        
        
        
        return cellTime ;
    }
    
    
    
    
    if (rLogFootType == JYLogFootViewTypeRegister) {
        static NSString *identifier = @"identifierRegistr" ;
        
        JYLogInCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        if (cell  == nil) {
            
            cell = [[JYLogInCell alloc]initWithCellType:JYLogCellTypeCode reuseIdentifier:identifier];
            
            self.rSecondTextField = cell.rTextField ;
            
            @weakify(self)
            [[cell.rRightBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
                @strongify(self)
                
                [self pvt_getCode];
                
                
            }] ;
        }
        
        return cell ;
        
    }
    
    
    static NSString *identifier = @"identifierLogin" ;
    
    JYLogInCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYLogInCell alloc]initWithCellType:JYLogCellTypePassword reuseIdentifier:identifier];
        self.rSecondTextField = cell.rTextField ;
        
        [ cell.rTextField.rac_textSignal filter:^BOOL(id value) {
            NSLog(@"%@",value) ;
            
            return YES ;
        }] ;
    }
    
    return cell ;
    
    
}

#pragma mark- UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    if ([string isEqualToString:@""]) {
        
        return YES ;
    }
    
    NSCharacterSet *cs  = [[NSCharacterSet characterSetWithCharactersInString:kNumber] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
    BOOL canChange = [string isEqualToString:filtered];
    
    NSString *fullString = [textField.text stringByReplacingCharactersInRange:range withString:string] ;
    
    if (canChange ) {
        
        if (fullString.length <= 11) {
            return YES ;
        }else{
            return NO ;
        }
        return YES ;
    }
    
    return NO ;
}


#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = kBackGroundColor ;
        _rTableView.estimatedRowHeight = 180 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
        
        _rTableView.tableHeaderView = self.rTableHeaderView ;
        _rTableView.tableFooterView = self.rTableFootView ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        
    }
    return _rTableView ;
}

-(UIImageView*)rTableHeaderView {
    
    if (_rTableHeaderView == nil) {
        _rTableHeaderView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
        _rTableHeaderView.image = [UIImage imageNamed:@"log_img"] ;
        _rTableHeaderView.contentMode = UIViewContentModeCenter
        ;
        _rTableHeaderView.backgroundColor = [UIColor whiteColor] ;
    }
    
    return _rTableHeaderView ;
}

-(JYLogFootView*)rTableFootView {
    if (_rTableFootView == nil) {
        
        
        @weakify(self)
        if (rLogFootType == JYLogFootViewTypeLogIn) { //登录
            _rTableFootView = [[JYLogFootView alloc]initWithType:JYLogFootViewTypeLogIn] ;
            _rTableFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120) ;
            
            [[_rTableFootView.rRegisterBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                @strongify(self)
                
                JYLogInViewController *registerVC = [[JYLogInViewController alloc]initWithLogType:JYLogFootViewTypeRegister] ;
                registerVC.title = @"注册" ;
                
                [self.navigationController pushViewController:registerVC animated:YES];
            }] ;
            
            [[_rTableFootView.rForgetBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                @strongify(self)
                
                
                 
                JYPasswordSetController *getPassVC = [[JYPasswordSetController alloc]initWithLogType:JYLogFootViewTypeGetBackPass] ;
                getPassVC.title = @"找回密码" ;
                
                [self.navigationController pushViewController:getPassVC animated:YES];
            }] ;
            
            
        }else{  //注册
            _rTableFootView = [[JYLogFootView alloc]initWithType:JYLogFootViewTypeRegister] ;
            _rTableFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120) ;
        }
        
        _rTableFootView.rCommitBtn.enabled = NO ;
        [[_rTableFootView.rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            
            
            if (rLogFootType == JYLogFootViewTypeLogIn) {
                
                NSLog(@"登录请求") ;
                [self pvt_login];
                
            }else{
                
                NSLog(@"注册请求") ;
                
                [self pvt_register];
              
            }
            
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
