//
//  JYHTTPRequestSerializer.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/24.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYHTTPRequestSerializer.h"




NSString *const kDPHTTPErrorMessageKey = @"NSLocalizedDescription";
NSString *const kDPHTTPErrorCodeKey = @"_kCFStreamErrorCodeKey";
NSString *const kDPHTTPErrorProtobufData = @"ErrorPBData";

typedef NS_ENUM(NSInteger, DPHTTPErrorCode) {
    DPHTTPErrorCodeSessionTimeOut,
    DPHTTPErrorCodeDecryptFailure,
};



@implementation JYHTTPRequestSerializer

- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError *__autoreleasing *)error
{
    NSParameterAssert(request);
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    
    // 将参数直接拼接到URI中
    if ([self.HTTPMethodsEncodingParametersInURI containsObject:[[mutableRequest HTTPMethod] uppercaseString]]) {
        return [super requestBySerializingRequest:mutableRequest withParameters:parameters error:error];
    }
    
    //    // 判断是否登录超时
    //    NSData *key = [DPMemberManager sharedInstance].secureKey;
    //    if (key.length == 0) {
    //        if (error) {
    //            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(@"Session timeout.", @"AFNetworking", nil),
    //                                       kDPHTTPErrorMessageKey: @"登录超时, 请重新登录.",
    //                                       kDPHTTPErrorCodeKey: @(DPHTTPErrorCodeSessionTimeOut)};
    //            *error = [NSError errorWithDomain:AFURLRequestSerializationErrorDomain code:kDPHTTPRequestSerializeError userInfo:userInfo];
    //        }
    //        return nil;
    //    }
    
    // Body 组织
    if (![mutableRequest valueForHTTPHeaderField:@"Content-Type"]) {
        [mutableRequest setValue:@"secure/json" forHTTPHeaderField:@"Content-Type"];
    }
    NSMutableDictionary *dic = [self getTargetStringWithDic:parameters];
    NSData *data = nil;
//    if ([request.URL.absoluteString containsString:kSetCertificationRealName options:NSBackwardsSearch]) {    //实名认证
//        data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
//    } else
    {
        // 加密处理
        NSString *secuString = [self sessionEncryDicWithDic:dic];
        data = [secuString dataUsingEncoding:NSUTF8StringEncoding];
    }
    [mutableRequest setHTTPBody:data];
    return mutableRequest;
}


- (NSString *)sessionEncryDicWithDic:(NSMutableDictionary *)dic {
    NSString *preSignStr = [self getPreSignStringWithDic:dic];
    
    return preSignStr;
}

/**
 *  请求body转换sign
 *
 *  @param jsonDict body
 *
 *  @return 排序后的sign
 */
- (NSString *)getPreSignStringWithDic:(NSMutableDictionary *)jsonDict {
    NSMutableArray *keys = [NSMutableArray arrayWithCapacity:10];
    for (NSString *key in jsonDict.allKeys) {
        [keys addObject:key];
    }
    
    NSArray *akeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result == NSOrderedDescending;
    }];
    //    NSLog(@"%@",akeys);
    NSMutableArray *strs = [NSMutableArray arrayWithCapacity:10];
    
    for (int i = 0; i < akeys.count; i++) {
        NSString *value = [jsonDict objectForKey:akeys[i]];
        [strs addObject:akeys[i]];
        [strs addObject:value];
    }
    
    //    NSLog(@"%@",strs);
    NSString *str1;
    NSString *str2 = @"";
    for (int i = 0; i < strs.count; i++) {
        str1 = [str2 stringByAppendingString:strs[i]];
        str2 = str1;
    }
    //    NSLog(@"str2 = \n%@",str2);
    return str2;
}

/**
 *  请求body
 *
 *  @param jsonDict dody
 *
 *  @return 请求body
 */
- (NSMutableDictionary *)getTargetStringWithDic:(NSDictionary *)jsonDict {
    NSMutableDictionary *tranDic = [[NSMutableDictionary alloc] init];
    //系统版本
//    NSString *requestTm = [NSString getFormatCurrDate];
//    [tranDic setObject:APP_VERSION forKey:@"appVersion"];         // app版本号
//    [tranDic setObject:DEVICE_VESION_STR forKey:@"osVersion"];    // 客户端系统版本号
//    [tranDic setObject:@"IOS" forKey:@"termTyp"];                 // 客户端类型
//    [tranDic setObject:@"APPStore" forKey:@"channelId"];          // 客户端渠道 APPStore
//    [tranDic setObject:DEVICE_ADUUID forKey:@"termId"];           // 广告标识符
//    [tranDic setObject:requestTm forKey:@"requestTm"];            // 请求时间
//    [tranDic setObject:kClientId forKey:@"clientId"];             //
//    [tranDic setObject:[JPUSHService registrationID]?:@"" forKey:@"deviceId"];
//    
//    NSLog(@"%@",[JPUSHService registrationID]) ;
//    if (APP_DELEGATE.userLogin.tokenId.length) {
//        [tranDic setObject:APP_DELEGATE.userLogin.tokenId forKey:@"tokenId"];
//        
//    }
//    
//    for (NSString *key in jsonDict.allKeys) {
//        [tranDic setObject:[jsonDict objectForKey:key] forKey:key];
//    }
//
     return tranDic;
}


@end


@implementation JYHTTPResponseSerializer

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.acceptableContentTypes = [NSSet setWithObjects:@"application/protobuf", @"secure/protobuf", nil];
    
    return self;
}

#pragma mark - AFURLResponseSerialization

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    
         return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:error] ;
        
 }

/**
 *  NSData转JSON对象
 */

/*
- (id)decrypeJsonWithData:(NSData *)data {
    // 1. 转成字符串
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    // 2. 解密
    // 如果是加密传输在这里进行解密
    NSString *deCodeStr = [[EncryptStr getInstance] startDeencrypt:jsonStr key:kEncryptionKey];
    
    // 3. 转成json对象
    NSDictionary *diction = [NSJSONSerialization JSONObjectWithData:[deCodeStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    
    if (APP_DELEGATE.userLogin && ([diction[@"rspCd"] isEqualToString:@"U0013"] || [diction[@"rspCd"] isEqualToString:@"U0007"] || [diction[@"rspCd"] isEqualToString:@"U0009"])) {
        
        [[TMDiskCache sharedCache] removeObjectForKey:USERLOGIN_CACHE block:^(TMDiskCache *cache, NSString *key, id<NSCoding> object, NSURL *fileURL){
            
        }];
        APP_DELEGATE.userLogin = nil;
        
        
        NSString *toastString = diction[@"rspInf"] ?: @"";
        [[NSNotificationCenter defaultCenter] postNotificationName:kReLoginNotify object:@{ @"toastString" : toastString }];
        [diction setValue:kErrorLogString forKey:@"rspInf"];
    }
    
    
    
    if ([diction[@"rspCd"] isEqualToString:@"U0055"]) { //单点登录
        [[TMDiskCache sharedCache] removeObjectForKey:USERLOGIN_CACHE block:^(TMDiskCache *cache, NSString *key, id<NSCoding> object, NSURL *fileURL){
            
        }];
        APP_DELEGATE.userLogin = nil;
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kReLoginNotify object:nil];
        
        [diction setValue:kErrorLogString forKey:@"rspInf"];
    }
    
    return diction;
}
*/
@end

