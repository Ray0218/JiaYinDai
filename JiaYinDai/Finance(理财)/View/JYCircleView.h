//
//  JYCircleView.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/1.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^JYCircleReturnBlock)(void);

@interface JYCircleView : UIView


@property (nonatomic,copy) JYCircleReturnBlock rReturnBlock ;

@end
