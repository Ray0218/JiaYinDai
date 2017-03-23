//
//  UIViewController+Transition.h
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/22.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Transition)


- (void)jy_showViewController:(UIViewController *)vc completion:(void (^)(void))completion  ;

@end
