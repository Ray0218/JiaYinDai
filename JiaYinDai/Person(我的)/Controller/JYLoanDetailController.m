//
//  JYLoanDetailController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/12.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoanDetailController.h"
#import "JYLoanDetailHeader.h"


@interface JYLoanDetailController ()

@property (nonatomic ,strong) JYLoanDetailHeader *rHeaderView ;

@end

@implementation JYLoanDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"借贷详情" ;
    [self buildSubViewsUI];
}

-(void)buildSubViewsUI {

    [self.view addSubview:self.rHeaderView];
    
    [self.rHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view) ;
        make.height.mas_equalTo(300) ;
    }] ;

}


#pragma mark- getter 

-(JYLoanDetailHeader*)rHeaderView {

    if (_rHeaderView == nil) {
        _rHeaderView = [[JYLoanDetailHeader alloc]init];
    }
    
    return _rHeaderView ;
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
