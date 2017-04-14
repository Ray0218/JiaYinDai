//
//  JYPayBackController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/13.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPayBackController.h"
#import "JYLoanDetailHeader.h"
#import "JYLogInCell.h"
#import "JYPayBackCell.h"
#import "JYPayStyleController.h"
#import "JYRedCardController.h"



@interface JYPayBackController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong) UITableView *rTableView ;


@property (nonatomic ,strong) JYLoanDetailHeader *rHeaderView ;

@property (nonatomic ,strong) JYLogFootView *rFooterView ;



@end

@implementation JYPayBackController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"借贷详情" ;
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
    return 2 ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3  ;
    }
    return 2 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //
    
    
    if (indexPath.section == 0) {
        
        if ( indexPath.row == 0) {
            
            static NSString *identifier = @"identifierLpayBack" ;
            
            JYPayBackCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
            
            if (cell  == nil) {
                
                cell = [[JYPayBackCell alloc]initWithCellType:JYPayBackCellTypeHeader reuseIdentifier:identifier];
            }
            
            cell.rTitleLabel.text = @"本期应还" ;
            cell.rRightLabel.text = @"已还款期数" ;
            
            return cell ;
            
        }
        
        if (indexPath.row == 2) {
            static NSString *identifier = @"identifierLoanHeaer" ;
            
            JYPayBackCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
            
            if (cell  == nil) {
                
                cell = [[JYPayBackCell alloc]initWithCellType:JYPayBackCellTypeTextField reuseIdentifier:identifier];
                cell.rTitleLabel.text  = @"还款金额" ;
                cell.rTextField.placeholder = @"XXX.00" ;
                
            }
            
            return cell ;
            
        }
        
        
        static NSString *identifier = @"identifierSwiych" ;
        
        JYPayBackCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYPayBackCell alloc]initWithCellType:JYPayBackCellTypeSwitch reuseIdentifier:identifier];
        }
        
        return cell ;
        
        
    }
    
    
    static NSString *identifier = @"identifierLoanNormal" ;
    
    JYPayBackCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPayBackCell alloc]initWithCellType:JYPayBackCellTypeNormal reuseIdentifier:identifier];
    }
    
    if (indexPath.row == 0) {
        cell.rTitleLabel.text = @"支付方式" ;
        cell.rRightLabel.text = @"选择余额/借记卡" ;
    }else{
        
        cell.rTitleLabel.text = @"选择优惠券" ;
        cell.rRightLabel.text = @"选择红包/优惠券" ;
        
    }
    
    return cell ;
    
    
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger) section {
    
    
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

    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            JYPayStyleController *vc =[[JYPayStyleController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
        }else{
        
            JYRedCardController *cardVC = [[JYRedCardController alloc]init];
            [self.navigationController pushViewController:cardVC animated:YES];
            
        
        }
    }
}

#pragma mark- getter

-(JYLoanDetailHeader*)rHeaderView {
    
    if (_rHeaderView == nil) {
        _rHeaderView = [[JYLoanDetailHeader alloc]init ];
        _rHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160) ;
    }
    
    return _rHeaderView ;
}



-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = [UIColor clearColor] ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.sectionFooterHeight = 15 ;
        _rTableView.tableFooterView = self.rFooterView ;
        _rTableView.separatorInset = UIEdgeInsetsZero ;
        _rTableView.estimatedRowHeight = 45 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension ;
        _rTableView.tableHeaderView = self.rHeaderView ;
        
        
    }
    return _rTableView ;
}


-(JYLogFootView*)rFooterView {
    if (_rFooterView == nil) {
        _rFooterView =[[JYLogFootView alloc]initWithType:JYLogFootViewTypeRegister];
        [_rFooterView.rCommitBtn setTitle:@"开始还款" forState:UIControlStateNormal];
        _rFooterView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80) ;
        @weakify(self)
        [[_rFooterView.rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
           
        }] ;
    }
    
    return _rFooterView ;
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
