//
//  JYLoanDetailHeader.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/12.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoanDetailHeader.h"

@interface JYLoanDetailHeader (){
    
    
    
    NSMutableArray *rLinesArray ;
    
    
}

@property (nonatomic ,strong) UILabel *rMoneyLabel ; //金额
@property (nonatomic ,strong) UIImageView *rArcView  ;
@property (nonatomic ,strong) UIImageView *rLeftImg  ; //
@property (nonatomic ,strong) UILabel *rSateLabel  ; //还款中
@property (nonatomic ,strong) UILabel *rTitleLabel  ; //应还款金额

@property (nonatomic,strong) UIView *rBgView ;

@property (nonatomic ,strong) NSMutableArray *rTitlesArray ;

@end



@implementation JYLoanDetailHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor] ;
        [self buildSubViewsUI];
    }
    return self;
}


-(void)buildSubViewsUI {
    
    
    [self addSubview:self.rBgView];
    
    [self addSubview:self.rArcView];
    [self addSubview:self.rSateLabel];
    [self addSubview:self.rMoneyLabel];
    [self addSubview:self.rTitleLabel];
    [self addSubview:self.rLeftImg];
    
    self.rTitlesArray = [NSMutableArray arrayWithCapacity:3] ;
    
    for (int i= 0; i< 3; i++) {
        UILabel *label = [self jyCreateLabelWithTitle:kTitles[i] font:12 color:kTextBlackColor  align:NSTextAlignmentCenter] ;
        label.numberOfLines = 0 ;
        label.tag = 1000 + i ;
        [self addSubview:label];
        [self.rTitlesArray addObject:label];
    }
    
    
    rLinesArray = [NSMutableArray arrayWithCapacity:4] ;
    
    for (int i= 0; i< 4; i++) {
        UIView *line = [[UIView alloc]init] ;
        
        if ( i == 0 || i == 3) {
            line.backgroundColor = [UIColor clearColor] ;
        }else{
            line.backgroundColor = kLineColor ;
        }
        [self addSubview:line];
        [rLinesArray addObject:line];
    }
    
    
    
}

-(void)layoutSubviews {
    
    [self.rBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self) ;
        make.bottom.equalTo(self.rLeftImg).offset(15) ;
    }] ;
    
    [self.rArcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self) ;
        make.top.equalTo(self) ;
    }] ;
    
    [self.rSateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.rArcView) ;
    }] ;
    
    [self.rLeftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15) ;
        make.top.equalTo(self.rArcView.mas_bottom).offset(40) ;
    }] ;
    
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rLeftImg.mas_right).offset(10) ;
        make.bottom.equalTo(self.rLeftImg) ;
        make.width.mas_greaterThanOrEqualTo(70) ;
    }];
    
    
    [self.rMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15) ;
        make.bottom.equalTo(self.rTitleLabel).offset(4) ;
        make.left.equalTo(self.rTitleLabel.mas_right).offset(5) ;
    }] ;
    
    [rLinesArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:1 leadSpacing:0 tailSpacing:0] ;
    [rLinesArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rLeftImg.mas_bottom).offset(20) ;
        make.height.mas_equalTo(40) ;
    }] ;
    
    
    [self.rTitlesArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:0 tailSpacing:0];
    
    [self.rTitlesArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rLeftImg.mas_bottom).offset(15) ;
        make.height.mas_equalTo(50) ;
        make.bottom.equalTo(self) ;
        
    }] ;
    
    
}

#pragma mark- getter

-(UIView*)rBgView {
    
    if (_rBgView == nil) {
        _rBgView = [[UIView alloc]init];
        _rBgView.backgroundColor = kBlueColor ;
    }
    return _rBgView ;
}

-(UIImageView*)rArcView {
    
    if (_rArcView == nil) {
        _rArcView = [[UIImageView alloc]init];
        _rArcView.image = [UIImage imageNamed:@"loan_arc"] ;
        _rArcView.backgroundColor = [UIColor clearColor] ;
    }
    
    return _rArcView ;
}

-(UILabel*)rSateLabel {
    
    if (_rSateLabel == nil) {
        _rSateLabel = [self jyCreateLabelWithTitle:@"还款中" font:16 color:[UIColor whiteColor] align:NSTextAlignmentCenter] ;
    }
    
    return _rSateLabel ;
}

-(UIImageView*)rLeftImg {
    
    if (_rLeftImg == nil) {
        _rLeftImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loan_money"]] ;
        _rLeftImg.backgroundColor = [UIColor clearColor] ;
    }
    
    return _rLeftImg ;
}

-(UILabel*)rTitleLabel {
    if (_rTitleLabel == nil) {
        _rTitleLabel = [self jyCreateLabelWithTitle:@"应还款总金额（元）" font:14 color:[UIColor whiteColor] align:NSTextAlignmentLeft] ;
    }
    
    return _rTitleLabel ;
}

-(UILabel*)rMoneyLabel {
    
    if (_rMoneyLabel == nil) {
        _rMoneyLabel = [self jyCreateLabelWithTitle:@"10000.00" font:30 color:[UIColor whiteColor] align:NSTextAlignmentRight] ;
    }
    
    return _rMoneyLabel ;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
    
    
}

