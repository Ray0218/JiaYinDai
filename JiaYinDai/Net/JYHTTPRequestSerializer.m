//
//  JYHTTPRequestSerializer.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/24.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYHTTPRequestSerializer.h"
#import "JYSignHelper.h"



NSString *const kDPHTTPErrorMessageKey = @"NSLocalizedDescription";
NSString *const kDPHTTPErrorCodeKey = @"_kCFStreamErrorCodeKey";
NSString *const kDPHTTPErrorProtobufData = @"ErrorPBData";

typedef NS_ENUM(NSInteger, DPHTTPErrorCode) {
    DPHTTPErrorCodeSessionTimeOut,
    DPHTTPErrorCodeDecryptFailure,
};



@implementation JYHTTPRequestSerializer


#pragma mark - AFURLRequestSerialization



- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError *__autoreleasing *)error
{
    
    
    NSParameterAssert(request);
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    
    [self.HTTPRequestHeaders enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
        if (![request valueForHTTPHeaderField:field]) {
            
            
            if ([field isEqualToString:@"User-Agent"]) {
                
                NSString *valueStr = (NSString*)value ;
                valueStr = [valueStr stringByReplacingOccurrencesOfString:@"iPhone" withString:[JYSingtonCenter getDeviceName]] ;
                [mutableRequest setValue:valueStr forHTTPHeaderField:field];
                
            }else
                
                [mutableRequest setValue:value forHTTPHeaderField:field];
        }
    }];
    
    
    NSMutableDictionary *oriDic = [NSMutableDictionary dictionaryWithDictionary:parameters] ;
    
    NSString *contentType = oriDic[kRequestJsonType] ;
    
    if (contentType && contentType.length) {
        [mutableRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        [oriDic removeObjectForKey:kRequestJsonType] ;
        
    }else{
        
        [mutableRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
    }
    
    
    if (![mutableRequest valueForHTTPHeaderField:@"Content-Type"]) {
        [mutableRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
    }
    
    
    NSString *query = nil ;
    
    if (oriDic) {
        
        
        oriDic = [self getTargetStringWithDic:oriDic];
        //加密
        oriDic = [self sessionEncryDicWithDic:oriDic];
        
        query = AFQueryStringFromParameters(oriDic);
        
    }
    
    
    if (!query) {
        query = @"";
    }
    
    
    
    
    NSString *contentString = [mutableRequest valueForHTTPHeaderField:@"Content-Type"] ;
    
    if ([contentString isEqualToString:@"application/json"]) {
        
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:oriDic options:NSJSONWritingPrettyPrinted error:nil] ;
        
        [mutableRequest setHTTPBody:data];
        
    }else{
        
        
        [mutableRequest setHTTPBody:[query dataUsingEncoding:self.stringEncoding]];
    }
    
    return mutableRequest ;
    
}


- (NSMutableDictionary *)sessionEncryDicWithDic:(NSMutableDictionary *)dict {
    
    
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionaryWithDictionary:dict] ;
    
    NSString *signKey = jsonDict[@"key"] ;
    
    if (signKey) {
        
        [jsonDict removeObjectForKey:@"key"] ;
        
        NSString *preSignStr = [ JYSignHelper jygetPreSignStringWithDic:jsonDict signKey:signKey];
        
        
        [jsonDict setObject:preSignStr forKey:@"sign" ] ;
    }
    
    
    return [jsonDict copy] ;
    
    
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

@end

