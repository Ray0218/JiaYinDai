//
//  JYDebtController.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/28.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYDebtController.h"
#import "JYBetTableViewCell.h"

@interface JYDebtController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *rTableView ;

@end



@implementation JYDebtController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"债权列表" ;
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 10, 0)) ;
    }];
}


#pragma mark-UITableViewDataSource /UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 ;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *indentifier = @"indentifier" ;
    
    JYBetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier] ;
    if (cell == nil) {
        cell = [[JYBetTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        
    }
      
    return cell ;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section  {
    
    
    static NSString *headerIdentifier = @"headerIdentifier" ;
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
        headerView.contentView.backgroundColor = [UIColor clearColor] ;
        headerView.backgroundView = ({
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = [UIColor clearColor] ;
            view ;
        
        }) ;
     }
    
    return headerView ;
}
#pragma mark -getter

-(UITableView*)rTableView{
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = [UIColor clearColor] ;
        _rTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rTableView.tableFooterView = [[UIView alloc]init];
        _rTableView.estimatedRowHeight = 220 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension ;
        _rTableView.sectionHeaderHeight = 15 ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
    }
    return _rTableView ;
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
