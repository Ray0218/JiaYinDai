//
//  JYLoanApplyController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/21.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoanApplyController.h"
#import "JYLoanApplyCell.h"
#import "JYApplyDetailController.h"

#import "JYTabBarController.h"



@interface JYLoanApplyController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) UITableView *rTableView ;


@property (nonatomic ,strong) NSMutableArray *rDataArray ;



@end

@implementation JYLoanApplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"借款记录" ;
    
    self.rDataArray = [NSMutableArray array] ;
    [self initializeTableView];
    
    [self pvt_loadData];
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
        
        _rTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        _rTableView.tableFooterView = [UIView new];
        @weakify(self)
        [_rTableView addLegendHeaderWithRefreshingBlock:^{
            @strongify(self)
            [self pvt_loadData];
        }] ;
        
        _rTableView.emptyDataView = [DZNEmptyDataView emptyDataView];
        _rTableView.emptyDataView.imageForNoData = [UIImage imageNamed:@"loan_noData"] ;
        _rTableView.emptyDataView.showButtonForNoData = YES;
        _rTableView.emptyDataView.requestSuccess = YES;
        
        
         _rTableView.emptyDataView.buttonTappedEvent = ^(DZNEmptyDataViewType type){
             switch (type) {
                case DZNEmptyDataViewTypeNoData:
                {
                    
                    JYTabBarController *tab= (JYTabBarController*)[[[UIApplication sharedApplication]keyWindow ]rootViewController] ;
                    
                     
                    UINavigationController *navc = tab.selectedViewController   ;
                    
                    
                     [tab setSelectedIndex:0] ;
                    
                    [navc popToRootViewControllerAnimated:NO] ;

                }
                    break;
                case DZNEmptyDataViewTypeFailure:
                {
                }
                    break;
                case DZNEmptyDataViewTypeNoNetwork:
                {
                }
                    break;
                default:
                    break;
            }
        };
    }
    return _rTableView ;
}

-(void)pvt_endRefresh{
    
    [self.rTableView.header endRefreshing];
}


-(void)pvt_loadData {
    
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kApplyRecordURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArr = responseObject[@"data"][@"records"] ;
        
        [self.rDataArray removeAllObjects];
        
        if (dataArr) {
            [self.rDataArray  addObjectsFromArray:[JYApplyRecordModel arrayOfModelsFromDictionaries:dataArr error:nil] ];
        }
        
        
        [self.rTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
    }] ;
}



#pragma mark- UITableViewDataSource/UITableViewDelegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  self.rDataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *identifier = @"identifierLogin" ;
    
    JYLoanApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYLoanApplyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.rDataModel = self.rDataArray[indexPath.row] ;
    
    
    return cell ;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    JYApplyRecordModel *model = self.rDataArray[indexPath.row] ;
    
    JYApplyDetailController *vc = [[JYApplyDetailController alloc]init];
    
    vc.rApplyNo = model.applyNo ;
    
    [self.navigationController pushViewController:vc animated:YES];
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
