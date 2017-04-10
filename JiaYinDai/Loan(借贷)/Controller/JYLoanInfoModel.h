//
//  JYLoanInfoModel.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/10.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JYLoanInfoModel : JSONModel

@property (nonatomic ,strong) NSString *rLeftString ;

@property (nonatomic ,strong) NSString *rRightString ;


- (instancetype)initWithLeft:(NSString*)left right:(NSString*)right ;

@end
