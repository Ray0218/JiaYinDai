//
//  JYFatherTableController.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/1.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYFatherTableController : UITableViewController

- (void)setNavRightButtonWithImage:(UIImage *)image title:(NSString *)title  ;

- (void)setNavLeftButtonWithImage:(UIImage *)image title:(NSString *)title  ;


//点击导航栏左按钮
- (void)pvt_clickButtonNavLeft ;
//点击导航栏右按钮
- (void)pvt_clickButtonNavRight  ;


@end
