//
//  JYLoanViewController.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/23.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoanViewController.h"
#import "JYLoanTableViewCell.h"
#import "JYLoanAlterVC.h"
#import "UIViewController+Transition.h"



@interface JYLoanFootVew : UIView

@property (nonatomic,strong) UIButton *rCommitBtn ;
@property (nonatomic,strong) UILabel *rAddressLab ;


@end

@implementation JYLoanFootVew

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self buildSubViewsUI];
        
    }
    return self;
}


-(void)buildSubViewsUI {
    
    [self addSubview:self.rCommitBtn];
    [self addSubview:self.rAddressLab];
    
    
    
}

-(void)layoutSubviews {
    [self.rCommitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15) ;
        make.top.equalTo(self).offset(35) ;
        
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(45) ;
    }] ;
    
    [self.rAddressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15) ;
        make.top.equalTo(self.rCommitBtn.mas_bottom).offset(10) ;
    }] ;
    


}

-(UIButton*)rCommitBtn {
    if (_rCommitBtn == nil) {
        _rCommitBtn = [self jyCreateButtonWithTitle:@"开始申请"] ;
    }
    return _rCommitBtn ;
}

-(UILabel*)rAddressLab {
    if (_rAddressLab == nil) {
        _rAddressLab = [self jyCreateLabelWithTitle:@"开放城市：杭州" font:16 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rAddressLab ;
}


@end


@interface JYLoanViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong) UITableView *rTableView ;

@property(nonatomic ,strong) UIView *rTableHeaderView ;

@property(nonatomic ,strong) JYLoanFootVew *rTableFootView ;


@end


static NSString *rCellTitles[] = {@"每月最低还款（元）",@"此次申请分期（期）",@"借款费用说明"} ;

@implementation JYLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItems = nil ;
    
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
    return 5 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (indexPath.row == 0) {
        
        static NSString *identifier = @"identifier" ;
        
        JYLoanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        if (cell == nil) {
            cell = [[JYLoanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        
        
        return cell ;
        
    }
    
    if (indexPath.row == 1) {
        
     
    static NSString *identifier = @"identifierdd" ;
    
    JYLoanTimeCell *cellTime = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    if (cellTime == nil) {
        
        
        cellTime = [[JYLoanTimeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cellTime ;
    
    }
    
    
    static NSString *identifier = @"identifierdd" ;
    
    UITableViewCell *cellTime = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    if (cellTime == nil) {
        
        
        cellTime = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cellTime.backgroundColor =
        cellTime.contentView.backgroundColor = [UIColor clearColor] ;
    }
    
    cellTime.textLabel.text = rCellTitles[indexPath.row - 2];
    cellTime.detailTextLabel.text = @"XXXX" ;
    return cellTime ;
    

    
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    static NSString *headerIdentifier = @"headerIdentifier" ;
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
        headerView.contentView.backgroundColor = UIColorFromRGB(0xd8981d) ;
    }
    
    return headerView ;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row  == 4) {
        JYLoanAlterVC *vc = [[JYLoanAlterVC alloc]init];
        [self.navigationController jy_showViewController:vc completion:nil];
        
    }
}

#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = kBackGroundColor ;
        //        _rTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        _rTableView.estimatedRowHeight = 180 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
        //        _rTableView.rowHeight = 140 ;
        _rTableView.tableFooterView = [[UIView alloc]init];
        _rTableView.tableHeaderView = self.rTableHeaderView ;
        _rTableView.tableFooterView = self.rTableFootView ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.sectionHeaderHeight = 20 ;
        
    }
    return _rTableView ;
}

-(UIView*)rTableHeaderView {
    
    if (_rTableHeaderView == nil) {
        _rTableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
        _rTableHeaderView.backgroundColor = kBlueColor ;
    }
    
    return _rTableHeaderView ;
}

-(JYLoanFootVew*)rTableFootView {

    if (_rTableFootView == nil) {
        _rTableFootView = [[JYLoanFootVew alloc]init];
        _rTableFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 130) ;
        _rTableFootView.backgroundColor = [UIColor clearColor] ;
        
    
    }
    
    return _rTableFootView ;

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
