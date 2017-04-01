//
//  JYLoanViewController.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/23.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoanViewController.h"
#import "JYLoanTableViewCell.h"


@interface JYLoanViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong) UITableView *rTableView ;

@property(nonatomic ,strong) UIView *rTableHeaderView ;

@end

@implementation JYLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItems = nil ;

    [self buildSubViewUI];
 
}


#pragma mark - builUI
-(void)buildSubViewUI {
    
    self.tableView.tableHeaderView = self.rTableHeaderView ;
    self.tableView.estimatedRowHeight = 144 ;
    self.tableView.rowHeight = UITableViewAutomaticDimension ;
    
//        [self.view addSubview:self.rTableView];
//        [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.insets(UIEdgeInsetsZero) ;
//        }];
//
    }


#pragma mark- UITableViewDataSource/UITableViewDelegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
        static NSString *identifier = @"identifier" ;
        
        JYLoanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        if (cell == nil) {
            cell = [[JYLoanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
    
    
    
        return cell ;
        
 
    

}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    static NSString *headerIdentifier = @"headerIdentifier" ;
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
        headerView.contentView.backgroundColor = UIColorFromRGB(0xd8981d) ;
    }
    
    return headerView ;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (indexPath.row %2 == 0) {
//        self.rTableView.sectionHeaderHeight = 0 ;
//
//    }else{
//        self.rTableView.sectionHeaderHeight = 20 ;
//
//    }
//    [self.rTableView reloadData];
 }

#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = kBackGroundColor ;
//        _rTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        _rTableView.estimatedRowHeight = 144 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
        _rTableView.rowHeight = 140 ;
        _rTableView.tableFooterView = [[UIView alloc]init];
        _rTableView.tableHeaderView = self.rTableHeaderView ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.sectionHeaderHeight = 20 ;
        
    }
    return _rTableView ;
}

-(UIView*)rTableHeaderView {
    
    if (_rTableHeaderView == nil) {
        _rTableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
        _rTableHeaderView.backgroundColor = kBlueColor ;
    }
    
    return _rTableHeaderView ;
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
