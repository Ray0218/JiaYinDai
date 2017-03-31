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

@class JYBuyRowView ;
@interface JYPayStyleView : UIView

@property (nonatomic,strong,readonly)JYBuyRowView *rRedView ; //红包
@property (nonatomic,strong,readonly)JYBuyRowView *rPayStyleView ; //支付方式

- (instancetype)initWithType:(JYPayType)type ;


@end


typedef NS_ENUM(NSUInteger, JYRowType) {
    JYRowTypeNormal,
    JYRowTypeTextField, //有输入框
    JYRowTypeBankIcon,//有图标
};

@interface JYBuyRowView : UIView

- (instancetype)initWithLeftTitle:(NSString*)leftStr rowType:(JYRowType)rowType ;

@end
