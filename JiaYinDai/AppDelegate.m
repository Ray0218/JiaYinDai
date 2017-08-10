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
#import <AFNetworkActivityIndicatorManager.h>
#import "JYNoNetworkManager.h"
#import "IQKeyboardManager.h"
#import "PPGetAddressBook.h"
#import "JYWelcomController.h"
#import "JYWebViewController.h"

#import <UMSocialCore/UMSocialCore.h>


// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>



@interface AppDelegate ()<JPUSHRegisterDelegate>


@property (strong, nonatomic) UIView *lunchView;


@property (strong, nonatomic) NSString *rArdLink ;



@end


static NSString *kAppVisionKey = @"kAppVisionKey" ;

@implementation AppDelegate


-(void)pvt_setSatartView {
    
    
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"startView"];
    
    _lunchView = viewController.view;
    
    self.window.rootViewController = viewController ;
    
    
    [viewController.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pvt_ClickAward)]] ;
    
    
    __block UIImageView *imageV = [_lunchView viewWithTag:999] ;
    imageV.userInteractionEnabled = YES;//打开imageV用户交互
    
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
    [dic setValue:@"1" forKey:@"platform"] ;
    
    [dic setValue:@"1" forKey:@"position"] ;
 
     [[AFHTTPSessionManager jy_sharedManager ] POST:KBannerURL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *data = responseObject[@"data"] ;
        
        if (data.count) {
            
            NSDictionary *dic = [data firstObject] ;
            
            NSString *imageUrl = dic[@"imageUrl"] ;
            
            [imageV sd_setImageWithURL:[NSURL URLWithString:imageUrl]  placeholderImage:nil];
            
            NSInteger interval = [dic[@"dynamicTime"] integerValue] ;
            self.rArdLink = dic[@"linkUrl"] ;
            
            [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(removeLun) userInfo:nil repeats:NO];
            
        }else{
            [self removeLun];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self removeLun];
    }] ;
    
    
}

-(void)removeLun {
    
      [self setRootViewController];
    
}


-(void)pvt_ClickAward {
    
    if (self.rArdLink.length) {
        
        JYWebViewController *webView = [[JYWebViewController alloc]initWithUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.rArdLink]]] ;
        
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:webView];
        
        
        UIViewController *rootVC = [[[UIApplication sharedApplication]keyWindow]rootViewController] ;
        
        if ([rootVC isKindOfClass:[JYTabBarController class]]) {
            [rootVC presentViewController:nvc animated:NO  completion:nil] ;
        }else{
            
            [self setRootViewController];
            
            rootVC = [[[UIApplication sharedApplication]keyWindow]rootViewController] ;
            
            [rootVC presentViewController:nvc animated:NO  completion:nil] ;
            
        }
        
        
    }
    
    
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [self youMeng];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    [self pvt_setSatartView] ;
    
    [self.window makeKeyAndVisible];
    
    
    [self pvt_registerJPUSH:launchOptions];
    
    
    [self configureFramework];
    
     return YES;
}





- (void)youMeng
{
    
    /* 打开调试日志 */
    //    [[UMSocialManager defaultManager] openLog:YES];
    
    //    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_DEMO_APPKEY];
    
    
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxd8125f997a243780" appSecret:@"58aba5cdc89576050c0023ec" redirectURL:@"http://mobile.umeng.com/social"];
    
    
    // 友盟统计
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    UMConfigInstance.appKey = @"58aba5cdc89576050c0023ec";
    //    UMConfigInstance.ePolicy = SEND_INTERVAL ;
    
    [MobClick startWithConfigure:UMConfigInstance];
    
    
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [[UMSocialManager defaultManager] handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    if ([url.scheme isEqualToString:@"jiayindaiapp"]) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:kZhimaNotification  object:nil] ;
    }
    
    return  [[UMSocialManager defaultManager] handleOpenURL:url];
}



#pragma mark- 极光推送
-(void)pvt_registerJPUSH:(NSDictionary*)launchOptions{
    
    // 3.0.0及以后版本注册可以这样写，也可以继续用旧的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        //    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        //      NSSet<UNNotificationCategory *> *categories;
        //      entity.categories = categories;
        //    }
        //    else {
        //      NSSet<UIUserNotificationCategory *> *categories;
        //      entity.categories = categories;
        //    }
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    
    //     如需使 IDFA功能请添加此代码并在初始化 法的advertisingIdentifier参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] ;
    
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
    
}



- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}


#pragma mark- 设置根试图
-(void)setRootViewController {
    
    
    UIViewController *rootVC = [[[UIApplication sharedApplication]keyWindow]rootViewController] ;
    
    if (![rootVC isKindOfClass:[JYTabBarController class]]) {
        
        JYTabBarController *rootViewControl = [[JYTabBarController alloc]init];
        self.window.rootViewController = rootViewControl ;
        
    }
    
    
    
}


-(void)configureFramework {
    // 监听网络状态变化
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    // 初始化底层框架
    
    [[UIButton appearance] setExclusiveTouch:YES];
    
    //请求用户获取通讯录权限
    [PPGetAddressBook requestAddressBookAuthorization];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //强制升级
    [self updateAppVersion];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark -强制升级
- (void)updateAppVersion {
    
    
    [[AFHTTPSessionManager jy_sharedManager] POST:kUpdateURL parameters:@{@"type":@"ios"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSDictionary *obj = responseObject[@"data"] ;
        //app版本
        NSString *appVersionStr = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
        appVersionStr = [appVersionStr stringByReplacingOccurrencesOfString:@"." withString:@""];
        
        
        NSString *newVersionStr=obj[@"version"];
        
        newVersionStr = [newVersionStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        newVersionStr = [newVersionStr stringByReplacingOccurrencesOfString:@"." withString:@""];
        
        
        NSString *lastvisiion = [[NSUserDefaults standardUserDefaults]valueForKey:kAppVisionKey];
        
        if ([lastvisiion isEqualToString:newVersionStr]) {
            return ;
        }
        
        
        if ([appVersionStr intValue] < [newVersionStr intValue]) {
            NSString *upgradeType = obj[@"upgradeType"];
            
            NSString * contentStr = [NSString stringWithFormat:@"%@",obj[@"content"]] ;
            
            //如果是强制更新
            if ([upgradeType isEqualToString:@"compulsive"]) {
                
                [UIAlertView alertViewWithTitle:@"有新版本，请前往更新" message:contentStr cancelButtonTitle:@"更新" otherButtonTitles:nil onDismiss:^(NSInteger buttonIndex) {
                    
                }
                                       onCancel:^{
                                           
                                           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",@"1248134035"]]];
                                       }];
                
                
            }else { //如果不强制更新
                [UIAlertView alertViewWithTitle:@"有新版本，请前往更新"  message:contentStr cancelButtonTitle:@"忽略" otherButtonTitles:@[@"更新"] onDismiss:^(NSInteger buttonIndex) {
                    
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",@"1248134035"]]];
                    
                }
                                       onCancel:^{
                                           
                                           [[NSUserDefaults standardUserDefaults] setValue:newVersionStr forKey:kAppVisionKey] ;
                                           [[NSUserDefaults standardUserDefaults]synchronize ];
                                           
                                           NSLog(@"取消") ;
                                       }];
                
                
            }
            
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
    
}


@end
