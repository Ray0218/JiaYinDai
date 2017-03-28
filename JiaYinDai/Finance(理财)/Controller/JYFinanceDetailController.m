//
//  JYFinanceDetailController.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/27.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYFinanceDetailController.h"
#import "JYFinanceDetailView.h"


@interface JYFinanceDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *rTableView ;
@property(nonatomic ,strong) JYFinanceDetailView *rTableHeaderView ;
@property (nonatomic ,strong)JYDetailBottomView *rBottomView ;


@end

static NSString *rCellName[] = {@"投资记录",@"项目描述",@"债券列表"} ;

@implementation JYFinanceDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"嘉银贷588期" ;
    [self initBaseUI];
}

-(void)initBaseUI {
    
    [self.view addSubview:self.rTableView];
    [self.view addSubview:self.rBottomView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 55, 0)) ;
    }];
    
    [self.rBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(-1) ;
        make.height.mas_equalTo(55) ;
        make.bottom.and.right.equalTo(self.view).offset(1) ;
    }];
    
    
}


#pragma mark- UITableViewDataSource/UITableViewDelegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
        static NSString *identifier = @"identifier" ;
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
            cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        }
    
    cell.textLabel.text = rCellName[indexPath.row] ;
    
    if (indexPath.row == 0) {
        cell.detailTextLabel.text =  @"58人" ;

    }
    
        return cell ;
        
   
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JYFinanceDetailController *detailVC = [[JYFinanceDetailController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    
    static NSString *headerIdentifier = @"headerIdentifier" ;
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
        headerView.backgroundColor = headerView.contentView.backgroundColor = UIColorFromRGB(0xd8981d) ;
    }
    
    return headerView ;
}



#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = [UIColor clearColor] ;
        _rTableView.separatorColor = kLineColor ;
         _rTableView.rowHeight = 45;
        _rTableView.tableFooterView = [[UIView alloc]init];
        _rTableView.tableHeaderView = self.rTableHeaderView ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.separatorInset = UIEdgeInsetsZero ;
        
    }
    return _rTableView ;
}

-(JYFinanceDetailView*)rTableHeaderView {
    
    if (_rTableHeaderView == nil) {
        _rTableHeaderView = [[JYFinanceDetailView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 340)];
        _rTableHeaderView.backgroundColor = [UIColor whiteColor] ;
    }
    
    return _rTableHeaderView ;
}


-(JYDetailBottomView*)rBottomView {

    if (_rBottomView == nil) {
        _rBottomView = [[JYDetailBottomView alloc]init];
    }
    return _rBottomView ;
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
