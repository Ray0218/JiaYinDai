//
//  JYLoanAlterVC.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/6.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoanAlterVC.h"

@interface JYLoanAlterVC (){
    UIView *_backgroundView;
    UIView *_rBottomLine;
    
}


@end

@implementation JYLoanAlterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pvt_dissMiss)]] ;

    [self builSubViewsUI];
}

-(void)builSubViewsUI {
    _backgroundView = [[UIView alloc] init];
    _backgroundView.backgroundColor =[UIColor whiteColor];
    _backgroundView.layer.cornerRadius = 10;
    _backgroundView.clipsToBounds = YES;
    
    _rBottomLine = ({
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = kBlueColor ;
        view ;
    }) ;
    [_backgroundView addSubview:_rBottomLine ];
    
    
    [self.view addSubview:_backgroundView];

    [self layoutSubViewsUI] ;
    
}

-(void)layoutSubViewsUI {
    
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH-60);
//        make.height.mas_equalTo(335);
        make.center.equalTo(self.view) ;
    }];
    
    
    [_rBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(_backgroundView) ;
        make.height.mas_equalTo(10) ;
    }] ;
    
    
    UILabel *rFirstTitle = [self jyCreateLabelWithTitle:@"借款利率" font:15 color:kBlueColor align:NSTextAlignmentLeft] ;
    NSString *dayStr = [NSString stringWithFormat:@"借款利率按日收取，日费率%.2f%%",[self.rYearInterest doubleValue]/(365)] ;

    UILabel *rFirstDesc = [self jyCreateLabelWithTitle:dayStr font: 14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    rFirstDesc.numberOfLines = 0 ;
    
    
    UILabel *rSecondTitle = [self jyCreateLabelWithTitle:@"收费详情" font: 15 color:kBlueColor align:NSTextAlignmentLeft] ;
    
    NSString *serverStr = [NSString stringWithFormat:@"%@%%",@([self.rServiceRate doubleValue]*100)] ;

    NSString *manageStr = [NSString stringWithFormat:@"%@%%",@([self.rManageRate doubleValue]*100)] ;
    
    UILabel *rSecondDesc = [self jyCreateLabelWithTitle:[NSString stringWithFormat:@"1）借款服务费：按借款金额的%@收取；\n2）资金管理费：按借款本金的%@，按借款周期每月收取；\n3）逾期费用：按逾期金额中的借款本金的0.1%%，每日收取。",serverStr,manageStr] font: 14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    rSecondDesc.numberOfLines = 0 ;
    
    UILabel *rThirdTitle = [self jyCreateLabelWithTitle:@"到账额度" font: 15 color:kBlueColor align:NSTextAlignmentLeft] ;
    
    
    NSString *money = [NSString stringWithFormat:@"%.2f",10000 - [self.rServiceRate doubleValue]*10000 ];
    
    UILabel *rThirdDesc = [self jyCreateLabelWithTitle:[NSString stringWithFormat:@"a.贷款服务费在贷款成功之后收取，不成功不收取。\nb.收取方式为平台筹资完成打款到借款人账户前预先收取，一次性收取。如：借款10000元，实际到账%@元",money] font: 14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    rThirdDesc.numberOfLines = 0 ;
    
    
    [UILabel changeLineSpaceForLabel:rSecondDesc WithSpace:5] ;
    [UILabel changeLineSpaceForLabel:rThirdDesc WithSpace:5] ;
    
    [self.view addSubview:rFirstTitle];
    [self.view addSubview:rFirstDesc];
    [self.view addSubview:rSecondTitle];
    [self.view addSubview:rSecondDesc];
    [self.view addSubview:rThirdTitle];
    [self.view addSubview:rThirdDesc];
    
    
    [rFirstTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backgroundView).offset(15);
        make.top.equalTo(_backgroundView).offset(20) ;
    }] ;
    
    [rFirstDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rFirstTitle) ;
        make.top.equalTo(rFirstTitle.mas_bottom).offset(5) ;
        make.right.equalTo(_backgroundView).offset(-15) ;
    }] ;
    
    
    [rSecondTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backgroundView).offset(15);
        make.top.equalTo(rFirstDesc.mas_bottom).offset(20) ;
    }] ;
    
    [rSecondDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rFirstTitle) ;
        make.top.equalTo(rSecondTitle.mas_bottom).offset(5) ;
        make.right.equalTo(_backgroundView).offset(-15) ;
    }] ;
    

    [rThirdTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backgroundView).offset(15);
        make.top.equalTo(rSecondDesc.mas_bottom).offset(20) ;
    }] ;
    
    [rThirdDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rFirstTitle) ;
        make.top.equalTo(rThirdTitle.mas_bottom).offset(5) ;
        make.right.equalTo(_backgroundView).offset(-15) ;
        
        make.bottom.equalTo(_backgroundView).offset(-30) ;
    }] ;
    
 
}

#pragma mark- action

-(void)pvt_dissMiss{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
