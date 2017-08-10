//
//  JYRedCardController.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/14.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYFatherController.h"
#import "JYRedGiftCell.h"



typedef NS_ENUM(NSUInteger, JYRedCardType) {
    JYRedCardTypeBoth,
    JYRedCardTypeOutBonus, //过期红包
    JYRedCardTypeOutVouche, //过期抵用券
    
 };


typedef void(^JYRedCardBlock)(JYRedBonusModel *model );

@interface JYRedCardController : JYFatherController

@property (nonatomic ,strong) NSMutableArray *rDataArray ;


@property (nonatomic ,assign) BOOL rClickNotBack ; //点击不返回



@property (nonatomic ,copy) JYRedCardBlock rSelectBlock ;

@property (nonatomic ,assign) BOOL rIsAllPay ;//是否全额还款

@property (nonatomic ,strong) NSString *rContiueRepayCount ;//连续还款期数

@property (nonatomic ,strong) NSString *rConditionAmount ;//使用条件：还款额度达到多少元,


- (instancetype)initWithType:(JYRedCardType)type ;


@end
