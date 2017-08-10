//
//  JYLoanTableViewCell.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/1.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYSlider.h"


@interface JYLoanTableViewCell : UITableViewCell

@property (nonatomic ,strong,readonly) UILabel *rMinLabel ; //最小金额
@property (nonatomic ,strong,readonly) UILabel *rMaxLabel ; //最大金额

@property (nonatomic ,strong,readonly) UITextField *rTextField ; //输入框

@property (nonatomic ,strong,readonly) JYSlider *rSliderView ;


@end


typedef void(^JYTimeSlectBlock)(NSInteger index);

@interface JYLoanTimeCell : UITableViewCell

@property (nonatomic ,assign) NSInteger rSelectIndex ;


@property (nonatomic ,copy) JYTimeSlectBlock rSelectBlock ;

@end


static NSString *kTimetitle[] = {@"1个月",@"3个月",@"6个月",@"9个月",@"12个月"} ;



 
