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

@interface JYAddBankController ()
@property (nonatomic ,strong)NSArray *rDataArray ;

@property (nonatomic ,strong) JYLogFootView *rTableFootView ;

@end

@implementation JYAddBankController

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
    
    self.tableView.estimatedRowHeight = 45 ;
    self.tableView.sectionHeaderHeight = 45 ;
    self.tableView.rowHeight = UITableViewAutomaticDimension ;
    self.tableView.tableFooterView =  self.rTableFootView ;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    
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
        }
        
        [cell setDataModel:model];
        
        return cell ;
    }
    
    static NSString *identifier = @"identifierLogin" ;
    
    JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPasswordCell alloc] initWithCellType:JYPassCellTypeNormal reuseIdentifier:identifier];
    }
    
    [cell setDataModel:model];
    
    return cell ;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    static NSString *headerIdentifier = @"headerIdentifier" ;
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
        headerView.contentView.backgroundColor = [UIColor clearColor];
        headerView.backgroundView = ({
            UIView *view = [[UIView alloc]init] ;
            view.backgroundColor = [UIColor clearColor] ;
            view ;
        });
    }
    if (section == 0) {
        headerView.textLabel.text = @"持卡人信息" ;
    }else{
        headerView.textLabel.text = @"请填写本人的储蓄卡信息" ;
    }
    return headerView ;
    
}


-(JYLogFootView*)rTableFootView{

    if (_rTableFootView == nil) {
        _rTableFootView = [[JYLogFootView alloc]initWithType:JYLogFootViewTypeRegister] ;
        _rTableFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100) ;
        
        @weakify(self)
        [[_rTableFootView.rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            JYAddBankCodeController *vc = [[JYAddBankCodeController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
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


@interface JYAddBankCodeController (){
    NSArray *rTitleArray ;

}
@property (nonatomic,strong) JYLogFootView *rTableFootView ;

@end


@implementation JYAddBankCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"添加银行卡";
    
     rTitleArray = [NSArray arrayWithObjects:  [[JYPasswordSetModel alloc]initWithTitle:@"手机号码" fieldText:@"" placeHolder:@"银行预留手机号" hasCode:NO] , [[JYPasswordSetModel alloc]initWithTitle:@"验证码" fieldText:@"" placeHolder:@"请输入验证码" hasCode:YES] , nil] ;
    
    
    [self initializeTableView] ;
    

}

-(void)initializeTableView {
    
    self.tableView.estimatedRowHeight = 45 ;
    self.tableView.rowHeight = UITableViewAutomaticDimension ;
    
    self.tableView.tableFooterView = self.rTableFootView ;
    self.tableView.separatorInset = UIEdgeInsetsZero ;
    
    self.tableView.sectionHeaderHeight = 15 ;
}

#pragma mark- UITableViewDataSource/UITableViewDelegate



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [rTitleArray  count] ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JYPasswordSetModel *model = rTitleArray[indexPath.row] ;
    
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


@end





