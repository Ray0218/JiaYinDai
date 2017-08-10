//
//  JYBalanceController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/2.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYBalanceController.h"
#import "JYChargeController.h"
#import "JYDrawController.h"
#import "JYBankIdentifyController.h"
#import "JYBankModel.h"

@interface JYBalanceController (){
    
    UIScrollView *_rScrollView ;
    UILabel *rTitleLabel ;
    
    UIView *rBgView ;
    
}
@property (nonatomic, strong)UIView *rContentView ;

@property (nonatomic, strong)UIView *rHeaderBgView ;

@property (nonatomic, strong)UILabel *rMoneyLabel ;

@property (nonatomic, strong)UIImageView *rLeftImage ;

@property (nonatomic, strong)UILabel *rDescLabel ;

@property (nonatomic, strong)UILabel *rRightLabel ;


@property (nonatomic, strong)UIButton *rDrawButton ; //提现


@property (nonatomic, strong)UIButton *rChargeButton ; //充值



@end

@implementation JYBalanceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的余额" ;
    [self buildSubViewUI];
    
    [self rLoadData];
    
    [self pvt_loadData];
}


-(void)pvt_loadData {
    
    @weakify(self)
    [[AFHTTPSessionManager jy_sharedManager]POST:kGetMyAccountURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @strongify(self)
        NSDictionary *dataDic = responseObject[@"data"] ;
        
        if (dataDic) {
            
            JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
            [user.fundInfo mergeFromDictionary:dataDic useKeyMapping:NO error:nil];
            
            [self rLoadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
}




-(void)rLoadData {
    
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
    
    self.rMoneyLabel.text = [NSString stringWithFormat:@"%.2f",[user.fundInfo.currentAmount doubleValue]] ;
    self.rRightLabel.text = [NSString stringWithFormat:@"%.2f", [user.fundInfo.usableAmount doubleValue]] ;
    
    
}

-(void)buildSubViewUI {
    
    
    _rScrollView = [[UIScrollView alloc]init];
    _rScrollView.showsVerticalScrollIndicator = NO ;
    _rScrollView.backgroundColor = [UIColor clearColor] ;
    [self.view addSubview:_rScrollView];
    
    [_rScrollView addSubview:self.rContentView];
    
    
    [self.rContentView addSubview:self.rHeaderBgView];
    
    rTitleLabel = [self jyCreateLabelWithTitle:@"账户余额(元)" font:14 color:[UIColor whiteColor] align:NSTextAlignmentLeft] ;
    [self.rContentView addSubview:rTitleLabel];
    
    [self.rContentView addSubview:self.rMoneyLabel];
    
    rBgView = [[UIView alloc]init];
    rBgView.backgroundColor = [UIColor whiteColor] ;
    rBgView.layer.borderWidth = 1 ;
    rBgView.layer.borderColor = kLineColor.CGColor ;
    [self.rContentView addSubview:rBgView];
    
    [self.rContentView addSubview:self.rLeftImage];
    [self.rContentView addSubview:self.rDescLabel];
    [self.rContentView addSubview:self.rRightLabel];
    
    
    [self.rContentView addSubview:self.rChargeButton];
    [self.rContentView addSubview:self.rDrawButton];
    
    
    [self.view setNeedsUpdateConstraints];
    
}

-(void)updateViewConstraints {
    
    [_rScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }] ;
    
    [self.rContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_rScrollView);
        make.height.mas_greaterThanOrEqualTo(SCREEN_HEIGHT);
        make.width.mas_equalTo(SCREEN_WIDTH) ;
        
    }];
    
    
    [self.rHeaderBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.rContentView) ;
        make.height.mas_equalTo(150) ;
    }] ;
    
    
    [rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(15) ;
        make.top.equalTo(self.rContentView).offset(30) ;
    }] ;
    
    
    [self.rMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(15) ;
        make.top.equalTo(rTitleLabel.mas_bottom).offset(15);
    }] ;
    
    
    [rBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(-1) ;
        make.right.equalTo(self.rContentView).offset(1) ;
        make.height.mas_equalTo(45) ;
        make.top.equalTo(self.rHeaderBgView.mas_bottom).offset(15) ;
    }] ;
    
    [self.rLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(15) ;
        make.centerY.equalTo(rBgView) ;
        make.width.mas_equalTo(25) ;
        make.height.mas_equalTo(20) ;
        
    }] ;
    
    [self.rDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rLeftImage.mas_right).offset(15) ;
        make.centerY.equalTo(rBgView) ;
    }] ;
    
    
    [self.rRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rContentView).offset(-15) ;
        make.centerY.equalTo(rBgView) ;
    }] ;
    
    
    [self.rChargeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(15) ;
        make.top.equalTo(rBgView.mas_bottom).offset(30) ;
        make.height.mas_equalTo(45) ;
        make.width.mas_equalTo((SCREEN_WIDTH-45)/2.0) ;
    }] ;
    
    [self.rDrawButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rContentView).offset(-15) ;
        make.top.equalTo(rBgView.mas_bottom).offset(30) ;
        make.height.mas_equalTo(45) ;
        make.width.mas_equalTo((SCREEN_WIDTH-45)/2.0) ;
    }] ;
    
    
    [super updateViewConstraints];
    
}

