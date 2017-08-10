//
//  JYDrawController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/2.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYDrawController.h"
#import "JYBankCardController.h"
#import "JYPayCommtController.h"

@interface JYDrawController (){
    
    UIScrollView *_rScrollView ;
    
    
    UIView *rSwitchBgView ;
    UILabel*rSwitchLabel ;
    
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

@property (nonatomic,strong) UILabel *rDescLabel ;

@property (nonatomic,strong) UIImageView *rDescImage ;


@property(nonatomic,strong) UIImageView *rArrowView ;
@property (nonatomic, strong)UIButton *rDrawButton ; //充值

@property (nonatomic, strong)UITextField *rTextField ;

@property (nonatomic, strong)UISwitch *rSwitch ;

@property (nonatomic, strong)JYBankModel *rBankModel ;

@property (nonatomic, strong)RACSignal *rSignal ;

@property (nonatomic ,strong)UILabel *rNoBankLabel ;



@end

@implementation JYDrawController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账户提现" ;
    [self buildSubViewUI];
    
    [self rLoadBankData];
    
    
    
    
    self.rSignal =  [RACSignal  combineLatest:@[   self.rTextField.rac_textSignal
                                                   ]
                                       reduce:^(NSString *moneyStr) {
                                           
                                           return @( moneyStr.length > 0 && [moneyStr doubleValue] > 0 );
                                       }]  ;
    
    
    
    [self.rSignal subscribeNext:^(NSNumber* x) {
        
        self.rDrawButton.enabled = [x boolValue] ;
        
    }] ;
    
    
    [[self.rTextField rac_signalForControlEvents:UIControlEventEditingChanged]subscribeNext:^(UITextField *textField) {
        
         
        NSString *textStr = textField.text ;
        
        if (textStr.length <= 0) {
            self.rTextField.text = @"" ;
        }else{
            
            NSArray *textArr = [textStr componentsSeparatedByString:@"."] ;
            
            
            if (textArr.count < 2) {
                self.rTextField.text = [NSString stringWithFormat:@"%zd",[textStr integerValue]] ;
            }else{
                
                
                if ([textArr[1] length] > 2) {
                    self.rTextField.text = [NSString stringWithFormat:@"%zd.%@",[textArr[0] integerValue],[textArr[1] substringToIndex:2]] ;
                }else{
                    self.rTextField.text = [NSString stringWithFormat:@"%zd.%@",[textArr[0] integerValue],textArr[1] ] ;

                }
                
                
            }
            
        }
        
        
    }] ;
}


-(void)rLoadBankData {
    
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
    
    if (user.rBankModelArr.count) {
        JYBankModel *bankModel = user.rBankModelArr[0] ;
        
        self.rBankImg.image = [UIImage imageNamed:bankModel.bankNo] ;
        self.rBankName.text = bankModel.bankName ;
        
        if (bankModel.cardNo.length >4) {
            self.rCardNumberLabel.text = [NSString stringWithFormat:@"**** **** **** %@",[bankModel.cardNo substringFromIndex:bankModel.cardNo.length-4]] ;
        }else{
            self.rCardNumberLabel.text =  @"" ;
        }
        
        
        NSString *useAmountStr = [NSString stringWithFormat:@"可提现金额 %.2f",[user.fundInfo.usableAmount doubleValue]] ;
        
        
        self.rTextField.placeholder = useAmountStr ;
        
        
        self.rBankModel = bankModel ;
    }else{
        self.rNoBankLabel.hidden = NO ;
    }
    
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
    [self.rContentView addSubview:self.rNoBankLabel];
    
    [self.rContentView addSubview:self.rArrowView] ;
    
    
    
    rSwitchBgView = [[UIView alloc]init];
    rSwitchBgView.backgroundColor = [UIColor whiteColor] ;
    rSwitchBgView.layer.borderColor = kLineColor.CGColor ;
    rTextBgView.layer.borderWidth = 1 ;
    [self.rContentView addSubview:rSwitchBgView];
    
    rSwitchLabel = [self jyCreateLabelWithTitle:@"全部提现" font:16 color:kBlackColor align:NSTextAlignmentLeft] ;
    [self.rContentView addSubview:rSwitchLabel];
    [self.rContentView addSubview:self.rSwitch];
    
    
    
    rTextBgView = [[UIView alloc]init];
    rTextBgView.backgroundColor = [UIColor whiteColor] ;
    rTextBgView.layer.borderColor = kLineColor.CGColor ;
    rTextBgView.layer.borderWidth = 1 ;
    [self.rContentView addSubview:rTextBgView];
    
    rChargeLabel = [self jyCreateLabelWithTitle:@"提现金额" font:16 color:kBlackColor align:NSTextAlignmentLeft] ;
    [self.rContentView addSubview:rChargeLabel];
    
    
    rMiddelLine = [[UIView alloc]init];
    rMiddelLine.backgroundColor = kLineColor ;
    [self.rContentView addSubview:rMiddelLine];
    
    [self.rContentView addSubview:self.rTextField];
    
    [self.rContentView addSubview:self.rDescLabel];
    
    [self.rContentView addSubview:self.rDescImage] ;
    
    [self.rContentView addSubview:self.rDrawButton];
    
    
    
    [self.view setNeedsUpdateConstraints];
    
}

