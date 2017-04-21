//
//  JYSlider.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/21.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYSlider.h"

@implementation JYSlider


- (CGRect)trackRectForBounds:(CGRect)bounds
{
    bounds = [super trackRectForBounds:bounds]; // 必须通过调用父类的trackRectForBounds 获取一个 bounds 值，否则 Autolayout 会失效，UISlider 的位置会跑偏。
    return CGRectMake(bounds.origin.x, bounds.origin.y-4, bounds.size.width, 10); // 这里面的h即为你想要设置的高度。
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
