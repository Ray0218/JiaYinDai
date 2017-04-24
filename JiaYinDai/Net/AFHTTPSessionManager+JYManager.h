//
//  AFHTTPSessionManager+JYManager.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/24.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface AFHTTPSessionManager (JYManager)

+ (instancetype)jy_sharedManager  ;


@end



@interface NSError (WJerror)
@property (nonatomic, copy, readonly) NSString *dp_errorMessage;
@property (nonatomic, assign, readonly) NSInteger dp_errorCode;
@property (nonatomic, assign, readonly) BOOL dp_networkError;


@end
