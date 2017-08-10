//
//  JYFatherController.h
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/23.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JYMaskPosition) {
    JYMaskPositionTopRight,
    JYMaskPositionTopCenter,
    JYMaskPositionCenter,
};



@interface JYFatherController : UIViewController<UIGestureRecognizerDelegate>



@property (nonatomic ,strong,readonly) UIButton *rQuestButton ; //常见问题

@property (nonatomic ,strong,readonly) UIButton *rTelButton ;//联系客服


 
 
 
- (void)setNavRightButtonWithImage:(UIImage *)image title:(NSString *)title  ;

- (void)setNavLeftButtonWithImage:(UIImage *)image title:(NSString *)title  ;


//点击导航栏左按钮
- (void)pvt_clickButtonNavLeft ;
//点击导航栏右按钮
- (void)pvt_clickButtonNavRight  ;

//停止刷新
-(void)pvt_endRefresh ;


-(void)pvt_quest  ;


 -(void)pvt_dismissGuideView:(UIGestureRecognizer*)gesture  ;
 
- (void)pvt_addGuideView:(NSString*) imageName  View:(UIView*)view Position:(JYMaskPosition) position ;



-(void)pvt_loadData ;

@end



/************************* 导航栏宏定义 *************************/
#define NAV_TITLE_COLOR [UIColor whiteColor]
#define NAV_TITLE_FONT [UIFont systemFontOfSize:18.0]
#define NAV_BACKGROUND_COLOR  [UIColor whiteColor]
#define NAV_BUTTON_WIDTH 80.0
#define NAV_BUTTON_HEIGHT 44.0
#define NAV_BUTTON_FONT [UIFont systemFontOfSize:15.0]
#define NAV_BUTTON_COLOR [UIColor whiteColor]
#define NAV_LEFTBUTTON_ICON [UIImage imageNamed:@"return"]
#define NAV_HEIGHT 64.0

