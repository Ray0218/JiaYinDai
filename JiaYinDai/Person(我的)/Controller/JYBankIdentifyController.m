//
//  JYBankIdentifyController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/17.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYBankIdentifyController.h"
#import "JYLogInCell.h"
#import "JYPasswordCell.h"

@interface JYBankIdentifyController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *rTableView ;
@property (nonatomic ,strong) JYLogFootView *rTableFootView ;
@property (nonatomic ,strong) UIView *rTableHeaderView ;


@end

@implementation JYBankIdentifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"银行卡认证" ;
    
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"identifierNormal" ;
    
    JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeNormal reuseIdentifier:identifier ];
    }
    
    if (indexPath.row == 0) {
        [cell setDataModel:[[JYPasswordSetModel alloc] initWithTitle:@"姓名" fieldText:@"" placeHolder:@"输入本人姓名" hasCode:NO]] ;
    }else{
        [cell setDataModel:[[JYPasswordSetModel alloc] initWithTitle:@"身份证" fieldText:@"" placeHolder:@"输入本人身份证号" hasCode:NO]] ;

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
        _rTableView.tableFooterView = self.rTableFootView ;
        
    }
    return _rTableView ;
}


-(JYLogFootView*)rTableFootView {
    
    if (_rTableFootView == nil) {
        _rTableFootView = [[JYLogFootView alloc]initWithType:JYLogFootViewTypeGetBackPass] ;
        
        [_rTableFootView.rCommitBtn setTitle:@"下一步" forState:UIControlStateNormal] ;
        
          _rTableFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80) ;
      }
    
    return _rTableFootView ;
}


-(UIView*)rTableHeaderView {
    if (_rTableHeaderView == nil) {
        _rTableHeaderView = [[UIView alloc]init];
        _rTableHeaderView.backgroundColor = kBackGroundColor ;
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
