//
//  JYMessageCell.h
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/27.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYMessageModel.h"


@interface JYMessageCell : UITableViewCell


@property (nonatomic,strong,readonly) UILabel *rDetailLabel ;
@property (nonatomic,strong,readonly) UIImageView *rBackgroundView ;


@property (nonatomic ,strong) JYMessageModel *rDataModel ;


@end
