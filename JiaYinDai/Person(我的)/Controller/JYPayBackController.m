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
#import "JYPasswordCell.h"
#import "JYPersonInfoCell.h"
#import "JYPayBackCell.h"


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
        
        JYLoanDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYLoanDetailCell alloc]initWithCellType:JYLoanDetailCellTypeLabOnly reuseIdentifier:identifier];
            
         }
        
        return cell ;
        
    }
        
        
        if (indexPath.row == 2) {
            static NSString *identifier = @"identifierLoanHeaer" ;
            
            JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
            
            if (cell  == nil) {
                
                cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeNormal reuseIdentifier:identifier];
                cell.rTitleLabel.textAlignment = NSTextAlignmentCenter ;
                cell.rTitleLabel.text  = @"还款金额" ;
                
                cell.rTextField.placeholder = @"XXX.00" ;
                
            }
            
            return cell ;
            
        }
        
        
        static NSString *identifier = @"identifierSwiych" ;
        
        JYPayBackCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYPayBackCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
         }
        
        return cell ;


    }
    
    
     static NSString *identifier = @"identifierLoanNormal" ;
    
    JYPersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPersonInfoCell alloc]initWithCellType:JYPernfoCellTypeNormal reuseIdentifier:identifier];
     }
    
    if (indexPath.row == 0) {
        cell.rTitleLabel.text = @"支付方式" ;
        cell.rDetailLabel.text = @"选择余额/借记卡" ;
    }else{
    
        cell.rTitleLabel.text = @"选择优惠券" ;
        cell.rDetailLabel.text = @"选择红包/优惠券" ;

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



#pragma mark- getter

-(JYLoanDetailHeader*)rHeaderView {
    
    if (_rHeaderView == nil) {
        _rHeaderView = [[JYLoanDetailHeader alloc]init ];
        _rHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160) ;
    }
    
    return _rHeaderView ;
}


#pragma  mark- getter

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
