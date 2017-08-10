//
//  JYPayBackController.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/13.
//  Copyright © 2017年 嘉远控股. All rights reserved.
// 开始还款

#import "JYFatherController.h"

@interface JYPayBackController : JYFatherController

@property (nonatomic ,strong) NSArray *rThreeTitles ;

@property (nonatomic ,strong) NSString *rTotalRepayment ; //总还款金额

@property (nonatomic ,strong) NSString *rHaveRepayCount ;//已还期数


@property (nonatomic ,strong) NSString *rNotHaveRepayCount ;//未还期数

@property (nonatomic ,strong) NSString *rCurrentPayMoney ;//本期应还

@property (nonatomic ,strong) NSString *rSumDueAmount ;//滞纳金


@property (nonatomic ,strong) NSString *rapplyNo ;//订单号

@property (nonatomic ,strong) NSString *repayId ;//


@end
