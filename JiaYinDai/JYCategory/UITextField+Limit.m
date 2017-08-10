//
//  UITextField+Limit.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/26.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "UITextField+Limit.h"

#import <objc/runtime.h>


static const char *maxLength = "maxLength";
 
@implementation UITextField (Limit)

-(NSInteger)rMaxLength {
    
    return [objc_getAssociatedObject(self, maxLength) integerValue];
    
}

-(void)setRMaxLength:(NSInteger)rMaxLength {
    objc_setAssociatedObject(self, maxLength, [NSNumber numberWithInteger:rMaxLength], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(void)jy_textViewEditChanged {
    UITextField *textView = self;
    NSString *toBeString = textView.text;
    
    // 键盘输入模式
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage;
    
    // 简体中文输入，包括简体拼音，健体五笔，简体手写
    if ([lang isEqualToString:@"zh-Hans"]) {
        
        //获取高亮部分
        UITextRange *selectedRange = [textView markedTextRange];
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            
            if (toBeString.length > self.rMaxLength) {
                textView.text = [toBeString substringToIndex:self.rMaxLength];
                [JYProgressManager  showBriefAlert:[NSString stringWithFormat:@"文字长度超出最大限度%zd",self.rMaxLength]] ;
                
            }
            
  
        } else{// 有高亮选择的字符串，则暂不对文字进行统计和限制
         }
        
    }else{
        if (toBeString.length > self.rMaxLength) {
            textView.text = [toBeString substringToIndex:self.rMaxLength];
            
            [JYProgressManager  showBriefAlert:[NSString stringWithFormat:@"文字长度超出最大限度%zd",self.rMaxLength]] ;
        }
 
        
    }
}


-(void)jy_nametextViewEditChanged {
    
    UITextField *textfield = self;
    
    //获取高亮部分
    UITextRange *selectedRange = [textfield markedTextRange];
    UITextPosition *position = [textfield positionFromPosition:selectedRange.start offset:0];
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        
        textfield.text = [self filterCharactor:textfield.text withRegex:@"[^\u4e00-\u9fa5]"];
        
        
        if (textfield.text.length > self.rMaxLength) {
            textfield.text = [textfield.text substringToIndex:self.rMaxLength];
            [JYProgressManager  showBriefAlert:[NSString stringWithFormat:@"文字长度超出最大限度%zd",self.rMaxLength]] ;
            
        }
        
        
    } else{// 有高亮选择的字符串，则暂不对文字进行统计和限制
     
    }
    
    
   }

-(NSString*)filterCharactor:(NSString *)string withRegex:(NSString *)regexStr{
    NSString *searchText = string;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:searchText options:NSMatchingReportCompletion range:NSMakeRange(0, searchText.length) withTemplate:@""];
    return result;
}


@end
