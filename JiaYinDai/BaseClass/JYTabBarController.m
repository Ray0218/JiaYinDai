//
//  JYTabBarController.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/22.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYTabBarController.h"
#import "JYFinanceViewController.h"
#import "JYLoanViewController.h"
#import "JYPersonViewController.h"

 


#define kClassVCKey   @"rootVCClass"
#define kTitleKey     @"title"
#define kImageKey     @"imageName"
#define kSelImageKey  @"selectedImageName"

@implementation JYTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
    
    
    NSArray *childItemsArray = @[
                                 
                                 @{kClassVCKey  : @"JYFinanceViewController",
                                   kTitleKey    : @"理财",
                                   kImageKey    : @"tab_financialGray",
                                   kSelImageKey : @"tab_finance"},
                                 
                                 @{kClassVCKey  : @"JYLoanViewController",
                                   kTitleKey    : @"借贷",
                                   kImageKey    : @"tab_LoanGray",
                                   kSelImageKey : @"tab_loan"},
                                 
                                 @{kClassVCKey  : @"JYPersonViewController",
                                     kTitleKey    : @"我的",
                                   kImageKey    : @"tab_myGray",
                                   kSelImageKey : @"tab_my"}];
    
    
    NSMutableArray *controlls = [[NSMutableArray alloc]initWithCapacity:childItemsArray.count] ;
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = [NSClassFromString(dict[kClassVCKey]) new];
        vc.title = dict[kTitleKey];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        
        UITabBarItem *item = nav.tabBarItem;
        
        item.title =  dict[kTitleKey];
//        [item setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)] ;
        
        item.image = [UIImage imageNamed:dict[kImageKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImageKey]] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : kBlueColor} forState:(UIControlStateSelected)];
        
        
        [controlls addObject:nav];
    }];
    self.viewControllers = controlls;
}



@end
