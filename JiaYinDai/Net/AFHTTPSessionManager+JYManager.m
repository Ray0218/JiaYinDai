//
//  AFHTTPSessionManager+JYManager.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/24.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "AFHTTPSessionManager+JYManager.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>
#import <objc/runtime.h>
#import "JYHTTPRequestSerializer.h"

const CGFloat kTimeoutIntervalForWiFi = 10;
const CGFloat kTimeoutIntervalForWWAN = 18;

@implementation AFHTTPSessionManager (JYManager)
+ (instancetype)jy_sharedManager {
    
    static AFHTTPSessionManager *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWiFi ? kTimeoutIntervalForWiFi : kTimeoutIntervalForWWAN;
        sharedManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:(NSString *)kServiceURL] sessionConfiguration:configuration];
        
        sharedManager.requestSerializer = [[JYHTTPRequestSerializer alloc] init];
        sharedManager.responseSerializer = [[JYHTTPResponseSerializer alloc] init];
        
        //设置支持https,非校验证书模式
        sharedManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        sharedManager.securityPolicy.allowInvalidCertificates = YES;
        [sharedManager.securityPolicy setValidatesDomainName:NO];
        
    });
    return sharedManager;
}



- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:&serializationError];
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self dataTaskWithRequest:request
                          uploadProgress:uploadProgress
                        downloadProgress:downloadProgress
                       completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
                           
                           
                           
                           if (error) {
                               if (failure) {
                                   failure(dataTask, error);
                               }
                           } else {
                               
                               
                               if (success) {
                                   success(dataTask, responseObject);
                               }
                           }
                           
                           
                           
                           if ([responseObject[@"rspCd"] isEqualToString:@"00000"]) {    // 请求成功
                               
                               if (success) {
                                   success(dataTask, responseObject);
                               }
                           }else{
                               
                               
                               
                               //                                    [SVProgressHUD showErrorWithStatus:responseObject[@"rspInf"]];
                           }
                           
                           
                       }];
    
    return dataTask;
}




@end


@implementation NSError (WJerror)

- (BOOL)dp_networkError {
    if (self.dp_errorCode != 0) {
        return NO;
    }
    return YES;
}

- (NSInteger)dp_errorCode {
    return [self.userInfo[kDPHTTPErrorCodeKey] integerValue];
}

- (NSString *)dp_errorMessage {
    
    if(![AFNetworkReachabilityManager sharedManager].reachable){
        return @"星主，网络不给力呀~";
        
    }
    switch (self.code) {
        case NSURLErrorCancelled:
            return nil;
        case NSURLErrorTimedOut:
            return @"网络请求超时";
        case NSURLErrorNotConnectedToInternet:
            return @"星主，网络不给力呀~";
        case NSURLErrorCannotConnectToHost:
            //            return @"网络请求失败";
            return @"星主，网络不给力呀~";
        default:
            return self.userInfo[kDPHTTPErrorMessageKey];
    }
}

- (NSData *)dp_errorProtobuf {
    return self.userInfo[kDPHTTPErrorProtobufData];
}

@end





