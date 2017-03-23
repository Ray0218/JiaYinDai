//
//  JYFinanceViewController.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/23.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYFinanceViewController.h"
#import "JYMessageVController.h"

@interface JYFinanceViewController ()

@end

@implementation JYFinanceViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItems = nil ;
    
    [self setNavRightButtonWithImage:nil title:@"消息"] ;
    
}

#pragma mark - action

-(void)pvt_clickButtonNavRight {
    JYMessageVController *cv = [[JYMessageVController alloc]init];
    [self.navigationController pushViewController:cv animated:YES];
    
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
