//
//  JYBillCell.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/21.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYBillCell.h"

@interface JYBillCell ()
{
    UIView *rBottomView ;
}

@property (nonatomic ,strong) UIImageView *rLeftImg ;

@property (nonatomic ,strong) UILabel *rTitleLabel ;


@property (nonatomic ,strong) UILabel *rTimeLabel ;

@property(nonatomic,strong) UILabel*rMoneyLabel ;

@property(nonatomic,strong) UILabel *rStateLabel ;


@end

@implementation JYBillCell

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

-(void)setRDataModel:(JYBillListModel *)rDataModel {

    _rDataModel = [rDataModel copy] ;
    
    self.rTitleLabel.text = rDataModel.type ;
    self.rStateLabel.text = rDataModel.status ;
    self.rTimeLabel.text = TTTimeString(rDataModel.createTime) ;
    
    
    if ([rDataModel.accountType isEqualToString:@"1"] || [rDataModel.accountType isEqualToString:@"4"] || [rDataModel.accountType isEqualToString:@"5"]) {
        self.rMoneyLabel.text = [NSString stringWithFormat:@"+%.2f", [rDataModel.amount doubleValue]] ;
    }else{
        
        self.rMoneyLabel.text = [NSString stringWithFormat:@"-%.2f", [rDataModel.amount doubleValue]] ;
    }
    
    
    
    self.rLeftImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"bill_state%zd",[rDataModel.accountType intValue]+1]] ;
    
     
    if ([rDataModel.state containsString:@"2"]) {
        [self setCellColor:kTextBlackColor] ;

    }else if ([rDataModel.accountType isEqualToString:@"1"] || [rDataModel.accountType isEqualToString:@"4"] || [rDataModel.accountType isEqualToString:@"5"]) {
        [self setCellColor:kBlueColor] ;
    }else{
    
        [self setCellColor:kOrangewColor];
     }


}

-(void)setCellColor:(UIColor*) colorStyle {
    
    self.rStateLabel.textColor =
    self.rMoneyLabel.textColor =
    rBottomView.backgroundColor=
    self.rStateLabel.textColor = colorStyle  ;
    
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
    
    
    rBottomView = ({
        UIView *view = [[UIView alloc]init];
        view.backgroundColor =  kBlueColor ;
        
        view ;
        
    }) ;
    
    [self.contentView addSubview:rBgView];
    [rBgView addSubview:rBottomView];
    
    
    [self.contentView addSubview:self.rStateLabel ];
    
    
    [self.contentView addSubview:self.rLeftImg];
    [self.contentView addSubview:self.rTitleLabel];
    [self.contentView addSubview:self.rTimeLabel];
    [self.contentView addSubview:self.rMoneyLabel];
    
    
    [rBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(self.contentView).offset(15) ;
        make.right.equalTo(self.contentView).offset(-15) ;
        make.bottom.equalTo(self.contentView) ;
    }];
    
    
    [self.rLeftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(rBgView).offset(15);
        make.height.width.mas_equalTo(25) ;
    }] ;
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rLeftImg.mas_right).offset(10) ;
        make.centerY.equalTo(self.rLeftImg) ;
    }] ;
    
    
    
    [self.rTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rLeftImg.mas_right).offset(15) ;
        make.centerY.equalTo(self.rLeftImg) ;
        make.right.equalTo(rBgView).offset(-15) ;
    }] ;
    
    
    
    
    [self.rStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rBgView).offset(10) ;
        make.top.equalTo(self.rLeftImg.mas_bottom).offset(10) ;
        make.right.equalTo(rBgView).offset(-10) ;
        
    }] ;
    
    
    
    
    [rBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.left.and.right.equalTo(rBgView);
        make.height.mas_equalTo(5) ;
    }] ;
    
    [self.rMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rStateLabel) ;
        make.right.equalTo(rBgView).offset(-10) ;
        make.bottom.equalTo(rBgView).offset(-15) ;
        
    }] ;
    
    
}

#pragma mark- getter

-(UILabel*)rTitleLabel {
    if (_rTitleLabel == nil) {
        _rTitleLabel = [self jyCreateLabelWithTitle:@"还款" font:16 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rTitleLabel ;
}

-(UILabel*)rTimeLabel {
    if (_rTimeLabel == nil) {
        _rTimeLabel = [self jyCreateLabelWithTitle:@"YY-MM-DD" font:16 color:kTextBlackColor align:NSTextAlignmentRight] ;
    }
    
    return _rTimeLabel ;
}

-(UILabel*)rMoneyLabel {
    if (_rMoneyLabel == nil) {
        _rMoneyLabel = [self jyCreateLabelWithTitle:@"10000.00"  font:18 color:kTextBlackColor align:NSTextAlignmentRight] ;
    }
    
    return _rMoneyLabel ;
}

-(UILabel*)rStateLabel {
    
    if (_rStateLabel == nil) {
        _rStateLabel = [self jyCreateLabelWithTitle:@"还款成功" font:16 color:kBlueColor align:NSTextAlignmentLeft] ;
    }
    return _rStateLabel ;
}




-(UIImageView*)rLeftImg {
    
    if (_rLeftImg == nil) {
        _rLeftImg =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loan_num"]]  ;
        
    }
    
    return _rLeftImg ;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

@interface JYBillAlterCell (){
    NSMutableArray *rLinesArr ;
}

@property (nonatomic ,strong) NSMutableArray *rButonsArr ;

@end


@implementation JYBillAlterCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ;
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        [self buildSbuViewsUI];
    }
    
    return self ;
}

-(void)setTitles:(NSArray*)titles images:(NSArray*)images  {
    
    
    for (int i = 0; i < 3; i ++) {
        UIButton *btn = self .rButonsArr[i];
        [btn setTitle:titles[i] forState:UIControlStateNormal] ;
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal] ;
    }
}

#pragma mark- action

-(void)pvt_select:(UIButton*)btn {

    if (self.rBlock) {
        self.rBlock(btn.tag - 999, self) ;
    }
}


-(void)buildSbuViewsUI {
    
    self.rButonsArr = [NSMutableArray arrayWithCapacity:3] ;
    rLinesArr = [NSMutableArray arrayWithCapacity:4] ;
    for (int i = 0; i<4 ; i ++) {
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = kLineColor ;
        [self.contentView addSubview:line];
        [rLinesArr addObject:line];
    }
    
    
    for (int i = 0; i < 3; i ++) {
        UIButton *bt =[UIButton buttonWithType:UIButtonTypeCustom] ;
        bt.backgroundColor = [UIColor clearColor] ;
        [bt setTitleColor:kBlackColor forState:UIControlStateNormal];
        [bt setTitle:@"" forState:UIControlStateNormal] ;
        bt.titleLabel.font = [UIFont systemFontOfSize:16] ;
        [self.contentView addSubview:bt];
        bt.tag = 999+ i ;
        [bt addTarget:self action:@selector(pvt_select:) forControlEvents:UIControlEventTouchUpInside] ;
        [self.rButonsArr addObject:bt];
        
    }
    
    
    [self.rButonsArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:0 tailSpacing:0] ;
    [self.rButonsArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView) ;
        make.height.mas_equalTo(50) ;
    }] ;
    
    [rLinesArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:1 leadSpacing:-1 tailSpacing:-1] ;
    
    [rLinesArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView) ;
        make.height.mas_equalTo(30) ;
    }] ;
    
    
}

@end


