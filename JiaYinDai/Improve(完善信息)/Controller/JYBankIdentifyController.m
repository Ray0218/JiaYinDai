//
//  JYBankIdentifyController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/17.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYBankIdentifyController.h"
#import "JYLogInCell.h"
#import "JYPasswordCell.h"
#import "JYSupportBankController.h"
#import "JYMediaPhotoHelper.h"
#import "JYActionSheet.h"
#import "LLPaySdk.h"
#import "JYLLPayMamager.h"
#import "JYHTTPRequestSerializer.h"

@interface JYBankIdentifyController ()<UITableViewDelegate,UITableViewDataSource,LLPaySdkDelegate,UITextFieldDelegate>{
    
    JYIdentifyType rHeaderType ;
}

@property (nonatomic ,strong) UITableView *rTableView ;
@property (nonatomic ,strong) JYLogFootView *rTableFootView ;
@property (nonatomic ,strong) JYIdentifyHeader *rTableHeaderView ;

@property(nonatomic ,strong) UITextField *rFirstTextField ;
@property(nonatomic ,strong) UITextField *rSecondTextField ;



@property (nonatomic ,strong) NSString *rPositivePic ;
@property (nonatomic ,strong) NSString *rOppsitePic ;
@property (nonatomic ,strong) NSString *rHoldPic ;


@property (nonnull ,strong) JYBankModel *rBankModel ;

@property (nonnull ,strong) NSArray *rCellModelArray ;




@end

@implementation JYBankIdentifyController

- (instancetype)initWithHeaderType:(JYIdentifyType)type
{
    self = [super init];
    if (self) {
        rHeaderType = type ;
    }
    return self;
}


