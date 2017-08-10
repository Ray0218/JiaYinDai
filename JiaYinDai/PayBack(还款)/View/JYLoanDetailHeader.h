//
//  JYLoanDetailHeader.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/12.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYRepayModel.h"


static NSString *kTitles[] = {@"借款期限（月）",@"综合月利（%）",@"最低还款金额（元）"} ;


@interface JYLoanDetailHeader : UIView

@property (nonatomic ,strong,readonly) UILabel *rMoneyLabel ; //金额
@property (nonatomic ,strong,readonly) UILabel *rSateLabel  ; //还款中
@property (nonatomic ,strong,readonly) UIImageView *rLeftImg  ; //

@property (nonatomic,strong,readonly) UIView *rBgView ;

@property (nonatomic ,strong,readonly) NSMutableArray *rTitlesArray ;




@end



typedef NS_ENUM(NSUInteger, JYLoanDetailCellType) {
    JYLoanDetailCellTypeButton, //含有按钮
    JYLoanDetailCellTypeOverButton, //逾期
    
    JYLoanDetailCellTypeLabOnly, //只有一行
};

@interface JYLoanDetailCell : UITableViewCell

@property (nonatomic ,strong,readonly) UIButton *rcommitButton ;

@property (nonatomic ,strong,readonly) UILabel *rMoneyLabel; //金额

@property (nonatomic ,strong,readonly) UILabel *rTimesLabel; //期数

//@property (nonatomic ,strong,readonly) UIButton *rOrderButton ; //预约

@property (nonatomic ,strong,readonly) UILabel *rOverLabel  ; //滞纳金额


-(instancetype)initWithCellType:(JYLoanDetailCellType)type reuseIdentifier:(NSString *)reuseIdentifier ;

@end


typedef NS_ENUM(NSUInteger, JYLoanCllType) {
    JYLoanCllTypeNormal,
    JYLoanCllTypeHeader,
};

@interface JYLoanTimesCell : UITableViewCell

@property (nonatomic ,setter=rSetDataModel:)JYRepayModel *rRepyModel ;
-(instancetype)initWithCellType:(JYLoanCllType)type reuseIdentifier:(NSString *)reuseIdentifier  ;

@end
