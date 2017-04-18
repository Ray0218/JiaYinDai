//
//  JYIdentifyHeader.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/17.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAddImgView.h"

typedef NS_ENUM(NSUInteger, JYIdentifyType) {
    JYIdentifyTypeName,
    JYIdentifyTypeBank,
    JYIdentifyTypePassword,
};

@interface JYIdentifyHeader : UIView

- (instancetype)initWithType:(JYIdentifyType)type ;


@end