#pragma mark- action

-(void)pvt_chargeAction {
    
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
    
    NSArray *auditItem = [user.auditItem componentsSeparatedByString:@","] ;
    
    if ([auditItem containsObject:@"1"]) {
        
        JYChargeController *vc = [[JYChargeController alloc]init];
        [self.navigationController pushViewController:vc
                                             animated:YES] ;
    } else{
        
        [self gotToIdentify];
    }
    
    
    
}

-(void)pvt_drawAction {
    
    
    
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
    NSArray *auditItem = [user.auditItem componentsSeparatedByString:@","] ;
    
    if ([auditItem containsObject:@"1"]) {
        
        
        JYDrawController *vc = [[JYDrawController alloc]init];
        [self.navigationController pushViewController:vc
                                             animated:YES] ;
    }else {
        [self gotToIdentify] ;
        
    }
    
}

-(void)gotToIdentify {
    
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
    
    NSArray *auditItem = [user.auditItem componentsSeparatedByString:@","] ;
    
    if ([auditItem containsObject:@"1B"]){
        JYBankIdentifyController *identifyVC = [[JYBankIdentifyController  alloc]initWithHeaderType:JYIdentifyTypePassword] ;
        [self.navigationController pushViewController:identifyVC animated:YES];
        
    }else if ([auditItem containsObject:@"1A"]){
        JYBankIdentifyController *identifyVC = [[JYBankIdentifyController  alloc]initWithHeaderType:JYIdentifyTypeBank] ;
        [self.navigationController pushViewController:identifyVC animated:YES];
        
    }else{
        
        JYBankIdentifyController *identifyVC = [[JYBankIdentifyController  alloc]initWithHeaderType:JYIdentifyTypeName] ;
        [self.navigationController pushViewController:identifyVC animated:YES];
    }
    
    
    
}

#pragma mark- getter

-(UIView*)rContentView {
    if (_rContentView == nil) {
        _rContentView = [[UIView alloc]init];
        _rContentView.backgroundColor = kBackGroundColor ;
        
    }
    
    return _rContentView ;
}


-(UIView*)rHeaderBgView {
    
    if (_rHeaderBgView == nil) {
        _rHeaderBgView = [[UIView alloc]init];
        _rHeaderBgView.backgroundColor = kBlueColor ;
    }
    
    return _rHeaderBgView ;
}

-(UILabel*)rMoneyLabel {
    if (_rMoneyLabel == nil) {
        _rMoneyLabel = [self jyCreateLabelWithTitle:@"8.75" font:50 color:[UIColor whiteColor] align:NSTextAlignmentLeft] ;
    }
    
    return _rMoneyLabel ;
}


-(UIImageView*)rLeftImage {
    
    if (_rLeftImage == nil) {
        _rLeftImage = [[UIImageView alloc]init];
        _rLeftImage.backgroundColor = [UIColor clearColor] ;
        _rLeftImage.image = [UIImage imageNamed:@"charge_icon"] ;
    }
    
    return _rLeftImage ;
}

-(UILabel*)rDescLabel {
    
    if (_rDescLabel == nil) {
        _rDescLabel = [self jyCreateLabelWithTitle:@"可提现额度(元)" font:16 color:kBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rDescLabel ;
}


-(UILabel*)rRightLabel {
    
    if (_rRightLabel == nil) {
        _rRightLabel = [self jyCreateLabelWithTitle:@"1.25" font:14 color:kTextBlackColor align:NSTextAlignmentRight] ;
    }
    
    return _rRightLabel ;
}

-(UIButton*)rDrawButton {
    if (_rDrawButton == nil) {
        _rDrawButton = [self jyCreateButtonWithTitle:@"提现"] ;
        [_rDrawButton setBackgroundImage:[UIImage jy_imageWithColor:kOrangewColor] forState:UIControlStateNormal];
        @weakify(self)
        
        [[_rDrawButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            
            [self pvt_drawAction] ;
            
        }] ;
    }
    
    return _rDrawButton ;
}


-(UIButton*)rChargeButton {
    if (_rChargeButton == nil) {
        _rChargeButton = [self jyCreateButtonWithTitle:@"充值"] ;
        @weakify(self)
        [[_rChargeButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            [self pvt_chargeAction] ;
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
