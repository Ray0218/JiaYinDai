//
//  JYBankIdentifyController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/17.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYBankIdentifyController.h"
#import "JYLogInCell.h"
#import "JYPasswordCell.h"


@interface JYBankIdentifyController ()<UITableViewDelegate,UITableViewDataSource>{
    
    JYIdentifyType rHeaderType ;
}

@property (nonatomic ,strong) UITableView *rTableView ;
@property (nonatomic ,strong) JYLogFootView *rTableFootView ;
@property (nonatomic ,strong) JYIdentifyHeader *rTableHeaderView ;


@end

@implementation JYBankIdentifyController

- (instancetype)initWithHeaderType:(JYIdentifyType)type
{
    self = [super init];
    if (self) {
        rHeaderType = type ;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"银行卡认证" ;
    
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (rHeaderType == JYIdentifyTypeBank) {
        return 2 ;
    }
    
    return 1 ;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (rHeaderType == JYIdentifyTypeBank) {
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            static NSString *identifier = @"identifierArrow" ;
            
            JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
            
            if (cell  == nil) {
                
                cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeArrow reuseIdentifier:identifier ];
                [cell setDataModel:[[JYPasswordSetModel alloc] initWithTitle:@"验证码" fieldText:@"" placeHolder:@"请选择借记卡（储蓄卡）" hasCode:NO]] ;
                
            }
            
            return cell ;
            
        }
        
        
        if (indexPath.section == 1 && indexPath.row == 1) {
            static NSString *identifier = @"identifierCode" ;
            
            JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
            
            if (cell  == nil) {
                
                cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeCode reuseIdentifier:identifier ];
                
                [cell setDataModel:[[JYPasswordSetModel alloc] initWithTitle:@"验证码" fieldText:@"" placeHolder:@"请输入验证码" hasCode:NO]] ;
                
            }
            
            return cell ;
        }
        
    }
    
    if (rHeaderType == JYIdentifyTypePassword) {
        static NSString *identifier = @"identifierEye" ;
        
        JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeEye reuseIdentifier:identifier maxWidth:120];
        }
        
        if (indexPath.row == 0) {
            [cell setDataModel:[[JYPasswordSetModel alloc] initWithTitle:@"交易密码" fieldText:@"" placeHolder:@"设置6位数字交易密码" hasCode:NO]] ;
        }else{
            [cell setDataModel:[[JYPasswordSetModel alloc] initWithTitle:@"确认交易密码" fieldText:@"" placeHolder:@"再次输入交易密码" hasCode:NO]] ;
        }
        
        return cell ;
    }
    
    
    static NSString *identifier = @"identifierNormal" ;
    
    JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeNormal reuseIdentifier:identifier ];
    }
    
    
    if (rHeaderType == JYIdentifyTypeName) {
        if (indexPath.row == 0) {
            [cell setDataModel:[[JYPasswordSetModel alloc] initWithTitle:@"姓名" fieldText:@"" placeHolder:@"输入本人姓名" hasCode:NO]] ;
        }else{
            [cell setDataModel:[[JYPasswordSetModel alloc] initWithTitle:@"身份证" fieldText:@"" placeHolder:@"输入本人身份证号" hasCode:NO]] ;
            
        }
    }else{
        
        
        if (indexPath.section == 0) {
            
            [cell setDataModel:[[JYPasswordSetModel alloc] initWithTitle:@"卡号" fieldText:@"" placeHolder:@"输入卡号" hasCode:NO]] ;
            
        }else{
            
            [cell setDataModel:[[JYPasswordSetModel alloc] initWithTitle:@"手机号" fieldText:@"" placeHolder:@"请输入银行预留手机号" hasCode:NO]] ;
            
        }
    }
    return cell ;
    
    
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

#pragma mark- action


#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = kBackGroundColor ;
        _rTableView.estimatedRowHeight = 60 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.sectionFooterHeight = 15 ;
        _rTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        _rTableView.tableFooterView = self.rTableFootView ;
        _rTableView.tableHeaderView = self.rTableHeaderView ;
        
    }
    return _rTableView ;
}


-(JYLogFootView*)rTableFootView {
    
    if (_rTableFootView == nil) {
        _rTableFootView = [[JYLogFootView alloc]initWithType:JYLogFootViewTypeGetBackPass] ;
        if (rHeaderType == JYIdentifyTypePassword) {
            [_rTableFootView.rCommitBtn setTitle:@"确认" forState:UIControlStateNormal] ;
            
        }else{
            [_rTableFootView.rCommitBtn setTitle:@"下一步" forState:UIControlStateNormal] ;
        }
        _rTableFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80) ;
        [[_rTableFootView.rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            
            if (rHeaderType == JYIdentifyTypeName) {
                
                JYBankIdentifyController *vc = [[JYBankIdentifyController alloc]initWithHeaderType:JYIdentifyTypeBank] ;
                [self.navigationController pushViewController:vc animated:YES];
            }else if (rHeaderType == JYIdentifyTypeBank){
                
                JYBankIdentifyController *vc = [[JYBankIdentifyController alloc]initWithHeaderType:JYIdentifyTypePassword] ;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
                
                
            }
            
            
        }] ;
    }
    
    return _rTableFootView ;
}


-(JYIdentifyHeader*)rTableHeaderView {
    if (_rTableHeaderView == nil) {
        if (rHeaderType == JYIdentifyTypeName) {
            _rTableHeaderView = [[JYIdentifyHeader alloc]initWithType:JYIdentifyTypeName];
            
            _rTableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 180+kImageHeigh) ;
            
        } else if(rHeaderType == JYIdentifyTypeBank){
            _rTableHeaderView = [[JYIdentifyHeader alloc]initWithType:JYIdentifyTypeBank];
            
            _rTableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120) ;
            
        }else{
            _rTableHeaderView = [[JYIdentifyHeader alloc]initWithType:JYIdentifyTypePassword];
            _rTableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120) ;
            
            
        }
        
        _rTableHeaderView.backgroundColor = kBackGroundColor ;
    }
    
    return _rTableHeaderView ;
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
