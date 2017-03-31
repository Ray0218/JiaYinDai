//
//  JYPayStyleView.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/3/31.
//  Copyright © 2017年 嘉远控股. All rights reserved.
// 支付方式

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JYPayType) {
    JYPayTypeNormal,
   JYPayTypeAddBank,//添加银行卡
    JYPayTypeAcount, //账户余额
};

@interface JYPayStyleView : UIView

@end


@interface JYBuyRowView : UIView

- (instancetype)initWithLeftTitle:(NSString*)leftStr rightStr:(NSString*)rightStr ;

@end
