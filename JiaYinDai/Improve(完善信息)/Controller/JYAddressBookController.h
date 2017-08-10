//
//  JYAddressBookController.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/6/7.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYFatherController.h"
#import <PPGetAddressBook.h>

 

typedef void(^SelectedItem)(NSString *nameStr ,NSString *telNum);


@interface JYAddressBookController : JYFatherController

@property (strong, nonatomic) SelectedItem block;

- (void)didSelectedItem:(SelectedItem)block;


@end