@end


@interface JYLoanDetailCell (){
    
    JYLoanDetailCellType rType ;
}

@property (nonatomic ,strong) UIButton *rcommitButton ;

@property (nonatomic ,strong) UILabel *rMoneyLabel; //金额

@property (nonatomic ,strong) UILabel *rTimesLabel; //期数

//@property (nonatomic ,strong) UIButton *rOrderButton ; //预约
//
//@property (nonatomic ,strong) UILabel *rOrderLabel ; //预约

@property (nonatomic ,strong) UILabel *rOverLabel  ; //滞纳金额



@end

@implementation JYLoanDetailCell

-(instancetype)initWithCellType:(JYLoanDetailCellType)type reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] ;
    if (self) {
        
        rType = type ;
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        
        [self buildSubViewsUI];
        
        
        self.backgroundColor =
        self.contentView.backgroundColor = [UIColor clearColor] ;
        
    }
    
    return self ;
}

-(void)buildSubViewsUI {
    
    
    [self.contentView addSubview:self.rMoneyLabel];
    [self.contentView addSubview:self.rTimesLabel];
    
    
    if (rType == JYLoanDetailCellTypeButton) {
        
        self.rcommitButton.backgroundColor = kBlueColor ;
        
        
        
        
        [self.contentView addSubview:self.rcommitButton];
        
        /*
         [self.rOrderButton setTitleColor:kBlueColor forState:UIControlStateNormal];
         self.rOrderButton.layer.borderColor = kBlueColor.CGColor ;
         [self.contentView addSubview:self.rOrderButton];
         [self.contentView addSubview:self.rOrderLabel];
         */
        
        [self.rMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(15) ;
            make.top.equalTo(self.contentView).offset(15) ;
        }] ;
        
        [self.rTimesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15) ;
            make.top.equalTo(self.contentView).offset(15) ;
        }];
        
        [self.rcommitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15) ;
            make.right.equalTo(self.contentView).offset(-15) ;
            make.height.mas_equalTo(45) ;
            make.top.equalTo(self.rTimesLabel.mas_bottom).offset(15) ;
            make.bottom.equalTo(self.contentView).offset(-15) ;
            
        }] ;
        
        /*
         
         [self.rOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.rcommitButton.mas_bottom).offset(10) ;
         make.right.equalTo(self.contentView).offset(-15) ;
         make.width.mas_greaterThanOrEqualTo(80) ;
         make.bottom.equalTo(self.contentView).offset(-15) ;
         }] ;
         
         
         [self.rOrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.equalTo(self.rOrderButton.mas_left) ;
         make.centerY.equalTo(self.rOrderButton) ;
         }] ;
         */
        
    }else if(rType == JYLoanDetailCellTypeOverButton){
        
        
        [self.rcommitButton setBackgroundImage:[UIImage jy_imageWithColor: kOrangewColor] forState:UIControlStateNormal] ;
        
        
        
        
        [self.contentView addSubview:self.rOverLabel] ;
        
        [self.contentView addSubview:self.rcommitButton];
        
        /*
         
         [self.rOrderButton setTitleColor:kTextBlackColor forState:UIControlStateNormal];
         self.rOrderButton.layer.borderColor = kLineColor.CGColor ;
         
         [self.contentView addSubview:self.rOrderButton];
         [self.contentView addSubview:self.rOrderLabel];
         */
        
        [self.rMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(15) ;
            make.top.equalTo(self.contentView).offset(15) ;
         }] ;
        
        
        [self.rOverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rMoneyLabel.mas_bottom).offset(10) ;
            make.left.equalTo(self.rMoneyLabel) ;
        }] ;
        
        [self.rTimesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15) ;
            make.centerY.equalTo(self.rOverLabel) ;
        }];
        
        [self.rcommitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15) ;
            make.right.equalTo(self.contentView).offset(-15) ;
            make.height.mas_equalTo(45) ;
            make.top.equalTo(self.rOverLabel.mas_bottom).offset(15) ;
            
            make.bottom.equalTo(self.contentView).offset(-15) ;
            
        }] ;
        
        /*
         [self.rOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.rcommitButton.mas_bottom).offset(10) ;
         make.right.equalTo(self.contentView).offset(-15) ;
         make.width.mas_greaterThanOrEqualTo(80) ;
         make.bottom.equalTo(self.contentView).offset(-15) ;
         }] ;
         
         
         [self.rOrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.equalTo(self.rOrderButton.mas_left) ;
         make.centerY.equalTo(self.rOrderButton) ;
         }] ;
         
         */
        
        
    } else{
        
        
        [self.rMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(15) ;
            make.top.equalTo(self.contentView).offset(15) ;
            make.bottom.equalTo(self.contentView).offset(-15) ;
        }] ;
        
        [self.rTimesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15) ;
            make.top.equalTo(self.contentView).offset(15) ;
        }];
    }
    
}

#pragma mark- getter

-(UIButton*)rcommitButton {
    if (_rcommitButton == nil) {
        _rcommitButton = [self jyCreateButtonWithTitle:@"开始还款"] ;
    }
    
    return _rcommitButton ;
}

