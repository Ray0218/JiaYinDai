//
//  JYPersonHeaderView.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/6.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPersonHeaderView.h"


@interface JYPersonHeaderView (){
    
    
    UILabel *rAccountLab ;
    UILabel *rBankLab ;
    
    UILabel *rCompleteLab ;
    UILabel *rCompDesLab ;
    
    UIView *rBackGroundView ;
    
    
    UIView *rMiddleLine ;

    
    
}

@property (nonatomic ,strong) UIImageView *rHeaderImg ; //头像
@property (nonatomic ,strong) UILabel *rUserNameLabel ; //用户名
@property (nonatomic ,strong) UILabel *rUserTelLabel ; //电话号码
@property (nonatomic ,strong) UIImageView *rUserCodeView ; //二维码

@property (nonatomic ,strong) UIButton * rMoneyButton ; //金额按钮

@property (nonatomic ,strong) UILabel * rMoneyLabel ; //金额

@property (nonatomic ,strong) UIButton *rBankCardButton ; //银行卡

@property (nonatomic ,strong) UILabel *rBankCardLabel ; //银行卡


@property (nonatomic ,strong)UIButton *rRightArrow ; //箭头
@property (nonatomic ,strong) UIButton *rFinishButton ; //已完成按钮
@property (nonatomic ,strong) UIButton *rMiddleButton ;



@end
@implementation JYPersonHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self buildSubViewsUI];
    }
    return self;
}



-(void)buildSubViewsUI {
    
    rBackGroundView = [[UIView alloc]init];
    rBackGroundView.backgroundColor = kBlueColor ;
    [self addSubview:rBackGroundView];
    
    rMiddleLine = [[UIView alloc]init];
    rMiddleLine.backgroundColor = kLineColor ;
    
    
    
    rCompleteLab = [self jyCreateLabelWithTitle:@"完善信息" font:14 color:[UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1.00] align:NSTextAlignmentRight] ;
    rCompDesLab = [self jyCreateLabelWithTitle:@"（完善个人信息享受会员特权！）" font:12 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    
    rAccountLab = [self jyCreateLabelWithTitle:@"账户余额" font:14 color:kBlackColor align:NSTextAlignmentLeft] ;
    
    rBankLab = [self jyCreateLabelWithTitle:@"银行卡管理" font:14 color:kBlackColor align:NSTextAlignmentLeft] ;
    
    [self addSubview:self.rHeaderImg];
    [self addSubview:self.rUserNameLabel];
    [self addSubview:self.rUserTelLabel];
    [self addSubview:self.rUserCodeView];
    [self addSubview:self.rRightArrow];
    [self addSubview:rCompleteLab];
    [self addSubview:self.rFinishButton];
    [self addSubview:rCompDesLab];
    [self  addSubview: self.rMiddleButton ] ;
    
    [self addSubview:self. rMoneyButton];
    [self addSubview:rAccountLab];
    [self addSubview:self.rMoneyLabel];
    
    [self addSubview:self.rBankCardButton];
    [self addSubview:rBankLab];
    [self addSubview:self.rBankCardLabel];
    
    [self addSubview:rMiddleLine];
    
    
}


-(void)layoutSubviews {
    
    
    [rBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 45, 0)) ;
    }] ;
    [self.rHeaderImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15) ;
        make.top.equalTo(self).offset(15) ;
        
        make.height.and.width.mas_equalTo(65) ;
    }] ;
    
    [self.rUserNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rHeaderImg.mas_right).offset(10) ;
        make.top.equalTo(self.rHeaderImg) ;
    }];
    
    [self.rUserTelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rUserNameLabel) ;
        make.top.equalTo(self.rUserNameLabel.mas_bottom).offset(10) ;
    }] ;
    
    
    [self.rRightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.rHeaderImg) ;
        make.right.equalTo(self).offset(-15) ;
        make.width.height.mas_equalTo(25) ;
    }];
    
    [self.rUserCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.rHeaderImg) ;
        make.right.equalTo(self.rRightArrow.mas_left).offset(-10) ;
        make.height.and.width.mas_equalTo(33) ;
    }] ;
    
    
    [rCompleteLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rHeaderImg) ;
        make.top.equalTo(self.rHeaderImg.mas_bottom).offset(16) ;
    }] ;
    
    [self.rFinishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rCompleteLab.mas_right).offset(10) ;
        make.centerY.equalTo(rCompleteLab) ;
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(22) ;
    }];
    
    [rCompDesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rFinishButton.mas_right).offset(10) ;
        make.centerY.equalTo(self.rFinishButton) ;
    }];
    
    
    [self.rMiddleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.rHeaderImg) ;
        make.left.equalTo(self.rHeaderImg.mas_right).offset(15) ;
        make.right.equalTo(self).offset(-15) ;
    }] ;
    
    
    
    [self. rMoneyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-5) ;
        make.right.equalTo(self.mas_centerX).offset(-0.5) ;
        make.height.mas_equalTo(35) ;
        make.left.equalTo(self) ;
        
    }] ;
    
    
    
    [self.rMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.rMoneyButton) ;
        make.right.equalTo(self.rMoneyButton).offset(-10) ;
        make.left.equalTo(rAccountLab.mas_right).offset(5) ;
        
    }] ;
    
    
    
    [self.rBankCardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self) ;
        make.bottom.equalTo(self).offset(-5)  ;
        make.height.mas_equalTo(35) ;
        make.left.equalTo(self.mas_centerX).offset(0.5) ;
        
        
    }] ;
    
    
    
    [self.rBankCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-15) ;
        make.centerY.equalTo(self. rBankCardButton) ;
        make.left.equalTo(rBankLab.mas_right).offset(5) ;
        
    }] ;
    
    
    
    [rAccountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.rBankCardButton) ;
        
        make.left.equalTo(self).offset(15) ;
        
