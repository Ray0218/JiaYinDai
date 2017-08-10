//
//  JYPersonViewController.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/23.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPersonViewController.h"
#import "JYPersonCell.h"
#import "JYPersonHeaderView.h"
#import "JYPersonInfoVC.h"
#import "JYImproveInfoController.h"
#import "JYLoanApplyController.h"
#import "JYBillViewController.h"
#import "JYBankCardController.h"
#import "JYBalanceController.h"
#import "JYInviteController.h"
#import "JYRedCardController.h"
#import "JYBMoreViewController.h"
#import "JYActionController.h"
#import "JYLogInViewController.h"
#import "JYBankIdentifyController.h"



@interface JYPersonViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *rDataArray ;
}

@property(nonatomic ,strong) UITableView *rTableView ;

@property(nonatomic ,strong) JYPersonHeaderView *rTableHeaderView ;


@property(nonatomic ,strong) NSMutableArray *rGuidImges ; ;


@end


@implementation JYPersonViewController

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated] ;
    
    [self pvt_refreshUserInfo];
    
    
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel;
    if (user) {
        
        [self pvt_loadData] ;
        
        [self pvt_addGuidView] ;
        
    }else{
        
        
        [[JYSingtonCenter shareCenter]pvt_autoLoginSuccess:^{
            
             [self pvt_addGuidView] ;
            
            
        } failure:^{
            
            [self pvt_logIn];
            
        }] ;
        
        
    }
    
    
    
}

-(void)pvt_addGuidView {
    
    [self.rGuidImges  addObjectsFromArray:@[@"gui_bill" , @"gui_identify" ,@"gui_red"]] ;
    
    
    UIBarButtonItem *rightItem = [self.navigationItem.rightBarButtonItems lastObject];
    UIView *rightView = rightItem.customView ;
    
    [self pvt_addGuideView:self.rGuidImges[0] View:rightView Position:JYMaskPositionTopRight] ;
    
    
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"gui_bill"] ;
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
}

-(void)pvt_dismissGuideView:(UIGestureRecognizer *)gesture {
    if (self.rGuidImges.count) {
        
        [self.rGuidImges removeObjectAtIndex:0] ;
    }
    
    [super pvt_dismissGuideView:gesture];
    
    
    if (self.rGuidImges.count) {
        
        NSString *imasName = self.rGuidImges[0] ;
        
        if ([imasName isEqualToString:@"gui_identify"]) {
            [self pvt_addGuideView:self.rGuidImges[0] View:self.rTableHeaderView.rFinishButton Position:JYMaskPositionTopCenter] ;
        }else{
            
            
            JYPersonCell *cell = [self.rTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]] ;
            
            
            [self pvt_addGuideView:self.rGuidImges[0] View:cell Position:JYMaskPositionTopCenter] ;
            
            
        }
        
        
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItems = nil ;
    
    self.rGuidImges = [NSMutableArray array] ;
    
    
    rDataArray = @[
                   @[
                       @{  keyTitle    : @"借款申请记录",
                           keyImage    : @"per_record",
                           },
                       @{  keyTitle    : @"我的福利",
                           keyImage    : @"per_welf",
                           }
                       ],
                   @[
                       @{  keyTitle    : @"邀请好友",
                           keyImage    : @"per_friend",
                           },
                       //                       @{  keyTitle    : @"人人推（赚佣金）",
                       //                           keyImage    : @"per_recommend",
                       //                           },
                       @{  keyTitle    : @"活动中心",
                           keyImage    : @"per_active",
                           }
                       ],
                   @[ @{  keyTitle    : @"更多",
                          keyImage    : @"per_more",
                          }
                      ],
                   ] ;
    
    [self buildSubViewUI];
}

-(void)pvt_loadData {
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kGetUserInfoURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
        
        
        NSArray *bankArr = responseObject[@"bankList"] ;
        NSArray *bankmModelArr = [JYBankModel arrayOfModelsFromDictionaries:bankArr error:nil] ;
        
        [user.rBankModelArr removeAllObjects];
        
        [user.rBankModelArr addObjectsFromArray:bankmModelArr] ;
        
        [user mergeFromDictionary:responseObject[@"customer"] useKeyMapping:NO error:nil] ;
        
         [self pvt_refreshUserInfo];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
}

-(void)pvt_logIn {
    
    JYLogInViewController *logVC =[[JYLogInViewController alloc]initWithLogType:JYLogFootViewTypeLogIn];
    UINavigationController *nvc =[[UINavigationController alloc]initWithRootViewController:logVC] ;
    
    [self presentViewController:nvc animated:YES completion:^{
    }] ;
    
}

