//
//  JYPayRecordDetailController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/14.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPayRecordDetailController.h"

@interface JYPayRecordDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) UITableView *rTableView ;

 @property (nonatomic, strong) NSMutableArray *detailTextArray;
@property (nonatomic, strong) NSDictionary *data;
@end


static NSString *kTitles[] = {@"交易信息",@"交易流水号",@"金额",@"申请周期",@"还款周期",@"还款账户",@"处理时间",@"确认状态"} ;

@implementation JYPayRecordDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.detailTextArray = [NSMutableArray array];
    self.navigationItem.title = @"还款详情" ;
    [self initializeTableView] ;
    [self pvt_loadData];
}
- (void)pvt_loadData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
    [dic setValue:self.billId forKey:@"billId"] ;
    
    [[AFHTTPSessionManager jy_sharedManager ] POST:kgetRepaybillDetailURL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.data = responseObject[@"data"] ;
        
        [self.rTableView reloadData];
        
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }] ;
}

-(void)initializeTableView {
    
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }] ;
}

#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = kBackGroundColor ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        
        _rTableView.rowHeight = 45 ;
        
        _rTableView.sectionHeaderHeight = 15 ;
        
        _rTableView.separatorInset = UIEdgeInsetsZero ;
        _rTableView.tableFooterView = [UIView new];
    }
    return _rTableView ;
}



#pragma mark- UITableViewDataSource/UITableViewDelegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 8;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *identifier = @"identifierLoan" ;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        
        cell.textLabel.textColor = kBlackColor ;
        cell.textLabel.font = [UIFont systemFontOfSize:14] ;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14] ;
        cell.detailTextLabel.textColor = kTextBlackColor ;
        
    }
    cell.textLabel.text = kTitles[indexPath.row] ;
    
    
    if (!self.data) {
        return cell ;
    }
    
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.data[@"tradeInfo"]] ;
        
    }else if (indexPath.row == 1) {
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.data[@"applyNo"]] ;
        
    } else if (indexPath.row == 2) {
        
        NSString *moneyStr = [NSString stringWithFormat:@"%@",self.data[@"amount"]] ;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f元", [moneyStr doubleValue]] ;
        ;
        
    }else if (indexPath.row == 3) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@期",self.data[@"lendPeriod"]] ;

    }else if (indexPath.row == 4) {
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"第%@期",self.data[@"repayPeriod"]] ;

        
    }else if (indexPath.row == 5) {
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.data[@"payer"]] ;
        
    }else if (indexPath.row == 6) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",TTTimeHMString([NSString stringWithFormat:@"%@",self.data[@"time"]])] ;
        
    }else if (indexPath.row == 7) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.data[@"status"]] ;
        
    }
    
     
    return cell ;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section  {
    
    
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
    
    return headerView;
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