-(UILabel*)rMoneyLabel {
    
    if (_rMoneyLabel == nil) {
        _rMoneyLabel = [self jyCreateLabelWithTitle:@"本期应还款" font:14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rMoneyLabel ;
}

-(UILabel*)rOverLabel {
    
    if (_rOverLabel == nil) {
        _rOverLabel = [self jyCreateLabelWithTitle:@"滞纳金（元）" font:14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rOverLabel ;
}

-(UILabel*)rTimesLabel {
    
    if (_rTimesLabel == nil) {
        _rTimesLabel = [self jyCreateLabelWithTitle:@"已还款期数" font:14 color:kBlackColor align:NSTextAlignmentRight] ;
    }
    
    return _rTimesLabel ;
}

//-(UIButton*)rOrderButton {
//    if (_rOrderButton == nil) {
//        _rOrderButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
//        _rOrderButton.layer.cornerRadius = 4 ;
//        _rOrderButton.layer.borderWidth = 1 ;
//        _rOrderButton.layer.borderColor = kBlueColor.CGColor ;
//        [_rOrderButton setTitle:@"预约还款" forState:UIControlStateNormal] ;
//        [_rOrderButton  setTitleColor:kBlueColor forState:UIControlStateNormal];
//        _rOrderButton.titleLabel.font = [UIFont systemFontOfSize:16] ;
//    }
//
//    return _rOrderButton ;
//}
//
//-(UILabel*)rOrderLabel {
//    if (_rOrderLabel == nil) {
//        _rOrderLabel = [self jyCreateLabelWithTitle:@"现在还不想还款？可以" font:16 color:kTextBlackColor align:NSTextAlignmentRight] ;
//    }
//
//    return _rOrderLabel ;
//}

@end



@interface JYLoanTimesCell (){
    
    JYLoanCllType rType ;
    
    NSMutableArray *rLabelsArray ;
}


@end

static NSString *kHeaderTitles[] = {@"期数",@"还款日期",@"应还本金",@"相关费用",@"还款状态"} ;

@implementation JYLoanTimesCell

-(instancetype)initWithCellType:(JYLoanCllType)type reuseIdentifier:(NSString *)reuseIdentifier {
    
    
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] ;
    
    if (self) {
        
        rType = type ;
        
        self.backgroundColor = [UIColor whiteColor] ;
        self.selectionStyle = UITableViewCellSelectionStyleNone  ;
        
        [self buildSubViewsUI] ;
        
    }
    
    return self ;
}

-(void)buildSubViewsUI {
    
    rLabelsArray = [NSMutableArray arrayWithCapacity:5] ;
    
    
    CGFloat font = 13 ;
    
    UIColor *color = kTextBlackColor ;
    if (rType == JYLoanCllTypeHeader) {
        font = 14 ;
        color = kBlackColor ;
    }
    
    for (int i = 0; i < 5; i++) {
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        btn.titleLabel.font = [UIFont systemFontOfSize:font] ;
        [btn setTitleColor:color forState:UIControlStateNormal];
        
        if (rType == JYLoanCllTypeHeader) {
            
            [btn setTitle:kHeaderTitles[i] forState:UIControlStateNormal] ;
            
        }else{
            
            if (i == 4) {
                [btn setImage:[UIImage imageNamed:@"loan_finish"]  forState:UIControlStateSelected];
                [btn setImage:[UIImage imageNamed:@"loan_wait"]  forState:UIControlStateNormal];
                
            }else{
                [btn setTitle:kHeaderTitles[i] forState:UIControlStateNormal] ;
                
            }
        }
        
        
        [self.contentView addSubview:btn];
        [rLabelsArray addObject:btn ] ;
    }
    
    
    [rLabelsArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0] ;
    
    [rLabelsArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView) ;
    }] ;
    
}

-(void)rSetDataModel:(JYRepayModel *)rRepyModel {
    _rRepyModel = [rRepyModel copy];
    
    
    NSString *firstStr = [NSString stringWithFormat:@"第%@期",rRepyModel.repayPeriod] ;
    NSString *secondtStr = [NSString stringWithFormat:@"%@",rRepyModel.repayDate] ;
    NSString *thirdtStr = [NSString stringWithFormat:@"%.2f",[rRepyModel.perPrincple doubleValue]] ;
    
    
    NSString *fourStr = [NSString stringWithFormat:@"%.2f",[rRepyModel.correlativeFee doubleValue]] ;
    NSString *fiveStr = [NSString stringWithFormat:@"%@",rRepyModel.repayState] ;
    
    
    NSArray *titlesArr = @[firstStr,secondtStr,thirdtStr,fourStr,fiveStr] ;
    for (int i = 0; i< rLabelsArray.count; i++) {
        
        UIButton *bt = rLabelsArray[i] ;
        if (i == 4) {
            
            if ([titlesArr[i] isEqualToString:@"2"]) {
                bt.selected =  YES ;
                
            }else{
                bt.selected =  NO ;
                
            }
            
        }else {
            [bt setTitle:titlesArr[i] forState:UIControlStateNormal];
        }
        
        
    }
    
}

@end










