//
//  JYPersonCell.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/6.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPersonCell.h"

@interface JYPersonCell ()

@property (nonatomic,strong) UIImageView* rLeftImg ;
@property (nonatomic,strong) UILabel* rTitleLabel ;
@property (nonatomic ,strong) UILabel *rRightLabel ;

@end

@implementation JYPersonCell

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


#pragma mark -data

-(void)rSetCellDtaWithDictionary:(NSDictionary*)dic {

    self.rLeftImg.image =[ UIImage imageNamed:dic[keyImage]] ;
    self.rTitleLabel.text = dic[keyTitle] ;
}



-(void)buildSubViewsUI {

    [self.contentView addSubview:self.rLeftImg];
    [self.contentView addSubview:self.rTitleLabel];
    [self.contentView addSubview:self.rRightImg];
    
    [self.contentView addSubview:self.rRightLabel];
    
    [self.rLeftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15) ;
        make.centerY.equalTo(self.contentView) ;
        make.width.and.height.mas_equalTo(35) ;
    }] ;
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rLeftImg.mas_right).offset(5) ;
        make.centerY.equalTo(self.contentView) ;
    }];
    
    [self.rRightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView) ;
        make.right.equalTo(self.contentView).offset(-15) ;
//        make.width.height.mas_equalTo(25) ;
    }] ;
    
    
    [self.rRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView) ;
        make.right.equalTo(self.rRightImg.mas_left).offset(-5) ;
    }] ;

}

 
#pragma mark -getter

-(UIImageView*)rLeftImg {

    if (_rLeftImg == nil) {
        _rLeftImg = [[UIImageView alloc]init];
        _rLeftImg.contentMode = UIViewContentModeCenter ;
        _rLeftImg.backgroundColor = [UIColor clearColor] ;
    }
    
    return _rLeftImg ;
}

-(UILabel*)rTitleLabel {

    if (_rTitleLabel == nil) {
        _rTitleLabel = [self jyCreateLabelWithTitle:@"" font:16 color:kBlackColor align:NSTextAlignmentLeft ] ;
    }
    
    return _rTitleLabel ;
}


-(UILabel*)rRightLabel {
    
    if (_rRightLabel == nil) {
        _rRightLabel = [self jyCreateLabelWithTitle:@"" font:16 color:kTextBlackColor align:NSTextAlignmentRight ] ;
    }
    
    return _rRightLabel ;
}


-(UIImageView*)rRightImg {

    if (_rRightImg == nil) {
        _rRightImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more"]];
    }
    
    return _rRightImg ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
