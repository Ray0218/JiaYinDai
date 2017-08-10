//
//  JYBankCardController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/10.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYBankCardController.h"
#import "JYBankCardCell.h"
#import "JYAddBankController.h"
#import "JYBankIdentifyController.h"
#import "JYSupportBankController.h"


@interface JYBankCardController ()<UITableViewDataSource,UITableViewDelegate>{
    JYBankCardVCType rType ;
}
@property (nonatomic ,strong) UITableView *rTableView ;


@property (nonatomic ,strong) NSMutableArray *rDataArray ;

@end

@implementation JYBankCardController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSAssert(0, @"使用initWithType初始化") ;
    }
    return self;
}


- (instancetype)initWithType:(JYBankCardVCType)type
{
    self = [super init];
    if (self) {
        
        rType = type ;
        if (type == JYBankCardVCTypeManager) {
            self.title = @"银行卡管理" ;
        }else  {
            
            self.title = @"选择银行卡" ;
        }
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.rDataArray = [NSMutableArray array] ;
    
    
    if (rType == JYBankCardVCTypPay) {
        
        [self pvt_addAccountModel];
        
    }
    
    [self setNavRightButtonWithImage:nil title:@"限额说明"] ;
    
    
    [self initializeTableView];
    
    
    [self pvt_loadData];
}


-(void)pvt_addAccountModel {
    
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
    
    JYBankModel *model = [[JYBankModel alloc]init] ;
    
    model.bankName = @"账户余额" ;
    model.cardNo = [NSString stringWithFormat:@"%.2f",[user.fundInfo.usableAmount doubleValue]] ;
    model.rBankType = @"可用余额（元）" ;
    model.bankNo = @"bank_default" ;
    [self.rDataArray addObject:model] ;
}


-(void) pvt_loadData {
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kGetCustomerBankURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSArray *arr = responseObject[@"data"] ;
        
        NSArray *modelArray = [JYBankModel arrayOfModelsFromDictionaries:arr error:nil] ;
        
        [self.rDataArray removeAllObjects];
        
        if (rType == JYBankCardVCTypPay) {
            
            [self pvt_addAccountModel];
            
        }
        
        
        if (modelArray) {
            [self.rDataArray addObjectsFromArray:modelArray] ;
            [self.rTableView reloadData];
        }
        
        
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
        _rTableView.rowHeight = 95 ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        
        _rTableView.tableFooterView = [UIView new];
        
        
        @weakify(self)
        [_rTableView addLegendHeaderWithRefreshingBlock:^{
            @strongify(self)
            [self pvt_loadData];
        }] ;
    }
    return _rTableView ;
}


-(void)pvt_clickButtonNavRight {
    
    JYSupportBankController *supportVC =[[ JYSupportBankController alloc]init];
    
    [self.navigationController pushViewController:supportVC animated:YES];
    
}


#pragma mark- UITableViewDataSource/UITableViewDelegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    
    return self.rDataArray.count+1 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == self.rDataArray.count) {
        static NSString *identifier = @"identifieraddBank" ;
        
        JYAddBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYAddBankCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        return cell ;
    }
    
    
    
    static NSString *identifier = @"identifierbank" ;
    
    JYBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYBankCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    
    cell.rBankModel = self.rDataArray[indexPath.row] ;
    return cell ;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [tableView numberOfRowsInSection:0] - 1) {
        
        
        JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
        
        NSArray *itemsArr = [user.auditItem componentsSeparatedByString:@","] ;
        
        if ([itemsArr containsObject:@"1"]) { // //已实名
            JYAddBankController *vc =[[JYAddBankController alloc]init];
            [self.navigationController pushViewController:vc animated:YES] ;
        }else{
            
            JYBankIdentifyController *identifyVC  ;
            
            if ([user.auditItem containsString:@"1B"]) {
                identifyVC = [[JYBankIdentifyController alloc]initWithHeaderType:JYIdentifyTypePassword] ;
                
            }else if ([user.auditItem containsString:@"1A"]){
                
                identifyVC = [[JYBankIdentifyController alloc]initWithHeaderType:JYIdentifyTypeBank] ;
                
            }else{
                identifyVC = [[JYBankIdentifyController alloc]initWithHeaderType:JYIdentifyTypeName] ;
            }
            
            [self.navigationController pushViewController:identifyVC animated:YES];
            
        }
        
        
    }else{
        
        JYBankCardCell *cell = [tableView cellForRowAtIndexPath:indexPath] ;
        cell.selected = YES ;
        
        
        if (rType == JYBankCardVCTypeManager) {
            return ;
        }
        
        
        JYBankModel *model = self.rDataArray[indexPath.row] ;
        
        if (self.rBankBlock ) {
            self.rBankBlock(model) ;
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)pvt_endRefresh {
    
    [self.rTableView.header endRefreshing];
    [self.rTableView.footer endRefreshing];
    
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
