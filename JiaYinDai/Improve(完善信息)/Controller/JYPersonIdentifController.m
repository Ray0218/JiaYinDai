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
#import <CoreLocation/CoreLocation.h>
#import "AddressViewController.h"
#import "JYAddressBookController.h"




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

<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>{
    
    
    NSArray *rMarrArray ; //婚姻
    NSArray *reduitArray ;//教育
    
    
    
}

@property (nonatomic ,strong) UITableView *rTableView ;
@property (nonatomic ,strong) JYLogFootView *rTableFootView ;
@property (nonatomic ,strong) JYPerIdentifyHeader *rTableHeaderView ;
@property (nonatomic ,strong) JYPickerView *rPickerView ;

@property (nonatomic ,strong)NSArray *rDataArray ;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSMutableDictionary *rDataDic;

@property (nonatomic, strong) NSArray *rKeysArray;



@end

@implementation JYPersonIdentifController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
    
    NSString *nameStr = user.realName ;
    
    if (user.realName.length) {
        
        nameStr = [user.realName  stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"*"];
    }
    
    
    self.rTableHeaderView.rNameLabel.text = [NSString stringWithFormat:@"姓名：%@",nameStr] ;
    
    
    NSString *idCardStr = user.idcard ;
    
    if (user.idcard.length >= 18) {
        idCardStr = [user.idcard stringByReplacingCharactersInRange:NSMakeRange(4, 10) withString:@"**********"] ;
    }
    
    self.rTableHeaderView.rCardIdLabel.text = [NSString stringWithFormat:@"身份证号：%@",idCardStr] ;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"身份认证" ;
    self.rDataDic = [NSMutableDictionary dictionary] ;
    
    
    [[[self.rDataDic rac_signalForSelector:@selector(setValue:forKey:)]map:^id(id value) {
        
        NSArray *allVaues = self.rDataDic.allValues ;
        
        for (NSValue *value in allVaues) {
            
            NSString *valueStr = [NSString stringWithFormat:@"%@",value] ;
            
            
            if (valueStr.length <= 0) {
                return @(0) ;
            }
            
        }
        
        return @(self.rDataDic.count == 14) ;
        
    }] subscribeNext:^(id x) {
        
        self.rTableFootView.rCommitBtn.enabled = [x boolValue] ;
        
    }] ;
    
    
    
    
    [self buildSubViewUI];
    
    
    /*
     
     sex:性别   枚举 只需要传数字上来，1代表男，2代表女
     marriage:婚姻状况 枚举  同上  1.未婚 2.已婚有子女3.已婚无子女4.离异有子女5.离异无子女
     education: 受教育情况 枚举 1. 初中或初中以下 2. 高中（或中专） 3. 专科 4. 本科 5. 硕士研究生或以上
     origin:户籍地址
     address:现住地址
     contact1：联系人1关系   枚举  1. 父亲 2.母亲 3.配偶 4.子女 5.兄弟姐妹
     contact1Name：联系人一姓名
     contact1Phone：联系人一电话号码
     contact2：联系人2关系   枚举  6.同事，7.亲戚朋友
     contact2Name：联系人2姓名
     contact2Phone：联系人2电话号码
     vocation: 职业
     personalProperty：个人资产
     */
    
    self.rKeysArray = [NSArray arrayWithObjects:@[@"sex",@"marriage",@"vocation",@"education",@"personalProperty"] ,@[@"origin",@"address",@"addressDetail"],@[@"contact1",@"contact1Name",@"contact1Phone"],@[@"contact2",@"contact2Name",@"contact2Phone"], nil] ;
    [self initModelData] ;
    
    
    
}

