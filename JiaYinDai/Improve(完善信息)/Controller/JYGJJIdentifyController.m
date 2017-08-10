//
//  JYGJJIdentifyController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/20.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYGJJIdentifyController.h"
#import "JYPasswordCell.h"
#import "JYPasswordSetModel.h"


@interface JYGJJIdentifyController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSArray *rDataArray ;
    
}
@property(nonatomic ,strong) UITableView *rTableView ;

@property(nonatomic ,strong) UIView *rTableFootView ;

@property(nonatomic ,strong) UIButton *rCommitBtn ;


@property (nonatomic ,strong) UITextField *rFirstTextField ;

@property (nonatomic ,strong) UITextField *rSecondTextField ;


@property (nonatomic ,assign) int rType ;
@property (nonatomic ,assign) int rAccount_type ;





@end

@implementation JYGJJIdentifyController

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    self.rSecondTextField.keyboardType = UIKeyboardTypeAlphabet ;
    
    
    [[RACSignal  combineLatest:@[
                                 self.rFirstTextField.rac_textSignal,
                                 self.rSecondTextField.rac_textSignal,
                                 ]
                        reduce:^(NSString *username,NSString *password) {
                            return @([username length]  && [password length]);
                        }] subscribeNext:^(NSNumber* x) {
                            
                            self.rCommitBtn.enabled = [x boolValue] ;
                        }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"绑定社保账户" ;
    [self buildSubViewUI];
    
    
    rDataArray = @[
                   @[
                       [[JYPasswordSetModel alloc]initWithTitle:@"社保类型" fieldText:@"" placeHolder:@"" hasCode:NO]
                       ],
                   @[
                       [[JYPasswordSetModel alloc]initWithTitle:@"登录名" fieldText:@"" placeHolder:@"请输入" hasCode:NO],[[JYPasswordSetModel alloc]initWithTitle:@"密码" fieldText:@"" placeHolder:@"请输入密码" hasCode:NO],
                       ]
                   
                   ] ;
    
}


#pragma mark - builUI
-(void)buildSubViewUI {
    
    
    
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }];
    
    [self.view addSubview:self.rQuestButton];
    [self.view addSubview:self.rTelButton];
    
    [self.rQuestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-15) ;
        make.right.equalTo(self.view.mas_centerX).offset(-15) ;
    }] ;
    
    
    [self.rTelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-15) ;
        make.left.equalTo(self.view.mas_centerX).offset(15) ;
    }] ;

    
}

#pragma mark- UITableViewDataSource/UITableViewDelegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1 ;
    }
    return  2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JYPasswordSetModel *model = rDataArray[indexPath.section][indexPath.row] ;
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        static NSString *identifier = @"identifierButton" ;
        
        JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeTwoBtn reuseIdentifier:identifier ];
            [cell.rManButton setTitle:@" 省级" forState:UIControlStateNormal];
            [cell.rWomenButton setTitle:@" 市级" forState:UIControlStateNormal];
            
            [RACObserve(cell.rManButton, selected)subscribeNext:^(id x) {
                
                if ([x boolValue]) {
                    self.rType = 1 ;
                }else{
                    
                    self.rType = 2 ;
                }
                
                
            }] ;
        }
        
        
        [cell setDataModel:model] ;
        
        
        return cell ;
    }
    
    
    static NSString *identifier = @"identifierCode" ;
    
    JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeNormal reuseIdentifier:identifier ];
        
        [[cell.rTextField rac_signalForControlEvents:UIControlEventEditingDidEnd]subscribeNext:^(UITextField* textField) {
            
            NSInteger rowIndex = textField.tag - 1000 ;
            
            JYPasswordSetModel *mode = rDataArray[1][rowIndex] ;
            
            mode.rTFTitle = textField.text ;
            
            
        }] ;
    }
    cell.rTextField.tag =  1000 + indexPath.row ;

    [cell setDataModel:model] ;
    
    if (indexPath.row == 0) {
        self.rFirstTextField = cell.rTextField ;
    }else{
        
        self.rSecondTextField = cell.rTextField ;
    }
    
    
    return cell ;
    
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor] ;
    return view ;

}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
        
        static NSString *headerIdentifier = @"headerIdentifier" ;
        
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
        if (headerView == nil) {
            headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
            headerView.contentView.backgroundColor = [UIColor clearColor];
            
            
            NSString *titles[] = {@" 客户号",@" 用户名",@" 市民邮箱"} ;
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:3] ;
            for (int i = 0; i < 3; i++) {
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
                [btn setTitle:titles[i] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:14] ;
                [btn setTitleColor:kTextBlackColor forState:UIControlStateNormal];
                [headerView.contentView addSubview:btn];
                
                [btn setImage:[UIImage imageNamed:@"imp_unselect"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"imp_select"] forState:UIControlStateSelected];
                btn.tag = 1000+i ;
                [arr addObject:btn];
                btn.selected = NO ;
                
                if (i == 0) {
                    btn.selected = YES ;
                    self.rAccount_type = 1 ;
                }
                
                [btn addTarget:self action:@selector(pvt_selectBtn:) forControlEvents:UIControlEventTouchUpInside] ;
                
            }
            
            
            [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:25 tailSpacing:25] ;
            [arr mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(headerView.contentView) ;
            }] ;
            
            
            
        }
        
        return headerView ;
    }
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor] ;
    return view ;
    
}

