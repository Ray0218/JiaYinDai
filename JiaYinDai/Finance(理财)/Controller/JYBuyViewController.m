//
//  JYBuyViewController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/3/30.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYBuyViewController.h"
#import "JYEstimateHeaderView.h"

@interface JYBuyViewController (){
    UIScrollView *_rScrollView ;
    UILabel *_rTotalTitleLab ;//剩余可投金额
    UILabel *_rBeginTitleLab; //起购金额

    
    JYBuyRowView *_rbuyTextView ;//投资金额
    JYBuyRowView *_rPayStyleView ; //支付方式
    JYBuyRowView *_rChooseView ; //选择红包
    
}

@property (nonatomic, strong)UIView *rContentView ;
@property (nonatomic, strong)JYEstimateHeaderView *rHeaderView ;
@property (nonatomic, strong)UILabel *rTotalMoneyLab  ; //可投金额
@property (nonatomic, strong)UILabel *rBuyCountLab  ; //起购金额


@end

@implementation JYBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"嘉银贷588期" ;
    [self buildSubViewUI];
}
-(void)buildSubViewUI {
    
    _rScrollView = [[UIScrollView alloc]init];
    _rScrollView.showsVerticalScrollIndicator = NO ;
    _rScrollView.backgroundColor = [UIColor clearColor] ;
    [self.view addSubview:_rScrollView];
    
    [_rScrollView addSubview:self.rContentView];
    [self.rContentView addSubview:self.rHeaderView];
    
    
    _rTotalTitleLab = [self jyCreateLabelWithTitle:@"剩余可投金额：" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    _rBeginTitleLab = [self jyCreateLabelWithTitle:@"起投金额：" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    [self.rContentView addSubview:_rTotalTitleLab];
    [self.rContentView addSubview:_rBeginTitleLab];
    [self.rContentView addSubview:self.rTotalMoneyLab];
    [self.rContentView addSubview:self.rBuyCountLab];

    
    
    _rbuyTextView = [[JYBuyRowView alloc]initWithLeftTitle:@"投资金额" rightStr:@""];
    _rPayStyleView = [[JYBuyRowView alloc]initWithLeftTitle:@"支付方式" rightStr:@"选择  余额/银行卡"];
    _rChooseView = [[JYBuyRowView alloc]initWithLeftTitle:@"选择红包" rightStr:@"选择  红包/抵用券"];

    
    [self.rContentView addSubview:_rbuyTextView];
    [self.rContentView addSubview:_rPayStyleView];
    [self.rContentView addSubview:_rChooseView];
    
    [self.view setNeedsUpdateConstraints];
    
    
    
    
}

-(void)updateViewConstraints {
    
    [_rScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }] ;
    
    [self.rContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_rScrollView);
        make.height.equalTo(_rScrollView);
        make.width.mas_equalTo(SCREEN_WIDTH) ;
        make.bottom.equalTo(_rScrollView).offset(-10) ;
        
    }];
    
    [self.rHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.equalTo(self.rContentView) ;
         make.height.equalTo(@(120));
        
    }];
    
    [_rTotalTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(15) ;
        make.top.equalTo(self.rHeaderView.mas_bottom).offset(15) ;

    }];
    
    [_rBeginTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(15) ;
        make.bottom.equalTo(_rbuyTextView.mas_top).offset(-15) ;
    }];
    
    [self.rTotalMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rHeaderView.mas_bottom).offset(15) ;
        make.left.equalTo(_rTotalTitleLab.mas_right).offset(15) ;
        make.right.equalTo(self.rContentView).offset(-15) ;
     }];
    
    [self.rBuyCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_rBeginTitleLab) ;
        make.left.equalTo(self.rTotalMoneyLab) ;
        make.right.equalTo(self.rContentView).offset(-15) ;
    }];

    
    [_rbuyTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(-1) ;
        make.right.equalTo(self.rContentView).offset(1) ;
        make.height.mas_equalTo(45) ;
        make.top.equalTo(_rHeaderView.mas_bottom).offset(75) ;
    }];
    
    [_rPayStyleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(-1) ;
        make.right.equalTo(self.rContentView).offset(1) ;
        make.height.mas_equalTo(45) ;
        make.top.equalTo(_rbuyTextView.mas_bottom).offset(15) ;
    }];
    
    [_rChooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(-1) ;
        make.right.equalTo(self.rContentView).offset(1) ;
        make.height.mas_equalTo(45) ;
        make.top.equalTo(_rPayStyleView.mas_bottom).offset(-1) ;
    }];
    
    [super updateViewConstraints];
    
}

