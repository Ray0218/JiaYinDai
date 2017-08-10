//
//  JYPhoneIndetyfyController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/19.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPhoneIndetyfyController.h"
#import "JYTelPhoneAlterView.h"
#import "JYTelCodelAlterView.h"


@interface JYPhoneIndetyfyController (){
    
    UIScrollView *_rScrollView ;
    
    UILabel*rHeaderDescLab ;
    
    UIView *rBgView ;
    UIView *rLineView ;
    UILabel *rPassTitleLab ;
    
}

@property (nonatomic, strong)UIView *rContentView ;

@property (nonatomic, strong)UIButton *rCommitBtn ;

@property (nonatomic, strong)UILabel *rTelLabel ;

@property (nonatomic, strong)UITextField *rTextField ;

@property (nonatomic, strong)UIButton *rRightButton ;


@property (nonatomic, strong)UILabel *rBottomLabel ;

@property (nonatomic ,strong) NSString *rCodeString ;

@property (nonatomic ,assign) BOOL rStopRequest ;



@end

@implementation JYPhoneIndetyfyController

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
    
    if (user.cellphone.length >= 11) {
        
        NSString *telStr = [user.cellphone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"] ;
        
        telStr = [NSString stringWithFormat:@"手机号码：%@",telStr] ;
        
        self.rTelLabel.attributedText = TTFormateTitleString(telStr, 16, 13, telStr.length - 5, kBlackColor, kTextBlackColor) ;
    }else{
    
        self.rTelLabel.text = @"手机号码：" ;
    }
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [[self.rTextField.rac_textSignal filter:^BOOL(NSString *value) { //验证码
        
        return value.length > 6 ;
        
    }]subscribeNext:^(NSString* x) {
        self.rTextField.text = [x substringToIndex:6] ;
    }] ;
    
    
    [[RACSignal combineLatest:@[self.rTextField.rac_textSignal] reduce:^(NSString* servicePass){
        
        return @(servicePass.length > 0 );
    }] subscribeNext:^(NSNumber* x) {
        
        self.rCommitBtn.enabled = [x boolValue] ;
    }];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.rStopRequest = YES ;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"手机认证" ;
    self.rCodeString = @"0" ;
    
    [self buildSubViewUI];
}

#pragma mark - builUI
-(void)buildSubViewUI {
    
    _rScrollView = [[UIScrollView alloc]init];
    _rScrollView.showsVerticalScrollIndicator = NO ;
    _rScrollView.backgroundColor = [UIColor clearColor] ;
    [self.view addSubview:_rScrollView];
    
    [_rScrollView addSubview:self.rContentView];
    
    
    
    [self.rContentView addSubview:self.rCommitBtn];
    [self.rContentView addSubview:self.rBottomLabel];
    
    
    rHeaderDescLab = [self jyCreateLabelWithTitle:@"需要认证号码真实性，银行级保护，绝无泄密可能！" font:14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    [self.rContentView addSubview:rHeaderDescLab];
    
    [self.rContentView addSubview:self.rTelLabel];
    
    rBgView = [[UIView alloc]init];
    rBgView.backgroundColor = [UIColor whiteColor] ;
    rBgView.layer.borderWidth = 1 ;
    rBgView.layer.borderColor = kLineColor.CGColor ;
    [self.rContentView addSubview:rBgView] ;
    
    [self.rContentView addSubview:self.rTextField];
    [self.rContentView addSubview:self.rRightButton];
    
    rPassTitleLab = [self jyCreateLabelWithTitle:@"服务密码" font:16 color:kBlackColor align:NSTextAlignmentLeft] ;
    [self.rContentView addSubview:rPassTitleLab] ;
    
    
    rLineView = [[UIView alloc]init];
    rLineView.backgroundColor = kLineColor ;
    [self.rContentView addSubview:rLineView];
    
    
    [self.view addSubview:self.rQuestButton];
    [self.view addSubview:self.rTelButton];
    
    
    
    [self.view setNeedsUpdateConstraints];
    
}

-(void)updateViewConstraints {
    
    [_rScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }] ;
    
    [self.rQuestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-15) ;
        make.right.equalTo(self.view.mas_centerX).offset(-15) ;
    }] ;
    
    
    [self.rTelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-15) ;
        make.left.equalTo(self.view.mas_centerX).offset(15) ;
    }] ;
    
    
    [self.rContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_rScrollView);
        make.width.mas_equalTo(SCREEN_WIDTH) ;
        
        make.height.mas_greaterThanOrEqualTo(SCREEN_HEIGHT);
        
    }];
    
    
    [rHeaderDescLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.rContentView).offset(15) ;
    }] ;
    
    [self.rTelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(15) ;
        make.top.equalTo(rHeaderDescLab.mas_bottom).offset(25) ;
    }] ;
    
    
    [rBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rTelLabel.mas_bottom).offset(15) ;
        make.left.equalTo(self.rContentView).offset(-1) ;
        make.right.equalTo(self.rContentView).offset(1) ;
        make.height.mas_equalTo(45) ;
    }] ;
    
    [rPassTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(15) ;
        make.centerY.equalTo(rBgView) ;
        make.width.mas_lessThanOrEqualTo(80) ;
    }] ;
    
    [rLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rPassTitleLab.mas_right) .offset(15) ;
        make.centerY.equalTo(rBgView) ;
        make.height.mas_equalTo(30) ;
        make.width.mas_equalTo(1) ;
    }];
    
    [self.rTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rLineView.mas_right).offset(15) ;
        make.right.equalTo(self.rRightButton.mas_left).offset(-5) ;
        make.centerY.equalTo(rBgView) ;
        make.height.mas_equalTo(35);
    }] ;
    
    [self.rRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rContentView).offset(-15) ;
        make.centerY.equalTo(rBgView) ;
        make.width.height.mas_equalTo(25);
    }];
    
    [self.rCommitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45) ;
        make.left.equalTo(self.rContentView).offset(15) ;
        make.right.equalTo(self.rContentView).offset(-15) ;
        make.top.equalTo(rBgView.mas_bottom).offset(25) ;
        
    }] ;
    
    [self.rBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.rCommitBtn.mas_bottom).offset(15) ;
        make.left.equalTo(self.rContentView).offset(15) ;
        make.right.equalTo(self.rContentView).offset(-15) ;
    }] ;
    
    [super updateViewConstraints];
    
}


