//
//  JYPersonViewController.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/23.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPersonViewController.h"
#import "JYPersonCell.h"
#import "JYPersonHeaderView.h"
#import "JYPersonInfoVC.h"
#import "JYMyFinanceVC.h"
#import "JYLoanRecordController.h"
#import "JYImproveInfoController.h"




@interface JYPersonViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSArray *rDataArray ;
}

@property(nonatomic ,strong) UITableView *rTableView ;

@property(nonatomic ,strong) JYPersonHeaderView *rTableHeaderView ;


@end


@implementation JYPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItems = nil ;
    
    rDataArray = @[
                   @[ @{  keyTitle    : @"我的理财",
                          keyImage    : @"per_finance",
                          }
                      ],
                   @[
//  @{  keyTitle    : @"我的借款",
//                          keyImage    : @"per_loan",
//                          },
                      @{  keyTitle    : @"借款申请记录",
                          keyImage    : @"per_record",
                          }
                      ],
                   @[ @{  keyTitle    : @"我的福利",
                          keyImage    : @"per_welf",
                          },
                      @{  keyTitle    : @"邀请好友",
                          keyImage    : @"per_friend",
                          },
                      @{  keyTitle    : @"人人推（赚佣金）",
                          keyImage    : @"per_recommend",
                          },
                      @{  keyTitle    : @"活动中心",
                          keyImage    : @"per_active",
                          }
                      ],
                   @[ @{  keyTitle    : @"更多",
                          keyImage    : @"per_more",
                          }                                                                             ],
                   
                   ] ;
    
    
    [self buildSubViewUI];
    
}


#pragma mark - builUI
-(void)buildSubViewUI {
    
    [self setNavRightButtonWithImage:[UIImage imageNamed:@"per_mess"] title:@""] ;
    
    
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }];
    
}

#pragma mark- UITableViewDataSource/UITableViewDelegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return rDataArray.count ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [rDataArray[section] count] ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *identifier = @"identifierLogin" ;
    
    JYPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPersonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSDictionary *dic = rDataArray[indexPath.section][indexPath.row] ;
    [cell rSetCellDtaWithDictionary:dic];
    
    return cell ;
    
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    static NSString *headerIdentifier = @"headerIdentifier" ;
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
        headerView.contentView.backgroundColor = [UIColor clearColor];
    }
    
    return headerView ;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
        JYMyFinanceVC *financeVC = [[JYMyFinanceVC alloc]init];
        [self.navigationController pushViewController:financeVC animated:YES];
    }else if (indexPath.section == 1){
        
        JYLoanRecordController *recordVC = [[JYLoanRecordController alloc]init];
        [self.navigationController pushViewController:recordVC animated:YES];
    }
}

#pragma mark- action

-(void)pvt_clickButtonNavRight {
    
    
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
        _rTableView.sectionHeaderHeight = 20 ;
        
    }
    return _rTableView ;
}

-(JYPersonHeaderView*)rTableHeaderView {
    
    if (_rTableHeaderView == nil) {
        _rTableHeaderView = [[JYPersonHeaderView alloc]init];
        _rTableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 180);
        
        @weakify(self)
        [[_rTableHeaderView.rRightArrow rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            JYPersonInfoVC *info = [[JYPersonInfoVC alloc]init];
            [self.navigationController pushViewController:info animated:YES];
            
        }] ;
        
        
        [[_rTableHeaderView.rFinishButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            
            JYImproveInfoController *vc = [[JYImproveInfoController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }] ;
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
