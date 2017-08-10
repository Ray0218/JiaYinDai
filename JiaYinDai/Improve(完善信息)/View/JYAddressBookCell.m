//
//  JYAddressBookCell.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/6/7.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYAddressBookCell.h"

@implementation JYAddressBookCell

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
    
    [self.contentView addSubview:self.rLeftImage];
    [self.contentView addSubview:self.rHeaderImage];
    [self.contentView addSubview:self.rNameLabel];
    [self.contentView addSubview:self.rTelLabel];
    
    
    [self.rLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20) ;
        
        make.left.equalTo(self.contentView).offset(15) ;
        make.centerY.equalTo(self.contentView) ;
        
    }] ;
    
    
    [self.rHeaderImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.width.height.mas_equalTo(35) ;
        make.top.equalTo(self.contentView).offset(7.5) ;
        make.bottom.equalTo(self.contentView).offset(-7.5) ;
        make.left.equalTo(self.rLeftImage.mas_right).offset(10) ;
    }] ;
    
    
    [self.rNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rHeaderImage.mas_right).offset(10) ;
        make.top.equalTo(self.rHeaderImage) ;
    }] ;
    
    [self.rTelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rNameLabel) ;
        make.bottom.equalTo(self.contentView).offset(-7.5) ;
    }] ;
    
}
- (void)configCellWithModel:(PPPersonModel *)model{
    
    if (model.headerImage) {
        self.rHeaderImage.image = model.headerImage;
    }else{
        [UIImage imageNamed:@"book_header"] ;
    }
    self.rNameLabel.text =  model.name;
    
    if (model.mobileArray.count) {
        self.rTelLabel.text =  [NSString stringWithFormat:@"手机号：%@",[model.mobileArray firstObject]];
    }else{
        
        self.rTelLabel.text =   @"手机号：";
        
    }
    
}


#pragma mark- getter

-(UIImageView*)rHeaderImage {
    
    if (_rHeaderImage == nil) {
        _rHeaderImage = [[UIImageView alloc]init];
        _rHeaderImage.backgroundColor = kBackGroundColor ;
        _rHeaderImage.image = [UIImage imageNamed:@"book_header"] ;
    }
    
    return _rHeaderImage ;
}



-(UIImageView*)rLeftImage {
    if (_rLeftImage == nil) {
        _rLeftImage = [[UIImageView alloc]init];
        _rLeftImage.image = [UIImage imageNamed:@"book_normal"] ;
        _rLeftImage.highlightedImage = [UIImage imageNamed:@"book_select"] ;

    }
    
    return _rLeftImage ;

}

-(UILabel*)rNameLabel {
    
    if (_rNameLabel == nil) {
        _rNameLabel = [self jyCreateLabelWithTitle:@"" font:15 color:kBlackColor align:NSTextAlignmentLeft] ;
    }
    return _rNameLabel ;
}

-(UILabel*)rTelLabel {
    
    if (_rTelLabel == nil) {
        _rTelLabel = [self jyCreateLabelWithTitle:@"" font:13 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rTelLabel ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.rLeftImage.highlighted = selected ;
    
    // Configure the view for the selected state
}

@end
