//
//  JYLoanInfoController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/10.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoanInfoController.h"
#import "JYLogInCell.h"
#import "JYPersonInfoCell.h"
#import "JYLoanInfoModel.h"
#import "JYLoanInfoCell.h"
#import "JYBankCardController.h"
#import "JYLoanUsedController.h"
#import "JYImageAddController.h"



@interface JYLoanInfoController (){
    NSArray *rTitlesArray ;
}

@property(nonatomic ,strong)JYLogFootView *rTableFootView ;

@end

@implementation JYLoanInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"完善借款信息" ;
    
    
    rTitlesArray = [NSArray arrayWithObjects:@[[[JYLoanInfoModel alloc]initWithLeft:@"30000" right:@"3"]],@[[[JYLoanInfoModel alloc]initWithLeft:@"选择提现卡" right:@"选择已绑定借记卡"],[[JYLoanInfoModel alloc]initWithLeft:@"收入证明" right:@"上传银行流水扫描件/拍照上传"]],@[[[JYLoanInfoModel alloc]initWithLeft:@"借款用途" right:@"编辑借款用途"]],@[[[JYLoanInfoModel alloc]initWithLeft:@"所在位置" right:@"GPS定位"]] ,nil] ;
    
    
    [self initializeTableView];
}

-(void)initializeTableView {
    
    self.tableView.estimatedRowHeight = 45 ;
    self.tableView.rowHeight = UITableViewAutomaticDimension ;
    
    self.tableView.tableFooterView = self.rTableFootView ;
    self.tableView.separatorInset = UIEdgeInsetsZero ;
    
}

#pragma mark- UITableViewDataSource/UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        return 2 ;
    }
    return 1 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JYLoanInfoModel *model = rTitlesArray[indexPath.section][indexPath.row] ;
    
    
    if (indexPath.section == 0) {
        
        
        static NSString *identifier = @"identifierNormal" ;
        
        JYLoanInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYLoanInfoCell alloc]initWithStyle:UITableViewCellStyleDefault    reuseIdentifier:identifier];
        }
        
        
        return cell ;
    }
    
    
    
    static NSString *identifier = @"identifierLoan" ;
    
    JYPersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPersonInfoCell alloc]initWithCellType:JYPernfoCellTypeNormal    reuseIdentifier:identifier];
    }
    
    cell.rTitleLabel.text = model.rLeftString ;
    cell.rDetailLabel.text = model.rRightString ;
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
        
        UILabel *rTitlLab = [self jyCreateLabelWithTitle:@"" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
        rTitlLab.numberOfLines = 0 ;
        rTitlLab.tag = 999 ;
        rTitlLab.backgroundColor = [UIColor clearColor] ;
        [headerView.contentView addSubview:rTitlLab];
        
        [rTitlLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 15, 0, 15)) ;
        }] ;
        
        
    }
    
    
    if (section == 1) {
        UILabel *label = [headerView.contentView viewWithTag:999] ;
        
        label.text = @"嘉银贷均通过线上转账，请选择体现卡！" ;
    }
    
    return headerView ;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    
    
    static NSString *headerIdentifier = @"footerIdentifier" ;
    
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (footerView == nil) {
        footerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
        footerView.backgroundView = ({
            
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = [UIColor clearColor] ;
            view;
        }) ;
        footerView.contentView.backgroundColor = [UIColor clearColor];
        
        UILabel *rTitlLab = [self jyCreateLabelWithTitle:@"" font:16 color:kTextBlackColor align:NSTextAlignmentLeft] ;
        rTitlLab.numberOfLines = 0 ;
        rTitlLab.tag = 999 ;
        rTitlLab.backgroundColor = [UIColor clearColor] ;
        [footerView.contentView addSubview:rTitlLab];
        
        [rTitlLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 15, 0, 15)) ;
        }] ;
        
        
    }
    UILabel *label = [footerView.contentView viewWithTag:999] ;
    
    if (section == 0) {
        label.text = @"*借款为每月还本付息，分3期完成" ;
        
    }else{
        label.text = @"嘉银贷所有借贷均为同城借贷，准确的地理位置\n可以让系统更快的匹配出推荐人，完成您的需要。" ;
        
    }
    return footerView ;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0 ) {
        return 40 ;
    }
    
    if (section == 3) {
        return 60 ;
    }
    
    return 0 ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        return 45 ;
    }
    
    return 15 ;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
            JYBankCardController *vc =[[JYBankCardController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            JYImageAddController *vc = [[JYImageAddController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section == 2){
        
        JYLoanUsedController *vc = [[JYLoanUsedController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark- getter
-(JYLogFootView*)rTableFootView {
    
    if (_rTableFootView == nil) {
        _rTableFootView = [[JYLogFootView alloc]initWithType:JYLogFootViewTypeSetPassword] ;
        _rTableFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120) ;
        [_rTableFootView.rAgreeBtn setTitle:@"阅读并同意嘉银贷《借贷协议》" forState:UIControlStateNormal];
        [_rTableFootView.rCommitBtn setTitle:@"提交" forState:UIControlStateNormal];
        
        
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
