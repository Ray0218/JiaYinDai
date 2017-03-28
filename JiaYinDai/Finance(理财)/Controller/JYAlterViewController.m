//
//  JYAlterViewController.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/28.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYAlterViewController.h"

@interface JYAlterViewController (){
    UIView *_backgroundView;
}

@end

@implementation JYAlterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    _backgroundView = [[UIView alloc] init];
    _backgroundView.backgroundColor =[UIColor whiteColor];
    _backgroundView.layer.cornerRadius = 10;
    _backgroundView.clipsToBounds = YES;
    
    [self.view addSubview:_backgroundView];
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(110);
        make.width.mas_equalTo(SCREEN_WIDTH-60);
        make.height.mas_equalTo(300);
        make.centerX.equalTo(self.view) ;
    }];
    
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pvt_dissMiss)]] ;
    
    [self buildSubViewsUI];
}



-(void)buildSubViewsUI {
    
    UILabel *rFirstOrder = [self createLabelWithText:@"首单" color:kBlueColor font:16 align:NSTextAlignmentCenter hasLayer:YES] ;
    
    UILabel *rLastOrder = [self createLabelWithText:@"尾单" color:kBlueColor font:16 align:NSTextAlignmentCenter hasLayer:YES] ;
    
    UILabel *rReurnOrder = [self createLabelWithText:@"返现" color:kBlueColor font:16 align:NSTextAlignmentCenter hasLayer:YES] ;
    
    UILabel *rFirstDesc = [self createLabelWithText:@"首单科随机获得银子" color:kTextBlackColor font:13 align:NSTextAlignmentLeft hasLayer:NO] ;
    
    UILabel *rLastDesc = [self createLabelWithText:@"尾单科获得投资金额15%的银子" color:kTextBlackColor font:13 align:NSTextAlignmentLeft hasLayer:NO] ;
    
    UILabel *rReurnDesc = [self createLabelWithText:@"单笔满5000元，赠送5000两银子；\n单笔满10000元，赠送11000两银子；\n单笔满20000元，赠送24000两银子。" color:kTextBlackColor font:13 align:NSTextAlignmentLeft hasLayer:NO] ;
    [UILabel changeLineSpaceForLabel:rReurnDesc WithSpace:5] ;

    [self.view addSubview:rFirstOrder];
    [self.view addSubview:rFirstDesc];
    
    [self.view addSubview:rLastOrder];
    [self.view addSubview:rLastDesc];
    
    [self.view addSubview:rReurnOrder];
    [self.view addSubview:rReurnDesc];
    
    CGSize ss = [rReurnOrder  intrinsicContentSize] ;
    
    
    [rFirstOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(_backgroundView).offset(30) ;
         make.width.mas_greaterThanOrEqualTo(50) ;
        make.height.mas_greaterThanOrEqualTo(23) ;
     }] ;
    
    [rFirstDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backgroundView).offset(30) ;
        make.top.equalTo(rFirstOrder.mas_bottom).offset(10);
    }];
    
    [rLastOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rFirstDesc.mas_bottom).offset(20);
        make.left.equalTo(_backgroundView).offset(30) ;
        make.width.mas_greaterThanOrEqualTo(50) ;
        make.height.mas_greaterThanOrEqualTo(23) ;
    }] ;
    
    [rLastDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backgroundView).offset(30) ;
        make.top.equalTo(rLastOrder.mas_bottom).offset(10);
    }];

    [rReurnOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rLastDesc.mas_bottom).offset(20);
         make.left.equalTo(_backgroundView).offset(30) ;
        make.width.mas_greaterThanOrEqualTo(50) ;
        make.height.mas_greaterThanOrEqualTo(23) ;
    }] ;
    
    [rReurnDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backgroundView).offset(30) ;
        make.top.equalTo(rReurnOrder.mas_bottom).offset(10);
    }];




}

-(UILabel*)createLabelWithText:(NSString*)text color:(UIColor*)color font:(CGFloat)font align:(NSTextAlignment)align hasLayer:(BOOL)hasOrnot {

    UILabel *label = [[UILabel alloc]init];
    label.text = text ;
    label.textColor = color ;
    label.font = [UIFont systemFontOfSize:font] ;
    label.textAlignment = align ;
    label.numberOfLines = 0 ;
    if (hasOrnot) {
        label.layer.borderColor = kBlueColor.CGColor ;
        label.layer.borderWidth = 1 ;
        label.layer.cornerRadius = 4 ;
        label.clipsToBounds = YES  ;
    }
    
    return label ;
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