-(void)pvt_selectBtn:(UIButton*) button {
    
    
    UITableViewHeaderFooterView *headerView = [self.rTableView footerViewForSection:0] ;
    UIButton *btn0 = [headerView.contentView viewWithTag:1000] ;
    UIButton *btn1 = [headerView.contentView viewWithTag:1001] ;
    UIButton *btn2 = [headerView.contentView viewWithTag:1002] ;
    
    btn0.selected = btn1.selected = btn2.selected = NO ;
    
    
    button.selected = YES ;
    self.rAccount_type = (int)(button.tag - 999) ;
    
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 15 ;
    }
    
    
    return 0 ;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 50 ;
    }
    
    
    return 0 ;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark- action


-(void)pvt_commit {

    [self pvt_loadData];
}

-(void)pvt_loadData {

  
    NSMutableDictionary *dic= [NSMutableDictionary dictionary] ;
    [dic setValue:self.rFirstTextField.text forKey:@"userName"];
    
    [dic setValue:self.rSecondTextField.text forKey:@"password"] ;
    
    [dic setValue:[NSNumber numberWithInt:self.rType] forKey:@"type"];
    
    [dic setValue:[NSNumber numberWithInt:self.rAccount_type] forKey:@"accountType"] ;
    
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kGJJinURL parameters:dic  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [JYProgressManager showBriefAlert:@"公积金认证成功"] ;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
}


#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = kBackGroundColor ;
        _rTableView.estimatedRowHeight = 45 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
        _rTableView.tableFooterView = self.rTableFootView ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        
    }
    return _rTableView ;
}


-(UIView*)rTableFootView {
    
    if (_rTableFootView == nil) {
        _rTableFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 120)];
        
        
        UIButton *commitBtn = [self jyCreateButtonWithTitle:@"确认"] ;
        commitBtn.enabled = NO ;
        commitBtn.frame = CGRectMake(15, 30, SCREEN_WIDTH-30, 45);
        [_rTableFootView addSubview:commitBtn];
        self.rCommitBtn = commitBtn ;
        
        @weakify(self)
        [[commitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            
            @strongify(self)
            [self pvt_commit] ;
        }] ;
        
        UILabel *descLabe = [self jyCreateLabelWithTitle:@"如担心信息安全可在绑定之后到公积金网就该密码" font:14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
        descLabe.frame = CGRectMake(15, CGRectGetMaxY(commitBtn.frame)+15, SCREEN_WIDTH-30, 16) ;
        [_rTableFootView addSubview:descLabe];
        
        
        
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
