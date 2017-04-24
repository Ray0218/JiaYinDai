//
//  JYLogInViewController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/5.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLogInViewController.h"
#import "JYPasswordSetController.h"




@interface JYLogInViewController ()<UITableViewDelegate,UITableViewDataSource>{
    JYLogFootViewType rLogFootType ;
}

@property(nonatomic ,strong) UITableView *rTableView ;

@property(nonatomic ,strong) UIImageView *rTableHeaderView ;

@property(nonatomic ,strong) JYLogFootView *rTableFootView ;
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
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildSubViewUI];
    
}

#pragma mark- agction

-(void)pvt_clickButtonNavLeft {
    if (rLogFootType == JYLogFootViewTypeLogIn) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
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
                  
            [[cellTime.rTextField.rac_textSignal filter:^BOOL(id value) {
               
                NSLog(@"%@",value) ;

                return YES ;
            }] subscribeNext:^(id x) {
                NSLog(@"%@",x) ;
            }] ;
            
        }
        
        [ cellTime.rTextField.rac_textSignal filter:^BOOL(id value) {
            NSLog(@"%@",value) ;
            
            return YES ;
        }] ;
        
        return cellTime ;
    }
    
    
    
    
    if (rLogFootType == JYLogFootViewTypeRegister) {
        static NSString *identifier = @"identifierRegistr" ;
        
        JYLogInCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        if (cell  == nil) {
            
            cell = [[JYLogInCell alloc]initWithCellType:JYLogCellTypeCode reuseIdentifier:identifier];
            [[cell.rRightBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
                
                NSLog(@"dddddddddddddd") ;
                
                NSDictionary *dic = @{@"cellphone":@"18757194522",} ;
                
//                [[AFHTTPSessionManager jy_sharedManager]POST:@"/sms" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                    
//                    NSLog(@"%@",responseObject) ;
//                    
//                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                    NSLog(@"%@",error) ;
//                }] ;
//                
                
            }] ;
        }
        
        return cell ;
        
    }
    
    
    static NSString *identifier = @"identifierLogin" ;
    
    JYLogInCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYLogInCell alloc]initWithCellType:JYLogCellTypePassword reuseIdentifier:identifier];
        
        [ cell.rTextField.rac_textSignal filter:^BOOL(id value) {
            NSLog(@"%@",value) ;
            
            return YES ;
        }] ;
    }
    
    return cell ;
    
    
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
        
        
        [[_rTableFootView.rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            
            
            if (rLogFootType == JYLogFootViewTypeLogIn) {
                
                NSLog(@"登录请求") ;
                
            }else{
                
                NSLog(@"注册请求") ;
                
                
                JYPasswordSetController *setPassVC = [[JYPasswordSetController alloc]initWithLogType:JYLogFootViewTypeSetPassword] ;
                setPassVC.title = @"设置登录密码" ;
                
                [self.navigationController pushViewController:setPassVC animated:YES];
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
