//
//  JYRedGiftCell.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/14.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JYRedBonusModel.h"


@interface JYRedGiftCell : UITableViewCell

@property (nonatomic ,strong,readonly) UIImageView *rBottomView ;

@property (nonatomic ,strong,readonly) UILabel *rTitleLabel ;

@property (nonatomic ,strong,readonly) UILabel *rTimeLabel ; //有效期
@property (nonatomic ,strong,readonly) UILabel *rMoneyLabel ; //金额
@property (nonatomic ,strong,readonly) UILabel *rTypeLabel ; //单位


@property (nonatomic ,strong,readonly) UILabel *rUseInfoLabel ;  //使用说明

@property (nonatomic ,strong,readonly) UILabel *rStatusLabel ;  //单期，全额说明


@property (nonatomic ,strong,readonly) UIImageView *rOverImage ; //过期图标


@property (nonatomic ,strong) JYRedBonusModel *rDataModel ;


@property (nonatomic ,strong,readonly) UIImageView *rNormalBackView ;

-(void)setTitlesColor:(UIColor*)color  ;



@end
