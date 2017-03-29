//
//  JYFinanceDetailView.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/28.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYFinanceDetailView.h"

@interface JYFinanceDetailView ()

@property (nonatomic,strong)UIButton *rCashbackBtn ; //返现
@property (nonatomic,strong)UIButton *rFirstOrderBtn; //首单
@property (nonatomic,strong)UIButton *rLastOrderBtn ; //尾单

@property (nonatomic,strong)UILabel *rPercentLabel ; //预期年化

@property (nonatomic,strong)UILabel *rTimeLabel ; //期限

@property (nonatomic,strong)UILabel *rBeginMoneyLab ; //起购金额
@property (nonatomic,strong)UILabel *rSalePercentLab ; //已售

@property (nonatomic,strong)UILabel *rTotalMoneyLab ; // 募集金额
@property (nonatomic,strong)UILabel *rRestMoneyLab ; // 剩余金额


@end

static inline NSMutableAttributedString * TTPercentString( NSString*baseText,NSString *text ){
    
    NSMutableAttributedString *att = [[NSMutableAttributedString  alloc]initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:26]}] ;
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:50] range:NSMakeRange(0,baseText.length)] ;
    
    return att ;
    
} ;

@implementation JYFinanceDetailView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildSubViewsUI];
    }
    return self;
}




 - (void)buildSubViewsUI {
     
     self.rPercentLabel.attributedText = TTPercentString(@"12", @"12%+2%") ;
    
    
    
    UILabel *rPreLabel = [self createLabelWithTitle:@"预期年化" font:18 color:[UIColor whiteColor] align:NSTextAlignmentLeft] ;
    UIView *rBgView = [[UIView alloc]init];
    rBgView.backgroundColor = kBlueColor ;
    [self addSubview:rBgView];
    
    UIView *middelLine = ({
        UIView *view  = [[UIView alloc]init];
        view.backgroundColor = kBackGroundColor ;
        view.layer.borderWidth = 1 ;
        view.layer.borderColor = kLineColor.CGColor ;
        view ;
        
    }) ;
    
    UIView *bottomLine = ({
        UIView *view  = [[UIView alloc]init];
        view.backgroundColor = kBackGroundColor ;
        view.layer.borderWidth = 1 ;
        view.layer.borderColor = kLineColor.CGColor ;
        view ;
        
    }) ;
    
    UILabel *descLabel = [self createLabelWithTitle:@"起息日：募集成功次日开始计算收益\n到期日期：根据相应的还款方式，于计划还款日还款\n还款方式：每月等额本息，支持提前还款。" font:14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    descLabel.numberOfLines = 0 ;
    [UILabel changeLineSpaceForLabel:descLabel WithSpace:5.0] ;
    
    [self addSubview:self.rCashbackBtn];
    [self addSubview:self.rLastOrderBtn];
    [self addSubview:self.rFirstOrderBtn];
    [self addSubview:rPreLabel];
    [self addSubview:self.rTimeLabel];
    [self addSubview:self.rPercentLabel];
    [self addSubview:middelLine];
    [self addSubview:bottomLine];
    [self addSubview:descLabel];
    
    [self addSubview:self.rBeginMoneyLab];
    [self addSubview:self.rSalePercentLab];
    [self addSubview:self.rTotalMoneyLab];
    [self addSubview:self.rRestMoneyLab];
    
    
    [rBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.equalTo(self) ;
        make.height.mas_equalTo(120) ;
    }];
    
    
    [self.rBeginMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rBgView.mas_bottom).offset(20) ;
        make.left.equalTo(self).offset(15) ;
    }];
    
    
    [self.rSalePercentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.rBeginMoneyLab.mas_bottom) ;
        make.right.equalTo(self).offset(-15) ;
    }];
    [self.rTotalMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(middelLine.mas_top).offset(-15) ;
        make.left.equalTo(self).offset(15) ;
    }];
    
    
    [self.rRestMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(middelLine.mas_top).offset(-15) ;
        make.right.equalTo(self).offset(-15) ;
    }];
    
    
    
    [self.rFirstOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15) ;
        make.top.equalTo(self).offset(20) ;
        make.width.mas_equalTo(45) ;
        make.height.mas_equalTo(20) ;
    }] ;
    
    [self.rLastOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rFirstOrderBtn.mas_left).offset(-5) ;
        make.top.equalTo(self.rFirstOrderBtn) ;
        make.width.mas_equalTo(45) ;
        make.height.mas_equalTo(20) ;
    }] ;
    
    
    [self.rCashbackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rLastOrderBtn.mas_left).offset(-5) ;
        make.top.equalTo(self.rFirstOrderBtn)  ;
        make.width.mas_equalTo(45) ;
        make.height.mas_equalTo(20) ;
    }] ;
    
    
    [rPreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15) ;
        make.centerY.equalTo(self.rFirstOrderBtn) ;
    }] ;
    
    [self.rTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(rBgView).offset(-15) ;
    }] ;
    
    [self.rPercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.bottom.equalTo(rBgView).offset(-10) ;
    }] ;
    
    
    [middelLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rBgView.mas_bottom).offset(100) ;
        make.left.equalTo(self).offset(-1) ;
        make.right.equalTo(self).offset(1) ;
        make.height.mas_equalTo(15) ;
    }];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15) ;
        make.top.equalTo(middelLine.mas_bottom) ;
        make.bottom.equalTo(bottomLine.mas_top) ;
    }];
    
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self) ;
        make.left.equalTo(self).offset(-1) ;
        make.right.equalTo(self).offset(1) ;
        make.height.mas_equalTo(15) ;
    }];
    
}

