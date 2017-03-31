//
//  JYPayStyleView.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/3/31.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPayStyleView.h"

@interface JYPayStyleView (){

    JYPayType rType ;
}

@property (nonatomic,strong)JYBuyRowView *rRedView ; //红包
@property (nonatomic,strong)JYBuyRowView *rPayStyleView ; //支付方式

@property (nonatomic,strong)UILabel *rLimitLab ; //单笔限额
@property (nonatomic,strong)UILabel *rTotalLimitLab ; //每日限额


@end

@implementation JYPayStyleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self buildSubViewsWithType:JYPayTypeAddBank] ;
        rType = JYPayTypeAddBank ;
    }
    return self;
}

- (instancetype)initWithType:(JYPayType)type
{
    self = [super init];
    if (self) {
        
        rType = type ;
        [self buildSubViewsWithType:type] ;
    }
    return self;
}


-(void)buildSubViewsWithType:(JYPayType)type {

    [self addSubview:self.rPayStyleView];
    [self addSubview:self.rRedView];
    
    if (type == JYPayTypeAddBank) {
        [self addSubview:self.rLimitLab];
        [self addSubview:self.rTotalLimitLab];
    }

}

-(void)layoutSubviews {

    [self.rPayStyleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(-1) ;
        make.right.equalTo(self).offset(1) ;
        make.height.mas_equalTo(45) ;
        make.top.equalTo(self) ;
    }];
    
    
    
    if (rType == JYPayTypeAddBank) {
         [self.rLimitLab mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(self).offset(15)  ;
              make.height.mas_equalTo(35) ;
             make.top.equalTo(self.rPayStyleView.mas_bottom) ;
             make.bottom.equalTo(self.rRedView.mas_top) ;
          }] ;
        
        [self.rTotalLimitLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15)  ;
            make.height.mas_equalTo(35) ;
            make.top.equalTo(self.rPayStyleView.mas_bottom) ;
            make.bottom.equalTo(self.rRedView.mas_top) ;
        }] ;
        
        [self.rRedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(-1) ;
            make.right.equalTo(self).offset(1) ;
            make.height.mas_equalTo(45) ;
            make.top.equalTo(self.rLimitLab.mas_bottom) ;
            make.bottom.equalTo(self) ;
        }];
    }else{
    
        [self.rRedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(-1) ;
            make.right.equalTo(self).offset(1) ;
            make.height.mas_equalTo(45) ;
            make.top.equalTo(self.rPayStyleView.mas_bottom).offset(-1) ;
            make.bottom.equalTo(self) ;
        }];
    }

}

#pragma mark -getter 

-(JYBuyRowView*)rRedView {
    if (_rRedView == nil) {
        _rRedView = [[JYBuyRowView alloc]initWithLeftTitle:@"选择红包" rightStr:@"选择  红包/抵用券"];
    }
    
    return _rRedView ;
}

-(JYBuyRowView*)rPayStyleView {
    if (_rPayStyleView == nil) {
        _rPayStyleView = [[JYBuyRowView alloc]initWithLeftTitle:@"支付方式" rightStr:@"选择  余额/银行卡"];
     }
    
    return _rPayStyleView ;
}

-(UILabel*)rLimitLab {
    if (_rLimitLab == nil) {
        _rLimitLab = [self jyCreateLabelWithTitle:@"单笔限额：5,000元" font:16 color:kTextBlackColor align:NSTextAlignmentLeft];
    }
    
    return _rLimitLab ;
}

-(UILabel*)rTotalLimitLab {

    if (_rTotalLimitLab == nil) {
        _rTotalLimitLab = [self jyCreateLabelWithTitle:@"每日限额：10,000元" font:16 color:kTextBlackColor align:NSTextAlignmentRight] ;
    }
    
    return _rTotalLimitLab ;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end



@interface JYBuyRowView (){
    
    UILabel *rLeftLab ;
    UILabel *rRightLab ;
    
    UIView *rMidLine ;
    UIImageView *rRightView ;
    
}

@property (nonatomic ,strong)UITextField *rTextField ;

@end

@implementation JYBuyRowView

- (instancetype)initWithLeftTitle:(NSString*)leftStr rightStr:(NSString*)rightStr
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor] ;
        self.layer.borderColor = kLineColor.CGColor ;
        self.layer.borderWidth = 1 ;
        [self buildSubViewsWithLeft:leftStr right:rightStr];
    }
    return self;
}


-(void)buildSubViewsWithLeft:(NSString*)leftStr right:(NSString*)rightStr {
    
    rLeftLab = [self jyCreateLabelWithTitle:leftStr font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    [self addSubview:rLeftLab];
    
    rMidLine = [[UIView alloc]init];
    rMidLine.backgroundColor = kLineColor ;
    [self addSubview:rMidLine] ;
    
    
    if (rightStr.length) {
        rRightLab = [self jyCreateLabelWithTitle:rightStr font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
        rRightView = [[UIImageView alloc]init];
        rRightView.image = [UIImage imageNamed:@"more"] ;
        [self addSubview:rRightLab];
        [self addSubview:rRightView];
    }else{
        
        [self addSubview:self.rTextField];
    }
    
    
}


-(void)layoutSubviews {
    
    [rLeftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15) ;
        make.centerY.equalTo(self) ;
    }];
    
    [rMidLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rLeftLab.mas_right).offset(25) ;
        make.top.equalTo(self).offset(10) ;
        make.bottom.equalTo(self).offset(-10).priorityLow() ;
        make.width.mas_equalTo(1) ;
    }] ;
    
    
    if (rRightLab) {
        [rRightLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rMidLine.mas_right).offset(25) ;
            make.centerY.equalTo(self);
        }];
        
        [rRightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15) ;
            make.centerY.equalTo(self) ;
        }];
    }else{
        
        [self.rTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rMidLine.mas_right).offset(25) ;
            make.centerY.equalTo(self) ;
            make.right.equalTo(self).offset(-15);
        }];
    }
}

-(UITextField*)rTextField {
    if (_rTextField == nil) {
        _rTextField = [[UITextField alloc]init];
        
    }
    return _rTextField ;
}

@end




