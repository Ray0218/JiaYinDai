//
//  JYPayBackCell.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/13.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPayBackCell.h"

@interface JYPayBackCell ()
                          
@property (nonatomic, strong) UILabel*rTitleLabel ;

@property (nonatomic, strong) UISwitch *rSwitch ;


@end

@implementation JYPayBackCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] ;
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        
        [self buildSubViewsUI];
    }
    
    return self ;
}

-(void)buildSubViewsUI {

    [self.contentView addSubview:self.rTitleLabel];
    [self.contentView addSubview:self.rSwitch];
    
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15) ;
        make.centerY.equalTo(self.contentView);
    }] ;
    
    [self.rSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15) ;
        make.top.equalTo(self.contentView).offset(10) ;
        make.bottom.equalTo(self.contentView).offset(-10) ;
    }] ;
}


#pragma mark- gtter -

-(UILabel*)rTitleLabel {
    
    if (_rTitleLabel == nil) {
        _rTitleLabel = [self jyCreateLabelWithTitle:@"全部还款" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rTitleLabel ;
}

-(UISwitch*)rSwitch {
    if (_rSwitch == nil) {
        _rSwitch = [[UISwitch alloc]init];
    }
    
    return _rSwitch ;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
