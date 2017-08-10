//
//  JYApplyDetailController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/21.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYApplyDetailController.h"
#import "JYApplyRecordModel.h"
#import "JYImproveInfoController.h"


@interface JYApplyDetailController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *rTitlesArr ;
}
@property (nonatomic ,strong) UITableView *rTableView ;



@property (nonatomic ,strong) JYRecordDetailModel *rDataModel ;


@end


@implementation JYApplyDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"进度详情" ;
    rTitlesArr = @[@[@"流水号",@"类型",@"申请金额",@"申请银行",@"储蓄卡尾号"],@[@"申请时间",@"到账时间",@"还款日",@"审核意见",@""]] ;
    

    self.rDataModel = [[JYRecordDetailModel alloc]init];
    
    [self initializeTableView];
    
    
    [self pvt_loadData];
}


-(void)pvt_loadData {
    
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
    
    [dic setValue:self.rApplyNo forKey:@"applyNo"] ;
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kRecordDetailURL parameters: dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *data = responseObject[@"data"] ;
        
        [self.rDataModel mergeFromDictionary:data useKeyMapping:NO error:nil] ;
        
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
        
        _rTableView.estimatedRowHeight = 45 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
        
        _rTableView.sectionHeaderHeight = 15 ;
        
        _rTableView.separatorInset = UIEdgeInsetsZero ;
        _rTableView.tableFooterView = [UIView new];
    }
    return _rTableView ;
}



#pragma mark- UITableViewDataSource/UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2 ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [rTitlesArr[section] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *identifier = @"identifierLoan" ;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        cell.textLabel.font = [UIFont systemFontOfSize:16] ;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14] ;
        
        
        UILabel* optionLabel = [self jyCreateLabelWithTitle:@"" font:14 color:kTextBlackColor align:NSTextAlignmentLeft];
        optionLabel.numberOfLines = 0 ;
        optionLabel.tag = 999 ;
        optionLabel.backgroundColor = [UIColor clearColor] ;
        [cell.contentView addSubview:optionLabel] ;
        
        
        [optionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(10, 15, 10, 15)) ;
            
            make.height.mas_greaterThanOrEqualTo(25) ;
        }] ;
        
        
    }
    
    
    UILabel *optionLab = [cell.contentView viewWithTag:999] ;
    
    
    if ( [self.rDataModel.creditOrder.refuseType isEqualToString:@"1"]  && indexPath.section == 1 && indexPath.row == 3) {

    }
    
    if (indexPath.section == 1 && indexPath.row == 4) {
        optionLab.text = [self getDetailString:indexPath] ;
        
        [UILabel changeLineSpaceForLabel:optionLab WithSpace:5] ;
        
        cell.textLabel.text = @"" ;
        
        cell.detailTextLabel.text = @"";
        
    }else{
        
                 
        optionLab.text = @"" ;
        
        cell.textLabel.text = rTitlesArr[indexPath.section][indexPath.row] ;
        
        cell.detailTextLabel.text = [self getDetailString:indexPath] ;
        
        
    }
    
    
    if ( [self.rDataModel.creditOrder.refuseType isEqualToString:@"1"]  && indexPath.section == 1 && indexPath.row == 3) {
        
        cell.detailTextLabel.textColor = kBlueColor ;
    }else{
        cell.detailTextLabel.textColor = kTextBlackColor ;
    }
    
    
    
    return cell ;
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
    if ( [self.rDataModel.creditOrder.refuseType isEqualToString:@"1"]  && indexPath.section == 1 && indexPath.row == 3) {
        
        JYImproveInfoController *impVC = [[JYImproveInfoController alloc]init];
        [self.navigationController pushViewController:impVC animated:YES];
        
    }

}


-(NSString*)getDetailString:(NSIndexPath*)indexPath {
    
    NSString * detailString = nil ;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                detailString = self.rDataModel.creditOrder.applyNo ;
                break;
            case 1:
                detailString = self.rDataModel.productName ;
                break;
            case 2:{
                
                
                detailString = [NSString stringWithFormat:@"%.2f元",[self.rDataModel.creditOrder.principal doubleValue ]] ;
            }
                break;
            case 3:
                detailString = self.rDataModel.bankName ;
                break;
            case 4:
                detailString = self.rDataModel.cardNoWh ;
                break;
                
            default:
                break;
        }
        
    }else{
        
        
        switch (indexPath.row) {
            case 0:
                detailString = TTTimeString(self.rDataModel.creditOrder.applyTime) ;
                break;
            case 1:
                detailString = TTTimeString( self.rDataModel.creditOrder.lendTime) ;
                break;
            case 2:{
                detailString = TTTimeString(self.rDataModel.creditOrder.lendTime) ;
                
                if (detailString.length) {
                    
                    
                    NSString *dayStr = [[detailString componentsSeparatedByString:@"-"] lastObject] ;
                    
                    
                    if ([dayStr integerValue] > 28) {
                        dayStr = @"28" ;
                    }else if([dayStr integerValue] == 1){
                    
                        dayStr = @"28" ;
                    }else{
                        dayStr = [NSString stringWithFormat:@"%zd",[dayStr integerValue] - 1] ;
                    }
                    detailString = [NSString stringWithFormat:@"每月%@号",dayStr] ;
                }
            }
                break;
            case 3:{
                
                if ( [self.rDataModel.creditOrder.refuseType isEqualToString:@"1"] ) {
                    detailString = @"去补录" ;

                }else{
                
                 detailString = @"" ;
                }
             }
                break ;
            case 4:
                detailString = self.rDataModel.creditOrder.auditOpinion ;
                break;
                
            default:
                break;
        }
        
    }
    
    
    return detailString ;
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
