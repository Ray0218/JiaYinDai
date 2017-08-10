//
//  JYMessageVController.h
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/23.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYFatherController.h"

@interface JYMessageVController : JYFatherController

@end



typedef NS_ENUM(NSUInteger, JYMessType) {
    JYMessTypeMessage,//消息
    JYMessTypeNote, //公告
 };

@interface JYMessageDetailController : JYFatherController

@property (nonatomic ,strong) NSString *rId ;

- (instancetype)initWithType:(JYMessType) type ;


@end
