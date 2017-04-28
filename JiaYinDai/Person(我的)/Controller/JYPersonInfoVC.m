//
//  JYPersonInfoVC.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/6.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPersonInfoVC.h"
#import "JYLogInCell.h"
#import "JYPersonInfoCell.h"
#import "JYSecureSettingVC.h"
#import "JYLogInViewController.h"
#import "JYTabBarController.h"

@interface JYPersonInfoVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *rTitlesArray ;
}

@property(nonatomic ,strong) UITableView *rTableView ;
@property(nonatomic ,strong) JYLogFootView *rTableFootView ;

@end


 
@implementation JYPersonInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人信息";
    [self buildSubViewUI];
    
    rTitlesArray = [NSArray arrayWithObjects:@[@"头像",@"我的二维码"],@[@"真实姓名",@"身份证号",@"性别",@"现居地"],@[@"安全设置"], nil] ;
    
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
    return rTitlesArray.count ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [rTitlesArray[section] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *title = rTitlesArray[indexPath.section][indexPath.row] ;
    
    if (indexPath.section == 0 ) {
        
        if (indexPath.row == 0) {
            
            static NSString *identifier = @"identifierHeader" ;
            
            JYPersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
            
            if (cell  == nil) {
                
                cell = [[JYPersonInfoCell alloc]initWithCellType:JYPernfoCellTypeHeader reuseIdentifier:identifier];
            }
            cell.rTitleLabel.text = title ;
            return cell ;
        }
        
        static NSString *identifier = @"identifierCode" ;
        
        JYPersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYPersonInfoCell alloc]initWithCellType:JYPernfoCellTypeCode reuseIdentifier:identifier];
        }
        cell.rTitleLabel.text = title ;

        return cell ;
        
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0 || indexPath.row == 1) {
            static NSString *identifier = @"identifierName" ;
            
            JYPersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
            
            if (cell  == nil) {
                
                cell = [[JYPersonInfoCell alloc]initWithCellType:JYPernfoCellTypeName reuseIdentifier:identifier];
            }
            cell.rTitleLabel.text = title ;

            return cell ;
        }
        
    }
    static NSString *identifier = @"identifierNormal" ;
    
    JYPersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPersonInfoCell alloc]initWithCellType:JYPernfoCellTypeNormal reuseIdentifier:identifier];
    }
    cell.rTitleLabel.text = title ;

    return cell ;
    
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    static NSString *headerIdentifier = @"headerIdentifier" ;
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
        headerView.backgroundView = ({
            
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = [UIColor clearColor] ;
            view;
        }) ;
        headerView.contentView.backgroundColor = [UIColor clearColor];
    }
    
    return headerView ;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        JYSecureSettingVC *setVC = [[JYSecureSettingVC alloc]init];
        [self.navigationController pushViewController:setVC animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80   ;
    }
    
    return 45 ;
}

#pragma mark -action

-(void)pvt_logOut {

    [[AFHTTPSessionManager jy_sharedManager]POST:kLogoutURL parameters:@{@"customerId":[JYSingtonCenter shareCenter].rUserModel.id} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if ([responseObject[@"code"] integerValue] == 0) {
            [JYSingtonCenter shareCenter].rUserModel = nil ;
            
            [self.navigationController popToRootViewControllerAnimated:NO];
            
            JYTabBarController *tab= (JYTabBarController*)[[[UIApplication sharedApplication]keyWindow ]rootViewController] ;
            [tab setSelectedIndex:0] ;
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
}


#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = kBackGroundColor ;
         _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.sectionHeaderHeight = 15 ;
        _rTableView.tableFooterView = self.rTableFootView ;
        _rTableView.separatorInset = UIEdgeInsetsZero ;
        
    }
    return _rTableView ;
}

-(JYLogFootView*)rTableFootView {
    
    if (_rTableFootView == nil) {
        _rTableFootView = [[JYLogFootView alloc]initWithType:JYLogFootViewTypeRegister ];
        _rTableFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 90) ;
        [_rTableFootView.rCommitBtn setTitle:@"退出" forState:UIControlStateNormal] ;
        _rTableFootView.rCommitBtn.enabled = YES ;
        @weakify(self)
        [[_rTableFootView.rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            
            [self pvt_logOut] ;
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
