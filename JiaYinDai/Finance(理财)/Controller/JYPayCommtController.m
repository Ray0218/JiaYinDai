//
//  JYPayCommtController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/3/31.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPayCommtController.h"
 #import "JYSuccessAlterController.h"
 #import "JYPasswordView.h"
#import "JYPasswodSettingVC.h"


@interface JYPayCommtController (){

    JYPasswordView *_rPassWordView ;
}

@property (nonatomic,strong) UIButton *rCommitBtn ;
@property (nonatomic,strong) UIButton *rForgetBtn ;


@end

@implementation JYPayCommtController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"确认交易" ;
    
    [self buildSubViewsUI];
}


-(void)buildSubViewsUI {
    
    
    _rPassWordView = [[JYPasswordView alloc]initWithFrame:CGRectMake(15, 30, SCREEN_WIDTH-30, 45)];
    [self.view addSubview:_rPassWordView] ;
    
    
    
    [self.view addSubview:self.rForgetBtn];
    [self.view addSubview:self.rCommitBtn];
    
    [self.rForgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15) ;
        make.top.equalTo(_rPassWordView.mas_bottom).offset(10) ;
    }] ;
    
    [self.rCommitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rForgetBtn.mas_bottom).offset(25) ;
        make.left.equalTo(self.view).offset(15) ;
        make.right.equalTo(self.view).offset(-15) ;
        make.height.mas_equalTo(45) ;
    }];
    
}


-(UIButton*)rCommitBtn {
    
    if (_rCommitBtn == nil) {
        _rCommitBtn = [self jyCreateButtonWithTitle:@"确认"] ;
        
        @weakify(self)
        [[_rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            JYSuccessAlterController *alterVC =[[ JYSuccessAlterController alloc]init];
            [self.navigationController jy_showViewController:alterVC completion:nil];
        }] ;
    }
    
    return _rCommitBtn ;
}

-(UIButton*)rForgetBtn {
    
    if (_rForgetBtn  == nil) {
        _rForgetBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [_rForgetBtn setTitle:@"找回交易密码?" forState:UIControlStateNormal];
        [_rForgetBtn setTitleColor:kBlueColor forState:UIControlStateNormal];
        _rForgetBtn.titleLabel.font = [UIFont systemFontOfSize:14] ;
        @weakify(self)
        [[_rForgetBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            JYPasswodSettingVC *pasVC = [[JYPasswodSettingVC alloc]initWithVCType:JYPassVCTypeChangePass]
            ;
            [self.navigationController pushViewController:pasVC animated:YES];
        }] ;
    }
    
    return _rForgetBtn ;
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
