//
//  JYPasswordSetController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/5.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPasswordSetController.h"

@interface JYPasswordSetController ()
<UITableViewDelegate,UITableViewDataSource>{
    
    JYLogFootViewType rFootType ;
    
}

@property(nonatomic ,strong) UITableView *rTableView ;

@property(nonatomic ,strong) UIView *rTableHeaderView ;

@property(nonatomic ,strong) JYLogFootView *rTableFootView ;

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
            }
            
            return cellTime ;
        }
        
        
        static NSString *identifier = @"identifierRegistr" ;
        
        JYLogInCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        if (cell  == nil) {
            
            
            cell = [[JYLogInCell alloc]initWithCellType:JYLogCellTypeCode reuseIdentifier:identifier];
        }
        
        return cell ;
        
        
    }else { //重置登录密码
        
        
        static NSString *identifier = @"identifierLogin" ;
        
        JYLogInCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        if (cell  == nil) {
            
            
            cell = [[JYLogInCell alloc]initWithCellType:JYLogCellTypePassword reuseIdentifier:identifier];
        }
        
        if (indexPath.row == 0) {
            cell.rTextField.placeholder = @"请设置6-16位英文或数字及组合密码" ;
            cell.rLeftImgView.image = [UIImage imageNamed:@"password_icon"] ;

        }else{
            cell.rTextField.placeholder = @"确认登录密码" ;
            cell.rLeftImgView.image = [UIImage imageNamed:@"makesure_icon"] ;

            
        }
        
        return cell ;
        
    }
    
    
    return nil ;
    
 
    
    
    
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
            
            
            
        }else{ //找回密码
            _rTableFootView = [[JYLogFootView alloc]initWithType:JYLogFootViewTypeGetBackPass] ;
            _rTableFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100) ;
            
            [[_rTableFootView.rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                @strongify(self)
                
                JYPasswordSetController *reSetPassVC = [[JYPasswordSetController alloc]initWithLogType:JYLogFootViewTypeSetPassword];
                reSetPassVC.title = @"重置登录密码" ;
                [self.navigationController pushViewController:reSetPassVC animated:YES];
                
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
