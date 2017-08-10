//
//  JYBillDetailController.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/24.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYFatherController.h"


typedef NS_ENUM(NSUInteger, JYBillDetailType) {
    JYBillDetailTypeLoan = 1, //借款
    JYBillDetailTypePayBack =2, //还款

    JYBillDetailTypeDraw =3, //提现
    JYBillDetailTypeCharge =4, //充值

    JYBillDetailTypeFee = 5,//佣金
};

@interface JYBillDetailController : JYFatherController

@property (nonatomic ,strong) NSString *rBillId ;


- (instancetype)initWithType:(JYBillDetailType) type ;


@end
