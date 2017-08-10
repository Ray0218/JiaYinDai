//
//  JYRecordPayController.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/14.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYFatherController.h"

@interface JYRecordPayController : JYFatherController


@property (nonatomic ,strong) NSArray *rThreeTitles ;

@property (nonatomic ,strong) NSString *rTotalRepayment ; //总还款金额

@property (nonatomic ,strong) NSString *rHaveRepayCount ;//已还期数

@property (nonatomic ,strong) NSString *rCurrentPayMoney ;//本期应还

@property (nonatomic ,strong) NSString *rSumDueAmount ;//滞纳金


@property (nonatomic ,strong) NSString *rCreateTime ;//还款日期



@property (nonatomic ,strong) NSString *rapplyNo ;//
@property (nonatomic ,strong) NSString *repayId ;//






@end
