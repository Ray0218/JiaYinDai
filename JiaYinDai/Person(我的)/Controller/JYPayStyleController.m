//
//  JYPayStyleController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/14.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPayStyleController.h"
#import "JYBankCardCell.h"
#import "JYAddBankController.h"

@interface JYPayStyleController ()

@end

@implementation JYPayStyleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选取支付方式" ;
    
    [self setNavRightButtonWithImage:nil title:@"限额说明"] ;
    
    
    [self initializeTableView] ;
}

-(void)initializeTableView {
    
    self.tableView.rowHeight = 95 ;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    self.tableView.tableFooterView = [UIView new] ;
    self.tableView.separatorInset = UIEdgeInsetsZero ;
    
}

-(void)pvt_clickButtonNavRight {
    
    
}

#pragma mark- UITableViewDataSource/UITableViewDelegate



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == [tableView numberOfRowsInSection:0]-1) {
        static NSString *identifier = @"identifierLoan" ;
        
        JYAddBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYAddBankCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        return cell ;
    }
    
    static NSString *identifier = @"identifierLoan" ;
    
    JYBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYBankCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell ;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [tableView numberOfRowsInSection:0] - 1) {
        JYAddBankController *vc =[[JYAddBankController alloc]init];
        [self.navigationController pushViewController:vc animated:YES] ;
        
    }else{
        
        JYBankCardCell *cell = [tableView cellForRowAtIndexPath:indexPath] ;
        cell.selected = YES ;
    }
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