//        make.width.mas_equalTo(60) ;
        
        make.width.mas_greaterThanOrEqualTo(60) ;

        
    }];
    
    [rBankLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(15) ;
        make.centerY.equalTo(rAccountLab) ;
        make.width.mas_greaterThanOrEqualTo(72) ;
    }] ;
    
    
    [rMiddleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self) ;
        make.width.mas_equalTo(0.5) ;
        make.height.mas_equalTo(self.rMoneyButton) ;
        make.bottom.equalTo(self).offset(-5) ;
    }] ;
    
    
     
}


#pragma mark- getter

-(UIImageView*)rHeaderImg {
    
    if (_rHeaderImg == nil) {
        _rHeaderImg = [[UIImageView alloc]init];
        _rHeaderImg.clipsToBounds = YES ;
        _rHeaderImg.layer.cornerRadius = 5 ;
        _rHeaderImg.backgroundColor = [UIColor lightGrayColor] ;
        _rHeaderImg.image = [UIImage imageNamed:@"per_header"] ;
    }
    return _rHeaderImg ;
}

-(UIImageView*)rUserCodeView {
    if (_rUserCodeView == nil) {
        _rUserCodeView = [[UIImageView alloc]init];
        _rUserCodeView.image =  [[UIImage imageNamed:@"per_code"] jy_imageWithTintColor:[UIColor whiteColor]] ;
        _rUserCodeView.backgroundColor = [UIColor clearColor] ;
    }
    return _rUserCodeView ;
    
}


-(UILabel*)rUserNameLabel {
    if (_rUserNameLabel == nil) {
        _rUserNameLabel = [self jyCreateLabelWithTitle:@" " font:19 color:[UIColor whiteColor] align:NSTextAlignmentLeft];
    }
    
    return _rUserNameLabel ;
}

-(UILabel*)rUserTelLabel {
    if (_rUserTelLabel == nil) {
        _rUserTelLabel = [self jyCreateLabelWithTitle:@" " font:16 color:[UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1.00] align:NSTextAlignmentLeft] ;
    }
    
    return _rUserTelLabel ;
}

-(UIButton*) rMoneyButton {
    
    if (_rMoneyButton == nil) {
        _rMoneyButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        _rMoneyButton.backgroundColor = [UIColor clearColor] ;
        
    }
    
    return _rMoneyButton ;
}

-(UILabel*)rMoneyLabel {
    
    if (_rMoneyLabel == nil) {
        _rMoneyLabel = [self jyCreateLabelWithTitle:@"0.00元" font:15 color:kBlueColor align:NSTextAlignmentRight] ;
    }
    
    return _rMoneyLabel ;
    
}

-(UIButton*)rBankCardButton {
    if (_rBankCardButton == nil) {
        
        _rBankCardButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        
        _rBankCardButton.backgroundColor = [UIColor clearColor] ;
        
 
    }
    
    return _rBankCardButton ;
}


-(UILabel*)rBankCardLabel {
    
    if (_rBankCardLabel == nil) {
        _rBankCardLabel = [self jyCreateLabelWithTitle:@"0张" font:15 color:kBlueColor align:NSTextAlignmentRight] ;
    }
    
    return _rBankCardLabel ;
}


-(UIButton*)rFinishButton {
    
    if (_rFinishButton == nil) {
        _rFinishButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        _rFinishButton.layer.cornerRadius = 5 ;
        _rFinishButton.clipsToBounds = YES ;
        _rFinishButton.titleLabel.font = [UIFont systemFontOfSize:14] ;
        _rFinishButton.backgroundColor = UIColorFromRGB(0xd8981d) ;
        [_rFinishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rFinishButton setTitle:@"已完成" forState:UIControlStateNormal];
        
    }
    
    return _rFinishButton ;
}


-(UIButton*)rMiddleButton {
    
    if (_rMiddleButton == nil) {
        _rMiddleButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        _rMiddleButton.backgroundColor = [UIColor clearColor] ;
        
    }
    
    return _rMiddleButton ;
}

-(UIButton*)rRightArrow {
    if (_rRightArrow == nil) {
        _rRightArrow = ({
            
            UIButton *view = [UIButton  buttonWithType:UIButtonTypeCustom];
            [view setImage:[[UIImage imageNamed:@"more"] jy_imageWithTintColor:[UIColor whiteColor]] forState:UIControlStateNormal] ;
            view.backgroundColor = [UIColor clearColor] ;
            view ;
        }) ;
    }
    return _rRightArrow ;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
