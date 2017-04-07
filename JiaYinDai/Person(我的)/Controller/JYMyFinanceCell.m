//
//  JYMyFinanceCell.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/6.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYMyFinanceCell.h"

@interface JYMyFinanceCell (){

    JYMyFinanceType rType ;
}

@property (nonatomic,strong) UIImageView *rLeftImage ;
@property (nonatomic,strong) UILabel *rTitleLabel ;
@property (nonatomic,strong) UILabel *rTimeLabel ;
@property (nonatomic,strong) UILabel *rLimitTimeLabel ;
@property (nonatomic,strong) UILabel *rPercentLabel ;

@property (nonatomic,strong) NSMutableArray *rLabesArray ;


@end


static NSString *kTitles[] = {@"投资本金",@"已收收益",@"起息时间",@"到期时间"} ;
static NSString *kTitlesBack[] = {@"投资本金",@"已收收益",@"已收本金",@"回款时间"} ;


@implementation JYMyFinanceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithCellType:(JYMyFinanceType)type reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] ;
    if (self) {
        
        rType = type ;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        self.backgroundColor =
        self.contentView.backgroundColor = [UIColor clearColor] ;
        
        
        [self buildSubViewsUI];
        
    }
    
    return self ;
}


-(void)buildSubViewsUI {
    
    UIView *rBackGroundView = ({
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor] ;
        view.layer.borderColor = kLineColor.CGColor ;
        view.layer.borderWidth = 1 ;
        view ;
    }) ;
    
    
    
    UIView *rMiddleLine = ({
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor =  kLineColor;
        view ;
    }) ;
    
    
    UIView *rBlueView = ({
        
        UIView *view = [[UIView alloc]init];
        
        if (rType == JYMyFinanceTypeFinish) {
            view.backgroundColor =  UIColorFromRGB(0xfff9ea) ;

        }else
        view.backgroundColor =  UIColorFromRGB(0xe8f5ff) ;
        view.layer.cornerRadius = 5 ;
        view ;
    }) ;
    
    
    [self.contentView addSubview:rBackGroundView];
    [self.contentView addSubview:self.rLeftImage];
    [self.contentView addSubview:self.rTitleLabel];
    [self.contentView addSubview:self.rTimeLabel];
    [self.contentView addSubview:self.rLimitTimeLabel];
    [self.contentView addSubview:self.rPercentLabel];
    [self.contentView addSubview:rMiddleLine];
    [self.contentView addSubview:rBlueView];
    
    
    NSMutableArray *rTitleArray = [NSMutableArray arrayWithCapacity:4] ;
    for (int i =0 ; i< 4; i++) {
        
        NSString *title = kTitles[i] ;
        if (rType == JYMyFinanceTypeNormal) {
            title = kTitlesBack[i] ;
        }
        UILabel *label = [self jyCreateLabelWithTitle:title font:12 color:kTextBlackColor align:NSTextAlignmentCenter] ;
         [self.contentView addSubview:label];
        [rTitleArray addObject:label];
    }
    
    
    self.rLabesArray = [NSMutableArray arrayWithCapacity:4] ;
    for (int i =0 ; i< 4; i++) {
        UILabel *label = [self jyCreateLabelWithTitle:@"0.00" font:12 color:kTextBlackColor align:NSTextAlignmentCenter] ;
        label.numberOfLines = 0 ;
        [self.contentView addSubview:label];
        [self.rLabesArray addObject:label];
    }
    
    
    NSMutableArray *rLineArray = [NSMutableArray arrayWithCapacity:5] ;
    for (int i =0 ; i< 5; i++) {
        UIView *view =  [[UIView alloc]init];
        if (i == 0 || i == 4) {
            view.backgroundColor = [UIColor clearColor] ;
            
        }else
            view.backgroundColor = kLineColor ;
        
        [self.contentView addSubview:view];
        [rLineArray addObject:view];
    }
    
    
    [rBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(15, -1, 0, 1)) ;
    }] ;
    
    
    [self.rLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15) ;
        make.top.equalTo(rBackGroundView).offset(10) ;
        make.width.and.height.mas_equalTo(30) ;
    }] ;
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rLeftImage.mas_right).offset(10) ;
        make.centerY.equalTo(self.rLeftImage) ;
    }] ;
    
    [self.rTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15) ;
        make.centerY.equalTo(self.rLeftImage) ;
    }];
    
    [self.rLimitTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15) ;
        make.top.equalTo(self.rLeftImage.mas_bottom).offset(10) ;
    }];
    
    [self.rPercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.rLimitTimeLabel) ;
    }] ;
    
    
    [rMiddleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15) ;
        make.right.equalTo(self.contentView).offset(-15) ;
        make.top.equalTo(self.rLimitTimeLabel.mas_bottom).offset(10) ;
        make.height.mas_equalTo(1) ;
    }] ;
    
    [rBlueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rMiddleLine.mas_bottom).offset(10) ;
        make.left.equalTo(self.contentView).offset(15) ;
        make.right.equalTo(self.contentView).offset(-15) ;
        make.height.mas_equalTo(50) ;
        make.bottom.equalTo(self.contentView).offset(-10);
    }] ;
    
    [rTitleArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:15 tailSpacing:15] ;
    
    [rTitleArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rBlueView).offset(8) ;
     }] ;
    
    
    [self.rLabesArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:15 tailSpacing:15] ;
    
    [self.rLabesArray mas_makeConstraints:^(MASConstraintMaker *make) {
         make.bottom.equalTo(rBlueView).offset(-8) ;
    }] ;
    
    
    [rLineArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:1 leadSpacing:15 tailSpacing:15] ;
    
    [rLineArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rBlueView).offset(10) ;
        make.bottom.equalTo(rBlueView).offset(-10) ;
    }];
    
    
 }


