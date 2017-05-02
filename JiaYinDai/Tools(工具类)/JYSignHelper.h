//
//  JYSignHelper.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/2.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYSignHelper : NSObject

+(NSString *)jygetPreSignStringWithDic:(NSMutableDictionary *)jsonDict signKey:(NSString*) sig ;


@end
