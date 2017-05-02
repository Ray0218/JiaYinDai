//
//  JYSupportBankController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/2.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYSupportBankController.h"

@interface JYSupportBankController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *rTableView ;


@end

@implementation JYSupportBankController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"支持银行" ;
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
    return 20 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *identifier = @"identifierNormal" ;
    
    JYSupportBankCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYSupportBankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier ];
    }
    
    
    return cell ;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.rSelectBlock  ) {
        self.rSelectBlock(@"农业银行") ;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = kBackGroundColor ;
        _rTableView.estimatedRowHeight = 60 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
         _rTableView.separatorInset = UIEdgeInsetsZero ;
        _rTableView.tableFooterView = [UIView new];
        
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


@interface JYSupportBankCell ()

@property (nonatomic ,strong) UILabel *rBankName ;
@property (nonatomic ,strong) UIImageView *rBankImg ;
@property (nonatomic ,strong) UILabel *rOneMaxLabel ;
@property (nonatomic ,strong) UILabel *rDayMaxLabel ;

@end

@implementation JYSupportBankCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ;
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        [self buildSubViewsUI] ;
    }
    
    return self ;
}


-(void)buildSubViewsUI {
    
    
     [self.contentView addSubview:self.rBankImg];
    [self.contentView addSubview:self.rBankName ];
    [self.contentView addSubview:self.rOneMaxLabel];
    [self.contentView addSubview:self.rDayMaxLabel];
    
    
    [self.rBankImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15) ;
        make.width.and.height.mas_equalTo(40) ;
        make.centerY.equalTo(self.contentView);
    }] ;
    
    [self.rBankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rBankImg.mas_right).offset(15) ;
        make.centerY.equalTo(self.contentView) ;
    }];
    
    [self.rOneMaxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15) ;
        make.top.equalTo(self.contentView).offset(10) ;
    }] ;
    
    [self.rDayMaxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rOneMaxLabel.mas_bottom).offset(5);
        make.right.equalTo(self.contentView).offset(-15) ;
        make.bottom.equalTo(self.contentView).offset(-10) ;
    }] ;
    
}


-(UIImageView*)rBankImg {
    
    if (_rBankImg == nil) {
        _rBankImg = [[UIImageView alloc]init];
        _rBankImg.backgroundColor = [UIColor clearColor] ;
        _rBankImg.image = [UIImage imageNamed:@"01030000"] ;
        
    }
    return _rBankImg ;
}

-(UILabel*)rBankName {
    
    if (_rBankName == nil) {
        _rBankName = [self jyCreateLabelWithTitle:@"农业银行" font:18 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    return _rBankName ;
}

-(UILabel*)rOneMaxLabel {
    
    if (_rOneMaxLabel == nil) {
        _rOneMaxLabel = [self jyCreateLabelWithTitle:@"单笔限额：10000" font:14 color:kTextBlackColor align:NSTextAlignmentRight] ;
    }
    return _rOneMaxLabel ;
}

-(UILabel*)rDayMaxLabel {
    
    if (_rDayMaxLabel == nil) {
        _rDayMaxLabel = [self jyCreateLabelWithTitle:@"单日限额：20w" font:14 color:kTextBlackColor align:NSTextAlignmentRight] ;
    }
    return _rDayMaxLabel ;
}




@end








