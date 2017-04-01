//
//  JYSuccessAlterController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/3/31.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYSuccessAlterController.h"
#import "JYCircleView.h"





@interface JYSuccessAlterController (){
    UIView *_backgroundView;
    UIView *_rBottomLine;

}

@property (nonatomic,strong) UIButton *rCommitBtn ;

@property (nonatomic,strong) UILabel *rTitleLabel ;

@property (nonatomic,strong) JYCircleView *rCircleView ;



@end

@implementation JYSuccessAlterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self builSubViewsUI];
}

-(void)builSubViewsUI {
    _backgroundView = [[UIView alloc] init];
    _backgroundView.backgroundColor =[UIColor whiteColor];
    _backgroundView.layer.cornerRadius = 10;
    _backgroundView.clipsToBounds = YES;
    
    _rBottomLine = ({
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = kBlueColor ;
        view ;
    }) ;
    [_backgroundView addSubview:_rBottomLine ];
    
    
    [self.view addSubview:_backgroundView];
    [self.view addSubview:self.rTitleLabel];
    
    [self.view addSubview:self.rCircleView];
    
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pvt_dissMiss)]] ;
    
    
    
    [self.view addSubview:self.rCommitBtn];
    
    
    [self layoutSubViewsUI] ;

}

-(void)layoutSubViewsUI {
    
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.width.mas_equalTo(SCREEN_WIDTH-60);
        make.height.mas_equalTo(335);
        make.center.equalTo(self.view) ;
    }];

    
    [_rBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(_backgroundView) ;
        make.height.mas_equalTo(10) ;
    }] ;
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backgroundView).offset(35);
        make.left.equalTo(_backgroundView).offset(15) ;
        make.right.equalTo(_backgroundView).offset(-15) ;
    }];
    
    [self.rCircleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(_backgroundView) ;
        make.top.equalTo(self.rTitleLabel.mas_bottom).offset(10) ;
        make.bottom.equalTo(self.rCommitBtn.mas_top).offset(-10) ;
    }];
    
    
    [self.rCommitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backgroundView).offset(15) ;
        make.right.equalTo(_backgroundView).offset(-15) ;
        make.bottom.equalTo(_backgroundView).offset(-30) ;
        make.height.mas_equalTo(45) ;
    }] ;

}

-(UIButton*)rCommitBtn {
    
    if (_rCommitBtn == nil) {
        _rCommitBtn = [self jyCreateButtonWithTitle:@"查看投资记录"] ;
    }
    
    return _rCommitBtn ;
}


 

-(UILabel*)rTitleLabel {
    if (_rTitleLabel == nil) {
        _rTitleLabel = [self jyCreateLabelWithTitle:@"您已成功购买XXX产品XXXX元，投资期限XX天。" font:16 color:kTextBlackColor align:NSTextAlignmentLeft] ;
        _rTitleLabel.numberOfLines = 0 ;
    }
    return _rTitleLabel ;
}

-(JYCircleView*)rCircleView {

    if (_rCircleView == nil) {
        _rCircleView = [[JYCircleView alloc]init];
        
        @weakify(self)
        _rCircleView.rReturnBlock = ^{
            @strongify(self)
            NSLog(@"倒计时结束") ;
            
            [self pvt_dissMiss] ;
            
        } ;
    
    }
    
    return _rCircleView ;
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
