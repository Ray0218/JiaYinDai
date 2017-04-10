//
//  JYBuyViewController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/3/30.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYBuyViewController.h"
#import "JYEstimateHeaderView.h"
#import "JYPayStyleView.h"
#import "JYPayCommtController.h"



@interface JYBuyViewController (){
    
    UIScrollView *_rScrollView ;
    UILabel *_rTotalTitleLab ;//剩余可投金额
    UILabel *_rBeginTitleLab; //起购金额
    
    JYBuyRowView *_rbuyTextView ;//投资金额
    JYPayStyleView *_rPayStyleView ; //支付方式
    
}

@property (nonatomic, strong)UIView *rContentView ;
@property (nonatomic, strong)JYEstimateHeaderView *rHeaderView ;
@property (nonatomic, strong)UILabel *rTotalMoneyLab  ; //可投金额
@property (nonatomic, strong)UILabel *rBuyCountLab  ; //起购金额

@property (nonatomic, strong)UIButton *rAgreeBtn  ; //同意协议
@property (nonatomic, strong)UIButton *rCommitBtn  ; //确认按钮


@end

@implementation JYBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"嘉银贷588期" ;
    [self buildSubViewUI];
}

#pragma mark- action

-(void)pvt_clickContent:(UIGestureRecognizer*)gesture{
    
    
    CGPoint point = [gesture locationInView:self.rContentView];
    
    
    CGRect payRect = [_rPayStyleView convertRect:_rPayStyleView.rPayStyleView.frame toView:self.rContentView] ;
    
    CGRect redRect = [_rPayStyleView convertRect:_rPayStyleView.rRedView.frame toView:self.rContentView] ;
    
    if (CGRectContainsPoint(payRect , point) ) {
        NSLog(@"点击支付方式") ;
    }else if (CGRectContainsPoint(redRect, point) ) {
        NSLog(@"点击红包") ;
    }
    
}


#pragma mark - builUI
-(void)buildSubViewUI {
    
    _rScrollView = [[UIScrollView alloc]init];
    _rScrollView.showsVerticalScrollIndicator = NO ;
    _rScrollView.backgroundColor = [UIColor clearColor] ;
    [self.view addSubview:_rScrollView];
    
    [_rScrollView addSubview:self.rContentView];
    [self.rContentView addSubview:self.rHeaderView];
    
    _rTotalTitleLab = [self jyCreateLabelWithTitle:@"剩余可投金额:" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    _rBeginTitleLab = [self jyCreateLabelWithTitle:@"起投金额:" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    [self.rContentView addSubview:_rTotalTitleLab];
    [self.rContentView addSubview:_rBeginTitleLab];
    [self.rContentView addSubview:self.rTotalMoneyLab];
    [self.rContentView addSubview:self.rBuyCountLab];
    
    
    _rbuyTextView = [[JYBuyRowView alloc]initWithLeftTitle:@"投资金额" rowType:JYRowTypeTextField];
    _rPayStyleView = [[JYPayStyleView alloc]initWithType:JYPayTypeAddBank ];
    
    
    [self.rContentView addSubview:_rbuyTextView];
    [self.rContentView addSubview:_rPayStyleView];
    
    [self.rContentView addSubview:self.rAgreeBtn];
    [self.rContentView addSubview:self.rCommitBtn];
    
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
    
    [self.rHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.equalTo(self.rContentView) ;
        make.height.equalTo(@(120));
        
    }];
    
    
    [_rTotalTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(15) ;
        make.top.equalTo(self.rHeaderView.mas_bottom).offset(15) ;
        make.width.mas_lessThanOrEqualTo(130) ;
        
    }];
    
    [_rBeginTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(15) ;
        make.bottom.equalTo(_rbuyTextView.mas_top).offset(-15) ;
    }];
    
    [self.rTotalMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rHeaderView.mas_bottom).offset(15) ;
        make.left.equalTo(_rTotalTitleLab.mas_right);
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
        make.top.equalTo(_rbuyTextView.mas_bottom).offset(15) ;
    }];
    
    
    
    [self.rAgreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(15) ;
        make.top.equalTo(_rPayStyleView.mas_bottom).offset(15) ;
        make.height.mas_equalTo(30) ;
    }];
    
    [self.rCommitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(15) ;
        make.right.equalTo(self.rContentView).offset(-15) ;
        make.top.equalTo(self.rAgreeBtn.mas_bottom).offset(25) ;
        make.height.mas_equalTo(45);
        make.bottom.equalTo(self.rContentView).offset(-25).priorityLow() ;
        
    }];
    
    [super updateViewConstraints];
    
}

#pragma mark -getter
-(UIView*)rContentView {
    
    if (_rContentView == nil) {
        _rContentView = [[UIView alloc]init];
        _rContentView.backgroundColor = kBackGroundColor ;
        [_rContentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pvt_clickContent:)]] ;
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
        _rTotalMoneyLab = [self jyCreateLabelWithTitle:@"200,000元" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rTotalMoneyLab ;
}

-(UIButton*)rAgreeBtn {
    
    if (_rAgreeBtn == nil) {
        _rAgreeBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        _rAgreeBtn.backgroundColor = [UIColor clearColor] ;
        [_rAgreeBtn setTitle:@"阅读并同意《嘉银贷借款协议》" forState:UIControlStateNormal];
        _rAgreeBtn.titleLabel.font = [UIFont systemFontOfSize:18] ;
        [_rAgreeBtn setTitleColor:kTextBlackColor forState:UIControlStateNormal];
        
        _rAgreeBtn.imageView.image = [UIImage imageNamed:@""] ;
    }
    return _rAgreeBtn ;
}

-(UIButton*)rCommitBtn {
    
    if (_rCommitBtn == nil) {
        _rCommitBtn =  [self jyCreateButtonWithTitle:@"下一步"] ;
        
        @weakify(self)
        [[_rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            
            JYPayCommtController *payVC = [[JYPayCommtController alloc]init];
            [self.navigationController pushViewController:payVC animated:YES];
            
        }] ;
        
        
        
    }
    return _rCommitBtn ;
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

