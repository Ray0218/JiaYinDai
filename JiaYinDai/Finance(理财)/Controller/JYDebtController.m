//
//  JYDebtController.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/28.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYDebtController.h"

@interface JYDebtController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *rTableView ;

@end

@implementation JYDebtController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"投资记录" ;
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }];
}


#pragma mark-UITableViewDataSource /UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 ;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 20 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *indentifier = @"indentifier" ;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier] ;
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        
    }
    
    cell.textLabel.text = @"dddd" ;
    
    return cell ;
}

//-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    
//    
//    static NSString *headerIdentifier = @"headerIdentifier" ;
//    
//    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
//    if (headerView == nil) {
//        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
//        headerView.contentView.backgroundColor = [UIColor clearColor] ;
//        headerView.layer.borderColor = kLineColor.CGColor ;
//        headerView.layer.borderWidth = 0.5 ;
//    }
//    
//    return headerView ;
//}
#pragma mark -getter

-(UITableView*)rTableView{
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _rTableView.backgroundColor = [UIColor clearColor] ;
        _rTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rTableView.tableFooterView = [[UIView alloc]init];
        _rTableView.rowHeight = 60 ;
//        _rTableView.sectionFooterHeight = 5 ;
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
