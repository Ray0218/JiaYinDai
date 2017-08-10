//
//  JYAddressBookCell.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/6/7.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PPPersonModel.h"

@interface JYAddressBookCell : UITableViewCell


@property (strong, nonatomic) UIImageView *rHeaderImage;

@property (strong, nonatomic) UIImageView *rLeftImage;

@property (strong, nonatomic) UILabel *rNameLabel;
@property (strong, nonatomic) UILabel *rTelLabel;


- (void)configCellWithModel:(PPPersonModel *)model;

 
@end