#pragma mark- getter

-(UIImageView *)rLeftImage {
    
    if (_rLeftImage == nil) {
        _rLeftImage = [[UIImageView alloc]init];
        _rLeftImage.backgroundColor = [UIColor lightGrayColor] ;
    }
    return _rLeftImage ;
}

-(UILabel*)rTitleLabel {
    if (_rTitleLabel == nil) {
        _rTitleLabel = [self jyCreateLabelWithTitle:@"嘉宝银" font:16 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    return _rTitleLabel ;
}

-(UILabel*)rTimeLabel {
    if (_rTimeLabel == nil) {
        _rTimeLabel =  [self jyCreateLabelWithTitle:@"YY-MM-DD" font:16 color:kTextBlackColor align:NSTextAlignmentRight] ;
    }
    
    return _rTimeLabel ;
}

-(UILabel*)rLimitTimeLabel {
    if (_rLimitTimeLabel == nil) {
        _rLimitTimeLabel = [self jyCreateLabelWithTitle:@"理财期限1个月" font:14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rLimitTimeLabel ;
}

-(UILabel*)rPercentLabel {
    
    if (_rPercentLabel == nil) {
        _rPercentLabel = [self jyCreateLabelWithTitle:@"预期年化：8%" font:18 color:kBlueColor align:NSTextAlignmentRight] ;
    }
    
    return _rPercentLabel ;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end



@interface JYMYFinanceHeader ()

@property(nonatomic ,strong) UILabel *rTotalIncomeLabel ;
@property(nonatomic ,strong) UILabel *rLeftLabel ;
@property(nonatomic ,strong) UILabel *rRightLabel ;
@property(nonatomic ,strong) UILabel *rTitleLabel ;


@end

@implementation JYMYFinanceHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = kBlueColor ;
        [self buildSubViewsUI];
    }
    return self;
}


-(void)buildSubViewsUI {
    
    [self addSubview:self.rTitleLabel];
    [self addSubview:self.rTotalIncomeLabel];
    [self addSubview:self.rLeftLabel];
    [self addSubview:self.rRightLabel];
    
    
    
    
}

-(void)layoutSubviews {
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self) ;
        make.top.equalTo(self).offset(15) ;
    }];
    
    [self.rTotalIncomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self) ;
        make.top.equalTo(self.rTitleLabel.mas_bottom).offset(10) ;
    }];
    
    
    [self.rLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15) ;
        make.bottom.equalTo(self).offset(-15) ;
    }];
    
    
    [self.rRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15) ;
        make.bottom.equalTo(self.rLeftLabel) ;
    }];
    
}

#pragma mark- getter

-(UILabel*)rTitleLabel {
    if (_rTitleLabel == nil) {
        _rTitleLabel = [self jyCreateLabelWithTitle:@"累计收益" font:14 color:[UIColor whiteColor] align:NSTextAlignmentCenter] ;
    }
    
    return _rTitleLabel ;
}

-(UILabel*)rTotalIncomeLabel {
    if (_rTotalIncomeLabel == nil) {
        _rTotalIncomeLabel = [self jyCreateLabelWithTitle:@"8.75" font:22 color:[UIColor whiteColor] align:NSTextAlignmentCenter] ;
    }
    
    return _rTotalIncomeLabel ;
}

-(UILabel*)rLeftLabel {
    if (_rLeftLabel == nil) {
        _rLeftLabel = [self jyCreateLabelWithTitle:@"待收收益XXX元" font:14 color:[UIColor whiteColor] align:NSTextAlignmentLeft] ;
    }
    return _rLeftLabel ;
}

-(UILabel*)rRightLabel {
    
    if (_rRightLabel == nil) {
        _rRightLabel = [self jyCreateLabelWithTitle:@"待收本金XXX元" font:14 color:[UIColor whiteColor] align:NSTextAlignmentRight] ;
    }
    
    return _rRightLabel ;
}

@end
