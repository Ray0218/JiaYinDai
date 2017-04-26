//
//  JYPayRecordController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/14.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPayRecordController.h"
#import "JYPayRecordDetailController.h"


@interface JYPayRecordController ()

@end

@implementation JYPayRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"还款记录" ;
    [self initializeTableView] ;
}

-(void)initializeTableView {
    
    self.tableView.rowHeight = 95 ;
    
    self.tableView.sectionFooterHeight = 15 ;
    self.tableView.separatorInset = UIEdgeInsetsZero ;
    
}



#pragma mark- UITableViewDataSource/UITableViewDelegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3 ;
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
    
    
    JYPayRecordDetailController *vc =[[JYPayRecordDetailController alloc]init];
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
    [self.contentView addSubview:self.rMoneyLabel];
    [self.contentView addSubview:self.rArrowView];
    
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(15);
    }] ;
    
    [self.rTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.rTitleLabel) ;
        make.right.equalTo(self.rArrowView.mas_left).offset(-15) ;
    }] ;
    
    
    [self.rPayTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rTitleLabel.mas_bottom).offset(10) ;
        make.left.equalTo(self.contentView).offset(15) ;
        make.bottom.equalTo(self.contentView).offset(-15) ;
    }] ;
    
    [self.rMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rTitleLabel.mas_bottom).offset(10) ;
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

-(UIImageView*)rArrowView {

    if (_rArrowView == nil) {
        _rArrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more"]] ;
    }
    
    return _rArrowView ;
}

@end





