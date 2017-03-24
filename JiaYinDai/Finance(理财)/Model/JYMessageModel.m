//
//  JYMessageModel.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/24.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYMessageModel.h"

static NSString *kSystemCellIdentifier = @"kSystemCellIdentifier";
static NSString *kAcionCellIdentifier = @"kAcionCellIdentifier";
static NSString *kDealCellIdentifier = @"kDealCellIdentifier";

@implementation JYMessageModel

+(BOOL)propertyIsIgnored:(NSString *)propertyName {
    return  YES ;
}


- (NSString *)rDealIndentifier {
    return kDealCellIdentifier;
}

- (NSString *)rActionIdentifier {
    return kAcionCellIdentifier;
}

- (NSString *)rSystemIdentifier {
    return kSystemCellIdentifier;
}


- (NSInteger)numberOfRowsWithMessageType:(JYDateFormatType )type {
    
    return self.rDataArray.count ;
}

 


@end
