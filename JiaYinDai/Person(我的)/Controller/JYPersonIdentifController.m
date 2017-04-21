//
//  JYPersonIdentifController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/18.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPersonIdentifController.h"
#import "JYPasswordCell.h"
#import "JYLogInCell.h"

#import "JYPickerView.h"



@interface JYPerIdentifyHeader : UIView

@property (nonatomic ,strong) UILabel* rTitleLabel ;
@property (nonatomic ,strong) UILabel* rNameLabel ;
@property (nonatomic ,strong) UILabel* rCardIdLabel ;


@end

@implementation JYPerIdentifyHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self addSubview:self.rTitleLabel];
        [self addSubview:self.rNameLabel];
        [self addSubview:self.rCardIdLabel];
    }
    return self;
}

-(void)layoutSubviews {
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(15) ;
    }] ;
    
    [self.rNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15) ;
        make.top.equalTo(self.rTitleLabel.mas_bottom).offset(20) ;
        
    }] ;
    
    [self.rCardIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15) ;
        make.top.equalTo(self.rNameLabel.mas_bottom).offset(5) ;
    }];
}

-(UILabel*)rTitleLabel {
    
    if (_rTitleLabel == nil) {
        _rTitleLabel = [self jyCreateLabelWithTitle:@"嘉银贷保障信息安全！" font:14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rTitleLabel ;
}

-(UILabel*)rNameLabel {
    
    if (_rNameLabel == nil) {
        _rNameLabel = [self jyCreateLabelWithTitle:@"姓名：" font:14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rNameLabel ;
}

-(UILabel*)rCardIdLabel {
    
    if (_rCardIdLabel == nil) {
        _rCardIdLabel = [self jyCreateLabelWithTitle:@"身份证号：" font:14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rCardIdLabel ;
}


@end



@interface JYPersonIdentifController ()

<UITableViewDelegate,UITableViewDataSource>{
    
}

@property (nonatomic ,strong) UITableView *rTableView ;
@property (nonatomic ,strong) JYLogFootView *rTableFootView ;
@property (nonatomic ,strong) JYPerIdentifyHeader *rTableHeaderView ;
@property (nonatomic ,strong) JYPickerView *rPickerView ;

@property (nonatomic ,strong)NSArray *rDataArray ;

@end

@implementation JYPersonIdentifController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"身份认证" ;
    [self buildSubViewUI];
    
    //    [[JYPasswordSetModel alloc]initWithTitle:@"" fieldText:@"" placeHolder:@"" hasCode:NO]
    
    
    self.rDataArray = [NSArray arrayWithObjects:
                       @[
                         [[JYPasswordSetModel alloc]initWithTitle:@"称谓" fieldText:@"" placeHolder:@"" hasCode:NO],[[JYPasswordSetModel alloc]initWithTitle:@"婚姻状况" fieldText:@"" placeHolder:@"请选择" hasCode:NO],[[JYPasswordSetModel alloc]initWithTitle:@"职业" fieldText:@"" placeHolder:@"请选择" hasCode:NO],[[JYPasswordSetModel alloc]initWithTitle:@"教育程度" fieldText:@"" placeHolder:@"请选择" hasCode:NO],[[JYPasswordSetModel alloc]initWithTitle:@"个人资产" fieldText:@"" placeHolder:@"请选择" hasCode:NO]
                         ],
                       @[
                         [[JYPasswordSetModel alloc]initWithTitle:@"籍贯" fieldText:@"" placeHolder:@"省份|市|区" hasCode:NO],[[JYPasswordSetModel alloc]initWithTitle:@"现居住地" fieldText:@"" placeHolder:@"省份|市|区" hasCode:NO],[[JYPasswordSetModel alloc]initWithTitle:@"详细地址" fieldText:@"" placeHolder:@"请输入详细地址:街道|小区|幢|单元|室" hasCode:NO]
                         ],
                       @[
                         [[JYPasswordSetModel alloc]initWithTitle:@"与您关系" fieldText:@"" placeHolder:@"请选择与紧急联系人的关系" hasCode:NO],[[JYPasswordSetModel alloc]initWithTitle:@"姓名" fieldText:@"" placeHolder:@"紧急联系人姓名" hasCode:NO],[[JYPasswordSetModel alloc]initWithTitle:@"联系电话" fieldText:@"" placeHolder:@"请选择紧急联系人" hasCode:NO]
                         
                         ],
                       
                       @[
                         [[JYPasswordSetModel alloc]initWithTitle:@"与您关系" fieldText:@"" placeHolder:@"请选择与紧急联系人的关系" hasCode:NO],[[JYPasswordSetModel alloc]initWithTitle:@"姓名" fieldText:@"" placeHolder:@"紧急联系人姓名" hasCode:NO],[[JYPasswordSetModel alloc]initWithTitle:@"联系电话" fieldText:@"" placeHolder:@"请选择紧急联系人" hasCode:NO]
                         ], nil];
}


#pragma mark - builUI
-(void)buildSubViewUI {
    
    
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }];
    
    
    [self.view addSubview:self.rPickerView];
    [self.rPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view) ;
        make.height.mas_equalTo(256) ;
    }];
}

#pragma mark- UITableViewDataSource/UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return self.rDataArray.count ;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.rDataArray[section] count] ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JYPasswordSetModel *model = self.rDataArray[indexPath.section][indexPath.row] ;
    
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        
        static NSString *identifier = @"identifierButton" ;
        
        JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeTwoBtn reuseIdentifier:identifier ];
        }
        
        
        [cell setDataModel:model] ;
        
        
        return cell ;
    }
    
    
    if (indexPath.section == 1 && indexPath.row != 2) {
        static NSString *identifier = @"identifierAdress" ;
        
        JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeEye reuseIdentifier:identifier ];
            [cell.rRightArrow setImage:[UIImage imageNamed:@"ident_address"] forState:UIControlStateNormal] ;
         }
        
        
        [cell setDataModel:model] ;
        
        
        return cell ;
    }
    
    
    if (indexPath.section == 0 || indexPath.row == 0) {
        static NSString *identifier = @"identifierArrow" ;
        
        JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeArrow reuseIdentifier:identifier ];
        }
        
        
        [cell setDataModel:model] ;
        
        
        return cell ;
    }
    
    
    
    
    static NSString *identifier = @"identifierNormal" ;
    
    JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeNormal reuseIdentifier:identifier ];
    }
    
    
    [cell setDataModel:model] ;
    
    
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
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 3) {
        return 0 ;
    }
    return  15 ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"%zd --- %zd",indexPath.section,indexPath.row) ;
    
    self.rPickerView.hidden = NO ;
    
    self.rPickerView.rDataArray = @[@"硕士研究生或以上",@"本科",@"专科",@"高中或中专",@"初中或初中以下"] ;
    
    
    
    @weakify(self)
    self.rPickerView.rSelectBlock = ^(NSString *selectString) {
        @strongify(self)
        JYPasswordSetModel *model = self.rDataArray[indexPath.section][indexPath.row] ;
        model.rTFTitle = selectString ;
        [self.rTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone] ;
    } ;
    
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
        _rTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        _rTableView.tableFooterView = self.rTableFootView ;
        _rTableView.tableHeaderView = self.rTableHeaderView ;
        
    }
    return _rTableView ;
}


