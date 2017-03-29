//
//  JYBetTableViewCell.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/29.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYBetTableViewCell.h"

@interface JYBetTableViewCell ()

@property (nonatomic,strong) UIView *rBackView ; //背景
@property (nonatomic,strong) UILabel *rPersonNoLab ; //借款人编号
@property (nonatomic,strong) UILabel *rNameLabel ; //姓名
@property (nonatomic,strong) UILabel *rCardId ; //身份证号
@property (nonatomic,strong) UILabel *rTotalMoneyLab ; //借款总额
@property (nonatomic,strong) UILabel *rAddressLab ; //借款地区
@property (nonatomic,strong) UILabel *rUseLabel ; //借款用途


@end

static inline NSMutableAttributedString * TTPersonLabString( NSString*baseText,NSString *text ){
    
    NSMutableAttributedString *att = [[NSMutableAttributedString  alloc]initWithString:text attributes:@{NSForegroundColorAttributeName:kBlueColor}] ;
    
    [att addAttribute:NSForegroundColorAttributeName value: kTextBlackColor range:NSMakeRange(0,baseText.length)] ;
    
    return att ;
    
} ;

@implementation JYBetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ;
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        self.backgroundColor =
        
        self.contentView.backgroundColor = [UIColor clearColor] ;
        
        [self buildSubViewsUI];
        
    }
    return self ;
}

-(void)buildSubViewsUI {
    
    
    self.rPersonNoLab.attributedText = TTPersonLabString(@"借款人编号：", @"借款人编号：6723738948923") ;
    
    [self.contentView addSubview:self.rBackView];
    [self.contentView addSubview:self.rPersonNoLab];
    [self.contentView addSubview:self.rNameLabel];
    [self.contentView addSubview:self.rCardId];
    [self.contentView addSubview:self.rTotalMoneyLab];
    [self.contentView addSubview:self.rAddressLab];
    [self.contentView addSubview:self.rUseLabel];
    
    
    [self.rBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15) ;
        make.right.equalTo(self.contentView).offset(-15) ;
        make.height.mas_equalTo(220) ;
        make.top.and.bottom.equalTo(self.contentView) ;
    }] ;
    
    [self.rPersonNoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15) ;
        make.left.equalTo(self.contentView).offset(30) ;
        
    }];
    
    [self.rNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rPersonNoLab);
        make.top.equalTo(self.rPersonNoLab.mas_bottom).offset(30) ;
    }];
    
    [self.rCardId mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rPersonNoLab) ;
        make.top.equalTo(self.rNameLabel.mas_bottom).offset(5) ;
    }];
    
    [self.rTotalMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rPersonNoLab) ;
        make.top.equalTo(self.rCardId.mas_bottom).offset(5) ;
    }];
    
    [self.rAddressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rPersonNoLab) ;
        make.top.equalTo(self.rTotalMoneyLab.mas_bottom).offset(5) ;
    }];
    
    [self.rUseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-15) ;
        make.left.equalTo(self.rPersonNoLab) ;
    }];
    
    
}

#pragma mark- getter

-(UIView*)rBackView {
    if (_rBackView == nil) {
        _rBackView = [[UIView alloc]init];
        _rBackView.backgroundColor = [UIColor whiteColor] ;
        _rBackView.layer.cornerRadius = 5 ;
        _rBackView.layer.borderWidth = 1 ;
        _rBackView.layer.borderColor = kLineColor.CGColor ;
        _rBackView.clipsToBounds = YES ;
    }
    
    return _rBackView ;
    
}

-(UILabel*)rPersonNoLab {
    if (_rPersonNoLab == nil) {
        _rPersonNoLab = [self createLabelWithText:@"借款人编号：6723738948923" textColor:kTextBlackColor] ;
    }
    return _rPersonNoLab ;
}



-(UILabel*)rNameLabel {
    if (_rNameLabel == nil) {
        _rNameLabel = [self createLabelWithText:@"借款人姓名：莫**" textColor:kTextBlackColor] ;
    }
    return _rNameLabel ;
}

-(UILabel*)rCardId {
    if (_rCardId == nil) {
        _rCardId = [self createLabelWithText:@"身份证号：3321********2736" textColor:kTextBlackColor] ;
    }
    return _rCardId ;
}

-(UILabel*)rTotalMoneyLab {
    if (_rTotalMoneyLab == nil) {
        _rTotalMoneyLab = [self createLabelWithText:@"借款总额：50000.00元"   textColor:kTextBlackColor] ;
    }
    return _rTotalMoneyLab ;
}

-(UILabel*)rAddressLab {
    if (_rAddressLab == nil) {
        _rAddressLab = [self createLabelWithText:@"借款地区：杭州市" textColor:kTextBlackColor] ;
    }
    return _rAddressLab ;
}

-(UILabel*)rUseLabel {
    if (_rUseLabel == nil) {
        _rUseLabel = [self createLabelWithText:@"借款用途：巴拉巴拉" textColor:kTextBlackColor] ;
    }
    return _rUseLabel ;
}





-(UILabel*)createLabelWithText:(NSString*)text  textColor:(UIColor*)textColor  {
    
    UILabel*label = [[UILabel alloc]init];
    label.text = text ;
    label.font = [UIFont systemFontOfSize:16] ;
    label.textColor = textColor ;
    label.textAlignment = NSTextAlignmentLeft ;
    
    return label ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
