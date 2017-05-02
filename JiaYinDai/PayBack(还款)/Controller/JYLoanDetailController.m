//
//  JYLoanDetailController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/12.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoanDetailController.h"
#import "JYLoanDetailHeader.h"
#import "JYPayBackController.h"
#import "JYRecordPayController.h"

 
@interface JYLoanDetailController ()<UITableViewDelegate,UITableViewDataSource>{
    
    BOOL rIsOver ;
}

@property(nonatomic ,strong) UITableView *rTableView ;


@property (nonatomic ,strong) JYLoanDetailHeader *rHeaderView ;

@end

@implementation JYLoanDetailController

-(instancetype)initWithOver:(BOOL) isOver{
    
    self = [super init] ;
    if (self) {
        rIsOver = isOver ;
    }
    return self ;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //    self.navigationController.navigationBar.barTintColor = kBlueColor;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage jy_imageWithColor:kBlueColor] forBarMetrics:UIBarMetricsDefault];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated] ;
    
    if (rIsOver) {
        
        //        self.navigationController.navigationBar.barTintColor = kOrangewColor;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage jy_imageWithColor:kOrangewColor] forBarMetrics:UIBarMetricsDefault];
        
    }else{
        //        self.navigationController.navigationBar.barTintColor = kBlueColor;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage jy_imageWithColor:kBlueColor] forBarMetrics:UIBarMetricsDefault];
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"借贷详情" ;
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
        
        static NSString *identifier = @"identifierLoanDeail" ;
        
        JYLoanDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            
            if (rIsOver ) {
                
                cell = [[JYLoanDetailCell alloc]initWithCellType:JYLoanDetailCellTypeOverButton reuseIdentifier:identifier];
            }else{
                cell = [[JYLoanDetailCell alloc]initWithCellType:JYLoanDetailCellTypeButton reuseIdentifier:identifier];
            }
            
            @weakify(self)
            [[cell.rcommitButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
                @strongify(self)
                
                
                JYPayBackController *vc = [[JYPayBackController alloc]init];
                [self.navigationController pushViewController:vc animated:YES] ;
            }] ;
            
            [[cell.rOrderButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
                @strongify(self)
                
                
                JYRecordPayController *vc = [[JYRecordPayController alloc]init];
                [self.navigationController pushViewController:vc animated:YES] ;
            }] ;
        }
        
        return cell ;
        
    }
    
    if (indexPath.row == 1) {
        static NSString *identifier = @"identifierLoanHeaer" ;
        
        JYLoanTimesCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYLoanTimesCell alloc]initWithCellType:JYLoanCllTypeHeader reuseIdentifier:identifier];
            
        }
        
        return cell ;
        
    }
    
    
    static NSString *identifier = @"identifierLoanNormal" ;
    
    JYLoanTimesCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYLoanTimesCell alloc]initWithCellType:JYLoanCllTypeNormal reuseIdentifier:identifier];
        
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
        
        
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:@"查看《借款协议》" attributes:@{NSForegroundColorAttributeName:kBlueColor}]  ;
        [attStr addAttribute:NSForegroundColorAttributeName value:kTextBlackColor range:NSMakeRange(0, 2)] ;
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [btn setAttributedTitle:attStr  forState:UIControlStateNormal] ;
        [btn setTitleColor:kBlueColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14] ;
        
        [headerView.contentView addSubview:btn];
        
        
        UILabel *labe= [self jyCreateLabelWithTitle:@"利息总计：XX元" font:16 color:kTextBlackColor align:NSTextAlignmentRight] ;
        
        [headerView.contentView addSubview:labe];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView.contentView).offset(15) ;
            make.centerY.equalTo(headerView.contentView) ;
        }] ;
        
        [labe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(headerView.contentView).offset(-15) ;
            make.centerY.equalTo(headerView.contentView) ;
        }] ;
        
        
        
    }
    
    return headerView ;
    
}



#pragma mark- getter

-(JYLoanDetailHeader*)rHeaderView {
    
    if (_rHeaderView == nil) {
        _rHeaderView = [[JYLoanDetailHeader alloc]init ];
        _rHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160) ;
        
        if (rIsOver) {
            _rHeaderView.rBgView.backgroundColor = kOrangewColor ;
            _rHeaderView.rSateLabel.text = @"已逾期" ;
            _rHeaderView.rLeftImg.image = [UIImage imageNamed:@"loan_yellow"] ;
        }else{
            _rHeaderView.rBgView.backgroundColor = kBlueColor ;
        }
    }
    
    return _rHeaderView ;
}


#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = [UIColor clearColor] ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.sectionFooterHeight = 50 ;
        _rTableView.tableFooterView = [UIView new] ;
        _rTableView.separatorInset = UIEdgeInsetsZero ;
        _rTableView.estimatedRowHeight = 45 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension ;
        _rTableView.tableHeaderView = self.rHeaderView ;
        
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
