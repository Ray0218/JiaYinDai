//
//  JYLoanInfoController.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/10.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYFatherController.h"

@interface JYLoanInfoController : JYFatherController

@property (nonatomic ,strong) NSString *rProductId ; //产品id

@property (nonatomic ,strong) NSString *rPrincipal ; //购买金额

@property (nonatomic ,strong) NSString *rRepayPeriod ; //还款期限

@property (nonatomic ,strong) NSString *rServiceFee ;//服务费

@property (nonatomic ,strong) NSString *rManageFee ;//管理费


@property (nonatomic ,strong) NSString *RepayAmount ;//还款总额

@property (nonatomic ,strong) NSString *RepayPerAmount ;//每月最低还款

@property (nonatomic ,strong) NSString *RrepayInterest ;//利息

@end
