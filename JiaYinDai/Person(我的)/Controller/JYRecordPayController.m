//
//  JYRecordPayController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/14.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYRecordPayController.h"
#import "JYLoanDetailHeader.h"
#import "JYPayBackCell.h"


@interface JYRecordPayController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong) UITableView *rTableView ;


@property (nonatomic ,strong) JYLoanDetailHeader *rHeaderView ;


@property (nonatomic ,strong) UIView *rFootView ;


@end

@implementation JYRecordPayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"预约还款" ;
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
    
    return 4 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ( indexPath.row == 0 || indexPath.row == 2) {
        
        static NSString *identifier = @"identifierLpayBack" ;
        
        JYPayBackCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYPayBackCell alloc]initWithCellType:JYPayBackCellTypeHeader reuseIdentifier:identifier];
         }
        
        if (indexPath.row == 0) {
            cell.rRightLabel.text = @"已还期数1/3" ;
        }
        
        return cell ;
        
    }
    
    if (indexPath.row == 1) {
        
        
        static NSString *identifier = @"identifierSwiych" ;
        
        JYPayBackCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYPayBackCell alloc]initWithCellType:JYPayBackCellTypeTextFieldButton reuseIdentifier:identifier];
            
            cell.rTitleLabel.text  = @"还款金额" ;
            cell.rTextField.placeholder = @"XXX.00" ;
            
        }
        
        return cell ;
        
    }
    
    
    static NSString *identifier = @"identifierLoanNormal" ;
    
    JYPayBackCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPayBackCell alloc]initWithCellType:JYPayBackCellTypeNormal reuseIdentifier:identifier];
        cell.rTitleLabel.text = @"扣款日期" ;
        cell.rRightLabel.text = @"建议选择到期还款日前2天" ;

    }
    
    
    return cell ;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 3) {
        [self pvt_selectDate];
    }
}

#pragma mark- action

-(void)pvt_selectDate {

    //创建一个UIPickView对象
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    //自定义位置
//    datePicker.frame = CGRectMake(0, SCREEN_HEIGHT*0.4-240, 414, 150);
    
    datePicker.frame = CGRectMake(0, SCREEN_HEIGHT - 450, 414, 450);

    //设置背景颜色
    datePicker.backgroundColor = [UIColor whiteColor];
    //datePicker.center = self.center;
    //设置本地化支持的语言（在此是中文)
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    //显示方式是只显示年月日
    datePicker.datePickerMode = UIDatePickerModeDate;
    //放在盖板上
    [self.view addSubview:datePicker];
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
        _rTableView.separatorInset = UIEdgeInsetsZero ;
        _rTableView.estimatedRowHeight = 45 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension ;
        _rTableView.tableHeaderView = self.rHeaderView ;
        _rTableView.tableFooterView = self.rFootView ;
        
    }
    return _rTableView ;
}


-(UIView*)rFootView {
    if (_rFootView == nil) {
        _rFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210)];
        
        
        UILabel *titleLabel = [self jyCreateLabelWithTitle:@"扣款规则顺序：账户余额>储蓄卡" font:16 color:kTextBlackColor align:NSTextAlignmentLeft] ;
        titleLabel.frame = CGRectMake(15, 15, SCREEN_WIDTH-30, 20) ;
        [_rFootView addSubview:titleLabel];
        
        
        UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [agreeBtn setTitle:@"同意《预约还款协议》" forState:UIControlStateNormal] ;
        [agreeBtn setTitleColor:kBlueColor forState:UIControlStateNormal] ;
        agreeBtn.titleLabel.font = [UIFont systemFontOfSize:14] ;
        agreeBtn.frame = CGRectMake(15, CGRectGetMaxY(titleLabel.frame)+15, 180, 15) ;
        [_rFootView addSubview:agreeBtn];
        
        
        UIButton *commitBtn = [self jyCreateButtonWithTitle:@"保存设置"] ;
        commitBtn.frame = CGRectMake(15, CGRectGetMaxY(agreeBtn.frame)+30, SCREEN_WIDTH-30, 45) ;
        [_rFootView addSubview:commitBtn];
        
        
        UIButton *deleteBtn = [self jyCreateButtonWithTitle:@"清除设置"] ;
        deleteBtn.frame = CGRectMake(15, CGRectGetMaxY(commitBtn.frame)+15, SCREEN_WIDTH-30, 45) ;
        deleteBtn.backgroundColor = [UIColor lightGrayColor] ;
        [_rFootView addSubview:deleteBtn];
        
        
      }
    
    
    return _rFootView ;
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
