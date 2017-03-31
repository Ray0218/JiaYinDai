//
//  JYSuccessAlterController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/3/31.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYSuccessAlterController.h"

@interface JYSuccessAlterController (){
    UIView *_backgroundView;
}

@property (nonatomic,strong) UIButton *rCommitBtn ;

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
    
    [self.view addSubview:_backgroundView];
    
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pvt_dissMiss)]] ;
    
    
    
    [self.view addSubview:self.rCommitBtn];
    
    
    [self layoutSubViewsUI] ;

}

-(void)layoutSubViewsUI {
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(110);
        make.width.mas_equalTo(SCREEN_WIDTH-60);
        make.height.mas_equalTo(300);
        make.centerX.equalTo(self.view) ;
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
