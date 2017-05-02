//
//  JYSupportBankController.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/2.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYFatherController.h"
typedef void(^JYBankSelectBlock)(NSString* bankName);

@interface JYSupportBankController : JYFatherController

@property(nonatomic ,copy) JYBankSelectBlock rSelectBlock ;


@end



@interface JYSupportBankCell : UITableViewCell


@end
