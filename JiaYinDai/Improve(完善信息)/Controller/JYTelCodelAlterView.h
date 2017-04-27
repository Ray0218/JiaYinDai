//
//  JYTelCodelAlterView.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/20.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JYCodeAlterType) {
    JYCodeAlterTypeNormal,
    JYCodeAlterTypeAgain,
 };

@interface JYTelCodelAlterView : UIViewController

- (instancetype)initWithAlterType:(JYCodeAlterType)type ;


@end
