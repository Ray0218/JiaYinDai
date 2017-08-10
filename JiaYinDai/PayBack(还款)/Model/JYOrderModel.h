//
//  JYOrderModel.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/4.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <JSONModel/JSONModel.h>


 
@interface JYRecentRepay : JSONModel

@property (nonatomic ,strong)NSString <Optional>*overdue ; //最近一期是否逾期 0未逾期，1已逾期


@end




@interface JYCreditProduct : JSONModel

@property (nonatomic ,strong)NSString <Optional>*applyNo ;  //订单号
@property (nonatomic ,strong)NSString <Optional>*lendTime  ; //计息时间
@property (nonatomic ,strong)NSString <Optional>*repayAmount  ; // 应还金额

@property (nonatomic ,strong)NSString <Optional>*repayPerAmount  ; // 应还金额

@property (nonatomic ,strong)NSString <Optional>*repayPeriod  ;//总期数

@end







@interface JYOrderModel : JSONModel


@property (nonatomic ,strong)JYCreditProduct <Optional>*creditOrder ;

@property (nonatomic ,strong)NSString <Optional>*haveRepayPeriod ; //已还款期数

@property (nonatomic ,strong)NSString <Optional>*principalSum  ; // 累计借款

@property (nonatomic ,strong)JYRecentRepay <Optional>*recentRepay  ;

@property (nonatomic ,strong)NSString <Optional>*recentDate  ; //本期还款日

@property (nonatomic ,strong)NSString <Optional>*successCnt ;//成功借款*笔

@property (nonatomic ,strong)NSString <Optional>*totalRepayment  ;//应还款总额





@end
