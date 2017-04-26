//
//  JYPayBackCell.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/13.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JYPayBackCellType) {
    JYPayBackCellTypeNormal, //有右箭头

    JYPayBackCellTypeSwitch,
    JYPayBackCellTypeTextField, //只有左边view
    JYPayBackCellTypeTextFieldButton, //右边有按钮
    JYPayBackCellTypeHeader, //本期应还 XXX.00  已还期数


};

@interface JYPayBackCell : UITableViewCell


@property (nonatomic, strong,readonly) UILabel*rTitleLabel ;
@property (nonatomic,strong,readonly) UILabel *rMiddleLabel ;

@property (nonatomic,strong,readonly) UILabel *rRightLabel ;
@property (nonatomic, strong,readonly) UITextField*rTextField  ;



-(instancetype)initWithCellType:(JYPayBackCellType)type reuseIdentifier:(NSString *)reuseIdentifier  ;


@end
