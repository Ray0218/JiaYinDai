//
//  JYHTTPRequestSerializer.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/24.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface JYHTTPRequestSerializer : AFJSONRequestSerializer

@end


@interface JYHTTPResponseSerializer  : AFJSONResponseSerializer

@end

extern NSInteger const kDPHTTPResponseSerializerError;
extern NSString *const kDPHTTPErrorMessageKey;
extern NSString *const kDPHTTPErrorCodeKey;
extern NSString *const kDPHTTPErrorProtobufData;