-(void)viewDidAppear:(BOOL)animated  {
    [super viewDidAppear:animated];
    
    @weakify(self)
    [[self rac_signalForSelector:@selector(textFieldShouldReturn:)  fromProtocol:@protocol(UITextFieldDelegate)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self)
        if (tuple.first == self.rFirstTextField)
        {
            [self.rSecondTextField becomeFirstResponder];
            
        };
    }];
    
    self.rFirstTextField.delegate = self ;
    
    
    if (rHeaderType == JYIdentifyTypeName) {
        
        self.rSecondTextField.keyboardType = UIKeyboardTypeAlphabet ;
        
        self.rFirstTextField.rMaxLength = 8 ; //姓名小于8位
        
        [[self.rFirstTextField rac_signalForControlEvents:UIControlEventEditingChanged]subscribeNext:^(UITextField *x) {
            
            [self.rFirstTextField jy_nametextViewEditChanged] ;
        }] ;
        
        [[self.rSecondTextField.rac_textSignal filter:^BOOL(NSString* value) { ////身份证号 18位
            
            return value.length > 18 ;
            
        }]subscribeNext:^(NSString* x) {
            
            self.rSecondTextField.text = [x substringToIndex:18] ;
            
        }] ;
        
        JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
        if (user.realName.length) {
            self.rFirstTextField.text = user.realName ;
            self.rSecondTextField.text = user.idcard ;
        }
        
    }else if(rHeaderType == JYIdentifyTypeNameOnly){
        JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
        
        
        self.rFirstTextField.text = user.realName ;
        self.rSecondTextField.text = user.idcard ;
        
        self.rFirstTextField.enabled = self.rSecondTextField.enabled = NO ;
        
    } else{
        
        self.rFirstTextField.keyboardType = self.rSecondTextField.keyboardType = UIKeyboardTypeNumberPad ;
    }
    
    
    if (rHeaderType == JYIdentifyTypePassword) { //交易密码6位
        
        
        [[ self.rFirstTextField.rac_textSignal filter:^BOOL(NSString* value) {
            return value.length > 6 ;
        }]subscribeNext:^(NSString* x) {
            self.rFirstTextField.text = [x substringToIndex:6] ;
        }] ;
        
        [[ self.rSecondTextField.rac_textSignal filter:^BOOL(NSString* value) {
            return value.length > 6 ;
        }]subscribeNext:^(NSString* x) {
            self.rSecondTextField.text = [x substringToIndex:6] ;
        }] ;
        
    }
    
    
    [[RACSignal  combineLatest:@[
                                 self.rFirstTextField.rac_textSignal,
                                 self.rSecondTextField.rac_textSignal,
                                 ]
                        reduce:^(NSString *username,NSString *password) {
                            return @(username.length && password.length );
                        }] subscribeNext:^(NSNumber* x) {
                            
                            self.rTableFootView.rCommitBtn.enabled = [x boolValue] ;
                        }];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"银行卡认证" ;
    
    if (rHeaderType == JYIdentifyTypeName || rHeaderType == JYIdentifyTypeNameOnly) {
        
        self.title = @"实名认证" ;
        
        self.rCellModelArray = @[[[JYPasswordSetModel alloc] initWithTitle:@"姓名" fieldText:@"" placeHolder:@"输入本人姓名" hasCode:NO],[[JYPasswordSetModel alloc] initWithTitle:@"身份证" fieldText:@"" placeHolder:@"输入本人身份证号" hasCode:NO]] ;
    }else  if (rHeaderType == JYIdentifyTypeBank) {
        self.title = @"银行卡认证" ;
        
        
        self.rCellModelArray = @[[[JYPasswordSetModel alloc] initWithTitle:@"银行卡" fieldText:@"" placeHolder:@"请选择借记卡（储蓄卡）" hasCode:NO],[[JYPasswordSetModel alloc] initWithTitle:@"卡号" fieldText:@"" placeHolder:@"输入卡号" hasCode:NO]] ;
        
    }else{
        self.title = @"设置交易密码" ;
        
        self.rCellModelArray = @[ [[JYPasswordSetModel alloc] initWithTitle:@"交易密码" fieldText:@"" placeHolder:@"设置6位数字交易密码" hasCode:NO], [[JYPasswordSetModel alloc] initWithTitle:@"确认交易密码" fieldText:@"" placeHolder:@"再次输入交易密码" hasCode:NO]] ;
        
    }
    
    
    [self buildSubViewUI];
    
    if (rHeaderType == JYIdentifyTypeName) {
        [self afn_loadCardImage:0] ;
        [self afn_loadCardImage:1] ;
        [self afn_loadCardImage:2] ;

    }
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
    
    
    return 1 ;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (rHeaderType == JYIdentifyTypeBank) {
        
        if (  indexPath.row == 0) {
            static NSString *identifier = @"identifierArrow" ;
            
            JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
            
            if (cell  == nil) {
                
                cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeArrow reuseIdentifier:identifier ];
                self.rFirstTextField = cell.rTextField ;
            }
            
            [cell setDataModel:self.rCellModelArray[0]] ;
            
            return cell ;
            
        }
        
        
    }
    
    if (rHeaderType == JYIdentifyTypePassword) {
        static NSString *identifier = @"identifierEye" ;
        
        JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeEye reuseIdentifier:identifier maxWidth:120];
            
            [[cell.rTextField rac_signalForControlEvents:UIControlEventEditingDidEnd]subscribeNext:^(UITextField* textField) {
                
                
                NSInteger rowIndex = textField.tag -1000 ;
                
                JYPasswordSetModel *mode = self.rCellModelArray[rowIndex] ;
                
                mode.rTFTitle = textField.text ;
                
                
            }] ;
        }
        
        
        cell.rTextField.tag = 1000 + indexPath.row ;
        
        [cell setDataModel:self.rCellModelArray[indexPath.row] ];
        
        if (indexPath.row == 0) {
            self.rFirstTextField = cell.rTextField ;
        }else{
            self.rSecondTextField = cell.rTextField ;
        }
        
        return cell ;
    }
    
    
    static NSString *identifier = @"identifierNormal" ;
    
    JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeNormal reuseIdentifier:identifier ];
        
        [[cell.rTextField rac_signalForControlEvents:UIControlEventEditingDidEnd]subscribeNext:^(UITextField* textField) {
            
            
            NSInteger rowIndex = textField.tag -1000 ;
            
            JYPasswordSetModel *mode = self.rCellModelArray[rowIndex] ;
            
            mode.rTFTitle = textField.text ;
            
            
        }] ;
        
    }
    
    cell.rTextField.tag = indexPath.row + 1000 ;
    
    [cell setDataModel:self.rCellModelArray[indexPath.row]] ;
    
    if (rHeaderType == JYIdentifyTypeName || rHeaderType == JYIdentifyTypeNameOnly) {
        if (indexPath.row == 0) {
            self.rFirstTextField = cell.rTextField ;
            
        }else{
            self.rSecondTextField = cell.rTextField ;
            
        }
    }else{
        
        
        self.rSecondTextField = cell.rTextField ;
        
    }
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    __block JYPasswordCell *cell = [self.rTableView cellForRowAtIndexPath:indexPath] ;
    
    if (cell.rCellType != JYPassCellTypeArrow) {
        return ;
    }
    
    __block JYPasswordSetModel *pasModel = self.rCellModelArray[indexPath.row] ;
    
    JYSupportBankController *vc = [[JYSupportBankController alloc]init];
    @weakify(self)
    vc.rSelectBlock = ^(JYBankModel *model) {
        @strongify(self)
        
        pasModel.rTFTitle =
        cell.rTextField.text = model.bankName ;
        self.rBankModel = model ;
    } ;
    [self.navigationController pushViewController:vc animated:YES] ;
    
    
}



