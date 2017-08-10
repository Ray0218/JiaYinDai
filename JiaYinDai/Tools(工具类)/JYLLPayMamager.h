//
//  JYLLPayMamager.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/2.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYLLPayMamager : NSObject


+ (NSDictionary *)jycreateJiaYuanRechargeOrderWithOrderNO:(NSString *)orderNO moneyNO:(NSString *)moneyNO userName:(NSString *)userName  userIdNO:(NSString *)userIdNO bankCardNO:(NSString *)bankCardNO bankNO:(NSString *)bankNO notifyURL:(NSString*) notifyStr ;

+ (NSDictionary *)jyBankServiceWithUserName:(NSString *)userName userIdNO:(NSString *)userIdNO bankCardNO:(NSString *)bankCardNO   sig:(NSString *)sig ;


 



@end



//开启改宏定义,系统进入测试环境配置;关闭该宏定义,系统进入生产环境(线上)
#define JIAYUANBANK_TESTING   "testing environment"

#ifdef JIAYUANBANK_TESTING

 
#else

#endif
