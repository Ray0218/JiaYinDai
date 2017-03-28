//
//  JYRecordController.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/28.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYRecordController.h"

@interface JYRecordController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *rTableView ;

@end

@implementation JYRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"投资记录" ;
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }];
}


#pragma mark-UITableViewDataSource /UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 ;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 20 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *indentifier = @"indentifier" ;
    
    JYRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier] ;
    if (cell == nil) {
        cell = [[JYRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        
    }
    
    return cell ;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    
    static NSString *headerIdentifier = @"headerIdentifier" ;
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
         headerView.contentView.backgroundColor = [UIColor clearColor] ;
        headerView.layer.borderColor = kLineColor.CGColor ;
        headerView.layer.borderWidth = 0.5 ;
    }
    
    return headerView ;
}
#pragma mark -getter

-(UITableView*)rTableView{
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = [UIColor clearColor] ;
        _rTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rTableView.tableFooterView = [[UIView alloc]init];
        _rTableView.rowHeight = 60 ;
        _rTableView.sectionFooterHeight = 5 ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
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



@interface JYRecordCell ()

@property (nonatomic,strong) UILabel* rPhoneLabel ;
@property (nonatomic,strong) UILabel* rTimeLabel ;
@property (nonatomic,strong) UILabel* rMoneyLabel ;


@end

@implementation JYRecordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier] ;
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        
        self.rPhoneLabel.text = @"136****2499" ;
        self.rTimeLabel.text = @"2017-01-01  12:00" ;
        self.rMoneyLabel.text =@"10000元" ;
        
        [self.contentView addSubview:self.rPhoneLabel];
        [self.contentView addSubview:self.rTimeLabel];
        [self.contentView addSubview:self.rMoneyLabel];
        
        
        [self.rPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15) ;
            make.top.equalTo(self.contentView).offset(10) ;

        }];
        
        [self.rTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15) ;
            make.bottom.equalTo(self.contentView).offset(-10) ;
        }];
        
        [self.rMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView) ;
            make.right.equalTo(self.contentView).offset(-15) ;
        }] ;
    }
    
    return self ;
}



#pragma mark- getter

-(UILabel*)rPhoneLabel {
    if (_rPhoneLabel == nil) {
        _rPhoneLabel = [[UILabel alloc]init];
        _rPhoneLabel.textAlignment = NSTextAlignmentLeft ;
        _rPhoneLabel.font = [UIFont systemFontOfSize:14] ;
        _rPhoneLabel.textColor = kTextBlackColor ;
    }
    
    return _rPhoneLabel ;
}

-(UILabel*)rTimeLabel {
    if (_rTimeLabel == nil) {
        _rTimeLabel = [[UILabel alloc]init];
        _rTimeLabel.textAlignment = NSTextAlignmentLeft ;
        _rTimeLabel.font = [UIFont systemFontOfSize:14] ;
        _rTimeLabel.textColor = kTextBlackColor ;
    }
    
    return _rTimeLabel ;
}
-(UILabel*)rMoneyLabel {
    if (_rMoneyLabel == nil) {
        _rMoneyLabel = [[UILabel alloc]init];
        _rMoneyLabel.textAlignment = NSTextAlignmentRight ;
        _rMoneyLabel.font = [UIFont systemFontOfSize:14] ;
        _rMoneyLabel.textColor = kTextBlackColor ;
    }
    
    return _rMoneyLabel ;
}


@end




