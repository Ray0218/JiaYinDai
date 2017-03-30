//
//  JYEstimateHeaderView.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/3/30.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYEstimateHeaderView.h"

@interface JYEstimateHeaderView (){

    UILabel *_rPreLabel ;

}


@property (nonatomic,strong)UILabel *rEndTimeLabel ; //期限
@property (nonatomic,strong)UILabel *rPercentLabel ; //预期年化

@end

static inline NSMutableAttributedString * TTPercentString( NSString*baseText,NSString *text ){
    
    NSMutableAttributedString *att = [[NSMutableAttributedString  alloc]initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:26]}] ;
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:50] range:NSMakeRange(0,baseText.length)] ;
    
    return att ;
    
} ;


@implementation JYEstimateHeaderView

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
    
    self.rPercentLabel.attributedText = TTPercentString(@"12", @"12%+2%") ;


    _rPreLabel = [self jyCreateLabelWithTitle:@"预期年化" font:18 color:[UIColor whiteColor] align:NSTextAlignmentLeft] ;
    [self addSubview:_rPreLabel];
    
    [self addSubview:self.rPercentLabel];
    [self addSubview:self.rEndTimeLabel];

 }

-(void)layoutSubviews {

    [_rPreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15) ;
        make.top.equalTo(self).offset(20) ;
    }] ;

    
    [self.rPercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.bottom.equalTo(self).offset(-10) ;
    }] ;
    
    
    [self.rEndTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(-15) ;
    }] ;

}

-(UILabel*)rPercentLabel {
    if (_rPercentLabel == nil) {
        _rPercentLabel = [self jyCreateLabelWithTitle:@"" font:18 color:[UIColor whiteColor] align:NSTextAlignmentLeft] ;
    }
    
    return _rPercentLabel ;
}

-(UILabel*)rEndTimeLabel {
    if (_rEndTimeLabel == nil) {
        _rEndTimeLabel = [self jyCreateLabelWithTitle:@"期限\n12个月" font:18 color:[UIColor whiteColor] align:NSTextAlignmentRight] ;
        _rEndTimeLabel.numberOfLines = 2 ;
    }
    
    return _rEndTimeLabel ;
}

 
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
