//
//  JYActionSheet.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/8.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SeletedButtonIndex)(NSInteger Buttonindex);
typedef void(^CompleteAnimationBlock)(BOOL Complete);

@interface JYActionSheet : UIView


@property (nonatomic,strong) SeletedButtonIndex ButtonIndex;


-(instancetype) initWithCancelStr:(NSString *)str otherButtonTitles:(NSArray<NSString *> *)Titles AttachTitle:(NSString *)AttachTitle;

-(void)ButtonIndex:(SeletedButtonIndex)ButtonIndex;

// 突出显示
-(void)ChangeTitleColor:(UIColor *)color AndIndex:(NSInteger )index;



@end
