//
//  JYIdentifyHeader.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/17.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYIdentifyHeader.h"

@interface JYIdentifyHeader (){
    
    NSMutableArray *rTitlesArray ;
    
    JYIdentifyType rType ;
}

@property (nonatomic ,strong) UILabel *rBottomLabel ;

@property (nonatomic ,strong) UIImageView  *rProgressImage  ;

@property (nonatomic ,strong) NSMutableArray  *rImageArray  ;



@end

@implementation JYIdentifyHeader


- (instancetype)initWithType:(JYIdentifyType)type
{
    self = [super init];
    if (self) {
        
        
        rType = type ;
        
        
        [self addSubview:self.rBottomLabel];
        [self addSubview:self.rProgressImage];
        
        
        if (rType == JYIdentifyTypeName) {
            self.rBottomLabel.text = @"请提交本人真实正确信息，以免申请借贷时被驳回。" ;
            
            self.rImageArray = [NSMutableArray arrayWithCapacity:3] ;
            for (int i = 0; i < 3; i++) {
                JYAddImgView *imgView = [[JYAddImgView alloc]init] ;
                imgView.backgroundColor = [UIColor clearColor] ;
                imgView.rDeleteBtn.hidden = YES ;
                [self addSubview:imgView];
                [self.rImageArray addObject:imgView];
            }
            
            NSArray *titles = [NSArray arrayWithObjects:@"身份证正面照",@"身份证反面照",@"持证半身照", nil] ;
            rTitlesArray = [NSMutableArray arrayWithCapacity:3] ;
            for (int i = 0; i< 3 ; i++) {
                UILabel *labe= [self jyCreateLabelWithTitle:titles[i] font:14 color:kTextBlackColor align:NSTextAlignmentCenter] ;
                [self addSubview:labe];
                [rTitlesArray addObject:labe];
            }
        }else if(rType == JYIdentifyTypePassword) {
            
            self.rBottomLabel.text = @"交易密码保障交易资金安全！" ;
        }
        
        
    }
    return self;
}

-(void)layoutSubviews {
    
    [self.rProgressImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(15) ;
        make.right.equalTo(self).offset(-15) ;
        make.height.mas_equalTo(80) ;
    }] ;
    
    
    [self.rBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15) ;
        make.top.equalTo(self.rProgressImage.mas_bottom).offset(30) ;
    }] ;
    
    
    if (rType != JYIdentifyTypeName) {
        return ;
    }
    
    [self.rImageArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:5 leadSpacing:15 tailSpacing:5] ;
    
    [self.rImageArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rBottomLabel.mas_bottom).offset(15) ;
        make.height.mas_equalTo(kImageHeigh) ;
    }] ;
    
    
    [rTitlesArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:5 leadSpacing:15 tailSpacing:15] ;
    
    [rTitlesArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rBottomLabel.mas_bottom).offset(15 + kImageHeigh+10) ;
        //        make.height.mas_equalTo(kImageHeigh) ;
        //        make.bottom.equalTo(self) ;
    }] ;
    
    
    
    
    
}


#pragma mark- gerter

-(UILabel*)rBottomLabel {
    
    if (_rBottomLabel == nil) {
        _rBottomLabel = [self jyCreateLabelWithTitle:@"添加借记卡（储蓄卡）" font:16 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rBottomLabel ;
}

-(UIImageView*)rProgressImage {
    
    if (_rProgressImage == nil) {
        _rProgressImage = [[UIImageView alloc]init];
        _rProgressImage.backgroundColor = [UIColor lightGrayColor] ;
    }
    
    return _rProgressImage ;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
