//
//  JYEstimateController.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/29.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYEstimateController.h"
#import "JYEstimateView.h"
#import "JYEstimateHeaderView.h"



@interface JYEstimateController (){
    UIScrollView *_rScrollView ;
     UILabel *_rPreLabel ;
    
    UILabel *_rTimeLab ; //期数
    UILabel *_rBackTimeLab ;//还款日期
    UILabel *_rPrincipleLab ; //本金
    UILabel *_rInterestLab ; //利息
    
}
@property (nonatomic, strong)UIView *rContentView ;

@property (nonatomic, strong)JYEstimateHeaderView *rHeaderView ;

@property (nonatomic,strong)UILabel *rDescLabel ; //描述文字
@property (nonatomic,strong)JYEstimateView *rMoneyView ; //投标金额


@property (nonatomic,strong)UILabel *rTimesLabel ;
@property (nonatomic,strong)UILabel *rBackLabel ;
@property (nonatomic,strong)UILabel *rPrinLabel ;
@property (nonatomic,strong)UILabel *rIntLabel ;


@property (nonatomic,strong)UILabel *rTotalLabel ; //利息总计


@end


static inline NSMutableAttributedString * TTTotalString( NSString*baseText,NSString *text ){
    
    NSMutableAttributedString *att = [[NSMutableAttributedString  alloc]initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}] ;
    
    [att addAttribute:NSForegroundColorAttributeName value:kTextBlackColor range:NSMakeRange(0,baseText.length)] ;
    
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
    
    self.rTotalLabel.attributedText = TTTotalString(@"利息总计：", @"利息总计：1632.20元") ;
    
    
    _rScrollView = [[UIScrollView alloc]init];
    _rScrollView.showsVerticalScrollIndicator = NO ;
    _rScrollView.backgroundColor = [UIColor clearColor] ;
    [self.view addSubview:_rScrollView];
    
    [_rScrollView addSubview:self.rContentView];
    
    
    
    [self.rContentView addSubview:self.rHeaderView];
    
    _rPreLabel = [self jyCreateLabelWithTitle:@"预期年化" font:18 color:[UIColor whiteColor] align:NSTextAlignmentLeft] ;
    [self.rContentView addSubview:_rPreLabel];
    [self.rContentView addSubview:self.rMoneyView];
    [self.rContentView addSubview:self.rDescLabel];
    
    
    _rTimeLab  = [self createChatLabel:@"期数" hasLayer:YES] ;
    _rBackTimeLab  = [self createChatLabel:@"回款日期" hasLayer:YES] ;
    _rPrincipleLab = [self createChatLabel:@"应收本金" hasLayer:YES] ;
    _rInterestLab  = [self createChatLabel:@"应收利息" hasLayer:YES] ;
    
    [self.rContentView addSubview:_rTimeLab];
    [self.rContentView addSubview:_rBackTimeLab];
    [self.rContentView addSubview:_rPrincipleLab];
    [self.rContentView addSubview:_rInterestLab];
    
    [self.rContentView addSubview:self.rTimesLabel];
    [self.rContentView addSubview:self.rBackLabel];
    [self.rContentView addSubview:self.rPrinLabel];
    [self.rContentView addSubview:self.rIntLabel];
    
    [self.rContentView addSubview:self.rTotalLabel];
    
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
    
    [self.rHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.equalTo(self.rContentView) ;
        
        make.height.equalTo(@(120));
        
    }];
    
    [_rPreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(15) ;
        make.top.equalTo(self.rContentView).offset(20) ;
    }] ;
    
    
    [self.rMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.rContentView) ;
        make.top.equalTo(self.rHeaderView.mas_bottom).offset(15) ;
        make.height.mas_equalTo(130) ;
    }];
    
    
    [self.rDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rMoneyView.mas_bottom).offset(15) ;
        make.left.equalTo(self.rContentView).offset(15) ;
        make.right.equalTo(self.rContentView).offset(-15) ;
    }];
    
    
    [_rTimeLab  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(35) ;
        make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH/4.0) ;
        make.left.equalTo(self.rContentView).offset(-1) ;
        make.top.equalTo(self.rDescLabel.mas_bottom).offset(15) ;
    }] ;
    
    [_rBackTimeLab  mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH/4.0) ;
        make.left.equalTo(_rTimeLab.mas_right).offset(-1) ;
        make.height.and.top.equalTo(_rTimeLab) ;
    }] ;
    [_rPrincipleLab  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH/4.0) ;
        make.left.equalTo(_rBackTimeLab.mas_right).offset(-1) ;
        make.height.and.top.equalTo(_rTimeLab) ;
    }] ;
    [_rInterestLab  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH/4.0).priorityLow() ;
        make.left.equalTo(_rPrincipleLab.mas_right).offset(-1) ;
        make.right.equalTo(self.rContentView).offset(1) ;
        
        make.height.and.top.equalTo(_rTimeLab) ;
    }] ;
    
    
    
    [self.rTimesLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(35) ;
        make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH/4.0) ;
        make.left.equalTo(self.rContentView) ;
        make.top.equalTo(_rTimeLab.mas_bottom) ;
    }] ;
    
    [self.rBackLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH/4.0) ;
        make.left.equalTo(self.rTimesLabel.mas_right);
        make.height.and.top.equalTo(self.rTimesLabel) ;
    }] ;
    [self.rPrinLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH/4.0) ;
        make.left.equalTo(self.rBackLabel.mas_right);
        make.height.and.top.equalTo(self.rTimesLabel) ;
    }] ;
    [self.rIntLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH/4.0).priorityLow() ;
        make.left.equalTo(self.rPrinLabel.mas_right) ;
        make.right.equalTo(self.rContentView)  ;
        make.height.and.top.equalTo(self.rTimesLabel) ;
    }] ;
    
    [self.rTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(-1) ;
        make.right.equalTo(self.rContentView).offset(1) ;
        make.top.equalTo(self.rTimesLabel.mas_bottom) ;
        make.height.mas_equalTo(35) ;
    }] ;
    
    
    
    
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

