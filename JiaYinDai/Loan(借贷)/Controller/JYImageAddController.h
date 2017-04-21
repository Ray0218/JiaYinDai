//
//  JYImageAddController.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/11.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYFatherController.h"


typedef NS_ENUM(NSUInteger, JYImageAddType) {
    JYImageAddTypeJob,
    JYImageAddTypeBank,
 };


@interface JYImageAddController : JYFatherController



- (instancetype)initWithType:(JYImageAddType) type ;

@end
