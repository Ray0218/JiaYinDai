//
//  JYEstimateController.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/29.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYEstimateController.h"
#import "JYEstimateView.h"


@interface JYEstimateController (){
    UIScrollView *_rScrollView ;
    UIView *_rHeaderBgView ;
    UILabel *_rPreLabel ;
}
@property (nonatomic, strong)UIView *rContentView ;

@property (nonatomic,strong)UILabel *rTimeLabel ; //期限
@property (nonatomic,strong)UILabel *rPercentLabel ; //预期年化
@property (nonatomic,strong)UILabel *rDescLabel ; //描述文字
@property (nonatomic,strong)JYEstimateView *rMoneyView ; //投标金额



@end

static inline NSMutableAttributedString * TTPercentString( NSString*baseText,NSString *text ){
    
    NSMutableAttributedString *att = [[NSMutableAttributedString  alloc]initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:26]}] ;
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:50] range:NSMakeRange(0,baseText.length)] ;
    
    return att ;
    
} ;


@implementation JYEstimateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.title = @"收益预估" ;
    [self buildSubViewUI];
}

-(void)buildSubViewUI {

    _rScrollView = [[UIScrollView alloc]init];
    _rScrollView.showsVerticalScrollIndicator = NO ;
    _rScrollView.backgroundColor = [UIColor clearColor] ;
     [self.view addSubview:_rScrollView];
    
    
    [_rScrollView addSubview:self.rContentView];
    
    
    _rHeaderBgView = [[UIView alloc]init];
    _rHeaderBgView.backgroundColor = kBlueColor ;
    [self.rContentView addSubview:_rHeaderBgView];
    
    _rPreLabel = [self createLabelWithTitle:@"预期年化" font:18 color:[UIColor whiteColor] align:NSTextAlignmentLeft] ;
    [self.rContentView addSubview:_rPreLabel];
    [self.rContentView addSubview:self.rPercentLabel];
    [self.rContentView addSubview:self.rTimeLabel];
    [self.rContentView addSubview:self.rMoneyView];
    [self.rContentView addSubview:self.rDescLabel];

    
    self.rPercentLabel.attributedText = TTPercentString(@"12", @"12%+2%") ;

    
    [self.view setNeedsUpdateConstraints];

         
}

-(void)updateViewConstraints {
    
    [_rScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }] ;
    
    [self.rContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_rScrollView);
        make.height.equalTo(_rScrollView);
        make.width.mas_equalTo(SCREEN_WIDTH) ;
        make.bottom.equalTo(_rScrollView).offset(-10) ;
        
     }];

    [_rHeaderBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.equalTo(self.rContentView) ;
        
        make.height.equalTo(@(120));
 
     }];
    
    [_rPreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(15) ;
        make.top.equalTo(self.rContentView).offset(20) ;
    }] ;
    
    [self.rPercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(15);
        make.bottom.equalTo(_rHeaderBgView.mas_bottom).offset(-10) ;
    }] ;
    
    
    [self.rTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rContentView).offset(-15);
        make.bottom.equalTo(_rHeaderBgView).offset(-15) ;
    }] ;
    
    [self.rMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.rContentView) ;
        make.top.equalTo(_rHeaderBgView.mas_bottom).offset(15) ;
        make.height.mas_equalTo(130) ;
    }];
    
    
    [self.rDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rMoneyView.mas_bottom).offset(15) ;
        make.left.equalTo(self.rContentView).offset(15) ;
        make.right.equalTo(self.rContentView).offset(-15) ;
    }];
    
    [super updateViewConstraints];


}

#pragma mark- action

-(void)pvt_dissKeyBoard {

    
     [self.view endEditing:YES];
}

#pragma mark- getter

-(UIView*)rContentView {
    if (_rContentView == nil) {
        _rContentView = [[UIView alloc]init];
        _rContentView.backgroundColor = kBackGroundColor ;
        [_rContentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pvt_dissKeyBoard)]] ;
    }
    
    return _rContentView ;
}

-(UILabel*)rPercentLabel {
    if (_rPercentLabel == nil) {
        _rPercentLabel = [self createLabelWithTitle:@"" font:18 color:[UIColor whiteColor] align:NSTextAlignmentLeft] ;
    }
    
    return _rPercentLabel ;
}

-(UILabel*)rTimeLabel {
    if (_rTimeLabel == nil) {
        _rTimeLabel = [self createLabelWithTitle:@"期限\n12个月" font:18 color:[UIColor whiteColor] align:NSTextAlignmentRight] ;
        _rTimeLabel.numberOfLines = 2 ;
    }
    
    return _rTimeLabel ;
}

-(UILabel*)rDescLabel {
    if (_rDescLabel == nil) {
        _rDescLabel = [self createLabelWithTitle:@"本次投标为每月等额还款，共分12月完成，收益实际投资持有月数(一年按12个月/360天)计算。\n实际收益请以实际投标金额和实际满标时间为准。" font:16 color:kTextBlackColor align:NSTextAlignmentLeft] ;
        _rDescLabel.numberOfLines = 0;
    }
    
    return _rDescLabel  ;
}

-(JYEstimateView*)rMoneyView {
    if (_rMoneyView == nil) {
        _rMoneyView = [[JYEstimateView alloc]init];
        
    }
    
    return _rMoneyView ;
}

- (UILabel*)createLabelWithTitle:(NSString*)title font:(CGFloat)font color:(UIColor*)color align:(NSTextAlignment) align{
    
    UILabel *label = [[UILabel alloc]init];
    label.text = title ;
    label.textColor = color ;
    label.font = [UIFont systemFontOfSize:font] ;
    label.textAlignment = align ;
    label.backgroundColor = [UIColor clearColor] ;
    
    return label ;
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
