//
//  JYLLPayMamager.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/2.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLLPayMamager.h"
#import "JYSingtonCenter.h"
#import "JYSignHelper.h"

@implementation JYLLPayMamager


+ (NSDictionary *)createJiaYuanRechargeOrderWithOrderNO:(NSString *)orderNO moneyNO:(NSString *)moneyNO userName:(NSString *)userName  userIdNO:(NSString *)userIdNO bankCardNO:(NSString *)bankCardNO bankNO:(NSString *)bankNO sig:(NSString *)sig
{
    
#ifdef JIAYUANBANK_TESTING
    //商户编号 待定 1
    NSString *oid_partner=[NSString stringWithFormat:@"201408071000001543"];
#else
    //正式
    NSString *oid_partner = [NSString stringWithFormat:@"201511271000615506"];
#endif
    
    //签名方式 2
    NSString *sign_type = @"MD5";
    
    //签名 后面补 3
    
    //商户业务类型  其它特殊有实名信息 但虚拟类商品 4
    NSString *busi_partner = [NSString stringWithFormat:@"101001"];
    
    //商品唯一订单号  待定 5
    NSString *no_order = [orderNO copy];
    
    //交易时间
    NSString *dt_order = [orderNO substringWithRange:NSMakeRange(3, 14)];
    
    //购买金额
#ifdef JIAYUANBANK_TESTING
    NSString *money_order = @"0.01";
#else
    NSString *money_order=[NSString stringWithFormat:@"%@",moneyOrder];
#endif
    //交易成功后通知的服务器地址 10
    NSString *notify_url = [NSString stringWithFormat:@"https://www.jiayuanbank.com/product/pay/result/async"];
    
    //支付有效期 非 11
    NSString *valid_order = [NSString stringWithFormat:@"5"];//支付有效期
    
    //风险参数 12
    NSMutableDictionary *riskDic = [NSMutableDictionary dictionary];
    
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
    
    
    //风控 之 用户在商户中的唯一标示
    NSString *userno_name = @"user_info_mercht_userno";
    NSString *userno = user.id;
    [riskDic setValue:userno forKey:userno_name];
    
    //风控 之 绑定手机号
    NSString *bind_phone = @"user_info_bind_phone";
    NSString *bindP=user.cellphone;
    [riskDic setValue:bindP forKey:bind_phone];
    
    //风控 之 产品类型
    NSString *frms_ware_category = @"frms_ware_category";
    NSString *categoryValue = @"2009";
    [riskDic setValue:categoryValue forKey:frms_ware_category];
    
    //风控 之 用户全名
    NSString *user_info_full_name = @"user_info_full_name";
    NSString *full_name = [userName copy];
    [riskDic setValue:full_name forKey:user_info_full_name];
    
    //风控 之 用户身份证
    NSString *user_info_id_no = @"user_info_id_no";
    NSString *info_id_no = [userIdNO copy];
    [riskDic setValue:info_id_no forKey:user_info_id_no];
    
    //风控 之 ...
    NSString *user_info_id_type = @"user_info_id_type";
    [riskDic setValue:@"0" forKey:user_info_id_type];
    
    //风控 之 是否对用户进行实名认证
    NSString *user_info_identify_state=@"user_info_identify_state";
    [riskDic setValue:@"1" forKey:user_info_identify_state];
    
    //风控 之 实名认证方式xxxxxxx
    NSString *user_info_identify_type=@"user_info_identify_type";
    [riskDic setValue:@"1" forKey:user_info_identify_type];
    
    //    //风控 之 注册时间
    //    NSString *dateStr=[DateHelper conversionTimeStampToCompactWith:[IndividualInfoManage currentAccount].registerTime];
    //    NSString *user_info_dt_register=dateStr; //注册时间
    //    [riskDic setValue:user_info_dt_register forKey:@"user_info_dt_register"];
    
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:riskDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *riskStr=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    //确定风控参数
    NSString *risk_item=riskStr;
    
    //以下不参与商户签名
    
    //商户用户唯一id  13
    NSString *user_id = @"" ;;// [IndividualInfoManage currentAccount].idStr;
    
    //略去了force_bank 非 是否强制使用该银行卡 14
    
    //证件类型 15 0代表身份证
    NSString *id_type = [NSString stringWithFormat:@"0"];
    
    //身份证号 16 待定
    NSString *id_no = [userIdNO copy];
    
    //姓名
    NSString *acct_name = [userName copy];
    
    
    //卡号 有协议号就非 18
    NSString *card_no = [bankCardNO copy];
    
    //银行编号
    //NSString *bank_no = [SCMeasureDump shareSCMeasureDump].bankNO;
    NSString *bank_no = [bankNO copy];
    NSString *pay_type = [NSString stringWithFormat:@"2"];
    NSString *messageStr = [NSString stringWithFormat:@"%@;%@;%@;%@;%@;%@;%@;%@;%@;%@",user_id,acct_name,id_no,bank_no,card_no,money_order,dt_order,orderNO,pay_type,sig];
    NSString *signStr = [ messageStr jy_MD5String];

//    NSString *signStr = [SignHelper partnerSignInfoOrder:messageStr];
    
    NSString *info_order = [NSString stringWithFormat:@"%@;%@;%@;%@;%@;%@;%@;%@;%@;%@",user_id,acct_name,id_no,bank_no,card_no,money_order,dt_order,orderNO,pay_type,signStr];
    
    NSLog(@"info_order=======%@",info_order);
    ////
    //只对以下字段进行签名
    NSDictionary *signDict = NSDictionaryOfVariableBindings(busi_partner,dt_order,info_order,money_order,no_order,notify_url,oid_partner,risk_item,sign_type,valid_order);
//    NSString *sign =[SignHelper partnerSignOrder:signDict sig:sig];
    NSString *sign = [JYSignHelper jygetPreSignStringWithDic:[signDict copy] signKey:sig] ;
    
    //封装
    NSDictionary *paramDic = NSDictionaryOfVariableBindings(oid_partner,busi_partner,no_order,dt_order,info_order,money_order,notify_url,valid_order,risk_item,user_id,id_type,id_no,acct_name,card_no,sign_type,sign);
    return paramDic;
    
    
    
    
    
}



@end
