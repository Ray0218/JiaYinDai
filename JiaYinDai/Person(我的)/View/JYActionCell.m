//
//  JYActionCell.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/22.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYActionCell.h"

@interface JYActionCell ()

@property (nonatomic ,strong) UIView *rNormalBackView ;


@property (nonatomic ,strong) UILabel *rTitleLabel ;

@property (nonatomic ,strong) UILabel *rTimeLabel ; //有效期

@property (nonatomic ,strong) UILabel *rStatusLabel ; //进行中


@property (nonatomic ,strong) UIImageView *rBottomView ;


@property (nonatomic ,strong) UIImageView *rFinishView ; //活动结束



@end

@implementation JYActionCell


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
    
     [self.contentView addSubview:self.rNormalBackView];
    
     [self.contentView addSubview:self.rTitleLabel ];
    [self.contentView addSubview:self.rTimeLabel];
    
    [self.contentView addSubview:self.rStatusLabel];
    [self.contentView addSubview:self.rBottomView];
    
    [self.contentView addSubview:self.rFinishView];
    
    
    [self.rNormalBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15) ;
        make.right.equalTo(self.contentView).offset(-15) ;
        make.top.equalTo(self.contentView).offset(15) ;
        //        make.height.mas_equalTo(80) ;
        make.bottom.equalTo(self.contentView) ;
    }] ;
    
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rNormalBackView).offset(10) ;
        make.top.equalTo(self.rNormalBackView).offset(12) ;
        make.width.mas_greaterThanOrEqualTo(20).priorityHigh();
        
    }];
    
    
    
    [self.rTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rTitleLabel) ;
         make.height.mas_equalTo(10) ;
        make.top.equalTo(self.rTitleLabel.mas_bottom).offset(7.5) ;
    }] ;
    
    
    [self.rStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.rTitleLabel.mas_bottom) ;
        make.right.equalTo(self.rNormalBackView).offset(-10) ;
    }];
    
    
    [self.rBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-10) ;
        make.left.equalTo(self.rNormalBackView).offset(10) ;
        make.right.equalTo(self.rNormalBackView).offset(-10) ;
        make.top.equalTo(self.rTimeLabel.mas_bottom).offset(5) ;
        make.height.mas_equalTo(160) ;
    }] ;
    
    
    [self.rFinishView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-10) ;
        make.left.equalTo(self.rNormalBackView).offset(10) ;
        make.right.equalTo(self.rNormalBackView).offset(-10) ;
        make.top.equalTo(self.rTimeLabel.mas_bottom).offset(5) ;
        make.height.mas_equalTo(160) ;
    }] ;

}

-(void)setRDataModel:(JYActiveModel *)rDataModel {

    _rDataModel = [rDataModel copy] ;
    
    self.rTitleLabel.text = rDataModel.title ;
    
    self.rTimeLabel.text =rDataModel.beginDate ;
    
    [self.rBottomView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",rDataModel.imageUrl]] placeholderImage:[UIImage imageNamed:@"img_defaut"]];
    
    if ([rDataModel.status isEqualToString:@"1"]) {
        self.rStatusLabel.text = @"进行中" ;
        self.rStatusLabel.textColor = kBlueColor ;
        self.rFinishView.hidden = YES ;
    }else{
        self.rStatusLabel.text = @"已结束" ;
        self.rStatusLabel.textColor = kBlackColor ;
        self.rFinishView.hidden = NO ;
    }
}

#pragma mark- getter

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
        _rTitleLabel = [self jyCreateLabelWithTitle:@"双十一来啦" font:16 color:kBlackColor align:NSTextAlignmentLeft] ;
    }
    return _rTitleLabel ;
}

-(UILabel*)rTimeLabel {
    
    if (_rTimeLabel == nil) {
        _rTimeLabel = [self jyCreateLabelWithTitle:@"2017.07.31" font:12 color: kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    return _rTimeLabel ;
}

-(UILabel*)rStatusLabel {

    if (_rStatusLabel == nil) {
        _rStatusLabel = [self jyCreateLabelWithTitle:@"进行中" font:14 color:kBlueColor align:NSTextAlignmentRight] ;
    }
    
    return _rStatusLabel ;
}

-(UIImageView*)rBottomView {
    
    if (_rBottomView == nil) {
        _rBottomView = [[UIImageView alloc]init];
        _rBottomView.backgroundColor = [UIColor clearColor] ;
        
    }
    
    return _rBottomView ;
}

-(UIImageView*)rFinishView {

    if (_rFinishView == nil) {
        _rFinishView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"active_over"]];
        _rFinishView.hidden = YES ;
    }
    
    return _rFinishView ;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