-(void)updateViewConstraints {
    
    [_rScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }] ;
    
    [self.rContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_rScrollView);
        make.width.mas_equalTo(SCREEN_WIDTH) ;
        
    }];
    
    
    [self.rBankBgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(-1) ;
        make.right.equalTo(self.rContentView).offset(1) ;
        make.top.equalTo(self.rContentView).offset(15) ;
        make.height.mas_equalTo(80) ;
    }] ;
    
    
    [self.rNoBankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.rContentView).offset(15) ;
        make.right.equalTo(self.rContentView).offset(1) ;
        make.centerY.equalTo(self.rBankBgButton)  ;
        make.height.mas_equalTo(78) ;
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
    
    [rSwitchBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(-1) ;
        make.right.equalTo(self.rContentView).offset(1) ;
        make.top.equalTo(self.rBankBgButton.mas_bottom).offset(15) ;
        make.height.mas_equalTo(45) ;
    }] ;
    
    [rSwitchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(15) ;
        make.centerY.equalTo(rSwitchBgView) ;
        make.width.mas_equalTo(80) ;
    }] ;
    
    [self.rSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rContentView).offset(-15) ;
        make.centerY.equalTo(rSwitchBgView) ;
    }] ;
    
    
    
    [rTextBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(-1) ;
        make.right.equalTo(self.rContentView).offset(1) ;
        make.top.equalTo(rSwitchBgView.mas_bottom).offset(-1) ;
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
        make.height.mas_equalTo(45) ;
        
    }] ;
    
    
    
    
    [self.rDrawButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(15) ;
        make.top.equalTo(rTextBgView.mas_bottom).offset(25) ;
        make.height.mas_equalTo(45) ;
        make.right.equalTo(self.rContentView).offset(-15);
        //        make.bottom.equalTo(self.rContentView).offset(-20).priorityLow() ;
    }] ;
    
    
    [self.rDescImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(15) ;
        make.left.equalTo(self.rContentView).offset(15) ;
        make.top.equalTo(self.rDrawButton.mas_bottom).offset(10) ;
    }] ;
    
    
    [self.rDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rDescImage.mas_right).offset(5) ;
        make.top.equalTo(self.rDrawButton .mas_bottom).offset(10) ;
        
        make.right.equalTo(self.rContentView).offset(-15) ;
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
            
            JYBankCardController *VC = [[ JYBankCardController alloc]initWithType:JYBankCardVCTypDraw];
            VC.rBankBlock = ^(JYBankModel *bankModel) {
                
                
                self.rNoBankLabel.hidden = YES ;
                self.rBankModel = bankModel ;
                self.rBankImg.image = [UIImage imageNamed:bankModel.bankNo] ;
                self.rBankName.text = bankModel.bankName ;
                
                if (bankModel.cardNo.length >4) {
                    self.rCardNumberLabel.text = [NSString stringWithFormat:@"**** **** **** %@",[bankModel.cardNo substringFromIndex:bankModel.cardNo.length-4]] ;
                }
                
            } ;
            
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
        ;
        
    }
    return _rBankImg ;
}

-(UILabel*)rBankName {
    
    if (_rBankName == nil) {
        _rBankName = [self jyCreateLabelWithTitle:@"农业银行" font:18 color:kBlackColor align:NSTextAlignmentLeft] ;
    }
    return _rBankName ;
}

