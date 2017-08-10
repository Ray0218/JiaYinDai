//
//  ShareConfig.m
//  SilverFoxWealth
//
//  Created by SilverFox on 15/6/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ShareConfig.h"
//#import "EncryptHelper.h"
//#import <TencentOpenAPI/TencentApiInterface.h>
//#import "WXApi.h"
//#import "IndividualInfoManage.h"
//#import "StringHelper.h"

@implementation ShareConfig

+ (void)uMengContentConfigWithCellPhone:(NSString *)cellPhone tag:(NSInteger )tag presentVC:( UIViewController *)presentVC shareContent:(NSString *)shareContent shareImage:(UIImage *)shareImage title:(NSString *)title userUrlStr:(NSString *)userUrlStr succeedCallback:(void(^)())succeedCallback {
    
    UIImage *image=[UIImage imageNamed:@"logo_share"];
    //微信好友
    if (tag==2) {
//        [MobClick event:@"share_to_weixin"];
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建网页内容对象
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:shareContent thumImage:image];
        //设置网页地址
        shareObject.webpageUrl = userUrlStr;
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //调用分享接口
//        [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {

            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
            //[self alertWithError:error];
        }];
    }
    //朋友圈
    if (tag==3) {
//        [MobClick event:@"share_to_weixin_circle"];
        
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:shareContent thumImage:image];
        //设置网页地址
        shareObject.webpageUrl = userUrlStr;
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //调用分享接口
//        [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        
        [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {

            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
            //[self alertWithError:error];
        }];
    }
    //短信分享
    if (tag==1) {
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        
//        JYUserModel *model = [JYSingtonCenter shareCenter].rUserModel ;
        
//        IndividualInfoManage *user = [IndividualInfoManage currentAccount];
//         NSString *cellPhone64 = [EncryptHelper base64StringFromText:cellPhone];
//        messageObject.text = [NSString stringWithFormat:@"好友%@正在邀请您使用微银贷app，快来注册吧！\n%@%@/register",model.cellphone,kServiceURL,kLogInURL];
        
        
        messageObject.text = [NSString stringWithFormat:@"%@\n%@",shareContent,userUrlStr];

        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Sms messageObject:messageObject currentViewController:presentVC completion:^(id data, NSError *error) {
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
            //[self alertWithError:error];
        }];
    }
}


@end




