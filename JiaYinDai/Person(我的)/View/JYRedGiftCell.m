//
//  JYRedGiftCell.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/14.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYRedGiftCell.h"

@interface JYRedGiftCell ()
@property (nonatomic ,strong) UILabel *rTitleLabel ;

@property (nonatomic ,strong) UILabel *rTimeLabel ; //有效期
@property (nonatomic ,strong) UILabel *rMoneyLabel ; //金额

@property (nonatomic ,strong) UILabel *rTypeLabel ; //单位


@property (nonatomic ,strong) UILabel *rUseInfoLabel ;  //使用说明

@property (nonatomic ,strong) UILabel *rStatusLabel ;  //单期，全额说明


@property (nonatomic ,strong) UIImageView *rOverImage ;


@property (nonatomic ,strong) UIView *rBlueBackView ;

@property (nonatomic ,strong) UIImageView *rNormalBackView ;

@property (nonatomic ,strong) UIImageView *rBottomView ;


@end

@implementation JYRedGiftCell

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
        self.contentView.clipsToBounds = YES ;
        
        
        [self buildSubViewsUI] ;
    }
    
    return self ;
}

-(void)buildSubViewsUI {
    
    [self.rNormalBackView addSubview:self.rBottomView] ;
    [self.contentView addSubview:self.rNormalBackView];
    [self.contentView addSubview:self.rBlueBackView] ;
    
    [self.contentView addSubview:self.rOverImage];
    
    
    [self.contentView addSubview:self.rTitleLabel ];
    [self.contentView addSubview:self.rTimeLabel];
    [self.contentView addSubview:self.rStatusLabel];
    [self.contentView addSubview:self.rUseInfoLabel];
    [self.contentView addSubview:self.rMoneyLabel];
    [self.contentView addSubview:self.rTypeLabel];
    
    
    
    
    [self.rBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.rNormalBackView) ;
        make.height.mas_equalTo(30) ;
    }] ;
    
    
    [self.rBlueBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15) ;
        make.right.equalTo(self.contentView).offset(-15) ;
        make.top.equalTo(self.contentView).offset(15) ;
        //        make.height.mas_equalTo(80) ;
        make.bottom.equalTo(self.contentView) ;
    }] ;
    
    [self.rNormalBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15) ;
        make.right.equalTo(self.contentView).offset(-15) ;
        make.top.equalTo(self.contentView).offset(15) ;
        //        make.height.mas_equalTo(80) ;
        make.bottom.equalTo(self.contentView) ;
    }] ;
    
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rNormalBackView).offset(15) ;
        make.top.equalTo(self.rNormalBackView).offset(10) ;
        make.width.mas_greaterThanOrEqualTo(20).priorityHigh();
    }];
    
    
    [self.rStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rTitleLabel) ;
        make.top.equalTo(self.rTitleLabel.mas_bottom ).offset(5) ;
        make.width.mas_greaterThanOrEqualTo(20).priorityHigh();
        
    }] ;
    
    [self.rUseInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rTitleLabel) ;
        make.top.equalTo(self.rStatusLabel.mas_bottom).offset(5) ;
        make.width.mas_greaterThanOrEqualTo(20).priorityHigh();
        
    }] ;
    
    
    
    
    [self.rTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rTitleLabel) ;
        make.bottom.equalTo(self.contentView) ;
        make.height.mas_equalTo(30) ;
        make.top.equalTo(self.rUseInfoLabel.mas_bottom).offset(10) ;
    }] ;
    
    
    [self.rTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rNormalBackView).offset(-15) ;
        make.bottom.equalTo(self.rNormalBackView).offset(-48) ;
        make.width.mas_equalTo(18) ;
    }] ;
    
    
    
    
    [self.rMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rTypeLabel.mas_left).offset(-3) ;
        make.bottom.equalTo(self.rNormalBackView).offset(-48) ;
        make.height.mas_equalTo(45) ;
        
        
        
        make.left.equalTo(self.rUseInfoLabel.mas_right).offset(5) ;
        
    }] ;
    
    [self.rOverImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rNormalBackView);
        make.right.equalTo(self.rNormalBackView) ;
        make.width.mas_equalTo(63) ;
        
        make.height.mas_equalTo(60) ;
    }] ;
    
    
    
    [self.rMoneyLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal] ;
    
}