-(void)pvt_refreshUserInfo {
    
    
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
    
    if (!user) {
        return ;
    }
    
    self.rTableHeaderView.rUserNameLabel.text = user.realName ;
    
    NSString *nameStr = user.realName ;
    
    if (user.realName.length) {
        
        nameStr = [user.realName  stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"*"];
    }
    self.rTableHeaderView.rUserNameLabel.text = nameStr ;
    
    
    if (user.cellphone.length > 8) {
        self.rTableHeaderView.rUserTelLabel.text =  [user.cellphone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"] ;
    }
    if ([user.auditStatus isEqualToString:@"1"]) {
        [self.rTableHeaderView.rFinishButton setTitle:@"已完成" forState:UIControlStateNormal];
    }else if([user.auditStatus isEqualToString:@"2"]){
        [self.rTableHeaderView.rFinishButton setTitle:@"去补录" forState:UIControlStateNormal];
        
    } else{
        [self.rTableHeaderView.rFinishButton setTitle:@"未完成" forState:UIControlStateNormal];
        
    }
    
    NSMutableAttributedString *bankStr = TTFormateNumString([NSString stringWithFormat:@"%zd张",user.rBankModelArr.count] , 15, 10, 1) ;
    
    
    [bankStr addAttribute:NSForegroundColorAttributeName value:kBlueColor range:NSMakeRange(0, bankStr.length)];
    
    self.rTableHeaderView.rBankCardLabel.attributedText = bankStr ;
    
    
    
    NSMutableAttributedString *moneyStr = TTFormateNumString([NSString stringWithFormat:@"%.2f元",[user.fundInfo.currentAmount doubleValue]], 15, 10, 1) ;
    
    
    [moneyStr addAttribute:NSForegroundColorAttributeName value:kBlueColor range:NSMakeRange(0, moneyStr.length)];
    
    
    self.rTableHeaderView.rMoneyLabel.attributedText = moneyStr ;
    
    [self.rTableHeaderView.rHeaderImg  sd_setImageWithURL:[NSURL URLWithString:user.headImage]  placeholderImage:[UIImage imageNamed:@"per_header"]] ;
    
}


#pragma mark - builUI
-(void)buildSubViewUI {
    
    [self setNavRightButtonWithImage:[UIImage imageNamed:@"per_mess"] title:@""] ;
    
    
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }];
    
}

#pragma mark- UITableViewDataSource/UITableViewDelegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return rDataArray.count ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [rDataArray[section] count] ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *identifier = @"identifierLogin" ;
    
    JYPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPersonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSDictionary *dic = rDataArray[indexPath.section][indexPath.row] ;
    [cell rSetCellDtaWithDictionary:dic];
    
    return cell ;
    
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    static NSString *headerIdentifier = @"headerIdentifier" ;
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
        headerView.contentView.backgroundColor = [UIColor clearColor];
    }
    
    return headerView ;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            JYLoanApplyController *recordVC = [[JYLoanApplyController alloc]init];
            [self.navigationController pushViewController:recordVC animated:YES];
        }else if (indexPath.row == 1) {
            
            JYRedCardController *vc = [[JYRedCardController alloc]initWithType:JYRedCardTypeBoth] ;
            vc.rClickNotBack = YES ;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            JYInviteController *InviteFriendsVC = [[JYInviteController alloc]init];
            [self.navigationController pushViewController:InviteFriendsVC animated:YES];
        }else if (indexPath.row == 1){
            
            JYActionController *vc = [[JYActionController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else if (indexPath.section == 2){
        JYBMoreViewController *moreVC = [[JYBMoreViewController alloc]init];
        [self.navigationController pushViewController:moreVC animated:YES];
        
    }
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.f;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

#pragma mark- action

-(void)gotToIdentify {
    
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
    
    NSArray *auditItem = [user.auditItem componentsSeparatedByString:@","] ;
    
    if ([auditItem containsObject:@"1B"]){
        JYBankIdentifyController *identifyVC = [[JYBankIdentifyController  alloc]initWithHeaderType:JYIdentifyTypePassword] ;
        [self.navigationController pushViewController:identifyVC animated:YES];
        
    }else if ([auditItem containsObject:@"1A"]){
        JYBankIdentifyController *identifyVC = [[JYBankIdentifyController  alloc]initWithHeaderType:JYIdentifyTypeBank] ;
        [self.navigationController pushViewController:identifyVC animated:YES];
        
    }else{
        
        JYBankIdentifyController *identifyVC = [[JYBankIdentifyController  alloc]initWithHeaderType:JYIdentifyTypeName] ;
        [self.navigationController pushViewController:identifyVC animated:YES];
    }
    
    
    
}


-(void)pvt_clickButtonNavRight {
    
    JYBillViewController *vc = [[JYBillViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)pvt_endRefresh {
    [self.rTableView.header endRefreshing];
}

#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _rTableView.backgroundColor = kBackGroundColor ;
        
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        
        _rTableView.rowHeight = 44;
        _rTableView.tableHeaderView = self.rTableHeaderView ;
        _rTableView.tableFooterView = [UIView new] ;
        
        _rTableView.separatorInset = UIEdgeInsetsZero ;
        
        @weakify(self)
        [_rTableView addLegendHeaderWithRefreshingBlock:^{
            @strongify(self)
            [self pvt_loadData] ;
            
        }] ;
        
    }
    return _rTableView ;
}

-(JYPersonHeaderView*)rTableHeaderView {
    
    if (_rTableHeaderView == nil) {
        _rTableHeaderView = [[JYPersonHeaderView alloc]init];
        _rTableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 175);
        
        @weakify(self)
        [[_rTableHeaderView.rMiddleButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            JYPersonInfoVC *info = [[JYPersonInfoVC alloc]init];
            [self.navigationController pushViewController:info animated:YES];
            
        }] ;
        
        
        [[_rTableHeaderView.rFinishButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            
            JYImproveInfoController *vc = [[JYImproveInfoController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }] ;
        
        [[_rTableHeaderView.rMoneyButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            
            
            
            JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
            
            NSArray *auditItem = [user.auditItem componentsSeparatedByString:@","] ;
            
            if ([auditItem containsObject:@"1"]) {
                
                JYBalanceController *vc = [[JYBalanceController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                
            } else{
                
                [self gotToIdentify];
            }
            
            
        }] ;
        
        [[_rTableHeaderView.rBankCardButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            
            JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
            
            NSArray *auditItem = [user.auditItem componentsSeparatedByString:@","] ;
            
            if ([auditItem containsObject:@"1"]) {
                
                JYBankCardController *vc = [[JYBankCardController alloc]initWithType:JYBankCardVCTypeManager];
                [self.navigationController pushViewController:vc animated:YES];
                
            } else{
                
                [self gotToIdentify];
            }
            
            
        }] ;
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
