//
//  JYBillViewController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/21.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYBillViewController.h"
#import "JYBillCell.h"
#import "JYBillDetailController.h"


@interface JYBillViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong) UITableView *rTableView ;

@property(nonatomic ,strong) UITableView *rAlterTableView ;


@end

@implementation JYBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的账单" ;
    [self initializeTableView];
    
    [self setNavRightButtonWithImage:nil title:@"筛选"] ;
}

-(void)initializeTableView {
    
    
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }] ;
    
    
    [self.view addSubview:self.rAlterTableView];
    [self.rAlterTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }] ;
    
}

#pragma mark- action

-(void)pvt_clickButtonNavRight{
    
    self.rAlterTableView.hidden = NO ;
    
 }


#pragma mark- UITableViewDataSource/UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView == self.rAlterTableView) {
        return 2 ;
    }
    return 1 ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.rAlterTableView) {
        return 1 ;
    }
    return 13;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (tableView == self.rAlterTableView) {
        static NSString *identifier = @"identifierLpayBack" ;
        
        JYBillAlterCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYBillAlterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            @weakify(self)
            cell.rBlock = ^(NSInteger index, JYBillAlterCell *curCell) {
                @strongify(self)
                
                self.rAlterTableView.hidden = YES ;
                NSIndexPath *path = [self.rAlterTableView indexPathForCell:curCell] ;
                
                NSLog(@"%zd, ==== %zd",index,path.section) ;
                
                
            } ;
        }
        
        if (indexPath.section == 0) {
            [cell setTitles:@[@"  全部",@"  借款",@"  还款"] images:@[@"bill_state1",@"bill_state2",@"bill_state3"]] ;
        }else{
            [cell setTitles:@[@"  提现",@"  充值",@"  佣金"] images:@[@"bill_state4",@"bill_state5",@"bill_state6"]] ;
            
        }
        
        
        
        return cell ;
        
    }
    
    static NSString *identifier = @"identifierLogin" ;
    
    JYBillCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYBillCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row %2 == 0) {
        [cell setCellColor:kOrangewColor];
    }else if (indexPath.row %3 ==0){
        
        [cell setCellColor:kBlueColor] ;
    }else{
        [cell setCellColor:kGrayColor] ;
    }
    
    
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
            view ;
        }) ;
        headerView.contentView.backgroundColor = [UIColor clearColor];
        
        
        
    }
    
    return headerView ;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JYBillDetailController *vc = [[JYBillDetailController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = [UIColor  clearColor] ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.separatorStyle = 0 ;
        _rTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        _rTableView.estimatedRowHeight = 45 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension ;
        _rTableView.tableFooterView =  [UIView new] ;
        
    }
    return _rTableView ;
}

-(UITableView*)rAlterTableView {
    
    if (_rAlterTableView == nil) {
        
        _rAlterTableView = [[UITableView alloc]init];
        _rAlterTableView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6] ;
        _rAlterTableView.delegate = self ;
        _rAlterTableView.dataSource = self ;
        _rAlterTableView.sectionHeaderHeight = 15 ;
        _rAlterTableView.separatorInset = UIEdgeInsetsZero ;
        _rAlterTableView.estimatedRowHeight = 45 ;
        _rAlterTableView.rowHeight = UITableViewAutomaticDimension ;
        _rAlterTableView.tableFooterView =  [UIView new] ;
        _rAlterTableView.hidden = YES ;
        
    }
    
    return _rAlterTableView ;
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
