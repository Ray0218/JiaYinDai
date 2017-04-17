//
//  JYLoanRecordController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/12.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoanRecordController.h"
#import "JYLoanRecordCell.h"
#import "JYMYFinanceHeader.h"
#import "JYLoanDetailController.h"
#import "JYPayRecordController.h"


 
@interface JYLoanRecordController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSArray *rDataArray ;
}

@property(nonatomic ,strong) UITableView *rTableView ;

@property(nonatomic ,strong) JYMYFinanceHeader *rTableHeaderView ;


@end

@implementation JYLoanRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItems = nil ;

    self.title = @"我的贷款" ;
    [self buildSubViewUI];
    
}


#pragma mark - builUI
-(void)buildSubViewUI {
    
    [self setNavRightButtonWithImage:nil title:@"还款记录"] ;
    
    
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }];
    
}

-(void)pvt_clickButtonNavRight {

    JYPayRecordController *recordVC =[[JYPayRecordController alloc]init];
    [self.navigationController pushViewController:recordVC animated:YES] ;
}

#pragma mark- UITableViewDataSource/UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  5;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *identifier = @"identifierLogin" ;
    
    JYLoanRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYLoanRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell ;
    
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    static NSString *headerIdentifier = @"headerIdentifier" ;
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
        headerView.contentView.backgroundColor = [UIColor clearColor];
        headerView.textLabel.text = @"近期还款计划";
        
        headerView.backgroundView = ({
        
            UIView *view= [[UIView alloc]init];
            view.backgroundColor = kBackGroundColor;
            view ;
        }) ;
    }
    
    
    
    return headerView ;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BOOL over = indexPath.row %2 ;
    
    JYLoanDetailController *recordVC = [[JYLoanDetailController alloc]initWithOver:over ];
    [self.navigationController pushViewController:recordVC animated:YES];
}


#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = kBackGroundColor ;
        _rTableView.estimatedRowHeight = 45 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
        _rTableView.tableHeaderView = self.rTableHeaderView ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.sectionHeaderHeight = 45 ;
        _rTableView.tableFooterView = [UIView new] ;
        _rTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        
    }
    return _rTableView ;
}

-(JYMYFinanceHeader*)rTableHeaderView {
    
    if (_rTableHeaderView == nil) {
        _rTableHeaderView = [[JYMYFinanceHeader alloc]init];
        _rTableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 180);
        _rTableHeaderView.backgroundColor = kBlueColor ;
        
        //        @weakify(self)
        //        [[_rTableHeaderView.rRightArrow rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        //            @strongify(self)
        //            JYPersonInfoVC *info = [[JYPersonInfoVC alloc]init];
        //            [self.navigationController pushViewController:info animated:YES];
        //
        //        }] ;
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
