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
    
    // Body 组织
    if (![mutableRequest valueForHTTPHeaderField:@"Content-Type"]) {
        //        [mutableRequest setValue:@"secure/json" forHTTPHeaderField:@"Content-Type"];
        //        [mutableRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [mutableRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    }
    
    
    NSMutableDictionary *dic = [self getTargetStringWithDic:parameters];
    NSData *data = nil;
    
    // 加密处理
    NSDictionary *secDic = [self sessionEncryDicWithDic:dic];
    
    data = [ NSJSONSerialization dataWithJSONObject:secDic options:NSJSONWritingPrettyPrinted error:nil] ;
    
    
    [mutableRequest setHTTPBody:data];
    return mutableRequest;
}


- (NSDictionary *)sessionEncryDicWithDic:(NSMutableDictionary *)dic {
    
    NSString *preSignStr = [ self getPreSignStringWithDic:dic signKey:@"65846b8c29154b3ef911e913f9e2205d"];
    
    NSMutableDictionary * dataDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [dataDic setObject:preSignStr forKey:@"sign" ] ;
    
    
    return [dataDic copy] ;
    
    
}

/**
 *  请求body转换sign
 *
 *  @param jsonDict body
 *
 *  @return 排序后的sign
 */
- (NSString *)getPreSignStringWithDic:(NSMutableDictionary *)jsonDict signKey:(NSString*) sig{
    
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
    
    //如果是md5加密 给paramString后面添加 MD5 key
    if (sig) {
        NSString *pay_md5_key=[NSString stringWithFormat:@"%@",sig];
        [paramString appendFormat:@"&key=%@",pay_md5_key];
    }
    NSLog(@"加密前===%@",paramString);
    
    
    //md5 加密
    NSString  *signString=[ paramString jy_MD5String] ;
    return signString;
    
    return nil ;
    
    
}

/**
 *  请求body
 *
 *  @param jsonDict dody
 *
 *  @return 请求body
 */
- (NSMutableDictionary *)getTargetStringWithDic:(NSDictionary *)jsonDict {
    NSMutableDictionary *tranDic = [NSMutableDictionary  dictionaryWithDictionary:jsonDict];
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    long long totalMilliseconds = interval*1000 ;
    [tranDic setValue:[NSString stringWithFormat:@"%lld",totalMilliseconds] forKey:@"timestamp"] ;
    
    
    
    
    return [tranDic copy];
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

