//
//  JYSingtonCenter.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/28.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYSingtonCenter.h"
#import "JYLogInViewController.h"
#import "JPUSHService.h"
#import <sys/utsname.h>

@implementation JYSingtonCenter

static JYSingtonCenter *center = nil ;


+(instancetype) shareCenter {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[super allocWithZone:NULL]init];
    });
    
    return center ;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone {
    return [JYSingtonCenter shareCenter] ;
}



-(void)pvt_autoLoginSuccess:(void (^)())logsuccess failure:(void (^)( ))logfailure
{
    
    
    NSDate *lastLogTime = (NSDate*)[[TMDiskCache sharedCache]objectForKey:kLogInTimeCache] ;
    
    
    NSTimeInterval ttimetevel = [[NSDate date] timeIntervalSince1970] -[lastLogTime timeIntervalSince1970] ;
    
     if ( ttimetevel > 6*24*60*60) {
        
          if (logfailure) {
             logfailure() ;
         }
         
         return ;
    }
    
    
    NSString *telNumStr = [JYSingtonCenter shareCenter].rUserModel.cellphone ;
    
    if (telNumStr.length <= 0 ) {
        
        telNumStr = (NSString*)[[TMDiskCache sharedCache]objectForKey:kTelNumCache];
        
        if (telNumStr.length <= 0 ) {

            NSArray *arr =  [SSKeychain accountsForService:kSSKeyService ] ;
            
            if (arr.count) {
                
                telNumStr =  arr.lastObject[@"acct"] ;
                
            }
        }
        
    }
    
    if (telNumStr.length <= 0) {
        if (logfailure) {
            logfailure() ;
        }
        return ;
    }
    
    
    
    NSString *passStr = [SSKeychain passwordForService:kSSKeyService account:telNumStr] ;
    
    if (passStr.length <= 0) {
        if (logfailure) {
            logfailure() ;
        }
        return ;
    }
    
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
    [dic setValue:telNumStr forKey:@"cellphone"];
    [dic setValue:passStr forKey:@"password"] ;
    
     [[AFHTTPSessionManager jy_sharedManager ] POST:kLogInURL parameters:dic  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dataDic = responseObject[@"data"] ;
        
        
        [JYSingtonCenter shareCenter].rUserModel =  [[JYUserModel alloc]initWithDictionary:dataDic error:nil];
        
        
        [JPUSHService setTags:nil aliasInbackground:[JYSingtonCenter shareCenter].rUserModel.cellphone] ;
        
         
         [[TMDiskCache sharedCache]setObject:[NSDate date] forKey:kLogInTimeCache];

        
        if (logsuccess) {
            logsuccess();
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (logfailure) {
            logfailure() ;
        }
        
    }] ;
    
}


 



// 获取设备型号然后手动转化为对应名称
+ (NSString *)getDeviceName
{
    // 需要#import "sys/utsname.h"
     struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7 Plus";
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    if ([deviceString isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
    if ([deviceString isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceString;
}

 
@end
