//
//  JYService.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/24.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#ifndef JYService_h
#define JYService_h


#define kSignKey @"65846b8c29154b3ef911e913f9e2205d"


//正式
#define kPay_md5_key @"20161202_jyd&ll88_20171201koulingwoyaodafa"
#define kPay_oid_partner @"201611301001290509"

////测试
//#define kPay_md5_key @"201608101001022519_test_20160810"
//#define kPay_oid_partner @"201608101001022519"

 
 
//#define kServiceURL  @"http://192.168.1.156:8080"

// #define kServiceURL  @"http://192.168.1.164:8080"

//#define kServiceURL  @"http://192.168.1.81:80"

//#define kServiceURL  @"http://192.168.1.216:16060"

//#define kServiceURL  @"http://116.62.180.160:8080"

#define kServiceURL  @"https://www.jiayinlending.com"


//用户还款列表
#define kPayBackURL @"/order/loadCreditOrderInfo"

//用户还款详情
#define kPayBackDetailURL @"/order/getCreditOrderDetail"

//用户订单
#define kOrderListURL @"/order/getCreditOrderList"

//余额全部还款
#define  kBalanceAllPayURL @"/customer/fullBalanceRpayment"

//余额单期还款
#define kBalancePayURL @"/customer/balanceRpayment"

//连续还款期数
#define  kContinuRepayPeriodURL @"/customer/getContinuRepayPeriod"

//订单详情
#define kOrderDetailURL @"/order/getCreditOrderDetail"

//产品列表
#define kProductListURL @"/product/getCreditProductList"

//注册
#define kRegisterURL @"/register"
//发送验证码
#define kCodeURL @"/sms"

//验证手机号码是否存在
#define kCellPhoneExistURL @"/duplicate/cellphone"

//修改手机号
#define kModifyCellPhoneURL @"customer/modifyCellphone"

//判断验证码是否正确(注册)
#define kCodeVerifyURL @"/smsVerify"
//登录
#define kLogInURL @"/login"
//退出登录
#define kLogoutURL @"/logout"
//修改登录密码
#define kChageLogPasswordURL @"/customer/update/password"
//设置登录密码
#define kReSetLogPasswordURL @"/customer/reset/password"

//判断验证码是否正确(修改手机号码)
#define kCheckSmsURL @"/sms/verify"

//检验验证码
#define  kVertifySMSURL @"/sms/verification"

//获取用户信息
#define kGetUserInfoURL @"/customer/getMyinfo"
// 账户资金
#define kGetMyAccountURL @"customer/getMyAccount"


//交易密码设置修改找回
#define kTradePasswordURL @"/customer/reset/tradePassword"

 //获取认证了的项目接口
#define kAuditItemURL @"/customer/getAuditItem"

//实名认证
#define kRealNameIdentyfyURL @"/customer/verifyRealNameP"
//认证交易密码
#define kTradePassIndentifyURL @"/customer/verifyTradePasswordP"
//身份认证
#define kRelationShipIdenURL @"/customer/verifyIdentityP"

//验证工作信息
#define kWorkIdentifyURL @"/customer/verifyWorkP"

//手机认证
#define kPhoneIdentifyURL @"/customer/authPhone"
//芝麻信用
#define kZhimaURL @"/customer/zhima/authorize"
//公积金
#define kGJJinURL @"/customer/saveCustomerAccount"

//身份证验证
#define kIdCardIdentifyURL @"/customer/validation/idcard"
////获取身份证图片
 #define kGetCardImageURL @"/customer/getImage"

////验证交易密码
#define kCheckTradePassURL @"/confirmTradePwd"

//活动
#define kActiveURL @"/personal/getActive"

//借贷记录
#define kApplyRecordURL @"/order/getApplyRecordP"
//进度详情
#define kRecordDetailURL @"/order/getRecordDetailP"

//支持银行
#define kBankSupportURL @"/customer/getPayBank"
//提交订单
#define kSubmitLoanURL @"/product/submitLoan"

//保存银行卡
#define kSaveBankCardURL @"/customer/saveCustomerBank"
//获取我的银行卡列表
#define kGetCustomerBankURL @"/customer/getCustomerBank"
//银行卡信息查询
#define kBankCardVertifyURL @"/bank/card/verification"
//在连连已绑定改银行卡
#define kBankBinListURL @"bank/card/bin/list"

//充值预处理
#define kChargeURL @"/customer/preDeposit"

//校验全额还款时金额是否正确

#define kCheckFullData @"/customer/checkFullData"

//校验单期还款金额
#define kCheckPerDtaURL @"/customer/checkPerData"

 
//提现
#define kDrawURL @"/customer/withDraw"
//上传图片
#define kUploadPicURL @"/customer/uploadPic"
//红包
#define kCustomerBonusURL @"/customer/getCustomerBonusP"
// 意见反馈
#define kFeekbackURL @"/personal/saveFeedback"
// banner图
#define KBannerURL @"/personal/getBanner"

// 公告
#define KGetNoticeURL @"/personal/getNotice"

//判断能否借款
#define  kAuditStatusURL @"/customer/getAuditStatus"
//是否第一次借款
#define kIsFirstLoanURL @"/customer/isFirstLoan"

//获取消息
#define kGetMessageURL @"/personal/getMessage"

//未读消息
#define kMessageCountURL @"personal/getMessageCount"

//消息已读
#define  kMessageReadURL @"/personal/saveMessage"
//消息详情
#define kMessageDetail @"/personal/getMessageDetail"
//公告详情
#define  kNoteDetailURL @"/personal/getNoticeDetail"

//还款订单列表
#define kBillListURL @"/customer/getAccountBillP"
// 还款界面  右上角的还款记录
#define kgetRepaybillURL @"/customer/getRepaybill"
// 还款记录详情
#define kgetRepaybillDetailURL @"/customer/getRepaybillDetail"

//还款订单详情
#define kBillDetailURL @"/customer/getBillDetailPost"
//首页统计
#define kRootCountURL @"/countIndex"

//充值回调
#define kChargeNotify @"/customer/installment/success/async"

//全额还款回调
#define kPayAllNotify @"/customer/fullInstallment/success/async"
//单期还款回调
#define kPayPerNotify @"/product/pay/result/async"

 
//邀请记录
#define kInviteRecordURL @"/customer/friend/inviteRecordPost"
//佣金记录
#define kInviteAwardURL @"/customer/friend/inviteBonusPost"

//邀请好友
#define kInvitePostURL @"/customer/friend/invitePost"
//更新版本
#define kUpdateURL @"/app/upgrade"
//常见问题
#define kQuestURL @"/personal/toFAQ"

//保存日志1:借款，2还款,3充值，4：提现
#define kSaveLogURL @"/saveLianLianLog"

#endif /* JYService_h */
