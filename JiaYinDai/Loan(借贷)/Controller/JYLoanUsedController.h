//
//  JYLoanUsedController.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/10.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYFatherController.h"


typedef void(^JYLoanUsedBlock)(NSString *rTitle,NSString *rDetail);

@interface JYLoanUsedController : JYFatherController

@property (nonatomic ,copy) JYLoanUsedBlock rUsedBlock ;

@property (nonatomic ,strong) NSString *rTitleStr ;
@property (nonatomic ,strong) NSString *rDetailStr ;


@end
