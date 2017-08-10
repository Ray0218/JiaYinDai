//
//  JYImproveInfoController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/17.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYImproveInfoController.h"
#import "JYPersonCell.h"
#import "JYBankIdentifyController.h"
#import "JYPersonIdentifController.h"
#import "JYJobIdentifyController.h"
#import "JYPhoneIndetyfyController.h"
#import "JYGJJIdentifyController.h"
#import "JYWebViewController.h"



@interface JYImproveInfoController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *rDataArray ;
    
}
@property (nonatomic ,strong) UITableView *rTableView ;


@property (nonatomic ,strong) UIButton *rTableFootView ;

@property (nonatomic ,strong) NSString *rAuditStatus ; //是否已经进行过认证   0代表未认证，1代表已认证 ，2代表需要补录


@property (nonatomic ,strong) NSArray *rAuditItem ; //已完成项目

@property (nonatomic ,strong) NSArray *rReAuditItem ;//需要补录的项目

@end


@implementation JYImproveInfoController

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self loadAuditData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"完善信息" ;
    
    rDataArray = @[
                   @{  keyTitle    : @"实名认证",
                       keyImage    : @"imp_user",
                       },
                   @{  keyTitle    : @"身份认证",
                       keyImage    : @"imp_sfz",
                       },
                   @{  keyTitle    : @"工作信息",
                       keyImage    : @"imp_job",
                       },
                   @{  keyTitle    : @"手机验证",
                       keyImage    : @"imp_phone",
                       },
                   @{  keyTitle    : @"芝麻信用授权",
                       keyImage    : @"imp_zhima",
                       },
                   @{  keyTitle    : @"社保查询",
                       keyImage    : @"imp_gjj",
                       },
                   //                                      @{  keyTitle    : @"征信报告（个人版）",
                   //                                          keyImage    : @"imp_zxbg",
                   //                                          }
                   ] ;
    
    [self initializeTableView];
    
}

-(void) loadAuditData {
    
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kAuditItemURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *items = [NSString stringWithFormat:@"%@",responseObject[@"auditItem"] ]; // 认证项用逗号隔开  1代表实名认证过  2身份认证 3工作信息 4手机验证  5芝麻信用  6公积金 7征信报告  然后  还有1A,1B  分别代表实名认证中实名   银行卡  与  交易密码
        NSString *auditStat = [NSString stringWithFormat:@"%@",responseObject[@"auditStatus"]] ; // 是否已经进行过认证   0代表未认证，1代表已认证 ，2代表需要补录
        
        NSString *reAuditItems = [NSString stringWithFormat:@"%@",responseObject[@"reAuditItem"]] ;
        
        self.rAuditStatus = auditStat ;
        
        JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
        user.auditStatus = auditStat ;
        user.auditItem = items ;
        
        self.rAuditItem = [items componentsSeparatedByString:@","] ;
        self.rReAuditItem = [reAuditItems componentsSeparatedByString:@","] ;
        
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
        _rTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _rTableView.backgroundColor = kBackGroundColor ;
        _rTableView.estimatedRowHeight = 45 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.separatorInset = UIEdgeInsetsZero ;
        _rTableView.tableFooterView = self.rTableFootView ;
    }
    return _rTableView ;
}



