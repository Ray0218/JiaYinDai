//
//  JYFinanceRecordCell.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/7.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYFinanceRecordCell.h"

@interface JYFinanceRecordCell ()

@property (nonatomic,strong) UILabel *rTitleLabel ;
@property (nonatomic,strong) UILabel *rTimeLabel ;
@property (nonatomic,strong) UILabel *rMoneyLabel ;


@end

@implementation JYFinanceRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ;
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        [self buildSubViewsUI];
    }
    
    return self ;
}

-(void)buildSubViewsUI {

    [self.contentView addSubview:self.rTimeLabel];
    [self.contentView addSubview:self.rTitleLabel];
    [self.contentView addSubview:self.rMoneyLabel];
    
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(self.contentView).offset(15);
        
    }];
    
    
    [self.rTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rTitleLabel) ;
        make.top.equalTo(self.rTitleLabel.mas_bottom).offset(5) ;
        make.bottom.equalTo(self.contentView).offset(-15);
    }] ;
    
    [self.rMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15) ;
        make.centerY.equalTo(self.contentView) ;
    }] ;

}

#pragma mark- getter 

-(UILabel*)rTitleLabel {

    if (_rTitleLabel == nil) {
        _rTitleLabel = [self jyCreateLabelWithTitle:@"XXX产品名称" font:16 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rTitleLabel ;
}


-(UILabel*)rTimeLabel {
    
    if (_rTimeLabel == nil) {
        _rTimeLabel = [self jyCreateLabelWithTitle:@"2017-01-01" font:14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rTimeLabel ;
}

-(UILabel*)rMoneyLabel {
    
    if (_rMoneyLabel == nil) {
        _rMoneyLabel = [self jyCreateLabelWithTitle:@"+100.86" font:16 color:kTextBlackColor align:NSTextAlignmentRight] ;
    }
    
    return _rMoneyLabel ;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
