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
    
    
    rTitle = [self jyCreateLabelWithTitle:@"申请金额（元）" font:14 color:kBlackColor align:NSTextAlignmentLeft] ;
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
            if ([self.rTextField.text integerValue] >= [self.rMaxLabel.text integerValue]) {
                [JYProgressManager showBriefAlert:@"金额不能大于最大限额"];
                
                return NO ;
            }
            return YES ;
        }]subscribeNext:^(id x) {
            @strongify(self)
            
            self.rTextField.text = [NSString stringWithFormat:@"%zd",[self.rTextField.text integerValue]+500] ;
            self.rSliderView.value = [self.rTextField.text integerValue]/500 ;
            
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
            if ([self.rTextField.text integerValue] <= [self.rMinLabel.text integerValue]) {
                [JYProgressManager showBriefAlert:@"金额不能低于最小限额"];
                
                return NO ;
            }
            return YES ;
        }]subscribeNext:^(id x) {
            @strongify(self)
            
            self.rTextField.text = [NSString stringWithFormat:@"%zd",[self.rTextField.text integerValue]-500] ;
            self.rSliderView.value = [self.rTextField.text integerValue]/500 ;
            
        }] ;
        
        
        btn ;
    }) ;
    
    [self.contentView addSubview:self.rTextField];
    
    
    [self.contentView addSubview:rMinusBtn];
    [self.contentView addSubview:rAddBtn];
    [self.contentView addSubview:self.rMinLabel];
    [self.contentView addSubview:self.rMaxLabel];
    
    
    [self layoutSubviewsContstraints];
    
}

-(void)layoutSubviewsContstraints {
    
    [rImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(self.contentView).offset(15) ;
        make.width.and.height.mas_equalTo(15) ;
    }] ;
    
    [rTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rImgView.mas_right).offset(5) ;
        make.centerY.equalTo(rImgView) ;
    }] ;
    
    [self.rTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView) ;
        make.top.equalTo(rImgView.mas_bottom).offset(15) ;
        //        make.left.equalTo(self.contentView).offset(70) ;
        //        make.right.equalTo(self.contentView).offset(-70) ;
        //        make.height.mas_equalTo(60) ;
        make.height.mas_equalTo(30) ;
        
        //        make.width.mas_equalTo(SCREEN_WIDTH - 160) ;
        
        make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH - 180) ;
        
        
        
    }];
    
    
    [rMinusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30) ;
        
        make.centerY.equalTo(self.rTextField) ;
        make.right.equalTo(self.rTextField.mas_left).offset(-20) ;
    }] ;
    
    
    [ rAddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30) ;
        
        make.centerY.equalTo(self.rTextField) ;
        make.left.equalTo(self.rTextField.mas_right).offset(20) ;
    }] ;
    
    
    
    
    [self.rMinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rTextField.mas_bottom).offset(10) ;
        make.left.equalTo(self.contentView).offset(15) ;
        make.bottom.equalTo(self.contentView).offset(-20);
    }] ;
    
    [self.rMaxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rTextField.mas_bottom).offset(10) ;
        make.right.equalTo(self.contentView).offset(-15) ;
        make.bottom.equalTo(self.contentView).offset(-20);
        //                make.height.mas_equalTo(20) ;
        
    }] ;
    
    [self.rSliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rMinLabel.mas_right).offset(10) ;
        make.right.equalTo(self.rMaxLabel.mas_left).offset(-10) ;
        make.centerY.equalTo(self.rMinLabel) ;
        //        make.height.mas_equalTo(60) ;
    }] ;
}


#pragma mark- action

-(void)pvt_Slider {
    
    self.rTextField.text = [NSString stringWithFormat:@"%zd",((int)self.rSliderView.value)*500] ;
}

#pragma mark - getter

