//
//  JYUserModel.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/28.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <JSONModel/JSONModel.h>



@interface JYFundInfoModel : JSONModel


@property(nonatomic ,strong) NSString <Optional>*brokerage  ;  //佣金
@property(nonatomic ,strong) NSString <Optional>*creditCurrentAmount; //当前借贷借贷金额
@property(nonatomic ,strong) NSString <Optional>*creditDropInterest;  //已付利息
@property(nonatomic ,strong) NSString <Optional>*creditHoldInterest; //未付利息
@property(nonatomic ,strong) NSString <Optional>*creditTotalAmount; //借贷总额
@property(nonatomic ,strong) NSString <Optional>*currentAmount  ; //当前资金
@property(nonatomic ,strong) NSString <Optional>*customerId ; //客户号
@property(nonatomic ,strong) NSString <Optional>*frozenAmount; //冻结资金
@property(nonatomic ,strong) NSString <Optional>*investCurrentAmount; //当前投资金额
@property(nonatomic ,strong) NSString <Optional>*investDropProfit;  //已收益
@property(nonatomic ,strong) NSString <Optional>*investHoldProfit;//未收益
@property(nonatomic ,strong) NSString <Optional>*investTotalAmount; //借贷总额
@property(nonatomic ,strong) NSString <Optional>*manageFee; //管理费
@property(nonatomic ,strong) NSString <Optional>*serviceFee;  //服务费
@property(nonatomic ,strong) NSString <Optional>*signmd5; //验证信息
@property(nonatomic ,strong) NSString <Optional>*usableAmount  ; //可用资金

@end

/*
@interface JYCustomer : JSONModel

@property(nonatomic ,strong) NSString <Optional>*address ;
@property(nonatomic ,strong) NSString <Optional>*age  ;
@property(nonatomic ,strong) NSString <Optional>*asset  ;
@property(nonatomic ,strong) NSString <Optional>*auditItem  ;
@property(nonatomic ,strong) NSString <Optional>*auditStatus  ;
@property(nonatomic ,strong) NSString <Optional>*cellphone  ;
@property(nonatomic ,strong) NSString <Optional>*channel  ;
@property(nonatomic ,strong) NSString <Optional>*channelId  ;
@property(nonatomic ,strong) NSString <Optional>*children  ;
@property(nonatomic ,strong) NSString <Optional>*comments  ;
@property(nonatomic ,strong) NSString <Optional>*company  ;
@property(nonatomic ,strong) NSString <Optional>*contact1  ;
@property(nonatomic ,strong) NSString <Optional>*contact1Comments  ;
@property(nonatomic ,strong) NSString <Optional>*contact1Name  ;
@property(nonatomic ,strong) NSString <Optional>*contact1Phone  ;
@property(nonatomic ,strong) NSString <Optional>*contact2  ;
@property(nonatomic ,strong) NSString <Optional>*contact2Comments  ;
@property(nonatomic ,strong) NSString <Optional>*contact2Name  ;
@property(nonatomic ,strong) NSString <Optional>*contact2Phone  ;
@property(nonatomic ,strong) NSString <Optional>*contact3Comments  ;
@property(nonatomic ,strong) NSString <Optional>*education  ;
@property(nonatomic ,strong) NSString <Optional>*family  ;
@property(nonatomic ,strong) NSString <Optional>*firstTradeTime  ;

@property(nonatomic ,strong) JYFundInfoModel <Optional>*fundInfo  ;

@property(nonatomic ,strong) NSString <Optional>*headImage  ;
@property(nonatomic ,strong) NSString <Optional>*id  ;
@property(nonatomic ,strong) NSString <Optional>*idcard  ;
@property(nonatomic ,strong) NSString <Optional>*introducerPhone  ;
@property(nonatomic ,strong) NSString <Optional>*investigater  ;
@property(nonatomic ,strong) NSString <Optional>*inviterPhone  ;
@property(nonatomic ,strong) NSString <Optional>*latestLoginDevice  ;
@property(nonatomic ,strong) NSString <Optional>*latestLoginTime  ;
@property(nonatomic ,strong) NSString <Optional>*latestTradeTime  ;
@property(nonatomic ,strong) NSString <Optional>*loginPassword  ;
@property(nonatomic ,strong) NSString <Optional>*marriage  ;
@property(nonatomic ,strong) NSString <Optional>*origin  ;
@property(nonatomic ,strong) NSString <Optional>*reAuditItem  ;
@property(nonatomic ,strong) NSString <Optional>*realName  ;
@property(nonatomic ,strong) NSString <Optional>*registerDevice ;
@property(nonatomic ,strong) NSString <Optional>*registerTime ;
@property(nonatomic ,strong) NSString <Optional>*score  ;
@property(nonatomic ,strong) NSString <Optional>*sex  ; //1男 2女
@property(nonatomic ,strong) NSString <Optional>*tradePassword  ;
@property(nonatomic ,strong) NSString <Optional>*wrongTimes ;


@end
*/



