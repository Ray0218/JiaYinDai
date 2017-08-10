//
//  JYBillListModel.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/16.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JYBillListModel : JSONModel


@property (nonatomic ,strong) NSString <Optional>*amount  ; //金额
@property (nonatomic ,strong) NSString <Optional>*createTime  ; //创建时间
@property (nonatomic ,strong) NSString <Optional>*status  ; //状态  如 还款成功 还款失败
@property (nonatomic ,strong) NSString <Optional>*type  ; //类型  string类型
@property (nonatomic ,strong) NSString <Optional>*accountType ;// 类型  1 借款，2 还款,3提现，4充值，5佣金
@property (nonatomic ,strong) NSString <Optional>*id ;

@property (nonatomic ,strong) NSString <Optional>*state ; //  1代表成功，2代表失败

@end



@interface JYBillDetailModel : JSONModel

@property (nonatomic ,strong) NSString <Optional>*amount ;//金额

@property (nonatomic ,strong) NSString <Optional>*payer  ; //付款明细
@property (nonatomic ,strong) NSString <Optional>*serialNum  ; //流水号

@property (nonatomic ,strong) NSString <Optional>*applyNo ;//订单号
@property (nonatomic ,strong) NSString <Optional>*status  ; //确认状态
@property (nonatomic ,strong) NSString <Optional>*time  ; //处理时间

@property (nonatomic ,strong) NSString <Optional>*createTime ;//创建时间

@property (nonatomic ,strong) NSString <Optional>*tradeInfo ; //交易信息
@property (nonatomic ,strong) NSString <Optional>*type  ; //类型  1 借款，2 还款,3提现，4充值，5佣金

@property (nonatomic ,strong) NSString <Optional>*applyTime ;//申请时间
@property (nonatomic ,strong) NSString <Optional>*payForTime ;//审批时间
@property (nonatomic ,strong) NSString <Optional>*cardEndNum ;//银行卡尾号

@property (nonatomic ,strong) NSString <Optional>*repayPeriod ;// 还款期数
@property (nonatomic ,strong) NSString <Optional>*lendPeriod ;// 借款期数

@property (nonatomic ,strong) NSString <Optional>*customerBonus ;// 优惠券

@end
