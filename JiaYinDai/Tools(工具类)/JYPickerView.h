//
//  JYPickerView.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/18.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JYPickerViewBlock)(NSString* selectString);


@interface JYPickerView : UIView

@property(nonatomic,strong)  NSArray *rDataArray ;

@property (nonatomic ,copy) JYPickerViewBlock rSelectBlock ;

@end
