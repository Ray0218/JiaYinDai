//
//  JYRedCardController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/14.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYRedCardController.h"
#import "JYTabBar.h"
#import "JYRedGiftCell.h"


@interface JYRedCardController ()<UITableViewDelegate,UITableViewDataSource>{
    
    
    BOOL rIsFinish ;
}

@property(nonatomic ,strong) UITableView *rTableView ;


@end

@implementation JYRedCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"卡包" ;
    
    [self buildSubViewUI];
    
    rIsFinish = NO ;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
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
    return 10 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *identifier = @"identifierNormal" ;
    
    JYRedGiftCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYRedGiftCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell ;
    
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    static NSString *headerIdentifier = @"headerIdentifier" ;
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
        headerView.contentView.backgroundColor = [UIColor whiteColor];
        
        
        JYTabBarItem *unfinishedItem = [[JYTabBarItem alloc] initWithTitle:@"红包"];
        JYTabBarItem *completedItem = [[JYTabBarItem alloc] initWithTitle:@"抵用券"];
        
        JYTabBar *tabbar = [[JYTabBar alloc]init];
        tabbar.items = @[unfinishedItem,completedItem] ;
        
        [headerView.contentView addSubview:tabbar];
        
        [tabbar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero) ;
        }] ;
        
        
        @weakify(self)
        [tabbar.rac_signalForSelectedItem subscribeNext:^(JYTabBarItem *item) {
            @strongify(self)
            
            if (item.tag - 1000 == 1 && !rIsFinish ) {
                rIsFinish = YES ;
                [self.rTableView reloadData];
            }else if(rIsFinish){
                rIsFinish = NO ;
                [self.rTableView reloadData];
            }
        }] ;
        
    }
    
    return headerView ;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    JYRedGiftCell *cell = [tableView cellForRowAtIndexPath:indexPath] ;
    cell.selected = YES ;
}

#pragma mark- action


#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = kBackGroundColor ;
        _rTableView.estimatedRowHeight = 145 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.sectionHeaderHeight = 45 ;
        _rTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        
        
    }
    return _rTableView ;
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
