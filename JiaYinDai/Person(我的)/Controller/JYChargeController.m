//
//  JYChargeController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/2.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYChargeController.h"
#import "JYPayStyleController.h"
#import "JYPayCommtController.h"


@interface JYChargeController (){
    UIScrollView *_rScrollView ;
    
    UIView *rTextBgView ;
    UILabel *rChargeLabel ;
    UIView *rMiddelLine ;
    

}

@property (nonatomic, strong)UIView *rContentView ;

@property (nonatomic ,strong) UIButton *rBankBgButton ;
@property (nonatomic ,strong) UILabel *rBankName ;
@property (nonatomic ,strong) UIImageView *rBankImg ;
@property (nonatomic ,strong) UILabel *rCardTypeLabel ;
@property (nonatomic ,strong) UILabel *rCardNumberLabel ;

@property(nonatomic,strong) UIImageView *rArrowView ;
 @property (nonatomic, strong)UIButton *rChargeButton ; //充值

@property (nonatomic, strong)UITextField *rTextField ;

@property (nonatomic, strong)UILabel *rCardMaxLabel ;
@property (nonatomic, strong)UILabel *rDayMaxLabel ;
@property (nonatomic, strong)UIButton *rMaxDescBtn ;



@end

@implementation JYChargeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账户充值" ;
    [self buildSubViewUI];
}

-(void)buildSubViewUI {
    
    
    _rScrollView = [[UIScrollView alloc]init];
    _rScrollView.showsVerticalScrollIndicator = NO ;
    _rScrollView.backgroundColor = [UIColor clearColor] ;
    [self.view addSubview:_rScrollView];
    
    [_rScrollView addSubview:self.rContentView];
    
    [self.rContentView addSubview:self.rBankBgButton] ;
    [self.rContentView addSubview:self.rBankImg];
    [self.rContentView addSubview:self.rBankName];
    [self.rContentView addSubview:self.rCardTypeLabel];
    [self.rContentView addSubview:self.rCardNumberLabel];
    
    [self.rContentView addSubview:self.rArrowView] ;
    
    
    rTextBgView = [[UIView alloc]init];
    rTextBgView.backgroundColor = [UIColor whiteColor] ;
    rTextBgView.layer.borderColor = kLineColor.CGColor ;
    rTextBgView.layer.borderWidth = 1 ;
    [self.rContentView addSubview:rTextBgView];
    
    rChargeLabel = [self jyCreateLabelWithTitle:@"充值金额" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    [self.rContentView addSubview:rChargeLabel];
    
    
    rMiddelLine = [[UIView alloc]init];
    rMiddelLine.backgroundColor = kLineColor ;
    [self.rContentView addSubview:rMiddelLine];
    
    [self.rContentView addSubview:self.rTextField];
    
    [self.rContentView addSubview:self.rCardMaxLabel];
    [self.rContentView addSubview:self.rDayMaxLabel];
    [self.rContentView addSubview:self.rMaxDescBtn];
    
    [self.rContentView addSubview:self.rChargeButton];
    
    
    
    [self.view setNeedsUpdateConstraints];
    
}

-(void)updateViewConstraints {
    
    [_rScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }] ;
    
    [self.rContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_rScrollView);
//        make.height.mas_greaterThanOrEqualTo(SCREEN_HEIGHT);
        make.width.mas_equalTo(SCREEN_WIDTH) ;
        
    }];
    
    
    [self.rBankBgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(-1) ;
        make.right.equalTo(self.rContentView).offset(1) ;
        make.top.equalTo(self.rContentView).offset(15) ;
        make.height.mas_equalTo(80) ;
    }] ;
    
    
    [self.rBankImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rBankBgButton).offset(15) ;
        make.width.and.height.mas_equalTo(40) ;
        make.centerY.equalTo(self.rBankBgButton);
    }] ;
    
    [self.rBankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rBankImg.mas_right).offset(15) ;
        make.bottom.equalTo(self.rBankImg.mas_centerY).offset(-5) ;
    }];
    
    [self.rCardTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rBankName) ;
        make.top.equalTo(self.rBankName.mas_bottom).offset(10) ;
    }] ;
    
    [self.rCardNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rCardTypeLabel.mas_right).offset(20) ;
        make.centerY.equalTo(self.rCardTypeLabel) ;
        make.right.equalTo(self.rBankBgButton).offset(-15) ;
    }] ;

    
    [self.rArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.rBankBgButton) ;
        make.right.equalTo(self.rContentView).offset(-15) ;
    }] ;
    
    
    
    [rTextBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(-1) ;
        make.right.equalTo(self.rContentView).offset(1) ;
        make.top.equalTo(self.rBankBgButton.mas_bottom).offset(15) ;
        make.height.mas_equalTo(45) ;
    }] ;
    
    [rChargeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(15) ;
        make.centerY.equalTo(rTextBgView) ;
         make.width.mas_equalTo(80) ;
    }] ;
    
    
    [rMiddelLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rChargeLabel.mas_right).offset(15) ;
        make.centerY.equalTo(rTextBgView) ;
        make.height.mas_equalTo(30) ;
        make.width.mas_equalTo(1) ;
    }] ;
    
    [self.rTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(rTextBgView) ;
        make.left.equalTo(rMiddelLine.mas_right).offset(15) ;
        make.right.equalTo(self.rContentView).offset(-15) ;
    }] ;
    
    
    
    [self.rCardMaxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(15) ;
        make.top.equalTo(rTextBgView.mas_bottom).offset(15) ;
    }] ;
    
    
    [self.rDayMaxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(15) ;
        make.top.equalTo(self.rCardMaxLabel.mas_bottom).offset(5) ;
    }] ;
    
    
    [self.rMaxDescBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rDayMaxLabel.mas_right).offset(5) ;
        make.centerY.equalTo(self.rDayMaxLabel) ;
    }] ;
    
    
    
    [self.rChargeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(15) ;
        make.top.equalTo(self.rDayMaxLabel.mas_bottom).offset(30) ;
         make.height.mas_equalTo(45) ;
        make.right.equalTo(self.rContentView).offset(-15);
        make.bottom.equalTo(self.rContentView).offset(-20).priorityLow() ;
    }] ;

    
    
    [super updateViewConstraints];
    
}