-(JYLogFootView*)rTableFootView {
    
    if (_rTableFootView == nil) {
        _rTableFootView = [[JYLogFootView alloc]initWithType:JYLogFootViewTypeSetPassword] ;
        [_rTableFootView.rCommitBtn setTitle:@"提交" forState:UIControlStateNormal] ;
        [_rTableFootView.rAgreeBtn setTitleColor:kTextBlackColor forState:UIControlStateNormal] ;
        _rTableFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 140) ;
        _rTableFootView.rAgreeBtn.titleLabel.numberOfLines = 0 ;
        [_rTableFootView.rAgreeBtn setTitle:@"请仔细填写，一经提交将不可更改。\n我申明以上信息为本人真实信息。" forState:UIControlStateNormal] ;
        
        [[_rTableFootView.rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            
            
        }] ;
    }
    
    return _rTableFootView ;
}


-(JYPerIdentifyHeader*)rTableHeaderView {
    if (_rTableHeaderView == nil) {
        _rTableHeaderView = [[JYPerIdentifyHeader alloc]init];
        _rTableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 110) ;
        
        _rTableHeaderView.backgroundColor = kBackGroundColor ;
    }
    
    return _rTableHeaderView ;
}

-(JYPickerView*)rPickerView {
    
    if (_rPickerView == nil) {
        _rPickerView = [[JYPickerView alloc]init];
        _rPickerView.hidden = YES ;
    }
    
    return _rPickerView ;
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
