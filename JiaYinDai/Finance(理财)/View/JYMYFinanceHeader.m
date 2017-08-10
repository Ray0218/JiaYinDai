//
//  JYMYFinanceHeader.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/12.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYMYFinanceHeader.h"


@interface JYMYFinanceHeader ()

@property(nonatomic ,strong) UITextField *rTotalIncomeField ;
@property(nonatomic ,strong) UILabel *rLeftLabel ;
@property(nonatomic ,strong) UILabel *rRightLabel ;
@property(nonatomic ,strong) UILabel *rTitleLabel ;


@property(nonatomic ,strong) UIImageView *rMoneyImage ;


 


@end

@implementation JYMYFinanceHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = kBlueColor ;
        [self buildSubViewsUI];
    }
    return self;
}


-(void)buildSubViewsUI {
    
    [self addSubview:self.rTitleLabel];
    [self addSubview:self.rTotalIncomeField];
    [self addSubview:self.rLeftLabel];
    [self addSubview:self.rRightLabel];
    
    
    
}

-(void)layoutSubviews {
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self) ;
        make.top.equalTo(self).offset(15) ;
    }];
    
    [self.rTotalIncomeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self) ;
        make.top.equalTo(self.rTitleLabel.mas_bottom).offset(10) ;
        make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH - 30) ;
    }];
    
    
    [self.rLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15) ;
        make.bottom.equalTo(self).offset(-15) ;
    }];
    
    
    [self.rRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15) ;
        make.bottom.equalTo(self.rLeftLabel) ;
    }];
    
}

#pragma mark- getter

-(UILabel*)rTitleLabel {
    if (_rTitleLabel == nil) {
        _rTitleLabel = [self jyCreateLabelWithTitle:@"应还款总额(元)" font:14 color:[UIColor whiteColor] align:NSTextAlignmentCenter] ;
    }
    
    return _rTitleLabel ;
}

-(UITextField*)rTotalIncomeField {
    if (_rTotalIncomeField == nil) {
        _rTotalIncomeField = [[UITextField alloc]init];
        _rTotalIncomeField.leftViewMode = UITextFieldViewModeAlways ;
        _rTotalIncomeField.leftView = ({
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 35, 20)] ;
            
            [view addSubview:self.rMoneyImage];
            
            view ;
        
         }) ;
        _rTotalIncomeField.enabled = NO ;
        _rTotalIncomeField.text = @"0.00" ;
        _rTotalIncomeField.font = [UIFont systemFontOfSize:39] ;
        _rTotalIncomeField.textColor = [UIColor whiteColor] ;

    }
    
    return _rTotalIncomeField ;
}

-(UILabel*)rLeftLabel {
    if (_rLeftLabel == nil) {
        _rLeftLabel = [self jyCreateLabelWithTitle:@"累计借款0元" font:14 color:[UIColor whiteColor] align:NSTextAlignmentLeft] ;
    }
    return _rLeftLabel ;
}

-(UILabel*)rRightLabel {
    
    if (_rRightLabel == nil) {
        _rRightLabel = [self jyCreateLabelWithTitle:@"成功借款0笔" font:14 color:[UIColor whiteColor] align:NSTextAlignmentRight] ;
    }
    
    return _rRightLabel ;
}

-(UIImageView*)rMoneyImage {

    if (_rMoneyImage == nil) {
        _rMoneyImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        _rMoneyImage.backgroundColor = [UIColor clearColor] ;
        _rMoneyImage.image = [UIImage imageNamed:@"loan_money"] ;
    }
    return _rMoneyImage ;
}

@end
