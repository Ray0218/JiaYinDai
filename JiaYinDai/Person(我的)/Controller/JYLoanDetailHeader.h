//
//  JYLoanDetailHeader.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/12.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYLoanDetailHeader : UIView

@property (nonatomic ,strong,readonly) UILabel *rMoneyLabel ; //金额
 @property (nonatomic ,strong,readonly) UILabel *rSateLabel  ; //还款中


@end



typedef NS_ENUM(NSUInteger, JYLoanDetailCellType) {
    JYLoanDetailCellTypeButton, //含有按钮
    JYLoanDetailCellTypeLabOnly, //只有一行
 };

@interface JYLoanDetailCell : UITableViewCell

@property (nonatomic ,strong,readonly) UIButton *rcommitButton ;

@property (nonatomic ,strong,readonly) UILabel *rMoneyLabel; //金额

@property (nonatomic ,strong,readonly) UILabel *rTimesLabel; //期数

@property (nonatomic ,strong,readonly) UIButton *rOrderButton ; //预约

-(instancetype)initWithCellType:(JYLoanDetailCellType)type reuseIdentifier:(NSString *)reuseIdentifier ;

@end



typedef NS_ENUM(NSUInteger, JYLoanCllType) {
    JYLoanCllTypeNormal,
    JYLoanCllTypeHeader,
 };

@interface JYLoanTimesCell : UITableViewCell


-(instancetype)initWithCellType:(JYLoanCllType)type reuseIdentifier:(NSString *)reuseIdentifier  ;

@end
