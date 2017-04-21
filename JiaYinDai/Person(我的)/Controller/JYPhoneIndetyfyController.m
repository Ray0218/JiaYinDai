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



@end

@implementation JYPhoneIndetyfyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"手机认证" ;
    
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
    
    
    rHeaderDescLab = [self jyCreateLabelWithTitle:@"需要认证号码真实性，银行级保护，绝无泄密可能！" font:16 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    [self.rContentView addSubview:rHeaderDescLab];
    
    [self.rContentView addSubview:self.rTelLabel];
    
    rBgView = [[UIView alloc]init];
    rBgView.backgroundColor = [UIColor whiteColor] ;
    rBgView.layer.borderWidth = 1 ;
    rBgView.layer.borderColor = kLineColor.CGColor ;
    [self.rContentView addSubview:rBgView] ;
    
    [self.rContentView addSubview:self.rTextField];
    [self.rContentView addSubview:self.rRightButton];
    
    rPassTitleLab = [self jyCreateLabelWithTitle:@"服务密码" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    [self.rContentView addSubview:rPassTitleLab] ;
    
    
    rLineView = [[UIView alloc]init];
    rLineView.backgroundColor = kLineColor ;
    [self.rContentView addSubview:rLineView];

     [self.view setNeedsUpdateConstraints];

 }

-(void)updateViewConstraints {
    
    [_rScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
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
        @weakify( self)
        [[_rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            
            JYTelCodelAlterView *vc =[[ JYTelCodelAlterView alloc]initWithAlterType:JYCodeAlterTypeNormal];
            [self.navigationController jy_showViewController:vc completion:nil] ;
        }] ;
    }
    
    return _rCommitBtn ;
}


-(UILabel*)rTelLabel {

    if (_rTelLabel == nil) {
        _rTelLabel = [self jyCreateLabelWithTitle:@"187****3146" font:15 color:kTextBlackColor align:NSTextAlignmentLeft] ;
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
        _rTextField.backgroundColor = [UIColor lightGrayColor] ;
    }
    
    return _rTextField ;
}

-(UIButton*)rRightButton {

    if (_rRightButton == nil) {
        _rRightButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [_rRightButton setImage:[UIImage imageNamed:@"imp_attention"] forState:UIControlStateNormal] ;
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
