//
//  JYInviteRecordController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/6/5.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYInviteRecordController.h"
#import "JYInviteRecordCell.h"


@interface JYInviteRecordController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong) UITableView *rTableView ;


@property(nonatomic ,strong) UIView *rTableHeaderView ;

@property(nonatomic ,strong) UILabel *rNumLabel ;



@property (nonatomic ,strong) NSMutableArray *rMonthsArray ;


@property (nonatomic ,strong) NSMutableDictionary *rMapsDic ;

@property (nonatomic ,strong) NSMutableSet *rOpenSectionIndex ;



@end

static NSString *kMonths[] = {@"",@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"} ;

@implementation JYInviteRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"邀请记录" ;
    
    self.rMonthsArray = [NSMutableArray array] ;
    
    
    self.rMapsDic = [NSMutableDictionary dictionary] ;
    
    self.rOpenSectionIndex = [NSMutableSet set] ;
    
    [self buildSubViews];
    
    [self pvt_loadData];
}

-(void)pvt_loadData {
    
    [[AFHTTPSessionManager jy_sharedManager] POST:kInviteRecordURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"ddd") ;
        
        
        NSDictionary *dataDic = responseObject[@"data"] ;
        
        self.rNumLabel.text = [NSString stringWithFormat:@" 总数量： %zd人 ", [dataDic[@"count"] integerValue]] ;
        
        NSArray *months = dataDic[@"monthList"] ;
        
        if (months.count) {
            
            [self.rMonthsArray addObjectsFromArray:months];
        }
        
        
        NSMutableDictionary *dic =dataDic[@"maps"] ;
        
        [self.rMapsDic addEntriesFromDictionary:dic];
        
        
        [self.rTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
}




-(void)buildSubViews {
    
    
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 5, 0)) ;
    }] ;
}


#pragma mark- UITableViewDataSource/UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return self.rMonthsArray.count ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if ( [self.rOpenSectionIndex containsObject:[NSNumber numberWithInteger:section]]) {
        return 0 ;
    }
    
    
    NSString *monthKey = self.rMonthsArray[section][@"month"] ;
    
    NSArray *keys = [self.rMapsDic[monthKey] allKeys] ;
    
    return keys.count ;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *monthKey = self.rMonthsArray[indexPath.section][@"month"] ;
    
    
    NSMutableDictionary *dic = self.rMapsDic[monthKey];
    
    NSString *dayKey = [dic allKeys][indexPath.row] ;
    
    
    NSInteger rowNum = [dic[dayKey] count];
    
    
    NSString * identify = [NSString stringWithFormat:@"identifyString%zd",rowNum ] ;
    
    
    JYInviteRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:identify] ;
    if (cell == nil) {
        cell = [[JYInviteRecordCell alloc]initWithRowNum:rowNum reuseIdentifier:identify];
    }
    
    
    
    [cell pvt_LoadDataDicArray:dic[dayKey] dicKey:dayKey];
    
    return cell ;
    
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    static NSString *headerIdentifier = @"headerIdentifier" ;
    
    JYInviteHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (headerView == nil) {
        headerView = [[JYInviteHeaderView alloc]initWithReuseIdentifier:headerIdentifier];
        
        [[headerView.rRightButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton *x) {
            
            x.selected = !x.selected ;
            
            if (x.selected ) {
                
                [self.rOpenSectionIndex addObject:[NSNumber numberWithInteger:x.tag - 1000]] ;
                
            }else{
                
                [self.rOpenSectionIndex removeObject:[NSNumber numberWithInteger:x.tag - 1000]] ;
                
            }
            
            [self.rTableView reloadSections:[NSIndexSet indexSetWithIndex:x.tag - 1000] withRowAnimation:UITableViewRowAnimationFade];
            
            
        }] ;
        
        
    }
    
    UILabel *label = headerView.rTitleLabel ;// [headerView.contentView viewWithTag:999] ;
    
    NSDictionary *dic = self.rMonthsArray[section] ;
    
    NSString *timeStr = dic[@"month"] ;
    
    NSString *yearStr  =@"" ;
    NSString*monthStr  = @"" ;
    
    if (timeStr.length>4) {
        yearStr =[ timeStr substringToIndex:4] ;
        monthStr = [timeStr substringFromIndex:4] ;
        monthStr = kMonths[[monthStr integerValue]] ;
    }
    
    
    NSInteger count = [dic[@"cnt"] integerValue] ;
    
    NSString *countStr = [NSString stringWithFormat:@"(%zd个)",count] ;
    
    
    label.attributedText = TTThreeFormateString([NSString stringWithFormat:@"%@%@\n%@年",monthStr,countStr,yearStr], monthStr.length, countStr.length, 19, 12, 10, kTextBlackColor, kBlackColor, kBlackColor) ;
    
    
    
    UIButton *rightBtn = headerView.rRightButton ;// [headerView.contentView viewWithTag:888] ;
    rightBtn.tag = 1000 + section ;
    
    if ([self.rOpenSectionIndex containsObject:[NSNumber numberWithInteger:section]]) {
        
        rightBtn.selected = YES ;
    }else{
        rightBtn.selected = NO ;
    }
    
    return headerView ;
    
    
    
}



