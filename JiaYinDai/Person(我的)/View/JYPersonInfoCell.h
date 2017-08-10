//
//  JYPersonInfoCell.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/7.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JYPernfoCellType) {
    JYPernfoCellTypeNormal , // 有右侧箭头

    JYPernfoCellTypeHeader, //头像
    JYPernfoCellTypeCode, //二维码
    JYPernfoCellTypeName, //姓名
};

@interface JYPersonInfoCell : UITableViewCell

@property (nonatomic,strong,readonly) UILabel *rTitleLabel ;
@property (nonatomic,strong,readonly) UILabel *rDetailLabel ;
@property (nonatomic,strong,readonly) UIImageView *rRightImgView ;


-(instancetype)initWithCellType:(JYPernfoCellType)type reuseIdentifier:(NSString *)reuseIdentifier ;

@end