-(void)initModelData {
    
    
    rMarrArray =  @[@"未婚" ,@"已婚有子女", @"已婚无子女", @"离异有子女" ,@"离异无子女"] ;
    reduitArray = @[@"初中或初中以下" ,@"高中（或中专）",@"专科",@"本科",@"硕士研究生或以上"] ;
    
    
    self.rDataArray = [NSArray arrayWithObjects:
                       @[
                         [[JYPasswordSetModel alloc]initWithTitle:@"称谓" fieldText:@"1" placeHolder:@"" hasCode:NO],
                         [[JYPasswordSetModel alloc]initWithTitle:@"婚姻状况" fieldText:@""  placeHolder:@"请选择" hasCode:NO pickerArr: rMarrArray ],
                         [[JYPasswordSetModel alloc]initWithTitle:@"职业" fieldText:@"" placeHolder:@"请选择" hasCode:NO pickerArr:@[@"企业主",@"一般上市公司员工",@"一般单位（私企）员工",@"其他职业"]],
                         
                         [[JYPasswordSetModel alloc]initWithTitle:@"教育程度" fieldText:@"" placeHolder:@"请选择" hasCode:NO pickerArr:reduitArray],
                         [[JYPasswordSetModel alloc]initWithTitle:@"个人资产" fieldText:@"" placeHolder:@"请选择" hasCode:NO pickerArr:@[@"无房无车",@"有车无房",@"有房无车",@"有房有车"]]
                         ],
                       @[
                         [[JYPasswordSetModel alloc]initWithTitle:@"籍贯" fieldText:@"" placeHolder:@"省份|市|区" hasCode:NO],[[JYPasswordSetModel alloc]initWithTitle:@"现居住地" fieldText:@"" placeHolder:@"省份|市|区" hasCode:NO],[[JYPasswordSetModel alloc]initWithTitle:@"详细地址" fieldText:@"" placeHolder:@"详细地址:街道|小区|幢|单元|室" hasCode:NO]
                         ],
                       @[
                         [[JYPasswordSetModel alloc]initWithTitle:@"与您关系" fieldText:@"" placeHolder:@"请选择与紧急联系人的关系" hasCode:NO pickerArr:@[@"父亲",@"母亲",@"配偶",@"子女",@"兄弟姐妹"]],[[JYPasswordSetModel alloc]initWithTitle:@"姓名" fieldText:@"" placeHolder:@"紧急联系人姓名" hasCode:NO],[[JYPasswordSetModel alloc]initWithTitle:@"联系电话" fieldText:@"" placeHolder:@"请选择紧急联系人" hasCode:NO]
                         
                         ],
                       
                       @[
                         [[JYPasswordSetModel alloc]initWithTitle:@"与您关系" fieldText:@"" placeHolder:@"请选择与紧急联系人的关系" hasCode:NO pickerArr:@[@"兄弟姐妹",@"同事",@"亲戚",@"朋友"]],[[JYPasswordSetModel alloc]initWithTitle:@"姓名" fieldText:@"" placeHolder:@"紧急联系人姓名" hasCode:NO],[[JYPasswordSetModel alloc]initWithTitle:@"联系电话" fieldText:@"" placeHolder:@"请选择紧急联系人" hasCode:NO]
                         ], nil];
    
    
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
    
    if ([user.auditStatus isEqualToString:@"2"] && [[user.reAuditItem componentsSeparatedByString:@","] containsObject:@"2"] ) {
        
        JYPasswordSetModel *sexModel = self.rDataArray[0][0] ;
        sexModel.rTFTitle = user.sex ;
        
        
        JYPasswordSetModel *marrModel = self.rDataArray[0][1] ;
        NSInteger marrIndex = [user.marriage integerValue] ;
        marrModel.rTFTitle = rMarrArray[marrIndex] ;
        
        [self.rDataDic setValue:@(marrIndex) forKey:@"marriage"] ;
        
        
        
        JYPasswordSetModel *eduModel = self.rDataArray[0][3] ;
        
        NSInteger eduitIndex = [user.education integerValue] ;
        eduitIndex = MAX(eduitIndex-1, 0) ;
        
        eduModel.rTFTitle = reduitArray[eduitIndex] ;
        
        [self.rDataDic setValue:@(eduitIndex) forKey:@"education"] ;
        
        
        
        
        JYPasswordSetModel *originAddressModel = self.rDataArray[1][0] ;
        originAddressModel.rTFTitle = user.origin ;
        
        [self.rDataDic setValue:user.origin forKey:@"origin"] ;
        
    }
    
    
    
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
            
            
            
            __block JYPasswordSetModel *sexModel = self.rDataArray[0][0] ;
            
            
            [RACObserve(cell.rManButton, selected) subscribeNext:^(id x) {
                NSLog(@"%@",x) ;
                
                if ([x boolValue]) {
                    [self.rDataDic setValue:@"1" forKey:@"sex"] ;
                    
                    sexModel.rTFTitle = @"1" ;
                }
                
            }] ;
            
            
            [RACObserve(cell.rWomenButton, selected) subscribeNext:^(id x) {
                NSLog(@"%@",x) ;
                
                if ([x boolValue]) {
                    [self.rDataDic setValue:@"2" forKey:@"sex"] ;
                    sexModel.rTFTitle = @"2" ;
                    
                }
                
            }] ;
            
            JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
            if ([user.auditStatus isEqualToString:@"2"] && [[user.reAuditItem componentsSeparatedByString:@","] containsObject:@"2"] ) {
                
                if ([model.rTFTitle isEqualToString:@"1"]) {
                    
                    cell.rWomenButton.enabled = NO ;
                    
                }else{
                    cell.rManButton.enabled = NO ;
                }
                
            }
        }
        
        
        [cell setDataModel:model] ;
        
        if ([model.rTFTitle isEqualToString:@"1"]) {
            cell.rManButton.selected = YES ;
        }else{
            cell.rWomenButton.selected = YES ;
        }
        
        
        return cell ;
    }
    
    
    if (indexPath.section == 0 || indexPath.row == 0) {
        static NSString *identifier = @"identifierArrow" ;
        
        JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeArrow reuseIdentifier:identifier ];
            cell.rRightArrow.enabled = NO ;
            
        }
        
        
        [cell setDataModel:model] ;
        
        
        return cell ;
    }
    
    if ((indexPath.section == 2 && indexPath.row == 2) || (indexPath.section == 3 && indexPath.row == 2) || (indexPath.section == 1&& indexPath.row == 1)) {
        
        //    if (indexPath.section == 1&& indexPath.row == 1) {
        
        
        static NSString *identifier = @"identifierArr" ;
        
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
        
        [[cell.rTextField rac_signalForControlEvents:UIControlEventEditingDidEnd]subscribeNext:^(UITextField* textField) {
            NSInteger sectonIndex = textField.tag/100 ;
            
            NSInteger rowIndex = textField.tag%10 ;
            
            JYPasswordSetModel *mode = self.rDataArray[sectonIndex][rowIndex] ;
            
            mode.rTFTitle = textField.text ;
            
            
            NSString *nameKey = self.rKeysArray[sectonIndex][rowIndex] ;
            
            [self.rDataDic setValue:textField.text forKey:nameKey];
            
            
            
        }] ;
        
        
        
    }
    
    if ((indexPath.section == 2 && indexPath.row == 2) || (indexPath.section == 3 && indexPath.row == 2) ) {
        
        cell.rTextField.keyboardType = UIKeyboardTypeNumberPad ;
        
        [[cell.rTextField.rac_textSignal filter:^BOOL(NSString *value) { //手机号
            
            return value.length > 11 ;
            
        }]subscribeNext:^(NSString* x) {
            cell.rTextField.text = [x substringToIndex:11] ;
        }] ;
        
        
    }else{
        
        cell.rTextField.keyboardType = UIKeyboardTypeDefault ;
    }
    
    cell.rTextField.tag = indexPath.section * 100 + indexPath.row ;
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
        return 0.01 ;
    }
    return  15 ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01 ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.rPickerView.hidden = YES ;
    
    
    
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
    
    if ([user.auditStatus isEqualToString:@"2"] && [[user.reAuditItem componentsSeparatedByString:@","] containsObject:@"2"] ) {
        
        
        if (indexPath.section == 0 && (indexPath.row == 1 || indexPath.row == 3)) {
            return ;
        }
        
        if (indexPath.section == 1 && indexPath.row == 0) {
            return ;
        }
        
    }
    
    
    
    
    NSLog(@"%zd --- %zd",indexPath.section,indexPath.row) ;
    
    NSString *keyString = self.rKeysArray[indexPath.section][indexPath.row] ;
    __block JYPasswordSetModel *model = self.rDataArray[indexPath.section][indexPath.row] ;
    
    
    
    self.rPickerView.rDataArray = model.rPickerArray ;
    self.rPickerView.rSelectRow = 0 ;
    
    
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            self.rPickerView.hidden = YES ;
            
        }else{
            
            self.rPickerView.hidden = NO ;
        }
        
    }else if (indexPath.section == 1) {
        self.rPickerView.hidden = YES;
        
        if (indexPath.row == 2) {
            return ;
        }
        
        // 省市区
        AddressViewController *addressVC = [[AddressViewController alloc]initWithAddressType:JYAddressTypeProvince];
        
        @weakify(self)
        addressVC.rSelectBlock = ^(NSString *rAddress) {
            @strongify(self)
            model.rTFTitle = rAddress;
            
            [self.rDataDic setValue:rAddress forKey:self.rKeysArray[indexPath.section][indexPath.row] ];
            
            [self.rTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        } ;
        
        [self.navigationController pushViewController:addressVC animated:YES] ;
        
        
        
    } else if (indexPath.section == 2 || indexPath.section == 3 ){
        
        if ( indexPath.row == 0) {
            
            self.rPickerView.hidden = NO ;
            
            
        } else if (indexPath.row == 2){
            
            
            self.rPickerView.hidden = YES;
            __block JYPasswordSetModel *modelName = self.rDataArray[indexPath.section][indexPath.row - 1] ;
            
            
            
            JYAddressBookController *addressVC = [[JYAddressBookController alloc]init];
            
            addressVC.block = ^(NSString *nameStr ,NSString *telNum) {
                
                
                self.name = nameStr;
                NSString *phoneNO = telNum;
                
                
                modelName.rTFTitle = [NSString stringWithFormat:@"%@",nameStr] ;
                
                model.rTFTitle = [NSString stringWithFormat:@"%@",phoneNO] ;
                
                [self.rDataDic setValue:phoneNO forKey:keyString];
                
                
                NSString *nameKey = self.rKeysArray[indexPath.section][indexPath.row-1] ;
                
                [self.rDataDic setValue:nameStr forKey:nameKey];
                
                
                [self.rTableView reloadRowsAtIndexPaths:@[indexPath,[NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationNone] ;
                
            } ;
            
            
            [self.navigationController pushViewController:addressVC animated:YES];
            
            return ;
            
            
        }
        
    }
    
    
    
    
    @weakify(self)
    self.rPickerView.rSelectBlock = ^(NSString *selectString,NSInteger index) {
        @strongify(self)
        model.rTFTitle = selectString ;
        [self.rTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone] ;
        
        if(indexPath.section == 0){
            
            if (indexPath.row == 1) {
                
                [self.rDataDic setValue:@(index - 1) forKey:keyString];
                
                
            }else if (indexPath.row == 2){
                
                [self.rDataDic setValue:selectString forKey:keyString];
                
            }else{
                [self.rDataDic setValue:@(index) forKey:keyString];
                
            }
            
            
        } else{
            [self.rDataDic setValue:@(index) forKey:keyString];
            
        }
    } ;
}




//
#pragma mark- action

-(void)pvt_commit {
    
    NSError *error = nil;
    
    
    
    
    
    
    NSString *address = self.rDataDic[@"address"] ;
    NSString *detailStr = self.rDataDic[@"addressDetail"] ;
    
    [self.rDataDic setObject:[NSString stringWithFormat:@"%@%@",address,detailStr] forKey:@"address"];
    
    
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.rDataDic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *paramString =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    NSMutableDictionary *dic =[ NSMutableDictionary dictionary] ;
    [dic  setValue:paramString forKey:@"params"] ;
    
    
    
    
    [[AFHTTPSessionManager jy_sharedManager] POST:kRelationShipIdenURL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [JYProgressManager showBriefAlert:@"身份认证成功"] ;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kShowTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES] ;
            
        });
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
}


-(void)pvt_loadData{
    
    [self pvt_commit];
}

#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _rTableView.backgroundColor = kBackGroundColor ;
        _rTableView.estimatedRowHeight = 60 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.separatorInset = UIEdgeInsetsZero ;
        _rTableView.tableFooterView = self.rTableFootView ;
        _rTableView.tableHeaderView = self.rTableHeaderView ;
        
    }
    return _rTableView ;
}


-(JYLogFootView*)rTableFootView {
    
    if (_rTableFootView == nil) {
        _rTableFootView = [[JYLogFootView alloc]initWithType:JYLogFootViewTypeNormal] ;
        [_rTableFootView.rCommitBtn setTitle:@"提交" forState:UIControlStateNormal] ;
        _rTableFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 140) ;
        _rTableFootView.rDescLabel.text = @"请仔细填写，一经提交将不可更改。\n我申明以上信息为本人真实信息。" ;
        _rTableFootView.rCommitBtn.enabled = NO ;
        
        
        @weakify(self)
        [[_rTableFootView.rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            [self pvt_commit];
            
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
