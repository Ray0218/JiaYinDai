//
//  JYBankCardCell.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/10.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYBankCardCell.h"

@interface JYBankCardCell ()


@property (nonatomic ,strong) UILabel *rBankName ;
@property (nonatomic ,strong) UIImageView *rBankImg ;
@property (nonatomic ,strong) UILabel *rCardTypeLabel ;
@property (nonatomic ,strong) UILabel *rCardNumberLabel ;


@property (nonatomic ,strong) UIView *rBlueBackView ;

@property (nonatomic ,strong) UIView *rNormalBackView ;


@end

@implementation JYBankCardCell

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
        
        
        [self buildSubViewsUI] ;
    }
    
    return self ;
}

-(void)buildSubViewsUI {
    
    
    [self.contentView addSubview:self.rNormalBackView];
    [self.contentView addSubview:self.rBlueBackView] ;
    [self.contentView addSubview:self.rBankImg];
    [self.contentView addSubview:self.rBankName ];
    [self.contentView addSubview:self.rCardTypeLabel];
    [self.contentView addSubview:self.rCardNumberLabel];
    
    
    [self.rBlueBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15) ;
        make.right.equalTo(self.contentView).offset(-15) ;
        make.top.equalTo(self.contentView).offset(15) ;
        make.height.mas_equalTo(80) ;
    }] ;
    
    [self.rNormalBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15) ;
        make.right.equalTo(self.contentView).offset(-15) ;
        make.top.equalTo(self.contentView).offset(15) ;
        make.height.mas_equalTo(80) ;
    }] ;
    
    
    [self.rBankImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rBlueBackView).offset(15) ;
        make.width.and.height.mas_equalTo(40) ;
        make.centerY.equalTo(self.rBlueBackView);
    }] ;
    
    [self.rBankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rBankImg.mas_right).offset(15) ;
        make.bottom.equalTo(self.rBankImg.mas_centerY).offset(-5) ;
    }];
    
    [self.rCardTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rBankName) ;
        make.top.equalTo(self.rBankName.mas_bottom).offset(10) ;
    }] ;
    
    [self.rCardNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rCardTypeLabel.mas_right).offset(20) ;
        make.centerY.equalTo(self.rCardTypeLabel) ;
        make.right.equalTo(self.rBlueBackView).offset(-15) ;
    }] ;
    
}


#pragma mark- getter

-(UIView*)rBlueBackView {
    if (_rBlueBackView == nil) {
        _rBlueBackView = ({
            UIView *rBackView = [[UIView alloc]init];
            rBackView.backgroundColor = [UIColor whiteColor] ;
            rBackView.layer.cornerRadius = 5 ;
            rBackView.layer.borderWidth = 1 ;
            rBackView.layer.borderColor = kBlueColor.CGColor ;
            
            rBackView.layer.shadowColor = kBlueColor.CGColor ;
            rBackView.layer.shadowOpacity = 1 ;
            rBackView.layer.shadowOffset = CGSizeMake(0, 0) ;
            
            rBackView ;
        }) ;
        _rBlueBackView.hidden = YES ;
    }
    
    return _rBlueBackView ;
}

-(UIView*)rNormalBackView {
    if (_rNormalBackView == nil) {
        _rNormalBackView = ({
            UIView *rBackView = [[UIView alloc]init];
            rBackView.backgroundColor = [UIColor whiteColor] ;
            rBackView.layer.cornerRadius = 5 ;
            rBackView.layer.borderWidth = 1 ;
            rBackView.layer.borderColor = kLineColor.CGColor ;
            
            rBackView ;
        }) ;
    }
    
    return _rNormalBackView ;
}

-(UIImageView*)rBankImg {
    
    if (_rBankImg == nil) {
        _rBankImg = [[UIImageView alloc]init];
        _rBankImg.backgroundColor = [UIColor clearColor] ;
        _rBankImg.image = [UIImage imageNamed:@"01030000"] ;
        
    }
    return _rBankImg ;
}

-(UILabel*)rBankName {
    
    if (_rBankName == nil) {
        _rBankName = [self jyCreateLabelWithTitle:@"农业银行" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    return _rBankName ;
}

-(UILabel*)rCardTypeLabel {
    
    if (_rCardTypeLabel == nil) {
        _rCardTypeLabel = [self jyCreateLabelWithTitle:@"储蓄卡" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    return _rCardTypeLabel ;
}

-(UILabel*)rCardNumberLabel {
    
    if (_rCardNumberLabel == nil) {
        _rCardNumberLabel = [self jyCreateLabelWithTitle:@"**** **** **** 0798" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    return _rCardNumberLabel ;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.rNormalBackView.hidden = selected ;
    self.rBlueBackView.hidden = !selected ;
    // Configure the view for the selected state
}

@end


@implementation JYAddBankCardCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ;
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        self.backgroundColor =
        self.contentView.backgroundColor = [UIColor clearColor] ;
        
        
        [self buildSubViewsUI] ;
    }
    
    return self ;
}

-(void)buildSubViewsUI {
    
    UILabel *label = [self jyCreateLabelWithTitle:@"＋添加卡片" font:18 color:kBlueColor align:NSTextAlignmentCenter];
    
    [self.contentView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView) ;
    }] ;
    
    
}


@end


















