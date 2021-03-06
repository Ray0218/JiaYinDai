//
//  NSString+Extern.h
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/23.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extern)

//邮箱校验(标准邮箱格式)
- (BOOL)jy_stringCheckEmail;

//手机格式校验(11位,数字)
- (BOOL)jy_stringCheckMobile;

//身份证校验(只包含数字和字母)
- (BOOL)jy_stringCheckIDCard;

//数字校验(只包含数字和小数点)
- (BOOL)jy_stringCheckNumber;


/**
 MD5加密

 @return <#return value description#>
 */
- (NSString *)jy_MD5String ;

//密码校验
-(BOOL)jy_checkPassWord ;


-(NSString*)jy_Base64String  ;


 
@end
