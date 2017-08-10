//
//  JYLoactionManager.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/9.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^JYLoactionBlock)(NSString *address);

@interface JYLoactionManager : NSObject

+(instancetype)shareManager  ;
 
- (void)startLocationComplete:(JYLoactionBlock) complete  ;


@end
