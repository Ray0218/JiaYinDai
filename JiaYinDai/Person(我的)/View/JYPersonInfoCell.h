//
//  JYPersonInfoCell.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/7.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JYPernfoCellType) {
    JYPernfoCellTypeNormal , //

    JYPernfoCellTypeHeader,
    JYPernfoCellTypeCode,
    JYPernfoCellTypeName,
};

@interface JYPersonInfoCell : UITableViewCell

@property (nonatomic,strong,readonly) UILabel *rTitleLabel ;
@property (nonatomic,strong,readonly) UILabel *rDetailLabel ;
@property (nonatomic,strong,readonly) UIImageView *rRightImgView ;


-(instancetype)initWithCellType:(JYPernfoCellType)type reuseIdentifier:(NSString *)reuseIdentifier ;

@end
