//
//  JYAgreeView.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/27.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYAgreeView.h"

@interface JYAgreeView ()

@property (nonatomic ,strong) UIButton *rAgreeBtn;


@property (nonatomic ,strong) UIButton *rImageButton;



@end

@implementation JYAgreeView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.rImageButton];
        [self addSubview:self.rAgreeBtn];
        
    }
    return self;
}

-(void)layoutSubviews {
    
    [self.rImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self) ;
        
        make.centerY.equalTo(self) ;
        make.height.equalTo(self ) ;
        
        make.width.mas_equalTo(30) ;
    }] ;
    
    
    [self.rAgreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self) ;
        make.height.mas_equalTo(self) ;
        make.left.equalTo(self.rImageButton.mas_right).offset(5) ;
        
        make.right.equalTo(self) ;
    }] ;
    
}


-(UIButton*)rAgreeBtn {
    
    if (_rAgreeBtn == nil) {
        _rAgreeBtn =  ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
            btn.titleLabel.font = [UIFont systemFontOfSize:12] ;
            btn.backgroundColor = [UIColor clearColor] ;
            
            NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:@"阅读并同意嘉银贷《用户使用协议》" attributes:@{NSForegroundColorAttributeName:kTextBlackColor,NSFontAttributeName:[UIFont systemFontOfSize:12]}] ;
            
            NSRange rang = [attString.string rangeOfString:@"《用户使用协议》"] ;
            
            [attString addAttribute:NSForegroundColorAttributeName value:kBlueColor range:rang] ;
            [btn setAttributedTitle:attString forState:UIControlStateNormal];
            
            btn.backgroundColor = [UIColor clearColor] ;
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
            btn ;
            
        }) ;
    }
    
    return _rAgreeBtn ;
}


-(UIButton*)rImageButton {
    
    if (_rImageButton == nil) {
        _rImageButton =  ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
            btn.backgroundColor = [UIColor clearColor] ;
            [btn setImage:[UIImage imageNamed:@"comm_normal"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"comm_agree"] forState:UIControlStateSelected] ;
            
            btn.imageView.contentMode = UIViewContentModeCenter ;
            
            btn.backgroundColor = [UIColor clearColor] ;
            btn.selected = YES ;
            btn ;
            
        }) ;
        
        
        [[_rImageButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton* x) {
            
            x.selected = !x.selected ;
            
        }] ;
    }
    
    return _rImageButton ;
}



@end
