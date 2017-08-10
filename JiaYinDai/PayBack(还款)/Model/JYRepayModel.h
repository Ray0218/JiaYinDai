//
//  JYRepayModel.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/5.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JYRepayModel : JSONModel

@property (nonatomic ,strong) NSString <Optional>*id  ;
@property (nonatomic ,strong) NSString <Optional>*overdue  ; //是否逾期 0未逾期
@property (nonatomic ,strong) NSString <Optional>*overdueAmount  ; //逾期金额
@property (nonatomic ,strong) NSString <Optional>*repayAmount  ; //应还金额

@property (nonatomic ,strong) NSString <Optional>*correlativeFee  ; //相关费用
@property (nonatomic ,strong) NSString <Optional>*perPrincple  ; //每期本金
@property (nonatomic ,strong) NSString <Optional>*repayDate  ; //还款日期
@property (nonatomic ,strong) NSString <Optional>*repayPeriod  ;// 第几期

@property (nonatomic ,strong) NSString <Optional>*repayState  ;//还款状态 0未还款，1还款中，2已还款


 


@end





@interface JYDdtailCreditOrder : JSONModel

@property (nonatomic ,strong) NSString <Optional>*manageFee  ; //管理费
@property (nonatomic ,strong) NSString <Optional>*principal  ; //借款本金
@property (nonatomic ,strong) NSString <Optional>*repayInterest ; //借款利息总计
@property (nonatomic ,strong) NSString <Optional>*repayPerAmount  ; //最低还款额
@property (nonatomic ,strong) NSString <Optional>*repayPeriod  ; //借款期数

@end

@interface JYLoanDetailModel : JSONModel



@property (nonatomic ,strong) JYDdtailCreditOrder <Optional>*creditOrder  ; //当前订单对象

@property (nonatomic ,strong) NSString <Optional>*manageRate ;//资金管理费


@property (nonatomic ,strong) NSString <Optional>*haveRepayPeriod  ; //已还期数

@property (nonatomic ,strong) NSString <Optional>*notHaveRepay ;//未还款的总期数

@property (nonatomic ,strong) JYRepayModel <Optional>*repay ;

@property (nonatomic ,strong) NSArray <JYRepayModel*>*repays ; //包含该订单下每期还款的对象

@property (nonatomic ,strong) NSString <Optional>*totalRepayment  ; //应还款总额
@property (nonatomic ,strong) NSString <Optional>*yearInterest  ; //年利率

@end
