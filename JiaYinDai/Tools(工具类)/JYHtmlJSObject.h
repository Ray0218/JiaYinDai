//
//  JYHtmlJSObject.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/7/13.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>


@protocol JavaScriptDelegate <JSExport>

/**
 分享
 */
-(void)pvt_share ;

/**
 认证
 */
-(void)pvt_goIdentification;

/**
 借贷
 */
-(void)pvt_goLoan;

/**
 邀请好友
 */
-(void)pvt_goInvite;

/**
 我的余额
 */
-(void)pvt_balance ;

/**
 我的福利
 */
-(void)pvt_welfare ;



@end


@interface JYHtmlJSObject : NSObject<JavaScriptDelegate>

 

@end
