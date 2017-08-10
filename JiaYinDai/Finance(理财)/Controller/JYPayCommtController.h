//
//  JYPayCommtController.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/3/31.
//  Copyright © 2017年 嘉远控股. All rights reserved.
// 确认交易

#import "JYFatherController.h"
#import "JYBankModel.h"

typedef NS_ENUM(NSUInteger, JYPayCommitType) {
    JYPayCommitTypeCharge, //充值
    JYPayCommitTypeDraw, //提现
    JYPayCommitTypeLoan, //借贷
    
    
    JYPayCommitTypePayBackAcount, //账户余额还款
    JYPayCommitTypePayBackAllAcount, //账户余额全部还款

    
    JYPayCommitTypePayBackBank, //银行卡账户余额
 
    JYPayCommitTypePayAllBackBank, //银行卡全额还款


 };

@interface JYPayCommtController : JYFatherController

@property(nonatomic ,strong) JYBankModel *rBankModel ;

@property(nonatomic ,strong) NSString *rOrderNo ; //订单号

@property(nonatomic ,strong) NSString *rMoneyNum ; //钱数

@property(nonatomic ,strong) NSMutableDictionary *rLoanDic ; //借款订单


- (instancetype)initWithType:(JYPayCommitType)type ;


@end