#pragma mark- getter

- (UIButton*)rCashbackBtn {
    
    if (_rCashbackBtn == nil) {
        _rCashbackBtn = [self createButtonWithTitle:@"返现"] ;
    }
    return _rCashbackBtn ;
}

- (UIButton*)rFirstOrderBtn {
    
    if (_rFirstOrderBtn == nil) {
        _rFirstOrderBtn = [self createButtonWithTitle:@"首单"] ;
    }
    return _rFirstOrderBtn ;
}

- (UIButton*)rLastOrderBtn {
    
    if (_rLastOrderBtn == nil) {
        _rLastOrderBtn = [self createButtonWithTitle:@"尾单"] ;
    }
    return _rLastOrderBtn ;
}

-(UILabel*)rPercentLabel {
    if (_rPercentLabel == nil) {
        _rPercentLabel = [self createLabelWithTitle:@"" font:18 color:[UIColor whiteColor] align:NSTextAlignmentLeft] ;
    }
    
    return _rPercentLabel ;
}

-(UILabel*)rTimeLabel {
    if (_rTimeLabel == nil) {
        _rTimeLabel = [self createLabelWithTitle:@"期限\n12个月" font:18 color:[UIColor whiteColor] align:NSTextAlignmentRight] ;
        _rTimeLabel.numberOfLines = 2 ;
    }
    
    return _rTimeLabel ;
}


-(UILabel*)rBeginMoneyLab {
    if (_rBeginMoneyLab == nil) {
        _rBeginMoneyLab = [self createLabelWithTitle:@"起购金额 1,000元" font:14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rBeginMoneyLab ;
}

-(UILabel*)rTotalMoneyLab {
    if (_rTotalMoneyLab == nil) {
        _rTotalMoneyLab = [self createLabelWithTitle:@"募集金额 400,000元" font:14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rTotalMoneyLab ;
}

-(UILabel*)rRestMoneyLab {
    if (_rRestMoneyLab == nil) {
        _rRestMoneyLab = [self createLabelWithTitle:@"剩余可投金额 200,000元" font:14 color:kTextBlackColor align:NSTextAlignmentRight] ;
    }
    
    return _rRestMoneyLab ;
}

-(UILabel*)rSalePercentLab {
    if (_rSalePercentLab == nil) {
        _rSalePercentLab = [self createLabelWithTitle:@"已售 50.0%" font:14 color:kTextBlackColor align:NSTextAlignmentRight] ;
    }
    
    return _rSalePercentLab ;
}


- (UIButton*)createButtonWithTitle:(NSString*)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16] ;
    btn.layer.cornerRadius = 4 ;
    btn.layer.borderWidth = 1 ;
    btn.layer.borderColor = [UIColor whiteColor].CGColor ;
    [btn addTarget:self action:@selector(pvt_btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    return btn ;
}

- (UILabel*)createLabelWithTitle:(NSString*)title font:(CGFloat)font color:(UIColor*)color align:(NSTextAlignment) align{
    
    UILabel *label = [[UILabel alloc]init];
    label.text = title ;
    label.textColor = color ;
    label.font = [UIFont systemFontOfSize:font] ;
    label.textAlignment = align ;
    label.backgroundColor = [UIColor clearColor] ;
    
    return label ;
}

#pragma mark -

-(void)pvt_btnClick{
    
    if (self.delegate) {
        [self.delegate detailShowAlterView];
    }

}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end



@interface JYDetailBottomView ()

@property (nonatomic ,strong) UIButton *rBuyButton ; //立即投资
@property (nonatomic ,strong) UIButton *rBugdetButton ; //收益预估


@end

@implementation JYDetailBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor] ;
        
        self.layer.borderColor = kLineColor.CGColor ;
        self.layer.borderWidth = 1 ;
        
        
        [self addSubview:self.rBugdetButton];
        [self addSubview:self.rBuyButton];
        
        
        [self.rBugdetButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15) ;
            make.width.mas_equalTo(60) ;
            make.height.mas_equalTo(40) ;
            make.centerY.equalTo(self) ;
        }];
        
        [self.rBuyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.rBugdetButton.mas_right).offset(15) ;
            make.right.equalTo(self).offset(-15) ;
            make.height.mas_equalTo(40) ;
            make.centerY.equalTo(self) ;
        }];
        
    }
    return self;
}
-(void)layoutSubviews{
    
    
    
}


#pragma mark- getter

-(UIButton*)rBuyButton {
    
    if (_rBuyButton == nil) {
        _rBuyButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [_rBuyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        [_rBuyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rBuyButton.layer.cornerRadius = 5 ;
        _rBuyButton.clipsToBounds = YES ;
        _rBuyButton.backgroundColor = kBlueColor ;
    }
    
    return _rBuyButton ;
}


-(UIButton*)rBugdetButton {
    
    if (_rBugdetButton == nil) {
        _rBugdetButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        _rBugdetButton.backgroundColor = [UIColor orangeColor] ;
    }
    
    return _rBugdetButton ;
}





@end
