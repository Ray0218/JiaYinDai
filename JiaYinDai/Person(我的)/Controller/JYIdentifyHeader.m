//
//  JYIdentifyHeader.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/17.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYIdentifyHeader.h"

@interface JYIdentifyHeader ()

@property (nonatomic ,strong) UILabel *rBottomLabel ;

@property (nonatomic ,strong) UIImageView  *rProgressImage  ;


@end

@implementation JYIdentifyHeader


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


#pragma mark- gerter

-(UILabel*)rBottomLabel {

    if (_rBottomLabel == nil) {
        _rBottomLabel = [self jyCreateLabelWithTitle:@"添加借记卡（储蓄卡）" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rBottomLabel ;
}

-(UIImageView*)rProgressImage {

    if (_rProgressImage == nil) {
        _rProgressImage = [[UIImageView alloc]init];
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