#pragma mark- getter

-(UIView*)rContentView {
    if (_rContentView == nil) {
        _rContentView = [[UIView alloc]init];
        _rContentView.backgroundColor = kBackGroundColor ;
        
    }
    
    return _rContentView ;
}

-(UIButton*)rBankBgButton {
    if (_rBankBgButton == nil) {
        _rBankBgButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        _rBankBgButton.layer.borderWidth = 1 ;
        _rBankBgButton.layer.borderColor = kLineColor.CGColor ;
        _rBankBgButton.backgroundColor = [UIColor whiteColor] ;
        @weakify(self)
        [[_rBankBgButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
             @strongify(self)
            
            JYPayStyleController *VC = [[JYPayStyleController alloc]init];
            [self.navigationController pushViewController:VC animated:YES ];
            
        }] ;
    }
    
    return _rBankBgButton ;
}


-(UIImageView*)rBankImg {
    
    if (_rBankImg == nil) {
        _rBankImg = [[UIImageView alloc]init];
        _rBankImg.backgroundColor = [UIColor clearColor] ;
        _rBankImg.image = [UIImage imageNamed:@"01030000"] ;

        
    }
    return _rBankImg ;
}

-(UILabel*)rBankName {
    
    if (_rBankName == nil) {
        _rBankName = [self jyCreateLabelWithTitle:@"农业银行" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    return _rBankName ;
}

-(UILabel*)rCardTypeLabel {
    
    if (_rCardTypeLabel == nil) {
        _rCardTypeLabel = [self jyCreateLabelWithTitle:@"储蓄卡" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    return _rCardTypeLabel ;
}

-(UILabel*)rCardNumberLabel {
    
    if (_rCardNumberLabel == nil) {
        _rCardNumberLabel = [self jyCreateLabelWithTitle:@"**** **** **** 0798" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    return _rCardNumberLabel ;
}

-(UIImageView*)rArrowView {
    if (_rArrowView == nil) {
        _rArrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more"]] ;
    }
    
    return _rArrowView ;
}

-(UITextField*)rTextField {
    if (_rTextField == nil) {
        _rTextField = [[UITextField alloc]init];
        _rTextField.placeholder = @"一次性充值最低100元" ;
        _rTextField.font = [UIFont systemFontOfSize:16] ;
    }
    
    return _rTextField ;
}

-(UILabel*)rCardMaxLabel {

    if (_rCardMaxLabel == nil) {
        _rCardMaxLabel = [self jyCreateLabelWithTitle:@"该卡单笔交易上限为100000元" font:14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rCardMaxLabel ;
}

-(UILabel*)rDayMaxLabel {

    if (_rDayMaxLabel == nil) {
        _rDayMaxLabel = [self jyCreateLabelWithTitle:@"您当日交易额度剩余50000元" font:14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rDayMaxLabel ;
}

-(UIButton*)rMaxDescBtn {

    if (_rMaxDescBtn == nil) {
        _rMaxDescBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [_rMaxDescBtn setTitle:@"限额说明" forState:UIControlStateNormal] ;
        _rMaxDescBtn.titleLabel.font = [UIFont systemFontOfSize:16] ;
        [_rMaxDescBtn setTitleColor:kBlueColor forState:UIControlStateNormal];
    }
    
    return _rMaxDescBtn ;
}


-(UIButton*)rChargeButton {
    if (_rChargeButton == nil) {
        _rChargeButton = [self jyCreateButtonWithTitle:@"充值"] ;
        @weakify(self)
        [[_rChargeButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            
            JYPayCommtController *control = [[JYPayCommtController alloc]init];
            [self.navigationController pushViewController:control animated:YES ];
             
        }] ;
    }
    
    return _rChargeButton ;
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
