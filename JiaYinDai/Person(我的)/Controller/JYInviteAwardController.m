//
//  JYInviteAwardController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/6/5.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYInviteAwardController.h"

@interface JYInviteAwardController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong) UITableView *rTableView ;

@property (nonatomic ,strong) NSMutableArray *rDataArray ;


@end

@implementation JYInviteAwardController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"邀请奖励" ;
    
    self.rDataArray = [NSMutableArray array] ;
    
    [self buildSubViews];
    
    [self pvt_loadData];
}

-(void)pvt_loadData {

    [[AFHTTPSessionManager jy_sharedManager]POST:kInviteAwardURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"ddd") ;
        
        
        NSArray *dataArr = responseObject[@"data"] ;
        
        
        [self.rDataArray removeAllObjects] ;
        
        
        [self.rDataArray addObjectsFromArray:[JYInviteAwardModel arrayOfModelsFromDictionaries:dataArr error:nil]] ;
        
        [self.rTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;

}



-(void)buildSubViews {


    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }] ;
}


#pragma mark- UITableViewDataSource/UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
     return self.rDataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  1 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identify = @"identifyString" ;
    
    JYInviteAwardCell *cell = [tableView dequeueReusableCellWithIdentifier:identify] ;
    if (cell == nil) {
        cell = [[JYInviteAwardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    cell.rDataModel = self.rDataArray[indexPath.section] ;
    
    return cell ;

}


-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
        
        static NSString *headerIdentifier = @"headerIdentifier" ;
        
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
        if (headerView == nil) {
            headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
             headerView.contentView.backgroundColor = kBackGroundColor;
        }
        
        return headerView ;
        
    }

-(void)pvt_endRefresh{
    [self.rTableView.header endRefreshing];
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
        _rTableView.sectionFooterHeight = 15 ;
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

@interface JYInviteAwardCell ()

@property (nonatomic ,strong) UILabel * rTitleLabel ;

@property (nonatomic ,strong) UILabel *rMoneyLabel ;

@property (nonatomic ,strong) UILabel *rTelNumLabel ;

@property (nonatomic ,strong) UILabel *rTimeLabel ;

@end

@implementation JYInviteAwardCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{


    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ;
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        
        [self buildSubViewsUI];
    }
    
    return self ;
}

-(void)buildSubViewsUI {


    [self.contentView addSubview:self.rTitleLabel];
    [self.contentView addSubview:self.rMoneyLabel];
    [self.contentView addSubview:self.rTelNumLabel];
    [self.contentView addSubview:self.rTimeLabel];
    
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(15) ;
    }] ;
    
    
    [self.rMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15) ;
        make.centerY.equalTo(self.rTitleLabel) ;
    }] ;
    
    [self.rTelNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rTitleLabel) ;
        make.top.equalTo(self.rTitleLabel.mas_bottom).offset(10) ;
        make.bottom.equalTo(self.contentView).offset(-15) ;
    }] ;
    
    
    [self.rTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.rTelNumLabel) ;
        make.right.equalTo(self.contentView).offset(-15) ;
    }] ;
}


-(void)setRDataModel:(JYInviteAwardModel *)rDataModel {

    _rDataModel = [rDataModel copy] ;
    
    
    self.rTitleLabel.text = rDataModel.des ;
    self.rMoneyLabel.text = [NSString stringWithFormat:@"%+.2f",[rDataModel.amount doubleValue]] ;

    
    if (rDataModel.cellphone.length > 7) {
        self.rTelNumLabel.text = [rDataModel.cellphone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"] ;
    }else{
    
        self.rTelNumLabel.text= @"" ;
    }
    
    
    self.rTimeLabel.text = TTTimeString(rDataModel.time) ;
}

#pragma mark- getter

-(UILabel*)rTitleLabel {

    if (_rTitleLabel == nil) {
        _rTitleLabel = [self jyCreateLabelWithTitle:@"投资XX奖励" font:16 color:kBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rTitleLabel ;
}

-(UILabel*)rMoneyLabel {

    if (_rMoneyLabel == nil) {
        _rMoneyLabel = [self jyCreateLabelWithTitle:@"+100.86" font:18 color:kBlackColor align:NSTextAlignmentRight] ;
    }
    
    return _rMoneyLabel ;
}


-(UILabel*)rTelNumLabel {
    if (_rTelNumLabel == nil) {
        _rTelNumLabel = [self jyCreateLabelWithTitle:@"138****0798" font:13 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rTelNumLabel ;
}

-(UILabel*)rTimeLabel {

    if (_rTimeLabel == nil) {
        _rTimeLabel = [self jyCreateLabelWithTitle:@"2017-01-01" font:13 color:kTextBlackColor align:NSTextAlignmentRight] ;
    }
    return _rTimeLabel ;
}

@end

