@interface JYUserModel : JSONModel

@property(nonatomic ,strong) NSString <Optional>*address ;
@property(nonatomic ,strong) NSString <Optional>*age ;

//@property(nonatomic ,strong,getter=rAuditStatus) NSString  <Optional>*auditStatus ; //  是否已经进行过认证   0代表未认证，1代表已认证 3，需补录
//
//@property(nonatomic ,strong,getter=rAuditItem) NSString  <Optional>*auditItem ;//认证项用逗号隔开  1代表实名认证过  2身份认证 3工作信息 4手机验证  5芝麻信用  6公积金 7征信报告 然后  还有1A,1B  分别代表实名认证中实名   银行卡  与  交易密码

@property(nonatomic ,strong) NSString  <Optional>*auditStatus ; //  是否已经进行过认证   0代表未认证，1代表已认证 3，需补录

@property(nonatomic ,strong) NSString  <Optional>*auditItem ;//认证项用逗号隔开  1代表实名认证过  2身份认证 3工作信息 4手机验证  5芝麻信用  6公积金 7征信报告 然后  还有1A,1B  分别代表实名认证中实名   银行卡  与  交易密码


@property(nonatomic ,strong) NSString <Optional>*cellphone ;
@property(nonatomic ,strong) NSString <Optional>*channel ;

@property(nonatomic ,strong) NSString <Optional>*channelId ;

@property(nonatomic ,strong) NSString <Optional>*children;
@property(nonatomic ,strong) NSString <Optional>*comments;
@property(nonatomic ,strong) NSString <Optional>*company;
@property(nonatomic ,strong) NSString <Optional>*contact1;
@property(nonatomic ,strong) NSString <Optional>*contact1Comments ;
@property(nonatomic ,strong) NSString <Optional>*contact1Name;
@property(nonatomic ,strong) NSString <Optional>*contact1Phone ;
@property(nonatomic ,strong) NSString <Optional>*contact2 ;
@property(nonatomic ,strong) NSString <Optional>*contact2Comments;
@property(nonatomic ,strong) NSString <Optional>*contact2Name;
@property(nonatomic ,strong) NSString <Optional>*contact2Phone;
@property(nonatomic ,strong) NSString <Optional>*education;
@property(nonatomic ,strong) NSString <Optional>*family;
@property(nonatomic ,strong) NSString <Optional>*firstTradeTime;

@property(nonatomic ,strong) JYFundInfoModel <Optional>*fundInfo ;



@property(nonatomic ,strong) NSString <Optional>*headImage;

 @property(nonatomic ,strong) NSString <Optional>*id;
@property(nonatomic ,strong) NSString <Optional>*idcard;
@property(nonatomic ,strong) NSString <Optional>*introducerPhone;
@property(nonatomic ,strong) NSString <Optional>*investigater;
@property(nonatomic ,strong) NSString <Optional>*inviterPhone;
@property(nonatomic ,strong) NSString <Optional>*latestLoginDevice;

@property(nonatomic ,strong) NSString <Optional>*latestLoginTime;

@property(nonatomic ,strong) NSString <Optional>*latestTradeTime;

@property(nonatomic ,strong) NSString <Optional>*loginPassword;
@property(nonatomic ,strong) NSString <Optional>*marriage;
@property(nonatomic ,strong) NSString <Optional>*origin;
@property(nonatomic ,strong) NSString <Optional>*reAuditItem  ;

@property(nonatomic ,strong) NSString <Optional>*realName;
@property(nonatomic ,strong) NSString <Optional>*registerDevice;
@property(nonatomic ,strong) NSString <Optional>*registerTime;
@property(nonatomic ,strong) NSString <Optional>*score;
@property(nonatomic ,strong) NSString <Optional>*sex; //1男 2女
@property(nonatomic ,strong) NSString <Optional>*totalCreditAmount ;
@property(nonatomic ,strong) NSString <Optional>*tradePassword;
@property(nonatomic ,strong) NSString <Optional>*wrongTimes ;





@property(nonatomic ,strong) NSMutableArray <Optional>*rBankModelArr; //银行卡列表



@end
