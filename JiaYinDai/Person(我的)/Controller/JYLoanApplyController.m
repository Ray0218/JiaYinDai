//
//  JYLoanApplyController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/21.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoanApplyController.h"
#import "JYLoanApplyCell.h"
#import "JYApplyDetailController.h"



@interface JYLoanApplyController ()

@end

@implementation JYLoanApplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"借贷记录" ;
    [self initializeTableView];
}

-(void)initializeTableView {
    
    self.tableView.estimatedRowHeight = 45 ;
    self.tableView.rowHeight = UITableViewAutomaticDimension ;
    self.tableView.tableFooterView =  [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    
}


#pragma mark- UITableViewDataSource/UITableViewDelegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *identifier = @"identifierLogin" ;
    
    JYLoanApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYLoanApplyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    return cell ;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JYApplyDetailController *vc = [[JYApplyDetailController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//
//    static NSString *headerIdentifier = @"headerIdentifier" ;
//
//    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
//    if (headerView == nil) {
//        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
//        headerView.contentView.backgroundColor = [UIColor clearColor];
//        headerView.backgroundView = ({
//            UIView *view = [[UIView alloc]init] ;
//            view.backgroundColor = [UIColor clearColor] ;
//            view ;
//        });
//    }
//
//    return headerView ;
//
//}


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
