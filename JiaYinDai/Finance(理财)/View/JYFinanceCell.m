//
//  JYFinanceCell.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/27.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYFinanceCell.h"

@interface JYFinanceCell ()

@property (nonatomic,strong) UIView *rBgView ;

@property (nonatomic,strong) UIView *rBackgroundView ;
@property (nonatomic,strong) UIImageView *rLeftImgView ;
@property (nonatomic,strong) UILabel *rTitleLabel ;
@property (nonatomic,strong) UILabel *rRightLabel ; //加息、预热、售罄


@property (nonatomic,strong) UILabel *rTimeLabel ; //期限

@property (nonatomic,strong) UILabel *rPercentLabel ; //利息

@property (nonatomic,strong) UILabel *rBegainLabel ; //已售 、开始抢购


@end

static inline NSMutableAttributedString * TTFormatePercentString( NSString*text,UIColor*percentColor ){
    
    NSMutableAttributedString *att = [[NSMutableAttributedString  alloc]initWithString:text attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:percentColor}] ;
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0,2)] ;
    [att addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x333333) range:NSMakeRange(0,2)] ;
    
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(text.length-1,1)] ;
    
    return att ;
    
} ;

static inline NSMutableAttributedString * TTFormateBeginString( NSString*text,UIColor*percentColor ){
    
    NSMutableAttributedString *att = [[NSMutableAttributedString  alloc]initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:percentColor}] ;
    
    
    
    NSRange rangD = [text rangeOfString:@"d"] ;
    NSRange rangH = [text rangeOfString:@"h"] ;
    NSRange rangM = [text rangeOfString:@"m"] ;

    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:rangD] ;
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:rangH] ;
     [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:rangM] ;
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(text.length-5,5)] ;


    
    [att addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x333333) range:rangD] ;
    [att addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x333333) range:rangH] ;
    [att addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x333333) range:rangM] ;

     [att addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x333333) range:NSMakeRange(text.length-5,5)] ;
    
    return att ;
    
} ;



@implementation JYFinanceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

-(instancetype)initWithCellType:(JYFinanceCellType)type reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        self.backgroundColor = self.contentView.backgroundColor = UIColorFromRGB(0xf2f2f2) ;
        [self initsubViewUIWithType:type];
        
    }
    return self ;
}


-(void)initsubViewUIWithType:(JYFinanceCellType)type {
    
    
    self.rTitleLabel.text = @"嘉银宝" ;
    self.rRightLabel.text = @"加息" ;
    
    self.rPercentLabel.text = @"X.XX%" ;
    self.rTimeLabel.text = @"80天" ;
    
    
    UIColor *textColor ;
    
    
    switch (type) {
        case JYFinanceCellTypeBegin: {
            self.rRightLabel.text = @"加息" ;
            textColor= UIColorFromRGB(0x1378d2) ;
            self.rRightLabel.layer.cornerRadius = 5 ;
            self.rRightLabel.layer.borderWidth = 1 ;
            self.rRightLabel.layer.borderColor = UIColorFromRGB(0x1378d2).CGColor ;
            
            self.rBackgroundView.backgroundColor = UIColorFromRGB(0xe8f4ff) ;
            self.rBegainLabel.attributedText = TTFormatePercentString(@"已售 50.0%", textColor)  ;
            
        }
            break;
        case JYFinanceCellTypeNotBegin:{
            self.rRightLabel.text = @"预热" ;
            textColor = UIColorFromRGB(0xd58f13) ;
            self.rRightLabel.layer.borderWidth = 0 ;
            self.rBackgroundView.backgroundColor = UIColorFromRGB(0xfff6e5) ;
            
            self.rBegainLabel.attributedText = TTFormateBeginString(@"5d5h30m60s开始抢购", UIColorFromRGB(0xd58f13))   ;

            
         }break ;
        case JYFinanceCellTypeOver:{
            self.rRightLabel.text = @"售罄" ;
            textColor = UIColorFromRGB(0x464646) ;
            self.rRightLabel.layer.borderWidth = 0 ;
            self.rBackgroundView.backgroundColor = UIColorFromRGB(0xf1f1f1) ;
            self.rBegainLabel.attributedText = TTFormatePercentString(@"已售 100.0%", textColor)  ;
            
        }break ;
            
        default:
            break;
    }
    self.rPercentLabel.textColor = self.rTimeLabel.textColor =
    self.rRightLabel.textColor= textColor ;
    
    
    [self.contentView addSubview:self.rBgView];
    [self.contentView addSubview:self.rLeftImgView];
    [self.contentView addSubview:self.rTitleLabel];
    [self.contentView addSubview:self.rRightLabel];
    [self.contentView addSubview:self.rBackgroundView];
    
    UILabel *interestLab = [self createLabelWithFont:14 textColor:UIColorFromRGB(0x333333) anlgn:NSTextAlignmentLeft] ;
    interestLab.text = @"利息" ;
    [self.contentView addSubview:interestLab];
    
    
    UILabel *dateLab = [self createLabelWithFont:14 textColor:UIColorFromRGB(0x333333) anlgn:NSTextAlignmentLeft] ;
    dateLab.text = @"期限" ;
    [self.contentView addSubview:dateLab];
    
    UIView *midLine = [[UIView alloc]init];
    midLine.backgroundColor = UIColorFromRGB(0xcccccc) ;
    [self.contentView addSubview:midLine];
    
    [self.contentView addSubview:self.rPercentLabel];
    [self.contentView addSubview:self.rTimeLabel];
    [self.contentView addSubview:self.rBegainLabel];
    
    
    [self.rBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(10, -1, 0, -1)) ;
    }] ;
    
    [self.rLeftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20) ;
        
        make.left.equalTo(self.contentView).offset(15) ;
        make.width.and.height.mas_equalTo(15) ;
    }];
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rLeftImgView.mas_right).offset(10) ;
        make.centerY.equalTo(self.rLeftImgView) ;
    }];
    
    [self.rRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-30) ;
        make.height.mas_greaterThanOrEqualTo(25) ;
        make.width.mas_greaterThanOrEqualTo(45) ;
        make.centerY.equalTo(self.rLeftImgView) ;
    }];
    
    [midLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15) ;
        make.right.equalTo(self.contentView).offset(-15) ;
        make.height.mas_equalTo(1) ;
        make.top.equalTo(self.contentView).offset(45) ;
    }];
    
    
    [self.rBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15) ;
        make.right.equalTo(self.contentView).offset(-15) ;
        make.bottom.equalTo(self.contentView).offset(-10) ;
        make.height.mas_equalTo(78) ;
        make.top.equalTo(midLine.mas_bottom).offset(10) ;
    }] ;
    
    [interestLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(25) ;
        make.top.equalTo(self.rBackgroundView).offset(10) ;
    }] ;
    
    [dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(25) ;
        make.top.equalTo(interestLab.mas_bottom).offset(10) ;
    }] ;
    
    [self.rPercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(interestLab.mas_right).offset(20) ;
        make.centerY.equalTo(interestLab) ;
    }];
    [self.rTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dateLab.mas_right).offset(20) ;
        make.centerY.equalTo(dateLab) ;
    }];
    
    [self.rBegainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-25) ;
        make.centerY.equalTo(interestLab.mas_bottom).offset(5) ;
    }];
    
}

