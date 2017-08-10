//
//  JYPasswordSetModel.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/7.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPasswordSetModel.h"

@implementation JYPasswordSetModel
+(BOOL)propertyIsIgnored:(NSString *)propertyName{

    return  YES ;
}


- (instancetype)initWithTitle:(NSString*)title fieldText:(NSString*)text placeHolder:(NSString*)place hasCode:(BOOL)hasCode
{
    self = [super init];
    if (self) {
        
        self.rTitle = title ;
        self.rTFTitle =text ;
        self.rTFPlaceholder = place ;
        self.rHasCode = hasCode ;
    }
    return self;
}


- (instancetype)initWithTitle:(NSString*)title fieldText:(NSString*)text placeHolder:(NSString*)place hasCode:(BOOL)hasCode pickerArr:(NSArray*)pickerArr{


    self = [super init];
    if (self) {
        
        self.rTitle = title ;
        self.rTFTitle =text ;
        self.rTFPlaceholder = place ;
        self.rHasCode = hasCode ;
        
        self.rPickerArray = [NSArray arrayWithArray:pickerArr] ;
    }
    return self;

}


@end