#pragma mark -action

-(void)afn_loadCardImage:(NSInteger)type  {
 
    [[AFHTTPSessionManager jy_sharedManager]POST:kGetCardImageURL parameters:@{@"type":@(type)} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *imageUrl = responseObject[@"imageUrl"] ;
        
        if (imageUrl.length) {
            
            JYAddImgView *imageView = self.rTableHeaderView.rImageArray[type] ;
            
            if (type == 0) {
                self.rPositivePic = imageUrl ;
                [imageView.rImageView  sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"ident_front"]] ;
            }else if (type == 1){
                self.rOppsitePic = imageUrl ;
                [imageView.rImageView  sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"ident_back"]] ;
                
            }else{
                self.rHoldPic = imageUrl ;
                [imageView.rImageView  sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"ident_half"]] ;
                
            }
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
}

-(void)pvt_addImage:(JYAddImgView*)imageView {
    
    
    [self.view endEditing:YES];
    
    NSInteger rSelectIndex = imageView.tag - 1000 ;
    
    
    // 照片选择
    JYActionSheet *actionSheet = [[JYActionSheet alloc] initWithCancelStr:@"取消" otherButtonTitles:@[ @"拍照上传", @"本地上传" ] AttachTitle:@""];
    [actionSheet ChangeTitleColor:kBlackColor AndIndex:1];
    [actionSheet ButtonIndex:^(NSInteger Buttonindex) {
        
        switch (Buttonindex) {
            case 1: {
                [[JYMediaPhotoHelper shareInstance] getPhotoByICLibry:self SourcType:EIMediaPhotoType_Camera mediaphotoSuccessFn:^(UIImage *resultImage) {
                    
                    
                    imageView.rImageView.image = resultImage ;
                    
                    
                    [self pvt_uploadImage:resultImage index:rSelectIndex] ;
                    
                    
                }  mediaphotoFailedFn:^(NSError *error){
                    
                }];
            } break;
                
            case 2: {
                [[JYMediaPhotoHelper shareInstance] getPhotoByICLibry:self SourcType:EIMediaPhotoType_Album mediaphotoSuccessFn:^(UIImage *resultImage) {
                    
                    imageView.rImageView.image = resultImage ;
                    
                    [self pvt_uploadImage:resultImage index:rSelectIndex] ;
                    
                } mediaphotoFailedFn:^(NSError *error){
                    
                }];
                
            } break;
                
            default:
                break;
        }
        
    }];
    
    
    
    
    
}



-(void)pvt_uploadImage:(UIImage*)image index:(NSInteger) index {
    
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.6) ;
    
    NSString *dataStr = [NSString stringWithFormat:@"base64,%@", [imageData base64EncodedStringWithOptions:0]];
    
    NSString *imageName = @"ddd.jpg" ;// [[JYDateFormatter shareFormatter]jy_getCurrentDateString] ;
    
    NSMutableDictionary *dic  =[ NSMutableDictionary dictionary];
    [dic setValue:@(index) forKey:@"type"] ;
    [dic setValue:dataStr forKey:@"files"] ;
    [dic setValue:imageName forKey:@"filename"] ;
    
    [JYProgressManager showWaitingWithTitle:@"图片上传中..." inView:self.view] ;
    
    
    @weakify(self)
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kUploadPicURL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [JYProgressManager hideAlert] ;
        @strongify(self)
        
        NSString *imageUrl = responseObject[@"filename"] ;
        if (index == 0) {
            self.rPositivePic = imageUrl ;
        }else if (index == 1){
            self.rOppsitePic = imageUrl ;
        }else{
            self.rHoldPic = imageUrl ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
}

-(void)pvt_checkIdNum {
    
    if (![self.rSecondTextField.text jy_stringCheckIDCard]) {
        [JYProgressManager showBriefAlert:@"身份证号码错误！"] ;
        return ;
    }
    
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kIdCardIdentifyURL parameters:@{@"idcard":self.rSecondTextField.text} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self pvt_identifyName] ;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
    
}


