//
//  UITextField+Limit.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/26.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Limit)

@property (nonatomic ,assign) NSInteger rMaxLength ;


 
-(void)jy_textViewEditChanged  ;

-(void)jy_nametextViewEditChanged  ;



@end
