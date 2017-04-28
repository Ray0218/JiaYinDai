//
//  JYSingtonCenter.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/28.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYUserModel.h"

@interface JYSingtonCenter : NSObject

+(instancetype) shareCenter  ;

@property (nonatomic ,strong) JYUserModel *rUserModel ;

@end
