//
//  JYPasswordSetController.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/5.
//  Copyright © 2017年 嘉远控股. All rights reserved.
// 密码设置

#import "JYFatherController.h"
#import "JYLogInCell.h"

@interface JYPasswordSetController : JYFatherController

- (instancetype)initWithLogType:(JYLogFootViewType) type ;

@property (nonatomic,strong) NSString *rTelPhone ;

@end
