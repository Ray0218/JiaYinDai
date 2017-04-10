//
//  JYBankCardController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/10.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYBankCardController.h"
#import "JYBankCardCell.h"

@interface JYBankCardController ()

@end

@implementation JYBankCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选取银行卡" ;
    [self initializeTableView];
    
    [self setNavRightButtonWithImage:nil title:@"限额说明"] ;
}

-(void)initializeTableView {
    
     self.tableView.rowHeight = 95 ;
    
//    self.tableView.tableFooterView = self.rTableFootView ;
    self.tableView.separatorInset = UIEdgeInsetsZero ;
    
}

-(void)pvt_clickButtonNavRight {

}


#pragma mark- UITableViewDataSource/UITableViewDelegate



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return 3 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//
    
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
