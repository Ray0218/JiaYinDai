//
//  JYLoanDetailHeader.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/12.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoanDetailHeader.h"

@interface JYLoanDetailHeader ()

@property (nonatomic ,strong) UILabel *rMoneyLabel ;

@end

@implementation JYLoanDetailHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = kBlueColor ;
    }
    return self;
}

#pragma mark- getter

-(UILabel*)rMoneyLabel {

    if (_rMoneyLabel == nil) {
        _rMoneyLabel = [self jyCreateLabelWithTitle:@"10000.00" font:24 color:[UIColor whiteColor] align:NSTextAlignmentRight] ;
    }
    
    return _rMoneyLabel ;
}

 // Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
    
    
}

@end
