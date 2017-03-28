//
//  JYFinanceViewController.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/23.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYFinanceViewController.h"
#import "JYMessageVController.h"
#import "JYFinanceCell.h"
#import "JYFinanceDetailController.h"

@interface JYFinanceViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong) UITableView *rTableView ;

@property(nonatomic ,strong) UIView *rTableHeaderView ;


@end

@implementation JYFinanceViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItems = nil ;
    self.navigationItem.title = @"嘉银贷" ;
    
    [self setNavRightButtonWithImage:nil title:@"消息"] ;
    
    [self initBaseUI];
    
}

-(void)initBaseUI {

    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }];

}


#pragma mark- UITableViewDataSource/UITableViewDelegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 13 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    
    if (indexPath.row%2 == 0) {
        
        static NSString *identifier = @"identifier" ;
        
        JYFinanceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        if (cell == nil) {
            cell = [[JYFinanceCell alloc]initWithCellType:JYFinanceCellTypeNotBegin reuseIdentifier:identifier];
        }
        
        return cell ;

    }
    
    if (indexPath.row%3 == 0) {
        
        static NSString *identifier = @"identifier33" ;
        
        JYFinanceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        if (cell == nil) {
            cell = [[JYFinanceCell alloc]initWithCellType:JYFinanceCellTypeOver reuseIdentifier:identifier];
        }
        
        return cell ;
        
    }
    
    
    
        static NSString *identifier = @"identifiertttt" ;
        
        JYFinanceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        if (cell == nil) {
            cell = [[JYFinanceCell alloc]initWithCellType:JYFinanceCellTypeBegin reuseIdentifier:identifier];
        }
        
        return cell ;
        
    
     
    return nil ;
    
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
    
    JYFinanceDetailController *detailVC = [[JYFinanceDetailController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark - action

-(void)pvt_clickButtonNavRight {
    JYMessageVController *cv = [[JYMessageVController alloc]init];
    [self.navigationController pushViewController:cv animated:YES];
    
}

#pragma  mark- getter 

-(UITableView*)rTableView {

    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = kBackGroundColor ;
        _rTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        _rTableView.estimatedRowHeight = 144 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
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
