//
//  UIAlertView+Extern.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/6/6.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "UIAlertView+Extern.h"
#import <objc/runtime.h>

static char DISMISS_IDENTIFER;
static char CANCEL_IDENTIFER;

@implementation UIAlertView (Extern)

- (void)setDismissBlock:(DismissBlock)dismissBlock {
    objc_setAssociatedObject(self, &DISMISS_IDENTIFER, dismissBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (DismissBlock)dismissBlock {
    return objc_getAssociatedObject(self, &DISMISS_IDENTIFER);
}

- (void)setCancelBlock:(CancelBlock)cancelBlock {
    objc_setAssociatedObject(self, &CANCEL_IDENTIFER, cancelBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(CancelBlock)cancelBlock {
    return objc_getAssociatedObject(self, &CANCEL_IDENTIFER);
}

+ (UIAlertView*) alertViewWithTitle:(NSString*)title
                            message:(NSString*)message
                  cancelButtonTitle:(NSString*)cancelButtonTitle
                  otherButtonTitles:(NSArray*)otherButtons
                          onDismiss:(DismissBlock)dismissed
                           onCancel:(CancelBlock)cancelled {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:[self class]
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:nil];
    
    [alert setDismissBlock:dismissed];
    [alert setCancelBlock:cancelled];
    
    for(NSString *buttonTitle in otherButtons) {
        [alert addButtonWithTitle:buttonTitle];
    }
    
    [alert show];
    return alert;
}

+ (void)alertView:(UIAlertView*) alertView didDismissWithButtonIndex:(NSInteger) buttonIndex {
    
    if(buttonIndex == [alertView cancelButtonIndex]) {
        if (alertView.cancelBlock) {
            alertView.cancelBlock();
        }
    } else {
        if (alertView.dismissBlock) {
            alertView.dismissBlock(buttonIndex - 1); // 取消按钮为 0,确定按钮第一个减1,所以第一个从0开始
        }
    }
}

@end
