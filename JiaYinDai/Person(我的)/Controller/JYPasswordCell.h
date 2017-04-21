//
//  JYPasswordCell.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/7.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYPasswordSetModel.h"


typedef NS_ENUM(NSUInteger, JYPassCellType) {
    JYPassCellTypeNormal,
    JYPassCellTypeCode, //验证码
    JYPassCellTypeArrow, //有右侧箭头
    JYPassCellTypeEye, //隐藏密码功能
    
    JYPassCellTypeTwoBtn, //两个按钮


 };

@interface JYPasswordCell : UITableViewCell

@property (nonatomic, strong,readonly) UILabel*rTitleLabel ;
@property (nonatomic, strong,readonly) UITextField*rTextField  ;
@property (nonatomic, strong,readonly) UIButton *rRightArrow  ;

@property (nonatomic, strong,readonly) UIButton *rManButton  ;
@property (nonatomic, strong,readonly) UIButton *rWomenButton  ;



-(instancetype)initWithCellType:(JYPassCellType)type reuseIdentifier:(NSString *)reuseIdentifier maxWidth:(CGFloat)width ;

-(instancetype)initWithCellType:(JYPassCellType)type reuseIdentifier:(NSString *)reuseIdentifier ;


-(void)setDataModel:(JYPasswordSetModel*)model ;

@end
