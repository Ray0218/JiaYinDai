//
//  JYPasswodSettingVC.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/7.
//  Copyright © 2017年 嘉远控股. All rights reserved.
// 交易密码

#import "JYFatherController.h"

typedef NS_ENUM(NSUInteger, JYPassVCType) {
    JYPassVCTypeChangePass, //修改交易密码
    JYPassVCTypeSetPass, //设置交易密码
    JYPassVCTypeChangeLogPass,//修改登录密码
    JYPassVCTypeChangeTelNum, //更换手机
    JYPassVCTypeSureChangeTelNum, //更换手机确认
};

@interface JYPasswodSettingVC : JYFatherController

- (instancetype)initWithVCType:(JYPassVCType)type ;


@end
