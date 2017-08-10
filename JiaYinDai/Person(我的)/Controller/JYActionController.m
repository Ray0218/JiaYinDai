//
//  JYActionController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/22.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYActionController.h"
#import "JYActionCell.h"
#import "JYWebViewController.h"


@interface JYActionController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong) UITableView *rTableView ;


@property (nonatomic ,strong) NSMutableArray *rDataArray ;


@end

@implementation JYActionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"活动中心" ;
    self.rDataArray = [NSMutableArray array] ;
    [self buildSubViewUI];
    
    [self pvt_loadData];
    
}

-(void)pvt_loadData {
    
    @weakify(self)
    [[AFHTTPSessionManager jy_sharedManager]POST:kActiveURL parameters:@{@"application":@"3"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @strongify(self)
        [self.rDataArray removeAllObjects];
        
        NSArray *dicArr= responseObject[@"data"] ;
        
        NSArray *modelArray = [JYActiveModel arrayOfModelsFromDictionaries:dicArr error:nil ] ;
        if (modelArray.count) {
            [ self.rDataArray addObjectsFromArray: modelArray] ;
         }
        
        
        [self.rTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
}

#pragma mark - builUI
-(void)buildSubViewUI {
    
    
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }];
    
}

#pragma mark- UITableViewDataSource/UITableViewDelegate



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.rDataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *identifier = @"identifierActive" ;
    
    JYActionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYActionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        
    }
    
    cell.rDataModel = self.rDataArray[indexPath.row] ;
    
    
    return cell ;
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        
    JYActiveModel *model = self.rDataArray[indexPath.row] ;
    
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
    
    if (model.appLink.length) {
         
         JYWebViewController *webVC = [[JYWebViewController alloc]initWithUrl:[NSURL URLWithString:[model.appLink stringByReplacingOccurrencesOfString:@"{cellphone}" withString:user.cellphone]]] ;
        
        [self.navigationController pushViewController:webVC animated:YES];
    }
}


#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = kBackGroundColor ;
        _rTableView.estimatedRowHeight = 220 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        
        _rTableView.sectionHeaderHeight = 0 ;
        _rTableView.tableFooterView = [UIView new] ;
        
        _rTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        
        @weakify(self)
        [_rTableView addLegendHeaderWithRefreshingBlock:^{
            @strongify(self)
            [self pvt_loadData];
        }] ;
        
        
        _rTableView.emptyDataView = [DZNEmptyDataView emptyDataView];
        _rTableView.emptyDataView.imageForNoData = [UIImage imageNamed:@"comm_noData"] ;
        _rTableView.emptyDataView.showButtonForNoData = NO;
        _rTableView.emptyDataView.requestSuccess = YES;
        
        
    }
    return _rTableView ;
}


-(void)pvt_endRefresh {

    [self.rTableView.header endRefreshing];
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
