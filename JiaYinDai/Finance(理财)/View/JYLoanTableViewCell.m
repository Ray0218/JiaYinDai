//
//  JYLoanTableViewCell.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/1.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoanTableViewCell.h"


@interface JYLoanTableViewCell (){
    
    UIImageView *rImgView ;// 图片
    UILabel *rTitle ; //申请金额
    
    UIButton *rAddBtn ; //加
    UIButton *rMinusBtn ; //减
}


@property (nonatomic ,strong) UILabel *rMinLabel ; //最小金额
@property (nonatomic ,strong) UILabel *rMaxLabel ; //最大金额
@property (nonatomic ,strong) UITextField *rTextField ; //输入框


@end
@implementation JYLoanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ;
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        self.contentView.backgroundColor = [UIColor whiteColor] ;
        [self buildSubViewsUI];
    }
    
    return self ;
}


-(void)buildSubViewsUI{
    
    
    rImgView = [[UIImageView alloc]init];
    rImgView.backgroundColor = [UIColor orangeColor] ;
    [self.contentView addSubview:rImgView];
    
    
    rTitle = [self jyCreateLabelWithTitle:@"申请金额（元）" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    [self.contentView addSubview:rTitle];
    
    
    rAddBtn = ({
        
        UIButton *btn =[ UIButton buttonWithType:UIButtonTypeCustom] ;
        [btn setTitle:@"＋" forState:UIControlStateNormal] ;
        btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter ;
        btn.titleLabel.font = [UIFont systemFontOfSize:30] ;
        btn.backgroundColor = [UIColor clearColor] ;
        btn.frame = CGRectMake(0, 0, 30, 30);
        [btn setTitleColor:kBlueColor forState:UIControlStateNormal];
        
        @weakify(self)
        [[[btn rac_signalForControlEvents:UIControlEventTouchUpInside]filter:^BOOL(id value) {
            @strongify(self)
            if ([self.rTextField.text integerValue] >= 10000) {
                return NO ;
            }
            return YES ;
        }]subscribeNext:^(id x) {
            @strongify(self)
            
            self.rTextField.text = [NSString stringWithFormat:@"%zd",[self.rTextField.text integerValue]+1] ;
            
            
        }] ;
        
        btn ;
    }) ;
    
    rMinusBtn = ({
        
        UIButton *btn =[ UIButton buttonWithType:UIButtonTypeCustom] ;
        [btn setTitle:@"－" forState:UIControlStateNormal] ;
        btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter ;
        btn.titleLabel.font = [UIFont systemFontOfSize:30] ;
        btn.backgroundColor = [UIColor clearColor] ;
        btn.frame = CGRectMake(0, 0, 30, 30);
        [btn setTitleColor:kBlueColor forState:UIControlStateNormal];
        
        
        @weakify(self)
        [[[btn rac_signalForControlEvents:UIControlEventTouchUpInside]filter:^BOOL(id value) {
            @strongify(self)
            if ([self.rTextField.text integerValue] <= 0) {
                return NO ;
            }
            return YES ;
        }]subscribeNext:^(id x) {
            @strongify(self)
            
            self.rTextField.text = [NSString stringWithFormat:@"%zd",[self.rTextField.text integerValue]-1] ;
            
        }] ;
        
        
        btn ;
    }) ;
    
    [self.contentView addSubview:self.rTextField];
    [self.contentView addSubview:self.rMinLabel];
    [self.contentView addSubview:self.rMaxLabel];
    
    
    [self layoutSubviewsContstraints];
    
}

-(void)layoutSubviewsContstraints {
    
    [rImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(self.contentView).offset(15) ;
        make.width.and.height.mas_equalTo(25) ;
    }] ;
    
    [rTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rImgView.mas_right).offset(15) ;
        make.centerY.equalTo(rImgView) ;
    }] ;
    
    [self.rTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView) ;
        make.top.equalTo(rImgView.mas_bottom).offset(20) ;
        make.left.equalTo(self.contentView).offset(70) ;
        make.right.equalTo(self.contentView).offset(-70) ;
        
    }];
    
    
    [self.rMinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rTextField.mas_bottom).offset(20) ;
        make.left.equalTo(self.contentView).offset(15) ;
        make.bottom.equalTo(self.contentView).offset(-20);
        make.height.mas_equalTo(20) ;
    }] ;
    
    [self.rMaxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rTextField.mas_bottom).offset(20) ;
        make.right.equalTo(self.contentView).offset(-15) ;
        make.bottom.equalTo(self.contentView).offset(-20);
        make.height.mas_equalTo(20) ;
        
    }] ;
}


#pragma mark - getter

-(UITextField*)rTextField {
    
    if (_rTextField == nil) {
        _rTextField = [[UITextField alloc]init];
        _rTextField.leftViewMode = UITextFieldViewModeAlways ;
        _rTextField.rightViewMode = UITextFieldViewModeAlways ;
        _rTextField.leftView = rMinusBtn ;
        _rTextField.rightView = rAddBtn ;
        _rTextField.text = @"1000" ;
        _rTextField.textAlignment = NSTextAlignmentCenter ;
        _rTextField.keyboardType = UIKeyboardTypeNumberPad ;
        _rTextField.font = [UIFont systemFontOfSize:50] ;
        _rTextField.textColor = kBlueColor ;
    }
    
    return _rTextField ;
}

-(UILabel*)rMinLabel {
    
    if (_rMinLabel == nil) {
        _rMinLabel = [self jyCreateLabelWithTitle:@"3000" font:16 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rMinLabel ;
}


-(UILabel*)rMaxLabel {
    
    if (_rMaxLabel == nil) {
        _rMaxLabel = [self jyCreateLabelWithTitle:@"5000" font:16 color:kTextBlackColor align:NSTextAlignmentRight] ;
    }
    
    return _rMaxLabel ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
