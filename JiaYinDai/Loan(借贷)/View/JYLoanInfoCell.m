//
//  JYLoanInfoCell.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/10.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoanInfoCell.h"

@implementation JYLoanInfoCell

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
    
    UILabel *lLabel = [self jyCreateLabelWithTitle:@"" font:16 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    UILabel *rLabel = [self jyCreateLabelWithTitle:@"" font:16 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    
    lLabel.attributedText = TTFormateTitleString(@"额度(元)", 16, 12,3,kBlackColor,kTextBlackColor);
                                                 
     rLabel.attributedText = TTFormateTitleString(@"周期(月)", 16, 12, 3,kBlackColor,kTextBlackColor);

    UIView *rMiddleLine = ({
        UIView *view = [[UIView alloc]init] ;
        view.backgroundColor = kLineColor ;
        view ;
    }) ;
    [self.contentView addSubview:rMiddleLine] ;
    
    [self.contentView addSubview:lLabel];
    [self.contentView addSubview:rLabel];

    [self.contentView addSubview:self.rLeftLabel];
    [self.contentView addSubview:self.rRightLabel];
    
    [lLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.equalTo(self.contentView) ;
        make.left.equalTo(self.contentView).offset(15) ;
        make.right.equalTo(self.rLeftLabel.mas_left).offset(-5) ;
        make.width.mas_greaterThanOrEqualTo(60) ;
    }] ;
    
    [self.rLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lLabel.mas_right).offset(5) ;
        make.right.equalTo(self.mas_centerX).offset(-15) ;
        make.centerY.equalTo(self.contentView) ;
    }];
    
    [rLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(15) ;
        make.centerY.equalTo(self.contentView) ;
        make.width.mas_greaterThanOrEqualTo(60) ;

    }];
    
    [self.rRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView) ;
        make.right.equalTo(self.contentView).offset(-15);
        make.left.equalTo(rLabel.mas_right).offset(5) ;
    }];
    
    [rMiddleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.width.mas_equalTo(1) ;
        make.height.mas_equalTo(35) ;
    }];
}


#pragma mark- getter 

-(UILabel*)rLeftLabel {

    if (_rLeftLabel == nil) {
        _rLeftLabel = [self jyCreateLabelWithTitle:@"30000" font:16 color:kBlueColor align:NSTextAlignmentRight] ;
        
    }
    
    return _rLeftLabel ;
}

-(UILabel*)rRightLabel {
    
    if (_rRightLabel == nil) {
        _rRightLabel = [self jyCreateLabelWithTitle:@"3" font:16 color:kBlueColor align:NSTextAlignmentRight] ;
        
    }
    
    return _rRightLabel ;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
