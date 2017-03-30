//
//  NSObject+JYLabel.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/3/30.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "NSObject+JYLabel.h"

@implementation NSObject (JYLabel)

- (UILabel*)jyCreateLabelWithTitle:(NSString*)title font:(CGFloat)font color:(UIColor*)color align:(NSTextAlignment) align{
    
    UILabel *label = [[UILabel alloc]init];
    label.text = title ;
    label.textColor = color ;
    label.font = [UIFont systemFontOfSize:font] ;
    label.textAlignment = align ;
    label.backgroundColor = [UIColor clearColor] ;
    
    return label ;
}

@end
