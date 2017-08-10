//
//  JYMessageCell.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/27.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYMessageCell.h"

@interface JYMessageCell ()

@property (nonatomic,strong) UILabel *rTitleLabel ;
@property (nonatomic,strong) UILabel *rTimeLabel ;
@property (nonatomic,strong) UIImageView *rBackgroundView ;
@property (nonatomic,strong) UIImageView *rRightView ;

@property (nonatomic,strong) UILabel *rDetailLabel ;


@end

@implementation JYMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier  {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ;
    if (self) {
        
//        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        self.contentView.backgroundColor =
        self.backgroundColor = [UIColor clearColor] ;

        [self makeConstraints];
    }
    return self ;
}

-(void)setRDataModel:(JYMessageModel *)rDataModel {

    _rDataModel = [rDataModel copy] ;
    self.rTitleLabel.text = rDataModel.title ;
    self.rDetailLabel.text =rDataModel.content ;
    
    self.rTimeLabel.text = TTTimeString(rDataModel.effectTime) ;
    
    if ([rDataModel.status isEqualToString:@"0"]) { //未读
        
        self.rBackgroundView.highlighted = NO ;
        
        self.rTitleLabel.textColor = kBlackColor ;
    }else{
        self.rBackgroundView.highlighted = YES ;
        
        self.rTitleLabel.textColor = kTextBlackColor ;

    }
}

 
-(void)makeConstraints {
    
 


    [self.contentView addSubview:self.rBackgroundView];
    [self.contentView addSubview:self.rTitleLabel];
    [self.contentView addSubview:self.rTimeLabel];
    [self.contentView addSubview:self.rDetailLabel] ;
    [self.contentView addSubview:self.rRightView];

    
    [self.rBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(15, 15, 0, 15)) ;
    }] ;
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(30) ;
        make.top.equalTo(self.contentView).offset(30) ;
        make.right.equalTo(self.rTimeLabel.mas_left).offset(-5) ;

        
     }] ;
    
    [self.rTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-50) ;
        make.centerY.equalTo(self.rTitleLabel)  ;
        make.width.mas_greaterThanOrEqualTo(60) ;
        
    }] ;

    
    [self.rDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(30) ;
        make.right.equalTo(self.contentView).offset(-50) ;
        make.top.equalTo(self.rTitleLabel.mas_bottom).offset(5) ;
        make.bottom.equalTo(self.contentView).offset(-10) ;
        
    }] ;
    
    [self.rRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.rBackgroundView);
        make.right.equalTo(self.contentView).offset(-15) ;
    
    }] ;


                                      
 }

#pragma mark- getter 

-(UILabel*)rTitleLabel {
    if (_rTitleLabel == nil) {
        _rTitleLabel = [self createLabelWithFont:14 textColor:kBlackColor anlgn:NSTextAlignmentLeft] ;
    }
    
    return _rTitleLabel ;
}

-(UILabel*)rTimeLabel {
    if (_rTimeLabel == nil) {
        _rTimeLabel = [self createLabelWithFont:12 textColor:kTextBlackColor anlgn:NSTextAlignmentRight] ;
    }
    
    return _rTimeLabel ;
}

-(UILabel*)rDetailLabel {
    if (_rDetailLabel == nil) {
        _rDetailLabel = [self createLabelWithFont:12 textColor:kTextBlackColor anlgn:NSTextAlignmentLeft] ;
        _rDetailLabel.numberOfLines = 2 ;
    }
    
    return _rDetailLabel ;
}

-(UIImageView*)rBackgroundView {

    if (_rBackgroundView == nil) {
        _rBackgroundView = [[UIImageView alloc]init];
        _rBackgroundView.backgroundColor = [UIColor clearColor] ;
        _rBackgroundView.image =  [UIImage jy_imageWithColor:[UIColor whiteColor]] ;
        _rBackgroundView.highlightedImage = [UIImage jy_imageWithColor:[UIColor clearColor]] ;
        _rBackgroundView.layer.cornerRadius = 5 ;
        _rBackgroundView.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor ;
        _rBackgroundView.layer.borderWidth = 0.5 ;
        _rBackgroundView.clipsToBounds = YES ;
     }
    return _rBackgroundView ;
}

-(UIImageView*)rRightView {
    
    if (_rRightView == nil) {
        _rRightView = [[UIImageView alloc]init];
        _rRightView.image =  [UIImage  imageNamed:@"more"] ;
        _rRightView.backgroundColor = [UIColor clearColor] ;
     }
    return _rRightView ;
}



-(UILabel*)createLabelWithFont:(CGFloat)font textColor:(UIColor*)textColor anlgn:(NSTextAlignment)align{

    UILabel*label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:font] ;
    label.textColor = textColor ;
    label.textAlignment = align ;
    
    return label ;
}

-(void)setSelected:(BOOL)selected {
    [super setSelected:selected];
 }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

     // Configure the view for the selected state
}

@end