-(JYEstimateHeaderView*)rHeaderView {
    
    if (_rHeaderView == nil) {
        _rHeaderView = [[JYEstimateHeaderView alloc]init];
    }
    
    return _rHeaderView ;
}

-(UILabel*)rDescLabel {
    if (_rDescLabel == nil) {
        _rDescLabel = [self jyCreateLabelWithTitle:@"本次投标为每月等额还款，共分12月完成，收益实际投资持有月数(一年按12个月/360天)计算。\n实际收益请以实际投标金额和实际满标时间为准。" font:16 color:kTextBlackColor align:NSTextAlignmentLeft] ;
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

-(UILabel*)rTimesLabel {
    
    if (_rTimesLabel == nil) {
        _rTimesLabel = [self createChatLabel:@"3期" hasLayer:NO] ;
    }
    return _rTimesLabel ;
}

-(UILabel*)rBackLabel {
    
    if (_rBackLabel == nil) {
        _rBackLabel = [self createChatLabel:@"17/07/01" hasLayer:NO] ;
    }
    return _rBackLabel ;
}

-(UILabel*)rPrinLabel {
    
    if (_rPrinLabel == nil) {
        _rPrinLabel = [self createChatLabel:@"200,000元" hasLayer:NO] ;
    }
    return _rPrinLabel ;
}

-(UILabel*)rIntLabel {
    
    if (_rIntLabel == nil) {
        _rIntLabel = [self createChatLabel:@"1,000元" hasLayer:NO] ;
    }
    return _rIntLabel ;
}


-(UILabel*)rTotalLabel {
    if (_rTotalLabel == nil) {
        _rTotalLabel = [self jyCreateLabelWithTitle:@"利息总计  1632.20元   " font:18 color:kBlueColor align:NSTextAlignmentRight] ;
        _rTotalLabel.layer.borderColor = kLineColor .CGColor;
        _rTotalLabel.layer.borderWidth = 1 ;
        _rTotalLabel.backgroundColor = [UIColor whiteColor] ;
        
    }
    return _rTotalLabel ;
}


-(UILabel*)createChatLabel:(NSString*)title hasLayer:(BOOL)has{
    
    UILabel *label = [self jyCreateLabelWithTitle:title font:18 color:kTextBlackColor align:NSTextAlignmentCenter] ;
    
    if (has) {
        label.layer.borderColor = kLineColor .CGColor;
        label.layer.borderWidth = 1 ;
    }
    
    label.backgroundColor = [UIColor whiteColor] ;
    
    
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
