//
//  ShareConfig.h
//  SilverFoxWealth
//
//  Created by SilverFox on 15/6/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//


//分享 统一配置
#import <Foundation/Foundation.h>
//#import "UMSocial.h"

//#import "CommunalInfo.h"
#import <UMSocialCore/UMSocialCore.h>


@interface ShareConfig : NSObject

+ (void)uMengContentConfigWithCellPhone:(NSString *)cellPhone tag:(NSInteger )tag presentVC:( UIViewController *)presentVC shareContent:(NSString *)shareContent shareImage:(UIImage *)shareImage title:(NSString *)title userUrlStr:(NSString *)userUrlStr succeedCallback:(void(^)())succeedCallback;



@end
