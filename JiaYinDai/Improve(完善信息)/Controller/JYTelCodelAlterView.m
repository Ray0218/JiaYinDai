//
//  JYTelCodelAlterView.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/20.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYTelCodelAlterView.h"

@interface JYTelCodelAlterView (){
    UIView *_backgroundView;
    
    UIButton *rCommitBtn ;
    UILabel *rDescLabel ;
    
    UIView *_rBottomLine;
    
    UITextField *rTextField ;
    JYCodeAlterType rType ;
}


@end

@implementation JYTelCodelAlterView

- (instancetype)initWithAlterType:(JYCodeAlterType)type
{
    self = [super init];
    if (self) {
        rType = type ;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self builSubViewsUI];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pvt_dissMiss)]] ;
    
    
    
    
    [[rTextField.rac_textSignal filter:^BOOL(NSString *value) { //验证码
        
        return value.length > 6 ;
        
    }]subscribeNext:^(NSString* x) {
        rTextField.text = [x substringToIndex:6] ;
    }] ;
    
    
    [[RACSignal combineLatest:@[rTextField.rac_textSignal] reduce:^(NSString* servicePass){
        
        return @(servicePass.length > 0 );
    }] subscribeNext:^(NSNumber* x) {
        
        rCommitBtn.enabled = [x boolValue] ;
    }];

    
}

-(void)builSubViewsUI {
    _backgroundView = [[UIView alloc] init];
    _backgroundView.backgroundColor =[UIColor whiteColor];
    _backgroundView.layer.cornerRadius = 6;
    _backgroundView.clipsToBounds = YES;
    [self.view addSubview:_backgroundView];
    
    
    _rBottomLine = ({
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = kBlueColor ;
        view ;
    }) ;
    [_backgroundView addSubview:_rBottomLine ];
    
    
    if (rType == JYCodeAlterTypeNormal) {
        rDescLabel = [self jyCreateLabelWithTitle:@"请输入验证码或密码" font:14 color:kTextBlackColor align:NSTextAlignmentCenter] ;
    }else{
        rDescLabel = [self jyCreateLabelWithTitle:@"请再次输入验证码或密码" font:14 color:kTextBlackColor align:NSTextAlignmentCenter] ;
        
    }
    [self.view addSubview:rDescLabel];
    
    
    rTextField = [[UITextField alloc]init];
    
    if (rType == JYCodeAlterTypeNormal) {
        rTextField.placeholder = @"请输入验证码或密码" ;
        
    }else{
        rTextField.placeholder = @"请再次输入验证码或密码" ;
        
    }
    rTextField.font = [UIFont systemFontOfSize:16] ;
    rTextField.keyboardType = UIKeyboardTypeNumberPad ;
    rTextField.layer.borderColor = kLineColor.CGColor ;
    rTextField.layer.borderWidth = 1 ;
    rTextField.leftViewMode= UITextFieldViewModeAlways ;
    rTextField.leftView = ({
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
        view.backgroundColor = [UIColor clearColor] ;
        view ;
    }) ;
    [_backgroundView addSubview:rTextField];
    
    
    rCommitBtn = [self jyCreateButtonWithTitle:@"确认"] ;
    rCommitBtn.enabled = NO ;
    [rCommitBtn addTarget:self action:@selector(pvt_commit) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:rCommitBtn];
    
    
    
    
    
    [self layoutSubViewsUI] ;
    
}

-(void)layoutSubViewsUI {
    
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH-60);
        make.height.mas_greaterThanOrEqualTo(100);
        make.center.equalTo(self.view) ;
    }];
    
    [_rBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(_backgroundView) ;
        make.height.mas_equalTo(10) ;
    }] ;
    
    
    [rDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backgroundView).offset(15) ;
        make.left.equalTo(_backgroundView).offset(15) ;
        make.right.equalTo(_backgroundView).offset(-15) ;
        
    }] ;
    
    
    [rTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backgroundView).offset(-1) ;
        make.right.equalTo(_backgroundView).offset(1);
        make.top.equalTo(rDescLabel.mas_bottom).offset(30) ;
        make.height.mas_equalTo(45) ;
    }] ;
    
    
    [rCommitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rTextField.mas_bottom).offset(30) ;
        make.left.equalTo(_backgroundView).offset(15) ;
        make.right.equalTo(_backgroundView).offset(-15) ;
        make.height.mas_equalTo(45) ;
        make.bottom.equalTo(_backgroundView).offset(-40) ;
    }] ;
}

#pragma mark- action

-(void)pvt_dissMiss{
    
     
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)pvt_commit {

    if (self.rCodeBlock) {
        self.rCodeBlock(rTextField.text) ;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
