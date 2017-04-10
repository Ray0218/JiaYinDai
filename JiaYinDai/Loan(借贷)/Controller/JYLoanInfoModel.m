//
//  JYLoanInfoModel.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/10.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoanInfoModel.h"

@implementation JYLoanInfoModel

+(BOOL)propertyIsIgnored:(NSString *)propertyName {
    return YES ;
}

- (instancetype)initWithLeft:(NSString*)left right:(NSString*)right
{
    self = [super init];
    if (self) {
        self.rLeftString = left ;
        self.rRightString = right ;
    }
    return self;
}

@end
