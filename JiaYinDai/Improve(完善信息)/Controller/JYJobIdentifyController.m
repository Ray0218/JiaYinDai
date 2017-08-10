//
//  JYJobIdentifyController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/19.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYJobIdentifyController.h"
#import "JYLogInCell.h"
#import "JYPasswordCell.h"
#import "JYPickerView.h"
#import "JYImageAddController.h"
#import "AddressViewController.h"



@interface JYJobIdentifyController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *rTableView ;

@property (nonatomic ,strong) JYLogFootView *rTableFootView ;

@property (nonatomic ,strong)NSArray *rDataArray ;

@property (nonatomic ,strong) JYPickerView *rPickerView ;





@property (nonatomic ,strong) UITextField *rIncomeTextField ;
@property (nonatomic ,strong) UITextField *rWorkUitTextField ;
@property (nonatomic ,strong) UITextField *rPhoneTextField ;
@property (nonatomic ,strong) UITextField *rAddressTextField ;

@property (nonatomic ,strong) UITextField *rAddressDetailTextField ;





@end

@implementation JYJobIdentifyController



-(void)viewDidAppear:(BOOL)animated  {
    [super viewDidAppear:animated];
    
    
    [[RACSignal  combineLatest:@[
                                 self.rIncomeTextField.rac_textSignal,
                                 
                                 self.rWorkUitTextField.rac_textSignal,
                                 self.rPhoneTextField.rac_textSignal,
                                 self.rAddressTextField.rac_textSignal,
                                 self.rAddressDetailTextField.rac_textSignal
                                 ]
                        reduce:^(NSString *rincomeStr,NSString *rworkUnitStr,NSString *rPhoneStr,NSString *rAddressStr,NSString *rAddressDetailStr) {
                            return @(rincomeStr.length && rworkUnitStr.length && rPhoneStr.length && rAddressStr.length && rAddressDetailStr.length );
                        }] subscribeNext:^(NSNumber* x) {
                            
                            self.rTableFootView.rCommitBtn.enabled = [x boolValue] ;
                        }];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"工作信息" ;
    [self initializeTableView];
    
    self.rDataArray = [NSArray arrayWithObjects:
                       @[
                         [[JYPasswordSetModel alloc]initWithTitle:@"每月收入" fieldText:@"" placeHolder:@"请输入月收入金额" hasCode:NO]
                         ],
                       @[
                         [[JYPasswordSetModel alloc]initWithTitle:@"工作单位" fieldText:@"" placeHolder:@"请填写公司名称" hasCode:NO],
                         //                         [[JYPasswordSetModel alloc]initWithTitle:@"单位证明" fieldText:@"" placeHolder:@"上传劳动合同或在职证明" hasCode:NO],
                         [[JYPasswordSetModel alloc]initWithTitle:@"联系电话" fieldText:@"" placeHolder:@"请填写单位座机/前台电话" hasCode:NO],
                         
                         [[JYPasswordSetModel alloc]initWithTitle:@"单位地址" fieldText:@"" placeHolder:@"省份|市|区" hasCode:NO],[[JYPasswordSetModel alloc]initWithTitle:@"详细地址" fieldText:@"" placeHolder:@"详细地址:街道|小区|幢|单元|室" hasCode:NO]
                         
                         ],
                       
                       nil];
    
}


-(void)initializeTableView {
    
    
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }] ;
    
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }];
    
    
}

#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _rTableView.backgroundColor = kBackGroundColor ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        
        _rTableView.estimatedRowHeight = 45 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
        
         
        _rTableView.separatorInset = UIEdgeInsetsZero ;
        _rTableView.tableFooterView = self.rTableFootView ;
    }
    return _rTableView ;
}



