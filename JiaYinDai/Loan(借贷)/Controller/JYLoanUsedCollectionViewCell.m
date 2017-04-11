//
//  JYLoanUsedCollectionViewCell.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/11.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoanUsedCollectionViewCell.h"

@implementation JYLoanUsedCollectionViewCell

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
    
    
    [self.contentView addSubview:self.rTitleLabel];
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }] ;
    
}

-(UILabel*)rTitleLabel{
    
    if (_rTitleLabel == nil) {
        
        _rTitleLabel = [self jyCreateLabelWithTitle:@"资金周转，诚信借贷" font:14 color:kTextBlackColor align:NSTextAlignmentCenter];
        _rTitleLabel.layer.cornerRadius = 5 ;
        _rTitleLabel.layer.borderWidth = 1 ;
        _rTitleLabel.layer.borderColor = kLineColor.CGColor ;
        _rTitleLabel.backgroundColor = [UIColor whiteColor] ;
        _rTitleLabel.clipsToBounds = YES ;
        _rTitleLabel.userInteractionEnabled = YES ;
    }
    
    return _rTitleLabel ;
}


@end


@implementation MyHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        [self addSubview:self.rTitleLabel];
        [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero) ;
        }] ;
        

        self.backgroundColor = [UIColor clearColor] ;
    }
    return self;
}

-(UILabel*)rTitleLabel{
    
    if (_rTitleLabel == nil) {
        
        _rTitleLabel = [self jyCreateLabelWithTitle:@"标题推荐" font:16 color:kTextBlackColor align:NSTextAlignmentLeft];
         _rTitleLabel.backgroundColor = [UIColor clearColor] ;
     }
    
    return _rTitleLabel ;
}

@end


