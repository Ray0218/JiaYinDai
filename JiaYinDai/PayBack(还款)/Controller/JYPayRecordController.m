//
//  JYPayRecordController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/14.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPayRecordController.h"
#import "JYPayRecordDetailController.h"

@interface JYPayRecordController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *rTableView ;

@property (nonatomic ,strong) NSMutableArray *rDataArray ;

@end

@implementation JYPayRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"还款记录" ;
    self.rDataArray = [NSMutableArray array];
    [self initializeTableView] ;
    [self pvt_loadData];
}


- (void)pvt_loadData
{
    
    [[AFHTTPSessionManager jy_sharedManager ] POST:kgetRepaybillURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
        [self.rDataArray removeAllObjects];
        
        NSArray *data = responseObject[@"data"] ;
        [self.rDataArray  addObjectsFromArray:[JYDGetRepaybillModel arrayOfModelsFromDictionaries:data error:nil]] ;
        
        [self.rTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }] ;
    
    
    
    
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
        
        _rTableView.rowHeight = 95 ;
        _rTableView.sectionHeaderHeight = 15 ;
        
        _rTableView.separatorInset = UIEdgeInsetsZero ;
        _rTableView.tableFooterView = [UIView new];
        
        
        @weakify(self)
        [_rTableView addLegendHeaderWithRefreshingBlock:^{
            @strongify(self)
            [self pvt_loadData] ;
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
    [self.rTableView.footer endRefreshing];
    
}



#pragma mark- UITableViewDataSource/UITableViewDelegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     
    return self.rDataArray.count ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *identifier = @"identifierLoan" ;
    
    JYPayRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPayRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.rGetRepaybillModel = self.rDataArray[indexPath.section] ;
    
    
    return cell ;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section  {
    
    
    static NSString *headerIdentifier = @"headerIdentifier" ;
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
        headerView.contentView.backgroundColor = [UIColor clearColor] ;
        headerView.backgroundView = ({
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = [UIColor clearColor] ;
            view ;
            
        }) ;
    }
    
    return headerView ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JYDGetRepaybillModel *model = self.rDataArray[indexPath.section] ;
    
    JYPayRecordDetailController *vc =[[JYPayRecordDetailController alloc]init];
    vc.billId = model.id;
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


@interface JYPayRecordCell ()

@property (nonatomic ,strong) UILabel*rTitleLabel ;
@property (nonatomic ,strong) UILabel *rTimeLabel ;
@property (nonatomic ,strong) UILabel *rPayTimeLab;
@property (nonatomic ,strong) UILabel *rMoneyLabel ;

@property (nonatomic ,strong) UILabel *rOrderNoLabel ;


@property (nonatomic ,strong) UIImageView *rArrowView ;



@end


@implementation JYPayRecordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ;
    if (self ) {
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        
        
        [self buildSubViewsUI] ;
    }
    
    return self ;
}

-(void)buildSubViewsUI {
    
    
    [self.contentView addSubview:self.rTimeLabel];
    [self.contentView addSubview:self.rTitleLabel];
    [self.contentView addSubview:self.rPayTimeLab];
    
    [self.contentView addSubview:self.rOrderNoLabel];
    [self.contentView addSubview:self.rMoneyLabel];
    [self.contentView addSubview:self.rArrowView];
    
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(15);
    }] ;
    
    [self.rOrderNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15) ;
        make.top.equalTo(self.rTitleLabel.mas_bottom).offset(10) ;
    }] ;
    
    [self.rTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.rTitleLabel) ;
        make.right.equalTo(self.rArrowView.mas_left).offset(-15) ;
    }] ;
    
    
    [self.rPayTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rOrderNoLabel.mas_bottom).offset(10) ;
        make.left.equalTo(self.contentView).offset(15) ;
        make.bottom.equalTo(self.contentView).offset(-15) ;
    }] ;
    
    [self.rMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rOrderNoLabel.mas_bottom).offset(10) ;
        make.right.equalTo(self.rArrowView.mas_left).offset(-15) ;
        make.bottom.equalTo(self.contentView).offset(-15) ;
    }] ;
    
    [self.rArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15) ;
        make.centerY.equalTo(self.contentView) ;
    }] ;
}

#pragma mark- getter

-(UILabel*)rTitleLabel {
    
    if (_rTitleLabel == nil) {
        _rTitleLabel = [self jyCreateLabelWithTitle:@"（工薪贷订单号XXXX）第X期" font:16 color:kBlueColor align:NSTextAlignmentLeft] ;
    }
    
    return _rTitleLabel ;
}

-(UILabel*)rTimeLabel {
    if (_rTimeLabel == nil) {
        _rTimeLabel = [self jyCreateLabelWithTitle:@"YY-MM-DD" font:14 color:kTextBlackColor align:NSTextAlignmentRight] ;
    }
    
    return _rTimeLabel ;
}

-(UILabel*)rPayTimeLab {
    
    if (_rPayTimeLab == nil) {
        _rPayTimeLab = [self jyCreateLabelWithTitle:@"到期还款日：YY-MM-DD" font:14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rPayTimeLab ;
}

-(UILabel*)rMoneyLabel {
    if (_rMoneyLabel == nil) {
        _rMoneyLabel = [self jyCreateLabelWithTitle:@"-10000.00" font:14 color:kBlueColor align:NSTextAlignmentRight] ;
    }
    
    return _rMoneyLabel ;
}

-(UILabel*)rOrderNoLabel {

    if (_rOrderNoLabel == nil) {
        _rOrderNoLabel = [self jyCreateLabelWithTitle:@"" font:14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    
    return _rOrderNoLabel ;
    
}

-(UIImageView*)rArrowView {
    
    if (_rArrowView == nil) {
        _rArrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more"]] ;
    }
    
    return _rArrowView ;
}

#pragma mark- setter


-(void)setRGetRepaybillModel:(JYDGetRepaybillModel *)rGetRepaybillModel{
    
    _rGetRepaybillModel = [rGetRepaybillModel copy] ;
    
//    NSString *rOrderStr = rGetRepaybillModel.applyNo ;
//    
//    
//    if (rOrderStr.length >= 7) {
//        rOrderStr = [rOrderStr substringFromIndex:rOrderStr.length - 7] ;
//    }
    
    
    _rTitleLabel.text = [NSString stringWithFormat:@"%@ 第%@期",rGetRepaybillModel.productName,rGetRepaybillModel.period];
    self.rOrderNoLabel.text = [NSString stringWithFormat:@"订单号 %@",rGetRepaybillModel.applyNo ];
    _rPayTimeLab.text = [NSString stringWithFormat:@"到期还款日：%@",rGetRepaybillModel.endDate];
    _rMoneyLabel.text = [NSString stringWithFormat:@"-%.2f",[rGetRepaybillModel.amount doubleValue]];
    
    _rTimeLabel.text = TTTimeString(rGetRepaybillModel.createTime);;
    
}
@end





