//
//  JYFinanceCell.h
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/27.
//  Copyright © 2017年 嘉远控股. All rights reserved.
// 理财页面Cell

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JYFinanceCellType) {
    JYFinanceCellTypeBegin, //已开始
    JYFinanceCellTypeNotBegin, //未开始
    JYFinanceCellTypeOver, //售罄
};


@interface JYFinanceCell : UITableViewCell

-(instancetype)initWithCellType:(JYFinanceCellType)type reuseIdentifier:(NSString *)reuseIdentifier ;


@end
