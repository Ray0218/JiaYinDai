//
//  JYHtmlJSObject.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/7/13.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYHtmlJSObject.h"
#import "JYTabBarController.h"
#import "JYImproveInfoController.h"
#import "JYInviteController.h"
#import "JYRedCardController.h"
#import "JYBalanceController.h"


#import "ShareConfig.h"
#import "ShareView.h"

@implementation JYHtmlJSObject

-(void)pvt_share {
    
    
    NSLog(@"分享");
    ShareView  *_shareView=[[[NSBundle mainBundle] loadNibNamed:@"CommenCell" owner:self options:nil] objectAtIndex:0];
    JYUserModel *model = [JYSingtonCenter shareCenter].rUserModel ;
    NSString *shareStr= [NSString stringWithFormat:@"缺钱花，嘉银贷为您提供每月零花钱。3分钟审批到账5万元。无门槛，低利率。点我申请！"];
    
    NSString *userUrlStr = [NSString stringWithFormat:@"%@/activity/toLottery/%@",kServiceURL, [model.cellphone jy_Base64String]] ;
    
    [_shareView show:^(NSInteger PlatformTag) {
        
        [ShareConfig uMengContentConfigWithCellPhone:model.cellphone tag:PlatformTag presentVC:nil shareContent:shareStr shareImage:nil  title:@"缺钱花，找嘉银贷" userUrlStr:userUrlStr succeedCallback:^{
        }];
    }];
    
}


-(void)pvt_goIdentification{
    NSLog(@"去认证") ;
    
    JYTabBarController *tab= (JYTabBarController*)[[[UIApplication sharedApplication]keyWindow ]rootViewController] ;
    
    UINavigationController *navc = tab.selectedViewController ;
    
    
    JYImproveInfoController *impVC =[[JYImproveInfoController alloc]init];
    
    [navc pushViewController:impVC animated:YES] ;
}

/**
 借贷
 */
-(void)pvt_goLoan {
    
    NSLog(@"借款") ;
    
    JYTabBarController *tab= (JYTabBarController*)[[[UIApplication sharedApplication]keyWindow ]rootViewController] ;
    
    UINavigationController *navc = tab.selectedViewController ;
    
    [tab setSelectedIndex:0] ;
    
    [navc popToRootViewControllerAnimated:NO] ;
}

/**
 邀请好友
 */
-(void)pvt_goInvite {
    
    NSLog(@"邀请好友") ;
    
    JYTabBarController *tab= (JYTabBarController*)[[[UIApplication sharedApplication]keyWindow ]rootViewController] ;
    
    UINavigationController *navc = tab.selectedViewController ;
    
    JYInviteController *inviteVC =[[JYInviteController alloc]init];
    
    [navc pushViewController:inviteVC animated:YES] ;
    
    
}

-(void)pvt_balance {
    
    JYTabBarController *tab= (JYTabBarController*)[[[UIApplication sharedApplication]keyWindow ]rootViewController] ;
    
    UINavigationController *navc = tab.selectedViewController ;
    
    JYBalanceController *balanceVC = [[JYBalanceController alloc]init];
    
    [navc pushViewController:balanceVC animated:YES];
    
}

-(void)pvt_welfare{
    
    JYTabBarController *tab= (JYTabBarController*)[[[UIApplication sharedApplication]keyWindow ]rootViewController] ;
    
    UINavigationController *navc = tab.selectedViewController ;
    
    JYRedCardController *cardVC = [[JYRedCardController alloc]initWithType:JYRedCardTypeBoth];
    cardVC.rClickNotBack = YES ;
    
    [navc pushViewController:cardVC animated:YES];
    
}


@end
