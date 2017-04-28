//
//  JYSingtonCenter.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/28.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYSingtonCenter.h"

@implementation JYSingtonCenter

static JYSingtonCenter *center = nil ;


+(instancetype) shareCenter {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[super allocWithZone:NULL]init];
    });
    
    return center ;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone {
    return [JYSingtonCenter shareCenter] ;
}


@end
