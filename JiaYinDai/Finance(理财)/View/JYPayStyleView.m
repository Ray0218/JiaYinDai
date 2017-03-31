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
            make.height.mas_equalTo(45)  ;
            make.top.equalTo(self.rLimitLab.mas_bottom) ;
            make.bottom.equalTo(self)  ;
        }];
    }else{
        
        [self.rRedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(-1) ;
            make.right.equalTo(self).offset(1) ;
            make.height.mas_equalTo(45)  ;
            make.top.equalTo(self.rPayStyleView.mas_bottom).offset(-1) ;
            make.bottom.equalTo(self)  ;
        }];
    }
    
}

#pragma mark -getter

-(JYBuyRowView*)rRedView {
    if (_rRedView == nil) {
        _rRedView = [[JYBuyRowView alloc]initWithLeftTitle:@"选择红包" rowType:JYRowTypeNormal];
    }
    
    return _rRedView ;
}

-(JYBuyRowView*)rPayStyleView {
    if (_rPayStyleView == nil) {
        
        if (rType == JYPayTypeNormal) {
            _rPayStyleView = [[JYBuyRowView alloc]initWithLeftTitle:@"支付方式" rowType:JYRowTypeNormal];
            
        }else{
            _rPayStyleView = [[JYBuyRowView alloc]initWithLeftTitle:@"支付方式" rowType:JYRowTypeBankIcon];
        }
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
    
    UIView *rMidLine ;
    UIImageView *rRightView ;
    
    JYRowType rRowType ;
    
}

@property (nonatomic ,strong)UITextField *rTextField ;
@property (nonatomic ,strong)UILabel *rRightLabel ;
@property (nonatomic ,strong)UIImageView *rImgView ;


@end

@implementation JYBuyRowView


- (instancetype)initWithLeftTitle:(NSString*)leftStr rowType:(JYRowType)rowType
{
    self = [super init];
    if (self) {
        
        rRowType = rowType ;
        self.backgroundColor = [UIColor whiteColor] ;
        self.layer.borderColor = kLineColor.CGColor ;
        self.layer.borderWidth = 1 ;
        [self buildSubViewsWithLeft:leftStr type:rowType];
        
        
        
    }
    return self;
}



-(void)buildSubViewsWithLeft:(NSString*)leftStr type:(JYRowType)type {
    
    rLeftLab = [self jyCreateLabelWithTitle:leftStr font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    [self addSubview:rLeftLab];
    
    rMidLine = [[UIView alloc]init];
    rMidLine.backgroundColor = kLineColor ;
    [self addSubview:rMidLine] ;
    
    if (type == JYRowTypeTextField) {
        [self addSubview:self.rTextField];
    }else {
        rRightView = [[UIImageView alloc]init];
        rRightView.image = [UIImage imageNamed:@"more"] ;
        
        [self addSubview:self.rRightLabel];
        [self addSubview:rRightView];
        
        self.rRightLabel.text = @"账户余额" ;
        if (type == JYRowTypeBankIcon){
            [self addSubview:self.rImgView];
        }
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
    
    
    if (rRowType == JYRowTypeTextField) {
        [self.rTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rMidLine.mas_right).offset(25) ;
            make.centerY.equalTo(self) ;
            make.right.equalTo(self).offset(-15);
        }];
    }else{
        
        [rRightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15) ;
            make.centerY.equalTo(self) ;
        }];
        
        if (rRowType == JYRowTypeBankIcon) {
            
            [self.rImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(rMidLine.mas_right).offset(25) ;
                make.centerY.equalTo(self);
                make.width.and.height.mas_greaterThanOrEqualTo(25) ;
            }] ;
            
            [self.rRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.rImgView.mas_right).offset(10) ;
                make.centerY.equalTo(self);
            }];
            
        }else{
            [self.rRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(rMidLine.mas_right).offset(25) ;
                make.centerY.equalTo(self);
            }];
        }
    }
    
    
}

#pragma mark- getter


-(UITextField*)rTextField {
    if (_rTextField == nil) {
        _rTextField = [[UITextField alloc]init];
        
    }
    return _rTextField ;
}

-(UILabel*)rRightLabel {
    
    if (_rRightLabel == nil) {
        _rRightLabel = [self jyCreateLabelWithTitle:@"" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rRightLabel ;
}

-(UIImageView*)rImgView {
    if (_rImgView == nil) {
        _rImgView = [[UIImageView alloc]init];
        _rImgView.backgroundColor = [UIColor orangeColor] ;
    }
    return _rImgView ;
}

@end




