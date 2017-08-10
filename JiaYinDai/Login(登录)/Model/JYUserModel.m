//
//  JYUserModel.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/28.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYUserModel.h"

@implementation JYFundInfoModel

 

@end

/*
@implementation JYCustomer

 

@end
 */

@implementation JYUserModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{

    return  YES ;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _rBankModelArr = [NSMutableArray array] ;
        
     }
    return self;
}


 
@end