-(UILabel*)rCardTypeLabel {
    
    if (_rCardTypeLabel == nil) {
        _rCardTypeLabel = [self jyCreateLabelWithTitle:@"储蓄卡" font:12 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    return _rCardTypeLabel ;
}

-(UILabel*)rCardNumberLabel {
    
    if (_rCardNumberLabel == nil) {
        _rCardNumberLabel = [self jyCreateLabelWithTitle:@"**** **** **** 0798" font:14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
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
        _rTextField.placeholder = @"可提现金额 0.00";
        _rTextField.font = [UIFont systemFontOfSize:14] ;
        _rTextField.keyboardType = UIKeyboardTypeDecimalPad ;
    }
    
    return _rTextField ;
}


-(UILabel*)rDescLabel {
    
    if (_rDescLabel == nil) {
        _rDescLabel = [self jyCreateLabelWithTitle:@"单日可提现 3 次，单日最高提现额度 50000 元；\n低于 100 元须一次性提完\n预计24小时内到账。" font:12 color:kTextBlackColor align:NSTextAlignmentLeft] ;
        _rDescLabel.numberOfLines = 0 ;
        [UILabel changeLineSpaceForLabel:_rDescLabel WithSpace:5] ;
    }
    
    return _rDescLabel ;
}

-(UIImageView*)rDescImage {
    
    if (_rDescImage == nil) {
        _rDescImage = [[UIImageView alloc]init];
        _rDescImage.image = [UIImage imageNamed:@"per_action"] ;
        _rDescImage.backgroundColor = [UIColor clearColor] ;
    }
    
    return _rDescImage ;
}

-(UISwitch*)rSwitch {
    
    if (_rSwitch == nil) {
        _rSwitch = [[UISwitch alloc]init];
        _rSwitch.onTintColor = kBlueColor ;
        @weakify(self)
        [[_rSwitch rac_signalForControlEvents:UIControlEventValueChanged]subscribeNext:^(UISwitch *x) {
            
            @strongify(self)
            if (x.on) {
                
                JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
                
                self.rTextField.text = [NSString stringWithFormat:@"%@",user.fundInfo.usableAmount] ;
                
            }else{
                
                self.rTextField.text = @"" ;
            }
            
            [self.rSignal subscribeNext:^(NSNumber* x) {
                
                self.rDrawButton.enabled = [x boolValue] ;
                
            }] ;
            
        }] ;
    }
    
    return _rSwitch ;
}


-(UIButton*)rDrawButton {
    if (_rDrawButton == nil) {
        _rDrawButton = [self jyCreateButtonWithTitle:@"提现"] ;
        _rDrawButton.enabled = NO ;
        
        @weakify(self)
        [[_rDrawButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            
            
            [self pvt_clickDraw];
            
        }] ;
    }
    
    return _rDrawButton ;
}

-(UILabel*)rNoBankLabel {
    
    if (_rNoBankLabel == nil) {
        _rNoBankLabel = [self jyCreateLabelWithTitle:@"选择银行卡" font:18 color:kBlackColor align:NSTextAlignmentLeft] ;
        _rNoBankLabel.backgroundColor = [UIColor whiteColor] ;
        _rNoBankLabel.hidden = YES ;
    }
    
    return _rNoBankLabel ;
}

#pragma mark action

-(void)pvt_clickDraw {
    
    
    if (!self.rBankModel) {
        [JYProgressManager showBriefAlert:@"请选择银行卡"] ;
        
        return ;
    }

     
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
    if ([self.rTextField.text doubleValue] > [user.fundInfo.usableAmount doubleValue]) {
        
        [JYProgressManager showBriefAlert:@"金额已超过可提现额度"] ;
        return ;
    }
    
    
    
    
    if ([user.fundInfo.usableAmount doubleValue] < 100.0 && [user.fundInfo.usableAmount doubleValue] > [self.rTextField.text doubleValue] ) {
        
        [JYProgressManager showBriefAlert:@"余额小于100元只能全额提现"] ;
        return ;
    }
    
    
    
    JYPayCommtController *control = [[JYPayCommtController alloc]initWithType:JYPayCommitTypeDraw ];
    
    
    JYBankModel *model = self.rBankModel ;
    model.rBankMoney = [NSString stringWithFormat:@"%.2f",[self.rTextField.text doubleValue]] ;
    
    control.rBankModel = model ;
    
    [self.navigationController pushViewController:control animated:YES ];
    
    
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