#pragma mark- UITableViewDataSource/UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.rDataArray.count ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.rDataArray[section] count] ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JYPasswordSetModel *model = self.rDataArray[indexPath.section][indexPath.row] ;
    
    if (indexPath.section == 0) {
        static NSString *identifier = @"identifierLong" ;
        
        JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeNormal reuseIdentifier:identifier];
            
            self.rIncomeTextField = cell.rTextField ;
            cell.rTextField.keyboardType = UIKeyboardTypeNumberPad ;
            
            [[cell.rTextField rac_signalForControlEvents:UIControlEventEditingDidEnd]subscribeNext:^(UITextField* textField) {
                
                JYPasswordSetModel *mode = self.rDataArray[0][0] ;
                
                mode.rTFTitle = textField.text ;
                
                
            }] ;
            
        }
        
        [cell setDataModel:model] ;
        
        
        return cell ;
    }
    
    if ((indexPath.section == 1 && (  indexPath.row == 2)) ) {
        
        
        static NSString *identifier = @"identifierButton" ;
        
        JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeArrow reuseIdentifier:identifier ];
            cell.rRightArrow.enabled = NO ;
            
            [cell.rRightArrow setImage:[UIImage imageNamed:@"ident_address"] forState:UIControlStateDisabled] ;
            self.rAddressTextField = cell.rTextField ;
        }
        
        
        [cell setDataModel:model] ;
        
        return cell ;
    }
    static NSString *identifier = @"identifierNormal" ;
    
    JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeNormal reuseIdentifier:identifier ];
        
        
        [[cell.rTextField rac_signalForControlEvents:UIControlEventEditingDidEnd]subscribeNext:^(UITextField* textField) {
            
            NSInteger sectonIndex = textField.tag/100 ;
            
            NSInteger rowIndex = textField.tag%10 ;
            
            JYPasswordSetModel *mode = self.rDataArray[sectonIndex][rowIndex] ;
            
            mode.rTFTitle = textField.text ;
            
            
        }] ;
        
    }
    
    cell.rTextField.tag = 100*indexPath.section + indexPath.row ;
    
    
    cell.rTextField.keyboardType = UIKeyboardTypeDefault ;
    
    
    if (indexPath.row == 0) {
        self.rWorkUitTextField = cell.rTextField ;
    }else if (indexPath.row == 1){
        cell.rTextField.keyboardType = UIKeyboardTypeNumberPad ;
        
        self.rPhoneTextField = cell.rTextField ;
    }else if (indexPath.row == 3){
        
        self.rAddressDetailTextField = cell.rTextField ;
    }
    
    
    
    [cell setDataModel:model] ;
    
    
    return cell ;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"%zd --- %zd",indexPath.section,indexPath.row) ;
    
    
    if(indexPath.row == 2){
        __block  JYPasswordSetModel *model = self.rDataArray[indexPath.section][indexPath.row] ;
        
        // 省市区
        AddressViewController *addressVC = [[AddressViewController alloc]initWithAddressType:JYAddressTypeProvince];
        
        @weakify(self)
        addressVC.rSelectBlock = ^(NSString *rAddress) {
            @strongify(self)
            model.rTFTitle = rAddress;
            
            
            [self.rTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone] ;
        } ;
        
        [self.navigationController pushViewController:addressVC animated:YES] ;
        
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.01 ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15 ;
}

#pragma mark- action

-(void)pvt_commit {
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
    
    [dic setValue:self.rIncomeTextField.text forKey:@"income"] ;
    [dic setValue:self.rWorkUitTextField.text forKey:@"workUnit"] ;
    [dic setValue:self.rPhoneTextField.text forKey:@"phone"] ;
    [dic setValue:[NSString stringWithFormat:@"%@%@",self.rAddressTextField.text,self.rAddressDetailTextField.text] forKey:@"address"] ;
    
    [[AFHTTPSessionManager jy_sharedManager] POST:kWorkIdentifyURL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [JYProgressManager showBriefAlert:@"工作信息认证成功"] ;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kShowTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
            
        });
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
}

-(void)pvt_loadData{ //自动登录成功后

    [self pvt_commit];

}


#pragma  mark- getter


//优化

-(JYLogFootView*)rTableFootView {
    if (_rTableFootView == nil) {
        _rTableFootView = [[JYLogFootView alloc]initWithType:JYLogFootViewTypeNormal] ;
        [_rTableFootView.rCommitBtn setTitle:@"提交" forState:UIControlStateNormal] ;
        _rTableFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 140) ;
        
        _rTableFootView.rDescLabel.text = @"请仔细填写，一经提交将不可更改。\n我申明以上信息为本人真实信息。" ;
        
        @ weakify(self)
        [[_rTableFootView.rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            
            @strongify(self)
            [self pvt_commit] ;
            
        }] ;
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
