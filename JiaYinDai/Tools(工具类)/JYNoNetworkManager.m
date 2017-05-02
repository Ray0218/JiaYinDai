//
//  JYNoNetworkManager.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/23.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYNoNetworkManager.h"

static JYNoNetworkManager *_manager = nil ;

@interface JYNoNetworkManager ()

@property (nonatomic,strong) UILabel *rNoNetLabel ;

@end

@implementation JYNoNetworkManager

+(instancetype)shareManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[super allocWithZone:NULL]init];
    });
    return _manager ;
    
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    return [JYNoNetworkManager shareManager] ;
}



-(UILabel*)rNoNetLabel {
    if (_rNoNetLabel == nil) {
        _rNoNetLabel = [[UILabel alloc] init];
        _rNoNetLabel.textAlignment = NSTextAlignmentCenter;
        _rNoNetLabel.text=@"暂无网络连接，请检查您的网络设置！";
        _rNoNetLabel.textColor=[UIColor colorWithRed:((Byte)(0x6d6d6d >> 16))/255.0 green:((Byte)(0x6d6d6d >> 8))/255.0 blue:((Byte)0x6d6d6d)/255.0 alpha:1];
        _rNoNetLabel.font=[UIFont systemFontOfSize:12];
        _rNoNetLabel.backgroundColor =  [UIColor colorWithRed:1.00 green:0.99 blue:0.27 alpha:0.6] ;//[UIColor yellowColor] ;
    }
    return _rNoNetLabel ;
}



@end
