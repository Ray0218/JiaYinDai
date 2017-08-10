//
//  JYRedBonusModel.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/11.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JYRedBonusModel : JSONModel

@property (nonatomic ,strong) NSString <Optional>* amount ; //金额
@property (nonatomic ,strong) NSString <Optional>*beginTime ; //生效时间
@property (nonatomic ,strong) NSString <Optional>*endTime  ; //过期时间

@property (nonatomic ,strong) NSString <Optional>*expiryDate  ;
@property (nonatomic ,strong) NSString <Optional>*giveCondition  ;

@property (nonatomic ,strong) NSString <Optional>*givenType  ; //1代表红包，2代表抵用券
@property (nonatomic ,strong) NSString <Optional>*id  ;
@property (nonatomic ,strong) NSString <Optional>*name  ; //名字
@property (nonatomic ,strong) NSString <Optional>*rate  ; //比率


@property (nonatomic ,strong) NSString <Optional>*used ;//是否使用0未使用 1已使用
@property (nonatomic ,strong) NSString <Optional>*isOver ;//是否过期 0未过期 1已过期

@property (nonatomic ,strong) NSString <Optional>*conditionAmount ;//使用条件：还款额度达到多少元,
@property (nonatomic ,strong) NSString <Optional>*couponsStatus ;// 0红包 1 单期 2全额
@property (nonatomic ,strong) NSString <Optional>*conditionRepayPeriod ; ///使用条件：连续还款多少次

@end