-(UITextField*)rTextField {
    
    if (_rTextField == nil) {
        _rTextField = [[UITextField alloc]init];
        _rTextField.text = @"10000" ;
        _rTextField.textAlignment = NSTextAlignmentCenter ;
        _rTextField.keyboardType = UIKeyboardTypeNumberPad ;
        _rTextField.font = [UIFont systemFontOfSize:40] ;
        _rTextField.textColor = kBlueColor ;
        _rTextField.enabled = NO ;
        [_rTextField.rac_textSignal subscribeNext:^(id x) {
            
            self.rTextField.text = [NSString stringWithFormat:@"%zd",[x integerValue]] ;
            self.rSliderView.value = [x integerValue] ;
        }] ;
        _rTextField.backgroundColor = [UIColor clearColor] ;
    }
    
    return _rTextField ;
}



-(UILabel*)rMinLabel {
    
    if (_rMinLabel == nil) {
        _rMinLabel = [self jyCreateLabelWithTitle:@"3000" font:13 color:kBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rMinLabel ;
}


-(UILabel*)rMaxLabel {
    
    if (_rMaxLabel == nil) {
        _rMaxLabel = [self jyCreateLabelWithTitle:@"5000" font:13 color:kBlackColor align:NSTextAlignmentRight] ;
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
        _rSliderView.minimumValue = 0 ;
        _rSliderView.maximumValue = 100 ;
        [_rSliderView addTarget:self action:@selector(pvt_Slider) forControlEvents:UIControlEventValueChanged] ;
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
        make.left.equalTo(self.contentView).offset(15) ;
        
        make.top.equalTo(self.contentView).offset(15) ;
        
    }] ;
    
    rButtonArray = [NSMutableArray arrayWithCapacity:5] ;
    
    
    
    for (int i= 0; i< 5; i++) {
        UIButton *btn = [self creatButtonWithButtonTitle:kTimetitle[i]] ;
        btn.tag = 1000 + i ;
        [self.contentView addSubview:btn];
        [rButtonArray addObject:btn];
    }
    
    
    [rButtonArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:5 leadSpacing:15 tailSpacing:15];
    
    [rButtonArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rTitle.mas_bottom).offset(10) ;
        make.height.mas_equalTo(30) ;
        //        make.bottom.equalTo(self.contentView).offset(-15) ;
    }] ;
    
    
}


-(UILabel*)rTitle {
    
    if (_rTitle == nil) {
        _rTitle = [self jyCreateLabelWithTitle:@"申请期限" font:16 color:kBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rTitle ;
}





-(UIButton*)creatButtonWithButtonTitle:(NSString*)title {
    
    UIButton *btn  = [ self jyCreateButtonWithTitle:title] ;
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setTitleColor:kBlackSecColor forState:UIControlStateNormal];
    
    [btn setBackgroundImage:[UIImage jy_imageWithColor:kBlueColor] forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage jy_imageWithColor:kBlueColor] forState:UIControlStateHighlighted];
    
    [btn setBackgroundImage:[UIImage jy_imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    
    
    btn.layer.borderWidth = 1 ;
    btn.layer.borderColor = kLineColor.CGColor ;
    btn.layer.cornerRadius = 4 ;
    
    btn.titleLabel.font = [UIFont systemFontOfSize:14] ;
    btn.backgroundColor = [UIColor clearColor] ;
    
    @weakify(self)
    [[[btn rac_signalForControlEvents:UIControlEventTouchUpInside]filter:^BOOL(UIButton* value) {
        
        
        return !value.selected ;
        
    } ] subscribeNext:^(UIButton* button) {
        @strongify(self)
        
        if (self.rSelectBlock) {
            self.rSelectBlock(btn.tag - 1000) ;
        }
        
        self.rSelectIndex = btn.tag - 1000 ;
        
    }] ;
    
    return btn ;
    
}

-(void)setRSelectIndex:(NSInteger)rSelectIndex {
    
    
    [rButtonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *btn = (UIButton*)obj ;
        btn.selected = NO ;
        
    }] ;
    
    UIButton *button = rButtonArray[rSelectIndex] ;
    
    button.selected = YES ;
    
    
    
}

@end




