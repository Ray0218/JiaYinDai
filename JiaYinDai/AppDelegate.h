//
//  AppDelegate.h
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/22.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end



static NSString *appKey = @"6d054d44e2be9ef7d9e9b74b" ;

static BOOL isProduction = YES   ; //是否生产环境. 如果为开发状态,设置为 NO; 如果为生产状态,应改为 YES.

static NSString *channel = @"Publish channel";



#define USHARE_DEMO_APPKEY @"58aba5cdc89576050c0023ec"
