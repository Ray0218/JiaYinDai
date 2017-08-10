//
//  JYFinanceRecordVC.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/7.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYFinanceRecordVC.h"
#import "JYFinanceRecordCell.h"


@interface JYFinanceRecordVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong) UITableView *rTableView ;


@end

@implementation JYFinanceRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"收益记录" ;
    [self buildSubViewUI];
    
 }


#pragma mark - builUI
-(void)buildSubViewUI {
    
    
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }];
    
}

#pragma mark- UITableViewDataSource/UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 19 ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"identifierNormal" ;
    
    JYFinanceRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYFinanceRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell ;
    
    
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    
    static NSString *headerIdentifier = @"headerIdentifier" ;
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
        headerView.backgroundView = ({
            
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = [UIColor clearColor] ;
            view ;
        }) ;
        headerView.contentView.backgroundColor = [UIColor clearColor];
        
        
        
    }
    
    return headerView ;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

#pragma mark- action


#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = kBackGroundColor ;
        _rTableView.estimatedRowHeight = 60 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.sectionFooterHeight = 15 ;
        _rTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        
        
    }
    return _rTableView ;
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