#pragma mark -getter
-(UIView*)rContentView {
    
    if (_rContentView == nil) {
        _rContentView = [[UIView alloc]init];
        _rContentView.backgroundColor = kBackGroundColor ;
    }
    
    return _rContentView ;
}

-(JYEstimateHeaderView*)rHeaderView {
    
    if (_rHeaderView == nil) {
        _rHeaderView = [[JYEstimateHeaderView alloc]init];
    }
    
    return _rHeaderView ;
}

-(UILabel*)rBuyCountLab {
    if (_rBuyCountLab == nil) {
        _rBuyCountLab = [self jyCreateLabelWithTitle:@"1000元" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    return _rBuyCountLab ;
}

-(UILabel*)rTotalMoneyLab {

    if (_rTotalMoneyLab == nil) {
        _rTotalMoneyLab = [self jyCreateLabelWithTitle:@"200,00元" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rTotalMoneyLab ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

@interface JYBuyRowView (){

    UILabel *rLeftLab ;
    UILabel *rRightLab ;
    
    UIView *rMidLine ;
    UIImageView *rRightView ;
    
 }

@property (nonatomic ,strong)UITextField *rTextField ;

@end

@implementation JYBuyRowView

- (instancetype)initWithLeftTitle:(NSString*)leftStr rightStr:(NSString*)rightStr
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor] ;
        self.layer.borderColor = kLineColor.CGColor ;
        self.layer.borderWidth = 1 ;
        [self buildSubViewsWithLeft:leftStr right:rightStr];
    }
    return self;
}


-(void)buildSubViewsWithLeft:(NSString*)leftStr right:(NSString*)rightStr {

    rLeftLab = [self jyCreateLabelWithTitle:leftStr font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    [self addSubview:rLeftLab];
    
    rMidLine = [[UIView alloc]init];
    rMidLine.backgroundColor = kLineColor ;
    [self addSubview:rMidLine] ;
    
    
    if (rightStr.length) {
        rRightLab = [self jyCreateLabelWithTitle:rightStr font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
        rRightView = [[UIImageView alloc]init];
        rRightView.image = [UIImage imageNamed:@"more"] ;
        [self addSubview:rRightLab];
        [self addSubview:rRightView];
    }else{
        
        [self addSubview:self.rTextField];
    }
    
    
}


-(void)layoutSubviews {

    [rLeftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15) ;
        make.centerY.equalTo(self) ;
    }];
    
    [rMidLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rLeftLab.mas_right).offset(25) ;
        make.top.equalTo(self).offset(10) ;
        make.bottom.equalTo(self).offset(-10).priorityLow() ;
        make.width.mas_equalTo(1) ;
    }] ;
    
    
    if (rRightLab) {
        [rRightLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rMidLine.mas_right).offset(25) ;
            make.centerY.equalTo(self);
        }];
        
        [rRightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15) ;
            make.centerY.equalTo(self) ;
        }];
    }else{
    
        [self.rTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rMidLine.mas_right).offset(25) ;
            make.centerY.equalTo(self) ;
            make.right.equalTo(self).offset(-15);
        }];
    }
}

-(UITextField*)rTextField {
    if (_rTextField == nil) {
        _rTextField = [[UITextField alloc]init];
        
    }
    return _rTextField ;
}

@end


 
