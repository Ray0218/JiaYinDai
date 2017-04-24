//
//  UrlEncode.m
//  Gxb
//
//  Created by 李翔 on 15/12/10.
//  Copyright © 2015年 gxb. All rights reserved.
//

#import "UrlEncode.h"

@implementation UrlEncode
+(NSString *)encodeToPercentEscapeString: (NSString *) input
{
    NSString* outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef)input,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8);
    return outputStr;
//    NSString *outputStr = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)input,NULL,CFSTR(":/?#[]@!$&’()*+,;="),kCFStringEncodingUTF8));//  // 确定 parameter 字符串中含有:/?#[]@!$&’()*+,;=这些字符时候，这些字符需要被转化，以免与语法冲突。
//    return outputStr;
}

@end
