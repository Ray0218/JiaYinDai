//
//  AppDelegate.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/22.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "AppDelegate.h"
#import "JYTabBarController.h"
#import <AFNetworkReachabilityManager.h>
#import "JYNoNetworkManager.h"
#import "IQKeyboardManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
 
    
    JYTabBarController *rootVC = [[JYTabBarController alloc]init];
    
    self.window.rootViewController = rootVC ;
    
    
    [self initNetWork];
    
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    
    
    return YES;
}

//网络检测
- (void)initNetWork {
    AFNetworkReachabilityManager *afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    
    [afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"网络已连接") ;
                UILabel *label = [JYNoNetworkManager shareManager].rNoNetLabel ;
                if (label.superview) {
                    
                    [UIView animateWithDuration:1.0 animations:^{
                        label.alpha=0.0;
                        label.frame=CGRectMake(0,20,SCREEN_WIDTH, 30);
                    } completion:^(BOOL finished) {
                        [label removeFromSuperview];
                    }];
                }
                
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog(@"当前网络不可用") ;
                
                UILabel *label = [JYNoNetworkManager shareManager].rNoNetLabel ;
                
                if (label.superview) {
                    break ;
                }
                label.frame = CGRectMake(0,20,SCREEN_WIDTH, 30);
                label.alpha=0.f;
                [self.window addSubview:label];
                [UIView animateWithDuration:1.0 animations:^{
                    label.alpha=1.0;
                    label.frame=CGRectMake(0,64,SCREEN_WIDTH, 30);
                }];
                
            }
                break;
            default:
                break;
        }
    }] ;
    
    [afNetworkReachabilityManager startMonitoring];  //开启网络监视器；
    
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
