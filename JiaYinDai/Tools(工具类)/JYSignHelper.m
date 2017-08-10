//
//  JYSignHelper.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/2.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYSignHelper.h"

@implementation JYSignHelper

/**
 *  对字典进行拼接 然后MD5加密
 *
 *  @param jsonDict body
 *
 *  @return 排序后的sign
 */
+(NSString *)jygetPreSignStringWithDic:(NSMutableDictionary *)jsonDict signKey:(NSString*) sig{
    
    NSArray *keyArray=[jsonDict allKeys];
    //参数按顺序按首字母升序排列,值为空的不参与签名,MD5的key值放在最后
    NSArray *resultArray=[keyArray sortedArrayUsingComparator:^NSComparisonResult(NSString *key1, NSString *key2) {
        return [key1 compare:key2];
    }];
    
    NSMutableString *paramString=[NSMutableString stringWithString:@""];
    
    //拼接成 A=B&X=Y
    for (NSString *key in resultArray) {
        if ([jsonDict[key] length]!=0) {
            [paramString appendFormat:@"&%@=%@",key,jsonDict[key]];
        }
    }
    
    //删除第一个&字符
    if ([paramString length]>1) {
        [paramString deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    
    
     
    //如果需要签名key
    if (sig.length) {
        NSString *pay_md5_key=[NSString stringWithFormat:@"%@",sig];
        [paramString appendFormat:@"&key=%@",pay_md5_key];
    }
    NSLog(@"加密前===%@",paramString);
    
    
    //md5 加密
    NSString  *signString=[ paramString jy_MD5String] ;
    return signString;
    
    return nil ;
    
    
}


@end
