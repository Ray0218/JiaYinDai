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

@property (nonatomic ,strong) UILabel *rUseInfoLabel ;  //使用说明


@property (nonatomic ,strong) UIView *rBlueBackView ;

@property (nonatomic ,strong) UIView *rNormalBackView ;

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
        
        
        [self buildSubViewsUI] ;
    }
    
    return self ;
}

-(void)buildSubViewsUI {
    
    [self.rNormalBackView addSubview:self.rBottomView] ;
    [self.contentView addSubview:self.rNormalBackView];
    [self.contentView addSubview:self.rBlueBackView] ;
    
    [self.contentView addSubview:self.rTitleLabel ];
    [self.contentView addSubview:self.rTimeLabel];
    [self.contentView addSubview:self.rUseInfoLabel];
    [self.contentView addSubview:self.rMoneyLabel];

    
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
        make.top.equalTo(self.rNormalBackView).offset(15) ;
    }];
    
    [self.rUseInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rTitleLabel) ;
        make.top.equalTo(self.rTitleLabel.mas_bottom).offset(10) ;
     }] ;
    
    [self.rTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rTitleLabel) ;
        make.bottom.equalTo(self.contentView) ;
        make.height.mas_equalTo(30) ;
        make.top.equalTo(self.rUseInfoLabel.mas_bottom).offset(10) ;
    }] ;
    
    [self.rMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rNormalBackView).offset(-15) ;
        make.bottom.equalTo(self.rNormalBackView).offset(-40) ;
     }] ;
    
    
    
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

-(UIView*)rNormalBackView {
    if (_rNormalBackView == nil) {
        _rNormalBackView = ({
            UIView *rBackView = [[UIView alloc]init];
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
        _rTitleLabel = [self jyCreateLabelWithTitle:@"注册红包" font:18 color:kBlueColor align:NSTextAlignmentLeft] ;
    }
    return _rTitleLabel ;
}

-(UILabel*)rUseInfoLabel {
    
    if (_rUseInfoLabel == nil) {
        _rUseInfoLabel = [self jyCreateLabelWithTitle:@"限常规产品使用" font:14 color:kBlueColor align:NSTextAlignmentLeft] ;
    }
    return _rUseInfoLabel ;
}


-(UILabel*)rMoneyLabel {
    
    if (_rMoneyLabel == nil) {
        _rMoneyLabel = [self jyCreateLabelWithTitle:@"15" font:28 color:kBlueColor align:NSTextAlignmentRight] ;
    }
    return _rMoneyLabel ;
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
        
    }
    
    return _rBottomView ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
//    self.rNormalBackView.hidden = selected ;
    self.rBlueBackView.hidden = !selected ;

    // Configure the view for the selected state
}

@end
