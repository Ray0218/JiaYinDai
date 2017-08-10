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


#define kTextBlackColor UIColorFromRGB(0x999999) //153/153/153

#define kBlackSecColor UIColorFromRGB(0x666666)


#define kBlackColor UIColorFromRGB(0x333333)

 
/************************ 数字格式化 ************************/

#define kNumber @"0123456789"


#define kHasLoadWelcom @"kHasLoadWelcom"

#define kRequestJsonType  @"kRuquestJsonType"

#define kLogInTimeCache @"kLogInTimeCache"
 

#define kLogInNotification @"kLogInNotification"

#define kZhimaNotification @"kZhimaNotification"

#define kEndRefreshNotification @"kEndRefreshNotification"


#define kAutoLogFinishNotification @"kAutoLogFinishNotification"


#define kTelNumCache @"kTelNumCache"
 

#define kSSKeyService @"JiaYinDaiAPP"
 


static inline NSMutableAttributedString * TTFormateNumString( NSString*text,CGFloat bigFont ,CGFloat smallFont,NSInteger smallLength){
    
    NSMutableAttributedString *att = [[NSMutableAttributedString  alloc]initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:bigFont]}] ;
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:smallFont] range:NSMakeRange( att.length-smallLength,smallLength)] ;
    
    return att ;
    
} ;


static inline NSMutableAttributedString * TTFormateTitleString( NSString*text,CGFloat bigFont ,CGFloat smallFont,NSInteger smallLength , UIColor *baseColor ,UIColor *smalColor){
    
    NSMutableAttributedString *att = [[NSMutableAttributedString  alloc]initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:bigFont]}] ;
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:smallFont] range:NSMakeRange( att.length-smallLength,smallLength)] ;
    
    [att addAttribute:NSForegroundColorAttributeName value:baseColor range:NSMakeRange(0, text.length)] ;
    
    [att addAttribute:NSForegroundColorAttributeName value:smalColor range:NSMakeRange( att.length-smallLength,smallLength)] ;

    
    return att ;
    
};



static inline NSString * TTTimeString(NSString *timeInterval ){
    
    if (timeInterval.length <= 0) {
        return @"" ;
    }
    
    NSTimeInterval times = [timeInterval longLongValue]/1000.0 ;
    
    NSDate *dateS = [NSDate dateWithTimeIntervalSince1970:times] ;
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd" ;
    
    NSString* timString = [format stringFromDate:dateS] ;

    
    return timString ;
    
} ;


static inline NSString * TTTimeHMString(NSString *timeInterval ){
    
    if (timeInterval.length <= 0) {
        return @"" ;
    }
    
    NSTimeInterval times = [timeInterval longLongValue]/1000.0 ;
    
    NSDate *dateS = [NSDate dateWithTimeIntervalSince1970:times] ;
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd HH:mm" ;
    
    NSString* timString = [format stringFromDate:dateS] ;
    
    
    return timString ;
    
} ;


static inline NSMutableAttributedString * TTThreeFormateString( NSString*baseText, NSInteger  firstLen ,NSInteger secondLen,CGFloat firstFont ,CGFloat secondFont, CGFloat thirdFont, UIColor *baseColor ,UIColor *firstColor,UIColor *secondColor){
    
    NSMutableAttributedString *att = [[NSMutableAttributedString  alloc]initWithString:baseText attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:thirdFont],NSForegroundColorAttributeName:baseColor}] ;
    
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:firstFont] range:NSMakeRange(0, firstLen)] ;
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:secondFont] range:NSMakeRange(firstLen, secondLen)] ;
    
    [att addAttribute:NSForegroundColorAttributeName value:firstColor range:NSMakeRange(0, firstLen)] ;
    [att addAttribute:NSForegroundColorAttributeName value:secondColor range:NSMakeRange(firstLen, secondLen)] ;
    
    
    return att ;
    
    
};




#endif /* JYDefine_h */
