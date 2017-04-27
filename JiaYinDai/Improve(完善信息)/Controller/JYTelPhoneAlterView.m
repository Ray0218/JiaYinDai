//
//  JYTelPhoneAlterView.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/20.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYTelPhoneAlterView.h"

@interface JYTelPhoneAlterView (){
    UIView *_backgroundView;
    
    UIButton *rCommitBtn ;
    UILabel *rDescLabel ;
    
}

@end

@implementation JYTelPhoneAlterView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self builSubViewsUI];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pvt_dissMiss)]] ;
    
}

-(void)builSubViewsUI {
    _backgroundView = [[UIView alloc] init];
    _backgroundView.backgroundColor =[UIColor whiteColor];
    _backgroundView.layer.cornerRadius = 6;
    _backgroundView.clipsToBounds = YES;
    [self.view addSubview:_backgroundView];
    
    
    rCommitBtn = [self jyCreateButtonWithTitle:@"我知道了"] ;
    [rCommitBtn addTarget:self action:@selector(pvt_dissMiss) forControlEvents:UIControlEventTouchUpInside] ;
    [_backgroundView addSubview:rCommitBtn];
    
    
    rDescLabel = [self jyCreateLabelWithTitle:@"服务密码是本人手机号预留在（移动、联通、电信）等运营商中的一种密码，用来查询办理业务。如已忘记请联系运营商客服。" font:14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    rDescLabel.numberOfLines = 0 ;
    [UILabel changeLineSpaceForLabel:rDescLabel WithSpace:10] ;
    
    [self.view addSubview:rDescLabel];
    
    
    
    [self layoutSubViewsUI] ;
    
}

-(void)layoutSubViewsUI {
    
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH-60);
        make.height.mas_greaterThanOrEqualTo(100);
        make.center.equalTo(self.view) ;
    }];
    
    [rDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backgroundView).offset(25) ;
        make.left.equalTo(_backgroundView).offset(15) ;
        make.right.equalTo(_backgroundView).offset(-15) ;
        make.bottom.equalTo(_backgroundView).offset(-80) ;
    }] ;
    
    
    [rCommitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(_backgroundView) ;
        make.height.mas_equalTo(45) ;
    }] ;
}

#pragma mark- action

-(void)pvt_dissMiss{
    
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
