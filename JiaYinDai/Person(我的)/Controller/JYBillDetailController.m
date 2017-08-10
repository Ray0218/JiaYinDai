//
//  JYBillDetailController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/24.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYBillDetailController.h"
#import "JYBillListModel.h"


@interface JYBillDetailController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *rTitlesArr ;
    
    JYBillDetailType rType ;
}
@property (nonatomic ,strong) UITableView *rTableView ;

@property (nonatomic ,strong) JYBillDetailModel*rDataModel;

@end

@implementation JYBillDetailController

- (instancetype)initWithType:(JYBillDetailType) type
{
    self = [super init];
    if (self) {
        rType = type ;
        switch (type) {
            case JYBillDetailTypeDraw:{
                rTitlesArr = @[ @"交易信息",@"交易流水号",@"金额",@"创建时间",@"处理时间",@"确认状态",@"付款明细"] ;
                
            }
                break;
            case JYBillDetailTypeCharge:{
                rTitlesArr = @[ @"交易信息",@"交易流水号",@"金额",@"创建时间",@"处理时间",@"确认状态",@"付款明细"] ;
                
            }
                break;
            case JYBillDetailTypeFee:{
                rTitlesArr = @[ @"交易信息",@"订单号",@"金额",@"处理时间",@"付款明细",@"确认状态"] ;
                
            }
                break;
            case JYBillDetailTypeLoan:{
                rTitlesArr = @[ @"交易信息",@"交易流水号",@"金额",@"申请时间",@"审批时间",@"确认状态",@"付款明细"] ;
                
            }
                break;
            case JYBillDetailTypePayBack:{
                rTitlesArr = @[ @"交易信息",@"交易流水号",@"金额",@"申请周期",@"还款周期",@"优惠券",@"还款账户",@"处理时间",@"确认状态"] ;
                
            }
                break;
                
            default:
                break;
        }
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账单详情" ;
    self.rDataModel = [[JYBillDetailModel alloc]init];
    
    [self initializeTableView];
    
    [self pvt_loadData];
    
}


-(void)pvt_loadData {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
    [dic setValue:self.rBillId forKey:@"billId"] ;
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kBillDetailURL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSDictionary *dataDic = responseObject[@"data"] ;
        
        [self.rDataModel mergeFromDictionary:dataDic useKeyMapping:NO  error:nil];
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
        _rTableView.estimatedRowHeight = 45 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.separatorInset = UIEdgeInsetsZero ;
        _rTableView.sectionHeaderHeight = 15 ;
        
        _rTableView.tableFooterView = [UIView new];
    }
    return _rTableView ;
}


-(void)cellInfoWithCell:(UITableViewCell*)cell IndexPath:(NSIndexPath*) indexPath {
    
    
    
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = self.rDataModel.tradeInfo ;
    }else if (indexPath.row == 1){
        cell.detailTextLabel.text = self.rDataModel.applyNo ;
        
    }else if(indexPath.row == 2){
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f元",[self.rDataModel.amount doubleValue]] ;
        
    } else if ([cell.textLabel.text isEqualToString:@"确认状态"]){
        
        cell.detailTextLabel.text = self.rDataModel.status ;
    }else if ([cell.textLabel.text isEqualToString:@"付款明细"]){
        
        cell.detailTextLabel.text = self.rDataModel.payer;
        
    }else if ([cell.textLabel.text isEqualToString:@"还款账户"]){
        
            cell.detailTextLabel.text = self.rDataModel.payer;
        
    }else if ([cell.textLabel.text isEqualToString:@"处理时间"]){
        
        cell.detailTextLabel.text = TTTimeHMString(self.rDataModel.time);
    } else if ([cell.textLabel.text isEqualToString:@"审批时间"]){
        
        cell.detailTextLabel.text = TTTimeString(self.rDataModel.payForTime);
        
    }else if ([cell.textLabel.text isEqualToString:@"申请时间"]){
        
        cell.detailTextLabel.text = TTTimeString(self.rDataModel.applyTime);
    }else if ([cell.textLabel.text isEqualToString:@"创建时间"]){
        
        cell.detailTextLabel.text =  self.rDataModel.createTime;
        
    }else if ([cell.textLabel.text isEqualToString:@"申请周期"]){
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%zd月",[self.rDataModel.lendPeriod integerValue]];
    }else if ([cell.textLabel.text isEqualToString:@"还款周期"]){
         cell.detailTextLabel.text = [NSString stringWithFormat:@"第%zd期",[self.rDataModel.repayPeriod integerValue]];
    }else if([cell.textLabel.text isEqualToString:@"优惠券"]){
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.rDataModel.customerBonus.length?self.rDataModel.customerBonus:@"无" ];

    }
    
    
}

#pragma mark- UITableViewDataSource/UITableViewDelegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [rTitlesArr count];
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
    
    
    cell.textLabel.text = rTitlesArr[indexPath.row] ;
    cell.detailTextLabel.text = @"XXX" ;
    
    [self cellInfoWithCell:cell IndexPath:indexPath];
    return cell ;
    
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    static NSString *headerIdentifier = @"headerIdentifier" ;
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
        headerView.contentView.backgroundColor = [UIColor clearColor];
        headerView.backgroundView = ({
            UIView *view = [[UIView alloc]init] ;
            view.backgroundColor = [UIColor clearColor] ;
            view ;
        });
    }
    
    return headerView ;
    
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
