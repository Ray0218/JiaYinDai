//
//  NSString+Extern.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/23.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "NSString+Extern.h"

@implementation NSString (Extern)

//邮箱校验(标准邮箱格式)
- (BOOL)stringCheckEmail {
    
    NSString *Regex=@"[A-Z0-9a-z._%+-]+@[A-Z0-9a-z._]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailString=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    return [emailString evaluateWithObject:self];
}


//手机格式校验(11位,数字)
- (BOOL)stringCheckMobile {
    NSString *stringTemp = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *Regex =@"(1)\\d{10}";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [mobileTest evaluateWithObject:stringTemp];
}

//身份证校验(只包含数字和字母)
- (BOOL)stringCheckIDCard{
    
    if (self.length <= 0) {
        return NO;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}


@end
