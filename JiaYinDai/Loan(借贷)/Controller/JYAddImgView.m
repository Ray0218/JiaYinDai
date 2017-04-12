//
//  JYAddImgView.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/11.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYAddImgView.h"

@interface JYAddImgView ()

@property (nonatomic,strong) UIImageView *rImageView ;

@property (nonatomic,strong) UIButton *rBgView ;

@property (nonatomic,strong) UIButton *rDeleteBtn  ;


@end

@implementation JYAddImgView


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self addSubview:self.rBgView];
        [self addSubview:self.rImageView];
        [self addSubview:self.rDeleteBtn];
        
    }
    return self;
}

-(void)layoutSubviews {
    
    [self.rBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(10, 0, 0, 10)) ;
    }] ;
    
    [self.rImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.rBgView) ;
        make.width.and.height.mas_equalTo(self.rBgView).offset(-5) ;
    }] ;
    
    [self.rDeleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self) ;
        make.right.equalTo(self) ;
        make.width.and.height.mas_equalTo(25) ;
    }] ;
    
}


-(UIImageView*)rImageView {
    
    if (_rImageView == nil) {
        _rImageView = [[UIImageView alloc]init];
        _rImageView.backgroundColor = [UIColor lightGrayColor] ;
        _rImageView.userInteractionEnabled = YES ;
    }
    return _rImageView ;
}

-(UIButton*)rBgView {
    
    if (_rBgView == nil) {
        _rBgView = [UIButton buttonWithType:UIButtonTypeCustom] ;
        _rBgView.backgroundColor = [UIColor greenColor] ;
    }
    
    return _rBgView ;
}

-(UIButton*)rDeleteBtn {
    if (_rDeleteBtn == nil) {
        _rDeleteBtn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure] ;
        _rDeleteBtn.backgroundColor = [UIColor clearColor] ;
    }
    
    return _rDeleteBtn ;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end



@implementation JYAddImgCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame

{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildLayout] ;
        self.contentView.backgroundColor =
        self.backgroundColor = [UIColor clearColor] ;
    }
    return self;
}


-(void)buildLayout{
    
    
    [self.contentView addSubview:self.rCellView];
    [self.rCellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }] ;
    
    
}

-(JYAddImgView*)rCellView{
    
    if (_rCellView == nil) {
        
        _rCellView = [[ JYAddImgView alloc]init];
        
        @weakify(self)
        [[_rCellView.rDeleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            
            if (self.rDeleteBlock) {
                self.rDeleteBlock(self) ;
            }
        }] ;
        
    }
    
    return _rCellView ; ;
}


@end










