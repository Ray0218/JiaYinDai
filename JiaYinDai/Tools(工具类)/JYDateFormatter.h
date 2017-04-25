//
//  JYDateFormatter.h
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/22.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, JYDateFormatType) {
    JYDateFormatTypeYMD,//年月日
    JYDateFormatTypeYMDHM,//年月日时分
    JYDateFormatTypeYMDHMS,////年月日时分秒
    JYDateFormatTypeYMDHMSS,////年月日时分秒毫秒

};


@interface JYDateFormatter : NSObject

+(instancetype)shareFormatter  ;

-(NSDateFormatter *)jy_getFormatterWithType:(JYDateFormatType)type ;


@end