-(void)pvt_identifyName { //实名
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
    [dic setValue:self.rFirstTextField.text forKey:@"realName"] ;
    [dic setValue:self.rSecondTextField.text forKey:@"idCard"] ;
    [dic setValue:self.rPositivePic forKey:@"positivePic"] ; //身份证正面照片
    [dic setValue:self.rOppsitePic forKey:@"oppositePic"] ; //身份证反面照片链接
    [dic setValue:self.rHoldPic forKey:@"holdPic"] ; //	手持身份证照片
    
    
    if (self.rPositivePic.length <= 0) {
        [JYProgressManager showBriefAlert:@"请上传身份证正面照"] ;
        return ;
    }
    
    if (self.rOppsitePic.length <= 0) {
        [JYProgressManager showBriefAlert:@"请上传身份证反面照"] ;
        return ;
    }
    
    if (self.rHoldPic.length <= 0) {
        [JYProgressManager showBriefAlert:@"请上传持证半身照"] ;
        return ;
    }
    
    
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kRealNameIdentyfyURL parameters:dic  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSDictionary *dic = responseObject[@"data"][@"customer"] ;
        
        JYUserModel *mode = [JYSingtonCenter shareCenter].rUserModel ;
        
        [mode mergeFromDictionary:dic useKeyMapping:NO error:nil];
        
        
        if (rHeaderType == JYIdentifyTypeNameOnly) {
            [JYProgressManager showBriefAlert:@"实名认证成功!"] ;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kShowTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
                
            });
            
        }else{
            
            JYBankIdentifyController *vc = [[JYBankIdentifyController alloc]initWithHeaderType:JYIdentifyTypeBank] ;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
    
}

-(void)pvt_checkBankNum {
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
    
    [dic setValue:self.rSecondTextField.text  forKey:@"cardNO"] ;
    [dic setValue:self.rBankModel.bankNo forKey:@"bankNO"] ;
    
    [dic setValue:self.rBankModel.bankName forKey:@"bankName"] ;
    
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kBankCardVertifyURL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        [self pvt_getBankcardbindlist] ;
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
    
}

-(void)pvt_getBankcardbindlist {
    
    
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kBankBinListURL parameters:@{@"cardNo":self.rSecondTextField.text} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSArray *agreementList = responseObject[@"data"] ;
        
        if (agreementList.count) {
            
            NSDictionary *dic = [agreementList firstObject];
            
            [self submitPayResult:dic];
            
        }else{
            
            [self pvt_identifyBank] ;
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
    
    
}


-(void)pvt_identifyBank { //银行卡认证
    
    
    [[LLPaySdk sharedSdk] setSdkDelegate:self] ;
    
    
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
    
    
    NSDictionary *resultDic = [JYLLPayMamager jyBankServiceWithUserName:user.realName  userIdNO:user.idcard bankCardNO:self.rSecondTextField.text sig:kPay_md5_key] ;
    
    [[LLPaySdk sharedSdk] presentLLPaySignInViewController: self withPayType:LLPayTypeInstalments
                                             andTraderInfo:resultDic] ;
    
    
}

#pragma -mark 支付结果 LLPaySdkDelegate
-(void)paymentEnd:(LLPayResult)resultCode withResultDic:(NSDictionary *)dic{
    NSLog(@"绑卡结果==dic======%@",dic);
    NSString *msg = @"";
    
    //  NSString *code = @"";
    switch (resultCode) {
        case kLLPayResultSuccess:
        {
            // 返回充值结果
            [self submitPayResult:dic];
        }
            break;
        case kLLPayResultFail:
        {
            msg = @"支付失败";
        }
            break;
        case kLLPayResultCancel:
        {
            msg = @"支付取消";
        }
            break;
        case kLLPayResultInitError:
        {
            msg = @"sdk初始化异常";
        }
            break;
        case kLLPayResultInitParamError:
        {
            NSLog(@"参数错误==%@",dic[@"rnet_msg"]);
            msg = dic[@"ret_msg"];
            
        }
            break;
        default:
            break;
    }
    if (![msg isEqualToString:@""]) {
        NSLog(@"msg=======%@",msg);
        
        
        [JYProgressManager showBriefAlert:msg] ;
        
    }
}

//返回充值结果///
- (void)submitPayResult:(NSDictionary *)dic {
    NSLog(@"充值支付结果=%@",dic);
    
    
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc]init];
    [paraDic setValue:self.rBankModel.bankNo forKey:@"bankNo"] ;
    [paraDic setValue:dic[@"no_agree"] forKey:@"bindId"] ;
    [paraDic setValue:self.rBankModel.bankName forKey:@"bankName"] ;
    [paraDic setValue:self.rSecondTextField.text forKey:@"cardNo"] ;
    
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kSaveBankCardURL parameters:paraDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        JYBankIdentifyController *vc = [[JYBankIdentifyController alloc]initWithHeaderType:JYIdentifyTypePassword] ;
        
        [self.navigationController pushViewController:vc animated:YES] ;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
    
}


