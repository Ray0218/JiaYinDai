//
//  NSString+Extern.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/23.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "NSString+Extern.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (Extern)

//邮箱校验(标准邮箱格式)
- (BOOL)jy_stringCheckEmail {
    
    NSString *Regex=@"[A-Z0-9a-z._%+-]+@[A-Z0-9a-z._]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailString=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    return [emailString evaluateWithObject:self];
}


//手机格式校验(11位,数字)
- (BOOL)jy_stringCheckMobile {
    
    NSString* mobile   = [self stringByReplacingOccurrencesOfString:@" "withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
//        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSString *CT_NUM = @"^((133)|(153)|(17[0-9])|(18[0,1,9]))\\d{8}$";

        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
    
}

//身份证校验(只包含数字和字母)
//- (BOOL)jy_stringCheckIDCard{
//
//    if (self.length <= 0) {
//        return NO;
//    }
//    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
//    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
//    return [identityCardPredicate evaluateWithObject:self];
//
// }
//



-(BOOL)jy_checkPassWord
{
    //6-16位数字和字母组成
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self]) {
        return YES ;
    }else
        return NO;
}

-(BOOL)jy_stringCheckIDCard
{
    //长度不为18的都排除掉
    if (self.length!=18) {
        return NO;
    }
    
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:self];
    
    if (!flag) {
        return flag;  //格式错误
    }else {
        //格式正确在判断是否合法
        //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++){
            NSInteger subStrIndex = [[self substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            idCardWiSum+= subStrIndex * idCardWiIndex;
        }
        
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        
        //得到最后一位身份证号码
        NSString * idCardLast= [self substringWithRange:NSMakeRange(17, 1)];
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2){
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
                return YES;
            }else{
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]){
                return YES;
            }else{
                return NO;
            }
        }
    }
}





- (BOOL)jy_stringCheckNumber {
    
    if (self.length <= 0) {
        return NO;
    }
    
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:self]) {
        return YES;
    }
    return NO ;
}

- (NSString *)jy_MD5String  {
    const char *original_str=[self UTF8String];
    unsigned char result[32];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash=[NSMutableString string];
    for (int i=0; i<16; i++) {
        [hash appendFormat:@"%02x",result[i]];
    }
    return hash;
}

-(NSString*)jy_Base64String {

    NSData *encodeData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    return  [encodeData base64EncodedStringWithOptions:0];
    

}


@end
