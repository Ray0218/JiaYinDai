//
//  UIAlertView+Extern.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/6/6.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^DismissBlock)(NSInteger buttonIndex);
typedef void (^CancelBlock)();

@interface UIAlertView (Extern)

 
/**
 *  快速创建
 *
 *  @param title             标题
 *  @param message           内容
 *  @param cancelButtonTitle 取消按钮内容
 *  @param otherButtons      其他按钮数组
 *  @param dismissed         其他那妞句柄
 *  @param cancelled         取消按钮句柄
 *
 *  @return UIAlertView对象
 */
+ (UIAlertView*) alertViewWithTitle:(NSString*) title
                            message:(NSString*) message
                  cancelButtonTitle:(NSString*) cancelButtonTitle
                  otherButtonTitles:(NSArray*) otherButtons
                          onDismiss:(DismissBlock) dismissed
                           onCancel:(CancelBlock) cancelled;


@property (nonatomic, copy) DismissBlock dismissBlock;
@property (nonatomic, copy) CancelBlock cancelBlock;

@end
