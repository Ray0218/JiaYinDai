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
@property (nonatomic ,strong) UIButton * rMoneyButton ; //金额
@property (nonatomic ,strong) UIButton *rBankCardButton ; //银行卡
@property (nonatomic ,strong)UIButton *rRightArrow ; //箭头
@property (nonatomic ,strong) UIButton *rFinishButton ; //已完成按钮
//@property (nonatomic ,strong) UIButton *rMiddleButton ;



@end
@implementation JYPersonHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor] ;
        
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
    [self addSubview:rMiddleLine];
    
    
    
    
    
    rCompleteLab = [self jyCreateLabelWithTitle:@"完善信息" font:16 color:kTextBlackColor align:NSTextAlignmentRight] ;
    rCompDesLab = [self jyCreateLabelWithTitle:@"（完善个人信息享受会员特权！）" font:14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    
    rAccountLab = [self jyCreateLabelWithTitle:@"账户余额" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    
    rBankLab = [self jyCreateLabelWithTitle:@"银行卡管理" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;

    [self addSubview:self.rHeaderImg];
    [self addSubview:self.rUserNameLabel];
    [self addSubview:self.rUserTelLabel];
    [self addSubview:self.rUserCodeView];
    [self addSubview:self.rRightArrow];
    [self addSubview:rCompleteLab];
    [self addSubview:self.rFinishButton];
    [self addSubview:rCompDesLab];
//    [self  addSubview: self.rMiddleButton ] ;

    [self addSubview:rAccountLab];
     [self addSubview:self. rMoneyButton];
    [self addSubview:self.rBankCardButton];
    [self addSubview:rBankLab];
    
 
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
        make.height.and.width.mas_equalTo(35) ;
    }] ;
    
    
    [rCompleteLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rHeaderImg) ;
        make.top.equalTo(self.rHeaderImg.mas_bottom).offset(20) ;
    }] ;
    
    [self.rFinishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rCompleteLab.mas_right).offset(15) ;
        make.centerY.equalTo(rCompleteLab) ;
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(22) ;
    }];
    
    [rCompDesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rFinishButton.mas_right).offset(10) ;
        make.centerY.equalTo(self.rFinishButton) ;
    }];
    
    
//    [self.rMiddleButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(self.rHeaderImg) ;
//        make.left.equalTo(self.rHeaderImg.mas_right).offset(15) ;
//        make.right.equalTo(self.rUserCodeView.mas_left).offset(-15) ;
//    }] ;
    
    
    [self. rMoneyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-5) ;
        make.right.equalTo(self.mas_centerX).offset(-15) ;
        make.height.mas_equalTo(35) ;
        make.left.equalTo(rAccountLab.mas_right).offset(5) ;
        
    }] ;
    
    [self.rBankCardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15) ;
        make.bottom.equalTo(self. rMoneyButton) ;
        make.height.mas_equalTo(35) ;
        make.left.equalTo(rBankLab.mas_right).offset(5) ;


    }] ;
    
    
    [rAccountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.rBankCardButton) ;
        make.left.equalTo(self).offset(30) ;
    }];
    
    [rBankLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(15) ;
        make.centerY.equalTo(rAccountLab) ;
    }] ;
    
    [rMiddleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self) ;
        make.bottom.equalTo(self).offset(-5) ;
        make.height.mas_equalTo(35) ;
        make.width.mas_equalTo(1) ;
    }];
 }


#pragma mark- getter

-(UIImageView*)rHeaderImg {

    if (_rHeaderImg == nil) {
        _rHeaderImg = [[UIImageView alloc]init];
        _rHeaderImg.clipsToBounds = YES ;
        _rHeaderImg.layer.cornerRadius = 5 ;
        _rHeaderImg.backgroundColor = [UIColor lightGrayColor] ;
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
        _rUserNameLabel = [self jyCreateLabelWithTitle:@"*玉玥" font:20 color:[UIColor whiteColor] align:NSTextAlignmentLeft];
    }
    
    return _rUserNameLabel ;
}

-(UILabel*)rUserTelLabel {
    if (_rUserTelLabel == nil) {
        _rUserTelLabel = [self jyCreateLabelWithTitle:@"187****3146" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rUserTelLabel ;
}

-(UIButton*) rMoneyButton {

    if (_rMoneyButton == nil) {
        _rMoneyButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [_rMoneyButton setTitleColor:kBlueColor forState:UIControlStateNormal];
        _rMoneyButton.titleLabel.font = [UIFont systemFontOfSize:16] ;
        [_rMoneyButton setTitle:@"0.00元" forState:UIControlStateNormal] ;
        _rMoneyButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight ;
          _rMoneyButton.backgroundColor = [UIColor clearColor] ;

    }
    
    return _rMoneyButton ;
}

-(UIButton*)rBankCardButton {
    if (_rBankCardButton == nil) {
        
        
        _rBankCardButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [_rBankCardButton setTitleColor:kBlueColor forState:UIControlStateNormal];
        _rBankCardButton.titleLabel.font = [UIFont systemFontOfSize:16] ;
        [_rBankCardButton setTitle:@"2张" forState:UIControlStateNormal] ;
        _rBankCardButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight ;
           _rBankCardButton.backgroundColor = [UIColor clearColor] ;
    }
    
    return _rBankCardButton ;
}

-(UIButton*)rFinishButton {

    if (_rFinishButton == nil) {
        _rFinishButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        _rFinishButton.layer.cornerRadius = 5 ;
        _rFinishButton.clipsToBounds = YES ;
        _rFinishButton.titleLabel.font = [UIFont systemFontOfSize:16] ;
         _rFinishButton.backgroundColor = UIColorFromRGB(0xd8981d) ;
        [_rFinishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rFinishButton setTitle:@"已完成" forState:UIControlStateNormal];

    }
    
    return _rFinishButton ;
}


//-(UIButton*)rMiddleButton {
//    
//    if (_rMiddleButton == nil) {
//        _rMiddleButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
//           _rMiddleButton.backgroundColor = [UIColor orangeColor] ;
//        
//    }
//    
//    return _rMiddleButton ;
//}

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
