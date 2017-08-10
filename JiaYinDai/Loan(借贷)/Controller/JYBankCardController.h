//
//  JYBankCardController.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/10.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYFatherController.h"
#import "JYBankModel.h"



typedef NS_ENUM(NSUInteger, JYBankCardVCType) {
    JYBankCardVCTypeManager, //银行卡管理
    JYBankCardVCTypCharge, // 充值
    JYBankCardVCTypDraw, // 提取
    JYBankCardVCTypPay, // 支付


 };

typedef void(^JYBankSelectBlock)(JYBankModel* bankModel);


@interface JYBankCardController : JYFatherController

@property (nonatomic ,copy) JYBankSelectBlock rBankBlock ;

- (instancetype)initWithType:(JYBankCardVCType)type ;



@end
