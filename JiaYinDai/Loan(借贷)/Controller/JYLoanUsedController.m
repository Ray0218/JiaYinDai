//
//  JYLoanUsedController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/10.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoanUsedController.h"


@interface JYLoanUsedController (){
    UIScrollView *_rScrollView ;
    
    UIView *rBackView ;
    UIView *rLineView ;
    UILabel *rTitleLabel ;
    
    UILabel *rDescLabel ;
    
    
}
@property (nonatomic, strong)UIView *rContentView ;

@property (nonatomic, strong)UITextView *rTextView ;

@property (nonatomic, strong)UIButton *rCommitBtn ;

@property (nonatomic ,strong) UITextField *rTextField ;

@property (nonatomic ,strong) UILabel *rLimitLabel ;


@end



static inline NSMutableAttributedString *TTTextViewString(NSString* labelText ){
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    paragraphStyle.headIndent = 15 ;
    paragraphStyle.firstLineHeadIndent = 15 ;
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    return attributedString ;
    
} ;

@implementation JYLoanUsedController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title  = @"借款用途" ;
    [self buildSubViewUI];
}

-(void)buildSubViewUI {
    
    
    
    _rScrollView = [[UIScrollView alloc]init];
    _rScrollView.showsVerticalScrollIndicator = NO ;
    _rScrollView.backgroundColor = [UIColor clearColor] ;
    [self.view addSubview:_rScrollView];
    
    [_rScrollView addSubview:self.rContentView];
    
    
    [self.rContentView addSubview:self.rTextView];
    [self.rContentView addSubview:self.rCommitBtn];
    
    
    rBackView = ({
        UIView *view = [[UIView alloc]init];
        view.layer.borderColor = kLineColor.CGColor ;
        view.layer.borderWidth = 1 ;
        view.layer.cornerRadius = 5 ;
        view.backgroundColor = [UIColor whiteColor] ;
        view ;
    }) ;
    
    rTitleLabel =[ self jyCreateLabelWithTitle:@"借款标题" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    
    rDescLabel = [ self jyCreateLabelWithTitle:@"借款描述" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    
    rLineView = ({
        UIView *view = [[UIView alloc]init];
        view.backgroundColor =  kLineColor;
        view ;
    }) ;
    
    
    [self.rContentView addSubview:rBackView];
    [self.rContentView addSubview:rTitleLabel];
    [self.rContentView addSubview:rLineView];
    
    [self.rContentView addSubview:self.rTextField];
    
    [self.rContentView addSubview:rDescLabel];
    [self.rContentView addSubview:self.rLimitLabel];
    
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
    
    
    [rBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self.rContentView).offset(15) ;
        make.right.equalTo(self.rContentView).offset(-15) ;
        make.height.mas_equalTo(45) ;
    }];
    
    [rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rBackView).offset(15) ;
        make.centerY.equalTo(rBackView) ;
        
    }] ;
    
    
    [rLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rTitleLabel.mas_right).offset(15) ;
        make.width.mas_equalTo(1) ;
        make.centerY.equalTo(rBackView) ;
        make.height.mas_equalTo(35) ;
    }];
    
    [self.rTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rBackView).offset(-5) ;
        make.centerY.equalTo(rBackView) ;
        make.left.equalTo(rLineView.mas_right).offset(15) ;
    }] ;
    [rDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rBackView.mas_bottom) ;
        make.left.equalTo(self.rContentView).offset(15) ;
        make.height.mas_equalTo(40) ;
    }] ;
    
    [self.rTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rDescLabel.mas_bottom)  ;
        make.centerX.equalTo(self.rContentView) ;
        make.width.mas_equalTo(SCREEN_WIDTH-30) ;
        make.height.mas_equalTo(200) ;
    }] ;
    
    
    [self.rLimitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.rTextView).offset(-15) ;
        make.right.equalTo(self.rTextView).offset(-15) ;
    }] ;
    
    
    
    [self.rCommitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rTextView.mas_bottom).offset(25) ;
        make.left.equalTo(self.rContentView).offset(15) ;
        make.right.equalTo(self.rContentView).offset(-15) ;
        make.bottom.equalTo(self.rContentView).offset(-20).priorityLow() ;
        make.height.mas_equalTo(45) ;
    }] ;
    
    
    [super updateViewConstraints];
    
}
#pragma mark- action

-(void)pvt_dissKeyBoard {
    
    
    [self.view endEditing:YES];
}

#pragma mar
#pragma mark- getter

-(UIView*)rContentView {
    if (_rContentView == nil) {
        _rContentView = [[UIView alloc]init];
        _rContentView.backgroundColor = kBackGroundColor ;
        [_rContentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pvt_dissKeyBoard)]] ;
    }
    
    return _rContentView ;
}



-(UITextView*)rTextView {
    
    if (_rTextView == nil) {
        _rTextView = [[UITextView alloc]init];
        _rTextView.textAlignment = NSTextAlignmentLeft ;
        _rTextView.layer.cornerRadius = 5 ;
        _rTextView.layer.borderColor = kLineColor.CGColor ;
        _rTextView.layer.borderWidth = 1 ;
        _rTextView.backgroundColor = [UIColor whiteColor] ;
        _rTextView.text = @"详细说明本次借款用途，自身优势和按时还款承诺等信息，限20-120字" ;
        _rTextView.font = [UIFont systemFontOfSize:16] ;
        _rTextView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0) ;
        [_rTextView.rac_textSignal subscribeNext:^(NSString* x) {
            
            _rTextView.attributedText = TTTextViewString(x) ;
            NSLog(@"%@",x) ;
        }  ] ;
    }
    
    
    
    
    return _rTextView ;
}

-(UITextField*)rTextField {
    
    if (_rTextField == nil) {
        _rTextField = [[UITextField alloc]init];
        _rTextField.placeholder = @"请如实填写您的借款用途，8-15字" ;
        _rTextField.font = [UIFont systemFontOfSize:16] ;
    }
    
    return _rTextField ;
}

-(UIButton*)rCommitBtn {
    
    if (_rCommitBtn == nil) {
        _rCommitBtn = [self jyCreateButtonWithTitle:@"提交"] ;
    }
    
    return _rCommitBtn ;
}

-(UILabel*)rLimitLabel {
    if (_rLimitLabel == nil) {
        _rLimitLabel = [self jyCreateLabelWithTitle:@"0/120" font:16 color:kTextBlackColor align:NSTextAlignmentRight] ;
        _rLimitLabel.backgroundColor = [UIColor orangeColor] ;
    }
    
    return _rLimitLabel ;
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
