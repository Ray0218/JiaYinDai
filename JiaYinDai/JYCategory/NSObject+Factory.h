//
//  NSObject+Factory.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/3/31.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Factory)
- (UILabel*)jyCreateLabelWithTitle:(NSString*)title font:(CGFloat)font color:(UIColor*)color align:(NSTextAlignment) align ;

-(UIButton*)jyCreateButtonWithTitle:(NSString*)title  ;


@end
