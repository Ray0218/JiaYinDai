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


@interface JYPasswodSettingVC (){
    
    JYPassVCType rVCType ;
    
    NSArray *rTitleArray ;
}

@property (nonatomic,strong) JYLogFootView *rTableFootView ;

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
            
            rTitleArray = [NSArray arrayWithObjects:@[ [[JYPasswordSetModel alloc]initWithTitle:@"原密码" fieldText:@"" placeHolder:@"请输入原密码" hasCode:NO] , [[JYPasswordSetModel alloc]initWithTitle:@"新密码" fieldText:@"" placeHolder:@"请输入新密码" hasCode:NO],[[JYPasswordSetModel alloc]initWithTitle:@"确认密码" fieldText:@"" placeHolder:@"确认新密码" hasCode:NO]  ], nil] ;
            
        }break ;
        case JYPassVCTypeSureChangeTelNum:{
            self.title = @"更换手机" ;
            [self.rTableFootView.rCommitBtn setTitle:@"确认提交" forState:UIControlStateNormal];
            
            rTitleArray = [NSArray arrayWithObjects:@[ [[JYPasswordSetModel alloc]initWithTitle:@"手机号码" fieldText:@"" placeHolder:@"请输入新手机号" hasCode:NO] , [[JYPasswordSetModel alloc]initWithTitle:@"验证码" fieldText:@"" placeHolder:@"请输入验证码" hasCode:YES]  ], nil] ;
            
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
    
    self.tableView.estimatedRowHeight = 45 ;
    self.tableView.rowHeight = UITableViewAutomaticDimension ;
    
    self.tableView.tableFooterView = self.rTableFootView ;
    self.tableView.separatorInset = UIEdgeInsetsZero ;
    
    self.tableView.sectionHeaderHeight = 15 ;
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
            
            cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeCode    reuseIdentifier:identifier];
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
    
    
}


#pragma mark- getter
-(JYLogFootView*)rTableFootView {
    
    if (_rTableFootView == nil) {
        _rTableFootView = [[JYLogFootView alloc]initWithType:JYLogFootViewTypeGetBackPass] ;
        _rTableFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100) ;
        
        @weakify(self)
        [[_rTableFootView.rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            
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
