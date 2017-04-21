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


@property (nonatomic ,strong) NSMutableArray  *rImageArray  ;


@property (nonatomic ,strong) NSMutableArray  *rProgressImgArr  ;



@property (nonatomic ,strong) UIProgressView  *rProgressView  ;



@end

@implementation JYIdentifyHeader


- (instancetype)initWithType:(JYIdentifyType)type
{
    self = [super init];
    if (self) {
        
        
        rType = type ;
        
        
        [self addSubview:self.rBottomLabel];
        [self addSubview:self.rProgressView];
        
        NSString *proTitles[] = {@"实名认证",@"银行卡验证",@"设置交易密码"} ;
        
        self.rProgressImgArr = [NSMutableArray arrayWithCapacity:3] ;
        for (int i =0 ; i < 3; i++) {
            JYImageLabe *view = [[JYImageLabe alloc]init];
            view.rLabel.text = proTitles[i] ;
            view.backgroundColor = [UIColor clearColor] ;
            [self addSubview:view] ;
            [self.rProgressImgArr addObject:view];
        }
        
        
        
        if (rType == JYIdentifyTypeName) {
            
            JYImageLabe *imgLabel = self.rProgressImgArr[0] ;
            imgLabel.rImageView.image = [UIImage imageNamed:@"imp_name"] ;
            self.rProgressView.progress = 0.13 ;
            imgLabel.rHighlighted = YES ;
            
            self.rBottomLabel.text = @"请提交本人真实正确信息，以免申请借贷时被驳回。" ;
            
            self.rImageArray = [NSMutableArray arrayWithCapacity:3] ;
            NSString *image[] = {@"ident_front",@"ident_back",@"ident_half"} ;
            for (int i = 0; i < 3; i++) {
                JYAddImgView *imgView = [[JYAddImgView alloc]init] ;
                imgView.rDeleteBtn.hidden = YES ;
                imgView.rImageView.image = [UIImage imageNamed:image[i]] ;
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
            
            JYImageLabe *imgLabel = self.rProgressImgArr[2] ;
            imgLabel.rImageView.image = [UIImage imageNamed:@"ident_pass"] ;
            self.rProgressView.progress = 1 ;
            imgLabel.rHighlighted = YES ;
            
            JYImageLabe *imgLabel0 = self.rProgressImgArr[0] ;
            imgLabel0.rHighlighted = YES ;
            JYImageLabe *imgLabel1 = self.rProgressImgArr[1] ;
            imgLabel1.rHighlighted = YES ;
            
        }else{
            JYImageLabe *imgLabel = self.rProgressImgArr[1] ;
            imgLabel.rImageView.image = [UIImage imageNamed:@"ident_bank"] ;
            self.rProgressView.progress = 0.6;
            imgLabel.rHighlighted = YES ;
            
            JYImageLabe *imgLabel0 = self.rProgressImgArr[0] ;
            imgLabel0.rHighlighted = YES ;
            
        }
        
        
    }
    return self;
}

-(void)layoutSubviews {
    
    
    
    [self.rProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(25) ;
        make.left.equalTo(self).offset(45) ;
        make.right.equalTo(self).offset(-45) ;
        make.height.mas_equalTo(2) ;
    }] ;
    
    
    [self.rProgressImgArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:25 leadSpacing:45 tailSpacing:45] ;
    [self.rProgressImgArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rProgressView.mas_centerY).offset(-13) ;
    }] ;
    
    
    
    [self.rBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15) ;
        make.top.equalTo(self.rProgressView.mas_bottom).offset(60) ;
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


-(UIProgressView*)rProgressView {
    
    if (_rProgressView == nil) {
        _rProgressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar] ;
        _rProgressView.trackTintColor = [UIColor lightGrayColor] ;
        _rProgressView.tintColor =kBlueColor ;
        
        _rProgressView.progress = 0.5 ;
    }
    return _rProgressView ;
    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end


@implementation JYImageLabe

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview: self.rImageView];
        [self addSubview:self.rLabel];
    }
    return self;
}

-(void)layoutSubviews {
    
    [self.rImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self) ;
        make.centerX.equalTo(self) ;
        make.width.height.mas_equalTo(25) ;
    }];
    
    [self.rLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self) ;
        make.bottom.equalTo(self) ;
        make.top.equalTo(self.rImageView.mas_bottom).offset(10) ;
    }] ;
}

-(void)setRHighlighted:(BOOL)rHighlighted {
    
    if (rHighlighted) {
        self.rLabel.textColor = kBlueColor ;
        
    }
    
    
}

-(UILabel*)rLabel {
    
    if (_rLabel == nil) {
        _rLabel = [self jyCreateLabelWithTitle:@"" font:13 color:kTextBlackColor align:NSTextAlignmentCenter] ;
    }
    
    return _rLabel ;
}

-(UIImageView*)rImageView {
    
    if (_rImageView == nil) {
        _rImageView = [[UIImageView alloc]init];
        _rImageView.backgroundColor = [UIColor orangeColor] ;
    }
    
    return _rImageView ;
}

@end



