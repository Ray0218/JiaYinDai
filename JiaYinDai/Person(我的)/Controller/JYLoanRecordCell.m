//
//  JYLoanRecordCell.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/12.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoanRecordCell.h"


@interface JYLoanRecordCell ()

@property (nonatomic ,strong) UIButton *rImageButton ;

@property (nonatomic ,strong) UILabel *rOrderLabel ;

@property(nonatomic,strong) UILabel*rMoneyLabel ;



@property(nonatomic,strong) UILabel *rFirLabel ;
@property(nonatomic,strong) UILabel *rSecLabel ;
@property(nonatomic,strong) UILabel *rThirLabel ;



@end
@implementation JYLoanRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
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
    
    
    UIView *rBgView = ({
        UIView *view = [[UIView alloc]init];
        view.backgroundColor =  [UIColor whiteColor] ;
        view.layer.cornerRadius = 5 ;
        view.layer.borderWidth = 1 ;
        view.layer.borderColor = kLineColor.CGColor ;
        view.clipsToBounds = YES ;
        view ;
        
    }) ;
    
    
    UIView *rBottomView = ({
        UIView *view = [[UIView alloc]init];
        view.backgroundColor =  kBlueColor ;
        
        view ;
        
    }) ;
    
    [self.contentView addSubview:rBgView];
    [rBgView addSubview:rBottomView];
    
    
    [self.contentView addSubview:self.rFirLabel ];
    [self.contentView addSubview:self.rSecLabel ];
    
    [self.contentView addSubview:self.rThirLabel ];
    
    UILabel *rMonTitle = [self jyCreateLabelWithTitle:@"应还金额" font:12 color:[UIColor whiteColor] align:NSTextAlignmentLeft] ;
    [self.contentView addSubview:rMonTitle];
    
    
    
    [self.contentView addSubview:self.rImageButton];
    [self.contentView addSubview:self.rOrderLabel];
    [self.contentView addSubview:self.rMoneyLabel];
    
    
    [rBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(self.contentView).offset(15) ;
        make.right.equalTo(self.contentView).offset(-15) ;
        make.bottom.equalTo(self.contentView) ;
    }];
    
    
    [self.rImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(rBgView).offset(15);
        make.height.mas_equalTo(25) ;
     }] ;
    
    [self.rOrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rImageButton.mas_right).offset(15) ;
        make.centerY.equalTo(self.rImageButton) ;
        make.right.equalTo(rBgView).offset(-15) ;
    }] ;
    
    
    
    [self.rSecLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView) ;
        make.top.equalTo(self.rImageButton.mas_bottom).offset(10) ;
        
    }] ;
    
    
    [self.rFirLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rBgView).offset(15) ;
        make.top.equalTo(self.rSecLabel) ;
        make.right.equalTo(self.rSecLabel.mas_left).offset(-5) ;
        
    }] ;
    
    [self.rThirLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rSecLabel.mas_right).offset(5) ;
        make.top.equalTo(self.rSecLabel) ;
        make.right.equalTo(rBgView).offset(-15) ;
    }] ;
    
    
    
    
    
    [rBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.left.and.right.equalTo(rBgView);
        
        make.height.mas_equalTo(45) ;
    }] ;
    
    [self.rMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rSecLabel.mas_bottom).offset(10) ;
        make.right.equalTo(rBgView).offset(-10) ;
        make.height.mas_equalTo(45) ;
        make.bottom.equalTo(self.contentView) ;
        
    }] ;
    
    [rMonTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rBgView).offset(15) ;
        make.centerY.equalTo(rBottomView) ;
    }] ;
    
    
    
    
}

#pragma mark- getter
-(UILabel*)rOrderLabel {
    if (_rOrderLabel == nil) {
        _rOrderLabel = [self jyCreateLabelWithTitle:@"JYD20163333333333333333" font:16 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rOrderLabel ;
}

-(UILabel*)rMoneyLabel {
    if (_rMoneyLabel == nil) {
        _rMoneyLabel = [self jyCreateLabelWithTitle:@"10000.00"  font:18 color:[UIColor whiteColor] align:NSTextAlignmentRight] ;
    }
    
    return _rMoneyLabel ;
}

-(UILabel*)rFirLabel {
    
    if (_rFirLabel == nil) {
        _rFirLabel = [self jyCreateLabelWithTitle:@"计息时间 YY-MM-DD" font:12 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    return _rFirLabel ;
}

-(UILabel*)rSecLabel {
    
    if (_rSecLabel == nil) {
        _rSecLabel = [self jyCreateLabelWithTitle:@"已还期数 1期" font:12 color:kTextBlackColor align:NSTextAlignmentCenter] ;
    }
    return _rSecLabel ;
}

-(UILabel*)rThirLabel {
    
    if (_rThirLabel == nil) {
        _rThirLabel = [self jyCreateLabelWithTitle:@"本期还款日 YY-MM-DD" font:12 color:kTextBlackColor align:NSTextAlignmentRight] ;
    }
    return _rThirLabel ;
}




-(UIButton*)rImageButton {
    
    if (_rImageButton == nil) {
        _rImageButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [_rImageButton setTitle:@"  订单号" forState:UIControlStateNormal] ;
        [_rImageButton setTitleColor:kBlueColor forState:UIControlStateNormal];
        [_rImageButton setImage:[UIImage imageNamed:@"loan_num"] forState:UIControlStateNormal];
        _rImageButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
        
    }
    
    return _rImageButton ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