#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.estimatedRowHeight = 65 ;
        
        _rTableView.rowHeight = UITableViewAutomaticDimension ;
        
        _rTableView.backgroundColor = kBackGroundColor ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.sectionHeaderHeight = 60 ;
        _rTableView.tableFooterView = [UIView new] ;
        _rTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        _rTableView.tableHeaderView = self.rTableHeaderView ;
        
        
        
        _rTableView.emptyDataView = [DZNEmptyDataView emptyDataView];
        _rTableView.emptyDataView.imageForNoData = [UIImage imageNamed:@"comm_noData"] ;
        _rTableView.emptyDataView.showButtonForNoData = NO;
        _rTableView.emptyDataView.requestSuccess = YES;
        
    }
    return _rTableView ;
}

-(UIView*)rTableHeaderView {
    
    if (_rTableHeaderView == nil) {
        _rTableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)] ;
        _rTableHeaderView.backgroundColor = kBlueColor ;
        [_rTableHeaderView addSubview:self.rNumLabel];
        
        [self.rNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_rTableHeaderView) ;
            make.height.mas_equalTo(34) ;
        }] ;
        
        
    }
    
    return _rTableHeaderView ;
}

-(UILabel*)rNumLabel {
    
    if (_rNumLabel == nil) {
        _rNumLabel = [self jyCreateLabelWithTitle:@" 总数量： 0人 " font:16 color:[UIColor whiteColor] align:NSTextAlignmentCenter] ;
        
        _rNumLabel.layer.cornerRadius= 5 ;
        _rNumLabel.layer.borderColor = [UIColor whiteColor].CGColor ;
        _rNumLabel.layer.borderWidth = 1 ;
    }
    
    return _rNumLabel ;
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

@interface JYInviteHeaderView ()

@end


@implementation JYInviteHeaderView


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithReuseIdentifier:reuseIdentifier] ;
    if (self ) {
        
        self.contentView.backgroundColor = kBackGroundColor;
        
        
        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = [UIColor whiteColor] ;
        bgView.layer.borderWidth = 0.5 ;
        bgView.layer.borderColor = kLineColor.CGColor ;
        [self.contentView addSubview:bgView];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(-1) ;
            make.right.equalTo(self.contentView).offset(1) ;
            make.bottom.equalTo(self.contentView) ;
            make.height.mas_equalTo(45) ;
        }] ;
        
        
        
        [self.contentView addSubview:self.rTitleLabel];
        
        [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15) ;
            make.centerY.equalTo(bgView) ;
        }] ;
        
        
        
        [self.contentView addSubview:self.rRightButton];
        
        [self.rRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView) ;
            make.right.equalTo(self.contentView).offset(-15) ;
            
            make.width.height.mas_equalTo(50) ;
        }] ;
        
        
        
        
    }
    
    return self ;
}


-(UILabel*)rTitleLabel {
    if (_rTitleLabel == nil) {
        
        _rTitleLabel = [self jyCreateLabelWithTitle:@"九月" font:10 color:kTextBlackColor align:NSTextAlignmentLeft] ;
        _rTitleLabel.numberOfLines = 2 ;
        
    }
    
    return _rTitleLabel ;
}

-(UIButton*)rRightButton {
    
    if (_rRightButton == nil) {
        _rRightButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [_rRightButton setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateNormal] ;
        
        [_rRightButton setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateSelected] ;
        _rRightButton.tag = 888 ;
        _rRightButton.backgroundColor = [UIColor clearColor] ;
    }
    
    return _rRightButton ;
}



@end


