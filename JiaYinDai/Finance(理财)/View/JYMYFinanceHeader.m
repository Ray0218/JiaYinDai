//
//  JYMYFinanceHeader.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/12.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYMYFinanceHeader.h"


@interface JYMYFinanceHeader ()

@property(nonatomic ,strong) UILabel *rTotalIncomeLabel ;
@property(nonatomic ,strong) UILabel *rLeftLabel ;
@property(nonatomic ,strong) UILabel *rRightLabel ;
@property(nonatomic ,strong) UILabel *rTitleLabel ;


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
    [self addSubview:self.rTotalIncomeLabel];
    [self addSubview:self.rLeftLabel];
    [self addSubview:self.rRightLabel];
    
    
    
}

-(void)layoutSubviews {
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self) ;
        make.top.equalTo(self).offset(15) ;
    }];
    
    [self.rTotalIncomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self) ;
        make.top.equalTo(self.rTitleLabel.mas_bottom).offset(10) ;
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
        _rTitleLabel = [self jyCreateLabelWithTitle:@"累计收益" font:14 color:[UIColor whiteColor] align:NSTextAlignmentCenter] ;
    }
    
    return _rTitleLabel ;
}

-(UILabel*)rTotalIncomeLabel {
    if (_rTotalIncomeLabel == nil) {
        _rTotalIncomeLabel = [self jyCreateLabelWithTitle:@"8.75" font:22 color:[UIColor whiteColor] align:NSTextAlignmentCenter] ;
    }
    
    return _rTotalIncomeLabel ;
}

-(UILabel*)rLeftLabel {
    if (_rLeftLabel == nil) {
        _rLeftLabel = [self jyCreateLabelWithTitle:@"待收收益XXX元" font:14 color:[UIColor whiteColor] align:NSTextAlignmentLeft] ;
    }
    return _rLeftLabel ;
}

-(UILabel*)rRightLabel {
    
    if (_rRightLabel == nil) {
        _rRightLabel = [self jyCreateLabelWithTitle:@"待收本金XXX元" font:14 color:[UIColor whiteColor] align:NSTextAlignmentRight] ;
    }
    
    return _rRightLabel ;
}

@end
