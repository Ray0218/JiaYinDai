//
//  JYMyFinanceVC.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/6.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYMyFinanceVC.h"
#import "JYMyFinanceCell.h"
#import "JYTabBar.h"
#import "JYFinanceRecordVC.h"




@interface JYMyFinanceVC ()<UITableViewDelegate,UITableViewDataSource>{
    
    
    BOOL rIsFinish ;
 }

@property(nonatomic ,strong) UITableView *rTableView ;

@property(nonatomic ,strong) JYMYFinanceHeader *rTableHeaderView ;



@end

@implementation JYMyFinanceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的理财" ;
    
    [self buildSubViewUI];
    
    rIsFinish = NO ;
    
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
    
    
    if (rIsFinish) {
        
        static NSString *identifier = @"identifierFinish" ;
        
        JYMyFinanceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYMyFinanceCell alloc]initWithCellType:JYMyFinanceTypeFinish reuseIdentifier:identifier];
        }
        
         return cell ;
    }
    static NSString *identifier = @"identifierNormal" ;
    
    JYMyFinanceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYMyFinanceCell alloc]initWithCellType:JYMyFinanceTypeNormal reuseIdentifier:identifier];
    }
    
//    cell.textLabel.text= @"dddddd" ;
    return cell ;
    
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    static NSString *headerIdentifier = @"headerIdentifier" ;
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
        headerView.contentView.backgroundColor = [UIColor whiteColor];
        
        
        JYTabBarItem *unfinishedItem = [[JYTabBarItem alloc] initWithTitle:@"投资中"];
        JYTabBarItem *completedItem = [[JYTabBarItem alloc] initWithTitle:@"已回款"];
        
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JYFinanceRecordVC *vc = [[JYFinanceRecordVC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark- action


#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = kBackGroundColor ;
        _rTableView.estimatedRowHeight = 145 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
        _rTableView.tableHeaderView = self.rTableHeaderView ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.sectionHeaderHeight = 45 ;
        _rTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
 
        
    }
    return _rTableView ;
}

-(JYMYFinanceHeader*)rTableHeaderView {
    
    if (_rTableHeaderView == nil) {
        _rTableHeaderView = [[JYMYFinanceHeader alloc]init];
        _rTableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 110);
        
        
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
