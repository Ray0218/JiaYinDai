//
//  JYFatherController.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/23.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYFatherController.h"

/************************* 导航栏宏定义 *************************/
#define NAV_TITLE_COLOR [UIColor whiteColor]
#define NAV_TITLE_FONT [UIFont systemFontOfSize:18.0]
#define NAV_BACKGROUND_COLOR  [UIColor whiteColor]
#define NAV_BUTTON_WIDTH 44.0
#define NAV_BUTTON_HEIGHT 44.0
#define NAV_BUTTON_FONT [UIFont systemFontOfSize:15.0]
#define NAV_BUTTON_COLOR [UIColor whiteColor]
#define NAV_LEFTBUTTON_ICON [UIImage imageNamed:@"return"]
#define NAV_HEIGHT 64.0


@interface JYFatherController ()

@end

@implementation JYFatherController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //背景颜色
    //    self.view.backgroundColor = UIColorFromRGB(0x005dad);
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self loadNavigationSetting];
    
}

- (void)loadNavigationSetting {
    //设置导航栏为不透明
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //    //导航栏标题颜色和字体大小
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:18], NSFontAttributeName,nil]];
    //    //导航栏背景颜色设置
    [self.navigationController.navigationBar setBackgroundImage:[UIImage jy_imageWithColor:UIColorFromRGB(0x005dad)] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage jy_imageWithColor:UIColorFromRGB(0xdddddd)];
    
    
    [self setNavLeftButtonWithImage:NAV_LEFTBUTTON_ICON title:@""];
}

//设置导航栏左按钮图片和标题
- (void)setNavLeftButtonWithImage:(UIImage *)image title:(NSString *)title {
    UIButton *buttonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonLeft.frame = CGRectMake(0, 0, NAV_BUTTON_WIDTH, NAV_BUTTON_HEIGHT);
    buttonLeft.backgroundColor = [UIColor clearColor];
    [buttonLeft setTitle:title forState:UIControlStateNormal];
    [buttonLeft setTitleColor:NAV_BUTTON_COLOR forState:UIControlStateNormal];
    buttonLeft.titleLabel.font = NAV_BUTTON_FONT;
    buttonLeft.titleLabel.numberOfLines = 0;
    [buttonLeft setImage:image forState:UIControlStateNormal];
    
    [buttonLeft setImage:[image jy_imageWithTintColor:UIColorFromRGB(0xe5e5e5)] forState:UIControlStateHighlighted];
    
    [buttonLeft addTarget:self action:@selector(pvt_clickButtonNavLeft) forControlEvents:UIControlEventTouchUpInside];
    //buttonLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    UIView *viewButton = [[UIView alloc] init];
    viewButton.frame = CGRectMake(0, 0, NAV_BUTTON_WIDTH, NAV_BUTTON_HEIGHT);
    [viewButton addSubview:buttonLeft];
    buttonLeft.exclusiveTouch = YES ;
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -15;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,[[UIBarButtonItem alloc] initWithCustomView:viewButton]];
}

#pragma mark ---设置导航栏右按钮图片和标题
//设置导航栏右按钮图片和标题
- (void)setNavRightButtonWithImage:(UIImage *)image title:(NSString *)title {
    UIButton *buttonRight = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonRight.frame = CGRectMake(self.view.frame.size.width-NAV_BUTTON_WIDTH, 0, NAV_BUTTON_WIDTH, NAV_BUTTON_HEIGHT);
    [buttonRight setTitle:title forState:UIControlStateNormal];
    [buttonRight setTitleColor:NAV_BUTTON_COLOR forState:UIControlStateNormal];
    [buttonRight setTitleColor:[UIColor colorWithWhite:0 alpha:0.6] forState:UIControlStateHighlighted];
    
    buttonRight.titleLabel.font = NAV_BUTTON_FONT;
    buttonRight.titleLabel.numberOfLines = 0;
    [buttonRight setImage:image forState:UIControlStateNormal];
    [buttonRight setImage:[image jy_imageWithTintColor:UIColorFromRGB(0xe5e5e5)] forState:UIControlStateHighlighted];
    
    
    [buttonRight addTarget:self action:@selector(pvt_clickButtonNavRight) forControlEvents:UIControlEventTouchUpInside];
    buttonRight.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonRight];
}


#pragma mark -action
//点击导航栏左按钮
- (void)pvt_clickButtonNavLeft {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


//点击导航栏右按钮
- (void)pvt_clickButtonNavRight  {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
