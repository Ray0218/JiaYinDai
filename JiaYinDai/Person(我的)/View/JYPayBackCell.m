//
//  JYPayBackCell.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/13.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPayBackCell.h"

@interface JYPayBackCell (){
    JYPayBackCellType rType ;
}

@property (nonatomic, strong) UILabel*rTitleLabel ;

@property (nonatomic,strong) UILabel *rMiddleLabel ;

@property (nonatomic,strong) UILabel *rRightLabel ;
@property (nonatomic, strong) UITextField*rTextField  ;



@property (nonatomic, strong) UISwitch *rSwitch ;

@property (nonatomic,strong) UIImageView *rArrowView ;
@property (nonatomic,strong) UIButton *rRightButton ;




@end

@implementation JYPayBackCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(instancetype)initWithCellType:(JYPayBackCellType)type reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] ;
    
    if (self) {
        
        rType = type ;
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        
        if (type == JYPayBackCellTypeHeader) {
            self.backgroundColor = 
            self.contentView.backgroundColor = [UIColor clearColor] ;
        }
        
        [self buildSubViewsUI];
    }
    
    return self ;
}

-(void)buildSubViewsUI {
    
    [self.contentView addSubview:self.rTitleLabel];
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15) ;
        make.centerY.equalTo(self.contentView);
    }] ;
    
    
    if (rType == JYPayBackCellTypeSwitch) {
        [self.contentView addSubview:self.rSwitch];
        
        [self.rSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15) ;
            make.top.equalTo(self.contentView).offset(10) ;
            make.bottom.equalTo(self.contentView).offset(-10) ;
        }] ;
        
    }else if (rType == JYPayBackCellTypeTextField){
        
        [self.rTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15) ;
            make.centerY.equalTo(self.contentView);
            make.width.mas_lessThanOrEqualTo(80) ;
        }] ;
        
        
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = kLineColor ;
        [self.contentView addSubview:lineView];
        
        [self.contentView addSubview:self.rTextField];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.rTitleLabel.mas_right).offset(10) ;
            make.width.mas_equalTo(1) ;
            make.centerY.equalTo(self.contentView) ;
            make.height.mas_equalTo(25) ;
        }];
        
        [self.rTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-5) ;
            make.centerY.equalTo(self.contentView) ;
            make.left.equalTo(lineView.mas_right).offset(10) ;
        }] ;
        
        
        
    } else if (rType == JYPayBackCellTypeTextFieldButton){
        
        
        [self.rTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15) ;
            make.centerY.equalTo(self.contentView);
            make.width.mas_lessThanOrEqualTo(80) ;
        }] ;
        
        
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = kLineColor ;
        [self.contentView addSubview:lineView];
        
        [self.contentView addSubview:self.rTextField];
        [self.contentView addSubview:self.rRightButton];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.rTitleLabel.mas_right).offset(10) ;
            make.width.mas_equalTo(1) ;
            make.centerY.equalTo(self.contentView) ;
            make.height.mas_equalTo(25) ;
        }];
        
        [self.rTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rRightButton.mas_left).offset(-5) ;
            make.centerY.equalTo(self.contentView) ;
            
            make.left.equalTo(lineView.mas_right).offset(10) ;
        }] ;
        
        
        [self.rRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.contentView).offset(-15) ;
            make.centerY.equalTo(self.contentView) ;
        }] ;
        
        
        
    }else if (rType == JYPayBackCellTypeHeader){
    
        [self.contentView addSubview:self.rRightLabel];
        [self.contentView addSubview:self.rMiddleLabel];
        
        
        [self.rMiddleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.rTitleLabel.mas_right).offset(10) ;
            make.centerY.equalTo(self.contentView) ;
            
        }] ;
        
        
        [self.rRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15) ;
            make.centerY.equalTo(self.contentView) ;
        }] ;
        
        
    } else{
        
        [self.contentView addSubview:self.rRightLabel];
        [self.contentView addSubview:self.rArrowView];
        
        [self.rArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15) ;
            make.centerY.equalTo(self.contentView) ;
        }] ;
        
        [self.rRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rArrowView.mas_left).offset(-5) ;
            make.centerY.equalTo(self.contentView) ;
            
        }] ;
        
    }
    
    
}


#pragma mark- gtter -

-(UILabel*)rTitleLabel {
    
    if (_rTitleLabel == nil) {
        _rTitleLabel = [self jyCreateLabelWithTitle:@"本期应还款" font:14 color:kBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rTitleLabel ;
}

-(UILabel*)rRightLabel {
    if (_rRightLabel == nil) {
        _rRightLabel = [self jyCreateLabelWithTitle:@"" font:14 color:kTextBlackColor align:NSTextAlignmentRight] ;
    }
    
    return _rRightLabel ;
}

-(UILabel*)rMiddleLabel {
    if (_rMiddleLabel == nil) {
        _rMiddleLabel = [self jyCreateLabelWithTitle:@"XXXX.00" font:19 color:kBlueColor align:NSTextAlignmentLeft] ;
    }
    
    return _rMiddleLabel ;
}


-(UITextField*)rTextField {
    if (_rTextField == nil) {
        _rTextField = [[UITextField alloc]init];
        _rTextField.backgroundColor =[ UIColor clearColor] ;
        _rTextField.font = [UIFont systemFontOfSize:13] ;
        _rTextField.placeholder  = @"选择余额" ;
        
        
        
    }
    return _rTextField ;
}


-(UIImageView*)rArrowView {
    
    if (_rArrowView == nil) {
        _rArrowView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"more"] jy_imageWithTintColor:kBlackColor]] ;
    }
    
    return _rArrowView ;
}

-(UIButton*)rRightButton {
    
    if (_rRightButton == nil) {
        _rRightButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [_rRightButton setTitle:@"全部还款" forState:UIControlStateNormal] ;
        [_rRightButton setTitleColor:kBlackColor forState:UIControlStateNormal] ;
        _rRightButton.titleLabel.font = [UIFont systemFontOfSize:16] ;
    }
    
    return _rRightButton ;
}


-(UISwitch*)rSwitch {
    if (_rSwitch == nil) {
        _rSwitch = [[UISwitch alloc]init];
        _rSwitch.onTintColor = kBlueColor ;
    }
    
    return _rSwitch ;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
