//
//  JYDefine.h
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/23.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#ifndef JYDefine_h
#define JYDefine_h

/************************* 设备信息 *************************/
#define DEVICE_USERNAME        [[UIDevice currentDevice] name]
#define DEVICE_SYSTEMNAME      [[UIDevice currentDevice] systemName]
#define DEVICE_VESION          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define DEVICE_VESION_STR       [[UIDevice currentDevice] systemVersion]
#define DEVICE_IPHONEORPAD     [[UIDevice currentDevice] userInterfaceIdiom]
#define DEVICE_ISIPAD          (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define DEVICE_ADUUID          [[[ASIdentifierManager sharedManager] advertisingIdentifier]UUIDString]


/************************ 屏幕尺寸宏定义 ************************/
//设备屏幕宽度(320)
#define SCREEN_WIDTH   CGRectGetWidth([[UIScreen mainScreen] bounds])
//设备屏幕高度(480/568)
#define SCREEN_HEIGHT  CGRectGetHeight([[UIScreen mainScreen] bounds])


/************************ 颜色宏定义 ************************/

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0x00FF0000) >> 16)) / 255.0     green:((float)((rgbValue & 0x0000FF00) >>  8)) / 255.0 blue:((float)((rgbValue & 0x000000FF) >>  0)) / 255.0 alpha:1.0]


#define kLineColor UIColorFromRGB(0xcccccc) 
#define kBlueColor UIColorFromRGB(0x005dad)

#define kOrangewColor UIColorFromRGB(0xd7991d)
#define kBackGroundColor UIColorFromRGB(0xf2f2f2)
#define kTextBlackColor UIColorFromRGB(0x333333)
#define kGrayColor UIColorFromRGB(0x999999)

/************************ 数字格式化 ************************/

#define kNumber @"0123456789"


#define kHasLoadWelcom @"kHasLoadWelcom"




static inline NSMutableAttributedString * TTFormateNumString( NSString*text,CGFloat bigFont ,CGFloat smallFont,NSInteger smallLength){
    
    NSMutableAttributedString *att = [[NSMutableAttributedString  alloc]initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:bigFont]}] ;
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:smallFont] range:NSMakeRange( att.length-smallLength,smallLength)] ;
    
    return att ;
    
} ;


#endif /* JYDefine_h */