-(void)pvt_identifyTradePassword{ //验证交易密码
    
    
    
    if (self.rFirstTextField.text.length < 6) {
        
        [JYProgressManager showBriefAlert:@"请设置6位数字交易密码"] ;
        
        return ;
    }
    
    
    if (![self.rFirstTextField.text isEqualToString:self.rSecondTextField.text]) {
        
        [JYProgressManager showBriefAlert:@"新密码输入不一致！请重新输入。"];
        
        return ;
    }
    
    
    @weakify(self)
    [[AFHTTPSessionManager jy_sharedManager]POST:kTradePassIndentifyURL parameters:@{@"tradePassword":self.rFirstTextField.text} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @strongify(self)
        [JYProgressManager showBriefAlert:@"设置交易密码成功"] ;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kShowTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            NSArray *views = [self.navigationController viewControllers] ;
            
            
            [views enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIViewController *control = (UIViewController*)obj ;
                
                if (![control isKindOfClass:[JYBankIdentifyController class]]) {
                    
                    [self.navigationController popToViewController:control animated:YES];
                    
                    *stop = YES ;
                }
            }] ;
            
            
        });
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
    
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
        _rTableView.sectionFooterHeight = 15 ;
        _rTableView.separatorInset = UIEdgeInsetsZero  ;
        _rTableView.tableFooterView = self.rTableFootView ;
        _rTableView.tableHeaderView = self.rTableHeaderView ;
        
    }
    return _rTableView ;
}


-(JYLogFootView*)rTableFootView {
    
    if (_rTableFootView == nil) {
        _rTableFootView = [[JYLogFootView alloc]initWithType:JYLogFootViewTypeGetBackPass] ;
        if (rHeaderType == JYIdentifyTypePassword) {
            [_rTableFootView.rCommitBtn setTitle:@"确认" forState:UIControlStateNormal] ;
            
        }else if (rHeaderType == JYIdentifyTypeNameOnly){
            
            [_rTableFootView.rCommitBtn setTitle:@"提交" forState:UIControlStateNormal] ;
            
            
        } else{
            [_rTableFootView.rCommitBtn setTitle:@"下一步" forState:UIControlStateNormal] ;
        }
        _rTableFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80) ;
        [[_rTableFootView.rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            
            if (rHeaderType == JYIdentifyTypeName ) {
                
                [self pvt_checkIdNum] ;
                
            }else if ( rHeaderType == JYIdentifyTypeNameOnly) { //补录
                
                [self pvt_identifyName] ;
                
            }else if (rHeaderType == JYIdentifyTypeBank){
                
                [self pvt_checkBankNum];
                
            }else{
                [self pvt_identifyTradePassword] ;
                
            }
            
            
        }] ;
    }
    
    return _rTableFootView ;
}


-(JYIdentifyHeader*)rTableHeaderView {
    if (_rTableHeaderView == nil) {
        if (rHeaderType == JYIdentifyTypeName) {
            _rTableHeaderView = [[JYIdentifyHeader alloc]initWithType:JYIdentifyTypeName];
            
            _rTableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 180+kImageHeigh) ;
            
            @weakify(self)
            _rTableHeaderView.rAddImageBlock = ^(JYAddImgView *addImageView) {
                
                @strongify(self)
                [self pvt_addImage:addImageView] ;
            } ;
            
            
        }else  if (rHeaderType == JYIdentifyTypeNameOnly) {
            _rTableHeaderView = [[JYIdentifyHeader alloc]initWithType:JYIdentifyTypeNameOnly];
            
            _rTableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100+kImageHeigh) ;
            
            @weakify(self)
            _rTableHeaderView.rAddImageBlock = ^(JYAddImgView *addImageView) {
                
                @strongify(self)
                [self pvt_addImage:addImageView] ;
            } ;
            
            
        }   else if(rHeaderType == JYIdentifyTypeBank){
            _rTableHeaderView = [[JYIdentifyHeader alloc]initWithType:JYIdentifyTypeBank];
            
            _rTableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120) ;
            
        }else{
            _rTableHeaderView = [[JYIdentifyHeader alloc]initWithType:JYIdentifyTypePassword];
            _rTableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120) ;
            
            
        }
        
        _rTableHeaderView.backgroundColor = kBackGroundColor ;
    }
    
    return _rTableHeaderView ;
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
