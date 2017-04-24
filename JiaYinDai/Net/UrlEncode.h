//
//  UrlEncode.h
//  Gxb
//
//  Created by 李翔 on 15/12/10.
//  Copyright © 2015年 gxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UrlEncode : NSObject
+(NSString *)encodeToPercentEscapeString:(NSString *) input;
@end