#pragma mark- getter

-(UILabel*)rTitleLabel {
    if (_rTitleLabel == nil) {
        _rTitleLabel = [self createLabelWithFont:18 textColor:UIColorFromRGB(0x333333) anlgn:NSTextAlignmentLeft] ;
    }
    
    return _rTitleLabel ;
}

-(UILabel*)rTimeLabel {
    if (_rTimeLabel == nil) {
        _rTimeLabel = [self createLabelWithFont:15 textColor:UIColorFromRGB(0x1378d2) anlgn:NSTextAlignmentLeft] ;
    }
    
    return _rTimeLabel ;
}

-(UILabel*)rPercentLabel {
    if (_rPercentLabel == nil) {
        _rPercentLabel = [self createLabelWithFont:15 textColor:UIColorFromRGB(0x1378d2) anlgn:NSTextAlignmentLeft] ;
    }
    
    return _rPercentLabel ;
}

-(UILabel*)rRightLabel {
    if (_rRightLabel == nil) {
        _rRightLabel = [self createLabelWithFont:16 textColor:UIColorFromRGB(0x979797) anlgn:NSTextAlignmentCenter] ;
        _rRightLabel.backgroundColor = [UIColor clearColor] ;
    }
    return _rRightLabel ;
}

-(UILabel*)rBegainLabel {
    if (_rBegainLabel == nil) {
        _rBegainLabel = [self createLabelWithFont:16 textColor:UIColorFromRGB(0x979797) anlgn:NSTextAlignmentRight] ;
    }
    return _rBegainLabel ;
}



-(UIView*)rBackgroundView {
    
    if (_rBackgroundView == nil) {
        _rBackgroundView = [[UIView alloc]init];
        _rBackgroundView.backgroundColor = UIColorFromRGB(0xe8f4ff) ;
        _rBackgroundView.layer.cornerRadius = 5 ;
        _rBackgroundView.clipsToBounds = YES ;
    }
    return _rBackgroundView ;
}

-(UIView*)rBgView {
    
    if (_rBgView == nil) {
        _rBgView = [[UIView alloc]init];
        _rBgView.backgroundColor = [UIColor whiteColor] ;
        _rBgView.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor ;
        _rBgView.layer.borderWidth = 1 ;
    }
    return _rBgView ;
}


-(UIImageView*)rLeftImgView {
    
    if (_rLeftImgView == nil) {
        _rLeftImgView = [[UIImageView alloc]init];
        //        _rLeftImgView.image =  [UIImage  imageNamed:@"more"] ;
        _rLeftImgView.backgroundColor = [UIColor blueColor] ;
    }
    return _rLeftImgView ;
}



-(UILabel*)createLabelWithFont:(CGFloat)font textColor:(UIColor*)textColor anlgn:(NSTextAlignment)align{
    
    UILabel*label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:font] ;
    label.textColor = textColor ;
    label.textAlignment = align ;
    
    return label ;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