-(void)setRDataModel:(JYRedBonusModel *)rDataModel {
    
    
    _rDataModel = [rDataModel copy] ;
    
    
    self.rTitleLabel.text = rDataModel.name ;
    self.rTimeLabel.text=  [NSString stringWithFormat:@"有效期：%@至%@",rDataModel.beginTime,rDataModel.endTime] ;
    
    if ([rDataModel.couponsStatus isEqualToString:@"2"]) { //全额
        self.rStatusLabel.text = @"限全额还款" ;
    }else if ([rDataModel.couponsStatus isEqualToString:@"1"]) { //单期
        
        self.rStatusLabel.text = @"单期还款" ;
        
    }else if ([rDataModel.couponsStatus isEqualToString:@"0"]) { //红包
        
        self.rStatusLabel.text = @"通用红包" ;
        
    }
    
    if (rDataModel.amount.length) {
        self.rMoneyLabel.text = [NSString stringWithFormat:@"%zd",rDataModel.amount.integerValue]  ;
        
        self.rTypeLabel.text = @"元" ;
    }else if (rDataModel.rate.length){
        self.rMoneyLabel.text = [NSString stringWithFormat:@"%@",rDataModel.rate] ;
        self.rTypeLabel.text = @"%" ;
        
    }
    
    NSString *moneyCondit = @"还款任意金额" ;
    
    
    if ([rDataModel.conditionAmount doubleValue] > 0) {
        
        moneyCondit = [NSString stringWithFormat:@"还款额度达到%@元可用", rDataModel.conditionAmount] ;
        
    }
    
    
    if ([rDataModel.conditionRepayPeriod integerValue] > 0){
        
        moneyCondit = [NSString stringWithFormat:@"%@;连续还款%zd次可用",moneyCondit,[rDataModel.conditionRepayPeriod integerValue]] ;
        
    }
    
    self.rUseInfoLabel.text = moneyCondit ;
    
    
    
    
    
    if ([rDataModel.givenType isEqualToString:@"1"]) { //红包
        
        
//        if (!rDataModel.isOver.length && !rDataModel.used.length) { //正常状态
        if (![rDataModel.isOver integerValue] && ![rDataModel.used integerValue]) { //正常状态

        
            self.rNormalBackView.image = [UIImage imageNamed:@"bonuse_normal"] ;
            
        }else if ([rDataModel.used integerValue]) { //已使用
            self.rNormalBackView.image = [UIImage imageNamed:@"bonuse_used"] ;
            
        }else{
            
            self.rNormalBackView.image = [UIImage imageNamed:@"bonuse_over"] ;
            
        }
    }else{
        
//        if (!rDataModel.isOver.length && !rDataModel.used.length) { //正常状态
        if (![rDataModel.isOver integerValue] && ![rDataModel.used integerValue]) { //正常状态

        
            self.rNormalBackView.image = [UIImage imageNamed:@"vouche_normal"] ;
            
        }else if ([rDataModel.used integerValue]) { //已使用
            self.rNormalBackView.image = [UIImage imageNamed:@"vouche_used"] ;
            
        }else{
            self.rNormalBackView.image = [UIImage imageNamed:@"vouche_over"] ;
            
        }
        
    }
    
    
    
}

-(void)setTitlesColor:(UIColor*)color {
    
    
    
    self.rTitleLabel.textColor = self.rStatusLabel.textColor =self.rUseInfoLabel.textColor  =  self.rMoneyLabel.textColor = self.rTypeLabel.textColor =color ;
    
 }

#pragma mark- getter

-(UIView*)rBlueBackView {
    if (_rBlueBackView == nil) {
        _rBlueBackView = ({
            UIView *rBackView = [[UIView alloc]init];
            rBackView.backgroundColor = [UIColor clearColor] ;
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

-(UIImageView*)rNormalBackView {
    if (_rNormalBackView == nil) {
        _rNormalBackView = ({
            UIImageView *rBackView = [[UIImageView alloc]init];
            rBackView.backgroundColor = [UIColor whiteColor] ;
            rBackView.layer.cornerRadius = 5 ;
            rBackView.layer.borderWidth = 1 ;
            rBackView.layer.borderColor = kLineColor.CGColor ;
            rBackView.clipsToBounds = YES ;
            rBackView ;
        }) ;
    }
    
    return _rNormalBackView ;
}

-(UILabel*)rTitleLabel {
    
    if (_rTitleLabel == nil) {
        _rTitleLabel = [self jyCreateLabelWithTitle:@"注册红包" font:21 color:kBlueColor align:NSTextAlignmentLeft] ;
    }
    return _rTitleLabel ;
}

-(UILabel*)rUseInfoLabel {
    
    if (_rUseInfoLabel == nil) {
        _rUseInfoLabel = [self jyCreateLabelWithTitle:@"限常规产品使用" font:14 color:kBlueColor align:NSTextAlignmentLeft] ;
    }
    return _rUseInfoLabel ;
}


-(UILabel*)rStatusLabel {
    
    if (_rStatusLabel == nil) {
        _rStatusLabel = [self jyCreateLabelWithTitle:@"限全额还款" font:14 color:kBlueColor align:NSTextAlignmentLeft] ;
    }
    
    return _rStatusLabel ;
}

-(UILabel*)rMoneyLabel {
    
    if (_rMoneyLabel == nil) {
        _rMoneyLabel = [self jyCreateLabelWithTitle:@"0" font:59 color:kBlueColor align:NSTextAlignmentRight] ;
        _rMoneyLabel.backgroundColor = [UIColor clearColor] ;
        _rMoneyLabel.lineBreakMode = NSLineBreakByTruncatingMiddle ;
    }
    return _rMoneyLabel ;
}


-(UILabel*)rTypeLabel {
    
    if (_rTypeLabel == nil) {
        _rTypeLabel = [self jyCreateLabelWithTitle:@"元" font:21 color:kBlueColor align:NSTextAlignmentCenter] ;
        _rTypeLabel.backgroundColor = [UIColor clearColor] ;
    }
    
    return _rTypeLabel ;
}

-(UILabel*)rTimeLabel {
    
    if (_rTimeLabel == nil) {
        _rTimeLabel = [self jyCreateLabelWithTitle:@"有效期：2017.07.01-2017.07.31" font:14 color: [UIColor whiteColor] align:NSTextAlignmentLeft] ;
    }
    return _rTimeLabel ;
}


-(UIImageView*)rBottomView {
    
    if (_rBottomView == nil) {
        _rBottomView = [[UIImageView alloc]init];
        _rBottomView.backgroundColor = kBlueColor ;
        
        _rBottomView.hidden = YES ;
        
    }
    
    return _rBottomView ;
}

-(UIImageView*)rOverImage {
    
    if (_rOverImage == nil) {
        _rOverImage = [[UIImageView alloc]init];
        _rOverImage.backgroundColor = [UIColor clearColor] ;
        _rOverImage.hidden = YES ;
        
    }
    
    return _rOverImage ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    //    self.rNormalBackView.hidden = selected ;
    self.rBlueBackView.hidden = !selected ;
    
    // Configure the view for the selected state
}

@end
