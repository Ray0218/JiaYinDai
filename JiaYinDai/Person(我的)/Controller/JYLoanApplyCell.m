//
//  JYLoanApplyCell.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/21.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoanApplyCell.h"

@interface JYLoanApplyCell ()

@property (nonatomic ,strong) UILabel *rTitleLabel ;

@property (nonatomic ,strong) UILabel *rTimeLabel ;


@property(nonatomic,strong) UILabel *rMoneyLabel ;
@property(nonatomic,strong) UIImageView *rBottomView ;
@property(nonatomic,strong) UIImageView *rArrowView ;

@property(nonatomic,strong) NSMutableArray *rStateTitlesArr ;

@property(nonatomic,strong) NSArray *rTitlesArr ;


@end

@implementation JYLoanApplyCell

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
        
        self.rTitlesArr = [NSArray arrayWithObjects:@"已受理",@"审核通过",@"筹款中",@"打款中", nil] ;
        
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
    
    
    [self.contentView addSubview:rBgView];
    
    
    [self.contentView addSubview:self.rMoneyLabel ];
    
    [self.contentView addSubview:self.rBottomView ];
    
    
    
    
    [self.contentView addSubview:self.rTitleLabel];
    [self.contentView addSubview:self.rTimeLabel];
    
    [self.contentView addSubview:self.rArrowView];
    
    
    self.rStateTitlesArr = [NSMutableArray arrayWithCapacity:4] ;
    for (int i=0; i<4; i++) {
        UILabel *lab = [self jyCreateLabelWithTitle:self.rTitlesArr[i] font:12 color:kTextBlackColor align:NSTextAlignmentCenter] ;

//        if (i == 0  ) {
//            lab.textAlignment = NSTextAlignmentLeft ;
//        }
//        
//        if (  i== 3) {
//            lab.textAlignment = NSTextAlignmentRight ;
//        }
        [self.contentView addSubview:lab];
        [self.rStateTitlesArr addObject:lab];
    }
    
    
    
    [rBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(self.contentView).offset(15) ;
        make.right.equalTo(self.contentView).offset(-15) ;
        make.bottom.equalTo(self.contentView) ;
    }];
    
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(rBgView).offset(15);
        make.height.mas_equalTo(25) ;
    }] ;
    
    [self.rTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rTitleLabel.mas_right).offset(15) ;
        make.centerY.equalTo(self.rTitleLabel) ;
        make.right.equalTo(rBgView).offset(-15) ;
    }] ;
    
    
    [self.rArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(rBgView) ;
        make.right.equalTo(rBgView).offset(-10) ;
    }] ;
    
    
    [self.rMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rBgView).offset(15) ;
        make.top.equalTo(self.rTitleLabel.mas_bottom).offset(15) ;
        make.right.equalTo(rBgView).offset(-5) ;
        
    }] ;
    
    [self.rBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rMoneyLabel.mas_bottom).offset(15) ;
        make.left.equalTo(rBgView).offset(30) ;
        make.right.equalTo(rBgView).offset(-30) ;
         make.height.mas_equalTo(25) ;
    }] ;
    
    
    
//    [self.rStateTitlesArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:2 leadSpacing:25 tailSpacing:25] ;
    [self.rStateTitlesArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:55 leadSpacing:25 tailSpacing:25] ;
    
    [self.rStateTitlesArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rBottomView.mas_bottom).offset(5) ;
        make.bottom.equalTo(rBgView).offset(-10) ;
    }] ;
    
}

#pragma mark- getter
-(UILabel*)rTimeLabel {
    if (_rTimeLabel == nil) {
        _rTimeLabel = [self jyCreateLabelWithTitle:@"2016-09-14" font:14 color:kTextBlackColor align:NSTextAlignmentRight] ;
    }
    
    return _rTimeLabel ;
}



-(UILabel*)rMoneyLabel {
    
    if (_rMoneyLabel == nil) {
        _rMoneyLabel = [self jyCreateLabelWithTitle:@"200000.00元" font:20 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    return _rMoneyLabel ;
}


-(UIImageView*)rBottomView {
    
    if (_rBottomView == nil) {
        _rBottomView =  [[UIImageView alloc]init];
        _rBottomView.backgroundColor = [UIColor clearColor] ;
//        _rBottomView.contentMode = UIViewContentModeCenter ;
        _rBottomView.image = [UIImage imageNamed:@"apply_state5"] ;
    }
    return _rBottomView ;
}




-(UILabel*)rTitleLabel {
    
    if (_rTitleLabel == nil) {
        _rTitleLabel = [self jyCreateLabelWithTitle:@"借款申请单号 8464254" font:16 color:kTextBlackColor align:NSTextAlignmentLeft] ;
        
    }
    
    return _rTitleLabel ;
}

-(UIImageView*)rArrowView {
    if (_rArrowView == nil) {
        _rArrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more"]] ;
     }
    
    return _rArrowView ;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