#pragma mark- UITableViewDataSource/UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return rDataArray.count ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *identifier = @"identifierLogin" ;
    
    JYPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPersonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSDictionary *dic = rDataArray[indexPath.section] ;
    [cell rSetCellDtaWithDictionary:dic];
    
    
    NSString *indexString = [NSString stringWithFormat:@"%zd",indexPath.section+1] ;
    
    if ([self.rAuditStatus isEqualToString:@"1"]) { //已完成
        
        if ([self.rAuditItem containsObject:indexString]) {
            cell.rRightLabel.text = @"已完成" ;
        }else{
            
            if (indexPath.section == 5 || indexPath.section == 6) {
                cell.rRightLabel.text = @"选填" ;
            }else{
                cell.rRightLabel.text = @"未完成(必填)" ;
                
            }
        }
        
        
    }else if ([self.rAuditStatus isEqualToString:@"2"]){ //补录
        
        if ([self.rReAuditItem containsObject:indexString]) {
            
            
            cell.rRightLabel.text = @"需补录" ;
        }else{
            
            if ([self.rAuditItem containsObject:indexString]) {
                
                cell.rRightLabel.text = @"已完成" ;
            }else{
                
                if (indexPath.section == 5 || indexPath.section == 6) {
                    cell.rRightLabel.text = @"选填" ;
                }else{
                    cell.rRightLabel.text = @"未完成(必填)" ;
                    
                }
                
            }
        }
        
        
    } else{
        
        if ([self.rAuditItem containsObject:indexString]) {
            
             cell.rRightLabel.text = @"已完成" ;
        }else{
            
            if (indexPath.section == 5 || indexPath.section == 6) {
                cell.rRightLabel.text = @"选填" ;
            }else{
                cell.rRightLabel.text = @"未完成(必填)" ;
            }
        }
    }
    
    return cell ;
    
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    static NSString *headerIdentifier = @"headerIdentifier" ;
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
        headerView.contentView.backgroundColor = [UIColor clearColor];
        headerView.backgroundView = ({
            UIView *view = [[UIView alloc]init] ;
            view.backgroundColor = [UIColor clearColor] ;
            view ;
        });
    }
    
    return headerView ;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSString *indexString = [NSString stringWithFormat:@"%zd",indexPath.section+1] ;
    
    
    if ([self.rAuditStatus isEqualToString:@"0"] ) { //未完成
        
        if ([self.rAuditItem containsObject:indexString]) {
            
            return ;
        }else {
            
            if (indexPath.section != 0 && ![self.rAuditItem containsObject:@"1"]) {
                
                [JYProgressManager showBriefAlert:@"请先完成实名认证"] ;
                
                return ;
            }
            
        }
    }else if ([self.rAuditStatus isEqualToString:@"1"]){ //已完成
        
        
        if ((indexPath.section == 5 || indexPath.section == 6) && ![self.rAuditItem containsObject:indexString]) {
            
            
        }else{
            
            return ;
        }
        
        
    }else if ([self.rAuditStatus isEqualToString:@"2"]){ //需补录
        
        
        if ([self.rReAuditItem containsObject:indexString]) { //需要补录项
            
        }else{
            
            
            if ((indexPath.section == 5 || indexPath.section == 6) && ![self.rAuditItem containsObject:indexString]) {
                
                
            }else{
                
                return ;
            }
            
            
        }
        
    }
    
    
    
    
    
    if (indexPath.section == 0) {
        
         if ([self.rAuditStatus isEqualToString:@"2"]){ //需补录
            
            JYBankIdentifyController *vc =[[JYBankIdentifyController alloc]initWithHeaderType:JYIdentifyTypeNameOnly];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            
            JYBankIdentifyController *vc =[[JYBankIdentifyController alloc]initWithHeaderType:JYIdentifyTypeName];
            
            if ([self.rAuditItem containsObject:@"1B"]) {
                vc = [[JYBankIdentifyController alloc]initWithHeaderType:JYIdentifyTypePassword];
            }
            
//            else if ([self.rAuditItem containsObject:@"1A"]) {
//                
//                vc  = [[JYBankIdentifyController alloc]initWithHeaderType:JYIdentifyTypeBank];
//                
//            }
            
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else if(indexPath.section == 1){
        
        if ([self.rAuditItem containsObject:@"1"]){ //已完成实名
            JYPersonIdentifController *vc = [[JYPersonIdentifController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else {
            
            JYBankIdentifyController *vc =[[JYBankIdentifyController alloc]initWithHeaderType:JYIdentifyTypeName];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }else if(indexPath.section == 2){
        
        if ([self.rAuditStatus isEqualToString:@"0"] ) { //未完成
            
            if (![self.rAuditItem containsObject:@"2"]) {
                
                [JYProgressManager showBriefAlert:@"请先完成身份认证"] ;
                
                return ;
            }
        }
        
        JYJobIdentifyController *vc= [[JYJobIdentifyController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(indexPath.section == 3){
        
        if ([self.rAuditStatus isEqualToString:@"0"] ) { //未完成
            
            if (![self.rAuditItem containsObject:@"3"]) {
                
                [JYProgressManager showBriefAlert:@"请先完成工作信息"] ;
                
                return ;
            }
        }
        
        if ([self.rAuditItem containsObject:@"1"]){ //已完成实名
            JYPhoneIndetyfyController *vc = [[JYPhoneIndetyfyController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else {
            
            JYBankIdentifyController *vc =[[JYBankIdentifyController alloc]initWithHeaderType:JYIdentifyTypeName];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if(indexPath.section == 4){ //芝麻信用
        
        
        if ([self.rAuditStatus isEqualToString:@"0"] ) { //未完成
            
            if (![self.rAuditItem containsObject:@"4"]) {
                
                [JYProgressManager showBriefAlert:@"请先完成手机验证"] ;
                
                return ;
            }
        }
        
        [[AFHTTPSessionManager jy_sharedManager]POST:kZhimaURL parameters:@{@"state":@"2"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            NSString *str = [NSString stringWithFormat:@"%@", responseObject[@"url"]];
            
            
            JYWebViewController *webVC = [[JYWebViewController alloc]initWithUrl:[NSURL URLWithString:str] ] ;
            
            [self.navigationController pushViewController:webVC animated:NO];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }] ;
        
        
    } else if(indexPath.section == 5){
        JYGJJIdentifyController *vc = [[JYGJJIdentifyController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}


-(UIButton*)rTableFootView {
    
    if (_rTableFootView == nil) {
        _rTableFootView = [UIButton buttonWithType:UIButtonTypeCustom] ;
        
        _rTableFootView.frame = CGRectMake(15, 0, SCREEN_WIDTH-30, 50) ;
        _rTableFootView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
        _rTableFootView.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom ;
        
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:@"完善信息可提高申请通过率，查看《保密协议》" attributes:@{NSForegroundColorAttributeName:kTextBlackColor,NSFontAttributeName:[UIFont systemFontOfSize:14]}] ;
        
        NSRange rang = [attString.string rangeOfString:@"《保密协议》"] ;
        
        [attString addAttribute:NSForegroundColorAttributeName value:kBlueColor range:rang] ;
        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:rang] ;
        
        [_rTableFootView setAttributedTitle:attString forState:UIControlStateNormal ];
        
        @weakify(self)
        [[_rTableFootView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            JYWebViewController *webVC = [[JYWebViewController alloc]initWithUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@/secrecyAgree",kServiceURL ]]] ;
            [self.navigationController pushViewController:webVC animated:YES];
        }] ;
    }
    
    return _rTableFootView ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01 ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15 ;
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
