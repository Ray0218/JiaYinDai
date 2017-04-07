//
//  JYMyFinanceCell.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/6.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JYMyFinanceType) {
    JYMyFinanceTypeNormal, //投资中
    JYMyFinanceTypeFinish,//已回款
 };

@interface JYMyFinanceCell : UITableViewCell

-(instancetype)initWithCellType:(JYMyFinanceType)type reuseIdentifier:(NSString *)reuseIdentifier  ;


@end



@interface JYMYFinanceHeader : UIView

@end
