//
//  JYTabBar.h
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/24.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYTabBarItem : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *badgeValue; //消息个数
@property (nonatomic, assign) NSInteger tag;

- (instancetype)initWithTitle:(NSString *)title;
 @end

@interface JYTabBar : UIView

@property (nonatomic, strong, readonly) RACSignal *rac_signalForSelectedItem;
@property (nonatomic, assign, readonly) NSInteger selectedIndex;
@property (nonatomic, copy) NSArray *items;
@property (nonatomic, weak) JYTabBarItem *selectedItem;

- (void)setSelectedItem:(JYTabBarItem *)selectedItem animation:(BOOL)animation  ;
@end
