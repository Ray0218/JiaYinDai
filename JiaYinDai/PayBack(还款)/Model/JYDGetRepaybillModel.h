//
//  JYDGetRepaybillModel.h
//  JiaYinDai
//
//  Created by 陈侠 on 2017/5/17.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JYDGetRepaybillModel : JSONModel


@property (nonatomic ,strong) NSString <Optional>*amount  ;// 金额
@property (nonatomic ,strong) NSString <Optional>*applyNo  ;//订单号
@property (nonatomic ,strong) NSString <Optional>*createTime  ;// 交易时间
@property (nonatomic ,strong) NSString <Optional>*endDate  ;//截止日期
@property (nonatomic ,strong) NSString <Optional>*id  ;
@property (nonatomic ,strong) NSString <Optional>*period  ;//第几期
@property (nonatomic ,strong) NSString <Optional>*productName  ; //产品名称


@end
