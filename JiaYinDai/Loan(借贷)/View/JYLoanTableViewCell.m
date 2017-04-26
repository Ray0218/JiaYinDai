//
//  JYLoanTableViewCell.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/1.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoanTableViewCell.h"
#import "JYSlider.h"



@interface JYLoanTableViewCell (){
    
    UIImageView *rImgView ;// 图片
    UILabel *rTitle ; //申请金额
    
    UIButton *rAddBtn ; //加
    UIButton *rMinusBtn ; //减
}


@property (nonatomic ,strong) UILabel *rMinLabel ; //最小金额
@property (nonatomic ,strong) UILabel *rMaxLabel ; //最大金额
@property (nonatomic ,strong) UITextField *rTextField ; //输入框
@property (nonatomic ,strong) JYSlider *rSliderView ;


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
    rImgView.image = [UIImage imageNamed:@"home_money"] ;
    rImgView.contentMode = UIViewContentModeCenter ;
    rImgView.backgroundColor = [UIColor clearColor] ;
    [self.contentView addSubview:rImgView];
    
    
    rTitle = [self jyCreateLabelWithTitle:@"申请金额（元）" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    [self.contentView addSubview:rTitle];
    
    
    [self.contentView addSubview:self.rSliderView];
    
    
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
        make.width.and.height.mas_equalTo(20) ;
    }] ;
    
    [rTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rImgView.mas_right).offset(5) ;
        make.centerY.equalTo(rImgView) ;
    }] ;
    
    [self.rTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView) ;
        make.top.equalTo(rImgView.mas_bottom).offset(20) ;
        make.left.equalTo(self.contentView).offset(70) ;
        make.right.equalTo(self.contentView).offset(-70) ;
        make.height.mas_equalTo(60) ;
        
    }];
    
    
    [self.rMinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rTextField.mas_bottom).offset(20) ;
        make.left.equalTo(self.contentView).offset(15) ;
        make.bottom.equalTo(self.contentView).offset(-20);
        //        make.height.mas_greaterThanOrEqualTo(20) ;
    }] ;
    
    [self.rMaxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rTextField.mas_bottom).offset(20) ;
        make.right.equalTo(self.contentView).offset(-15) ;
        make.bottom.equalTo(self.contentView).offset(-20);
        //        make.height.mas_equalTo(20) ;
        
    }] ;
    
    [self.rSliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rMinLabel.mas_right).offset(10) ;
        make.right.equalTo(self.rMaxLabel.mas_left).offset(-10) ;
        make.centerY.equalTo(self.rMinLabel) ;
//        make.height.mas_equalTo(60) ;
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

-(JYSlider*)rSliderView {

    if (_rSliderView == nil) {
        _rSliderView = [[JYSlider alloc]init];
        _rSliderView.backgroundColor = [UIColor clearColor] ;
        _rSliderView.minimumTrackTintColor =kBlueColor;
        _rSliderView.maximumTrackTintColor =  UIColorFromRGB(0xb9dfff) ;
        [_rSliderView setThumbImage:[UIImage imageNamed:@"loan_slider"] forState:UIControlStateNormal];
        _rSliderView.minimumValue = 3000 ;
        _rSliderView.maximumValue = 5000 ;
        _rSliderView.value = 3500 ;
    }
    
    return _rSliderView ;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


@interface JYLoanTimeCell (){
    
    NSMutableArray *rButtonArray ;
}


@property (nonatomic ,strong) UILabel *rTitle ;

@end

@implementation JYLoanTimeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier] ;
    if (self) {
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        self.backgroundColor=
        self.contentView.backgroundColor = [UIColor clearColor] ;
        [self buildSubViewsUI];
        
    }
    
    return self ;
}


-(void)buildSubViewsUI {
    
    [self.contentView addSubview:self.rTitle];
    [self.rTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(self.contentView).offset(15) ;
    }] ;
    
    rButtonArray = [NSMutableArray arrayWithCapacity:5] ;
    
    
    
    static NSString *title[] = {@"1个月",@"3个月",@"6个月",@"9个月",@"12个月"} ;
    for (int i= 0; i< 5; i++) {
        UIButton *btn = [self creatButtonWithButtonTitle:title[i]] ;
        [self.contentView addSubview:btn];
        [rButtonArray addObject:btn];
    }
    
    
    [rButtonArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:5 leadSpacing:15 tailSpacing:15];
    
    [rButtonArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rTitle.mas_bottom).offset(15) ;
        make.height.mas_equalTo(30) ;
        make.bottom.equalTo(self.contentView).offset(-15) ;
    }] ;
    
    
}


-(UILabel*)rTitle {
    
    if (_rTitle == nil) {
        _rTitle = [self jyCreateLabelWithTitle:@"申请期限" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rTitle ;
}


-(UIButton*)creatButtonWithButtonTitle:(NSString*)title {
    
    UIButton *btn  = [ self jyCreateButtonWithTitle:title] ;
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setTitleColor:kTextBlackColor forState:UIControlStateNormal];
    
    [btn setBackgroundImage:[UIImage jy_imageWithColor:kBlueColor] forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage jy_imageWithColor:kBlueColor] forState:UIControlStateHighlighted];
    
    [btn setBackgroundImage:[UIImage jy_imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    
    
    btn.layer.borderWidth = 1 ;
    btn.layer.borderColor = kLineColor.CGColor ;
    btn.layer.cornerRadius = 4 ;
    
    btn.titleLabel.font = [UIFont systemFontOfSize:16] ;
    btn.backgroundColor = [UIColor clearColor] ;
    
    
    [[[btn rac_signalForControlEvents:UIControlEventTouchUpInside]filter:^BOOL(UIButton* value) {
        
        
        return !value.selected ;
        
    } ] subscribeNext:^(UIButton* button) {
        
        
        [rButtonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UIButton *btn = (UIButton*)obj ;
            btn.selected = NO ;
            
        }] ;
        
        button.selected = YES ;
        
    }] ;
    
    return btn ;
    
}

@end