#pragma mark- action

-(void)pvt_commit {
    
    
    [self.rTextField resignFirstResponder];
    
     
    [self pvt_beginRequest];
    
    [JYProgressManager showWaitingWithTitle:@"服务密码校验中..." inView:self.view] ;
    
}

-(void)pvt_beginRequest {
    
    
    if (self.rStopRequest) {
        return ;
    }
    
    NSLog(@"手机认证请求...") ;//
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
    
    [dic setValue:self.rTextField.text forKey:@"servicePassword"] ;
    [dic setValue:self.rCodeString.length?self.rCodeString:@"0" forKey:@"smsCode"] ;
    
    self.rCodeString = @"0" ;
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kPhoneIdentifyURL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSString *code = responseObject[@"code"] ;
        
        
        NSString *procStage = responseObject[@"data"][@"procStage"] ;
      
        NSString *resultMsg = responseObject[@"data"][@"resultMsg"] ;
        
        
        if ([procStage isEqualToString:@"5"]) { //结束
            
            if ([code isEqualToString:@"12291"]) {// 成功
                
                [JYProgressManager showBriefAlert:@"手机认证成功！"] ;
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kShowTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            }else{
                [JYProgressManager showBriefAlert:resultMsg] ;
                
            }
            
        }else if ([procStage isEqualToString:@"3"]) { //要验证码
            
            [JYProgressManager hideAlert] ;
            
            JYTelCodelAlterView *vc =[[ JYTelCodelAlterView alloc]initWithAlterType:JYCodeAlterTypeNormal];
            @weakify(self)
            vc.rCodeBlock = ^(NSString *codeString) {
                @strongify(self)
                self.rCodeString  = codeString ;
                
                [JYProgressManager showWaitingWithTitle:@"验证码校验中..." inView:self.view] ;

                [self pvt_beginRequest];
            };
            [self.navigationController jy_showViewController:vc completion:nil] ;
            
        }else{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self pvt_beginRequest] ;
                
            });
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
    
    
}

#pragma mark -getter
-(UIView*)rContentView {
    
    if (_rContentView == nil) {
        _rContentView = [[UIView alloc]init];
        _rContentView.backgroundColor = kBackGroundColor ;
        //        [_rContentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pvt_clickContent:)]] ;
    }
    
    return _rContentView ;
}

-(UIButton*)rCommitBtn {
    
    if (_rCommitBtn == nil) {
        _rCommitBtn = [self jyCreateButtonWithTitle:@"确认"] ;
        _rCommitBtn.enabled = NO ;
        @weakify( self)
        [[_rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            [self pvt_commit];
        }] ;
    }
    
    return _rCommitBtn ;
}


-(UILabel*)rTelLabel {
    
    if (_rTelLabel == nil) {
        _rTelLabel = [self jyCreateLabelWithTitle:@"手机号码：187****3146" font:16 color:kBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rTelLabel ;
}

-(UILabel*)rBottomLabel {
    
    if (_rBottomLabel == nil) {
        _rBottomLabel = [self jyCreateLabelWithTitle:@"温馨提示：\n1、本人实名认证手机号\n2、收到运营商短信无需回复，属于正常情况\n3、提交成功后，如为担心密码泄露可到网上营业厅进行修改。" font:14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
        _rBottomLabel.numberOfLines = 0 ;
        [UILabel changeLineSpaceForLabel:_rBottomLabel WithSpace:5] ;
    }
    
    return _rBottomLabel ;
}

-(UITextField*)rTextField {
    
    if (_rTextField == nil) {
        _rTextField = [[UITextField alloc]init];
        _rTextField.placeholder = @"请输入手机运营商服务密码" ;
        _rTextField.font = [UIFont systemFontOfSize:13] ;
        _rTextField.backgroundColor = [UIColor clearColor] ;
        _rTextField.keyboardType = UIKeyboardTypeNumberPad ;
    }
    
    return _rTextField ;
}

-(UIButton*)rRightButton {
    
    if (_rRightButton == nil) {
        _rRightButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [_rRightButton setImage:[UIImage imageNamed:@"imp_tel"] forState:UIControlStateNormal] ;
        @weakify(self)
        [[_rRightButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            JYTelPhoneAlterView *alter = [[JYTelPhoneAlterView alloc]init];
            [self.navigationController jy_showViewController:alter completion:nil];
        }] ;
    }
    return _rRightButton ;
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
