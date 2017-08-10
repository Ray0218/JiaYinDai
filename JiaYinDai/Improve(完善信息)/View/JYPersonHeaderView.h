//
//  JYPersonHeaderView.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/6.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYPersonHeaderView : UIView


@property (nonatomic ,strong,readonly) UIImageView *rHeaderImg ; //头像
@property (nonatomic ,strong,readonly) UILabel *rUserNameLabel ; //用户名
@property (nonatomic ,strong,readonly) UILabel *rUserTelLabel ; //电话号码


@property (nonatomic ,strong,readonly)UIButton *rRightArrow ;

@property (nonatomic ,strong,readonly) UIButton *rFinishButton ;

@property (nonatomic ,strong,readonly) UIButton * rMoneyButton ; //金额
@property (nonatomic ,strong,readonly) UILabel * rMoneyLabel ; //金额

@property (nonatomic ,strong,readonly) UIButton *rBankCardButton ; //银行卡
@property (nonatomic ,strong,readonly) UILabel *rBankCardLabel ; //银行卡



@property (nonatomic ,strong,readonly) UIButton *rMiddleButton ;


@end
