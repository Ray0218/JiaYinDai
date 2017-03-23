//
//  UINavigationController+swizzle.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/22.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "UINavigationController+swizzle.h"
#import <objc/runtime.h>

@implementation UINavigationController (swizzle)

+(void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class] ;
        
        SEL originalSelector = @selector(pushViewController:animated:) ;
        SEL swizzledSelector = @selector(jy_pushViewController:animated:);
        
        Method originalMethod =  class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
    
}

-(void)jy_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES ;
    }
    [self jy_pushViewController:viewController animated:animated];
}

@end

