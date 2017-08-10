//
//  JYLoanViewController.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/23.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoanViewController.h"
#import "JYLoanTableViewCell.h"
#import "JYLoanAlterVC.h"
#import "JYLoanInfoController.h"
#import <SDCycleScrollView.h>
#import "JYMessageVController.h"
#import "JYProductModel.h"
#import "JYDBannerModel.h"
#import "JYLogInViewController.h"
#import "JYWebViewController.h"
#import "JYImproveInfoController.h"
#import "JYWebViewController.h"

#import "JYLoanUsedController.h"
#import "JYNoticeModel.h"
#import "JYMessageVController.h"
#import "JPUSHService.h"




@interface JYLoanFootVew : UIView

@property (nonatomic,strong) UIButton *rCommitBtn ;




@end

@implementation JYLoanFootVew

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self buildSubViewsUI];
        
    }
    return self;
}


-(void)buildSubViewsUI {
    
    [self addSubview:self.rCommitBtn];
    
}

-(void)layoutSubviews {
    [self.rCommitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15) ;
        make.top.equalTo(self).offset(15) ;
        
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(45) ;
    }] ;
    
    
}

-(UIButton*)rCommitBtn {
    if (_rCommitBtn == nil) {
        _rCommitBtn = [self jyCreateButtonWithTitle:@"开始申请"] ;
    }
    return _rCommitBtn ;
}



@end


@interface JYLoanViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,UIAlertViewDelegate>

@property(nonatomic ,strong) UITableView *rTableView ;

@property(nonatomic ,strong) SDCycleScrollView *rTableHeaderView ;


@property(nonatomic ,strong) SDCycleScrollView *rNoticeView ; //公告


@property(nonatomic ,strong) JYLoanFootVew *rTableFootView ;

@property(nonatomic ,strong) UILabel *rTitleLabel ;
@property(nonatomic ,strong) UIView *rTitleView ;
@property (nonatomic ,strong) UIButton *rMessageButton ;

@property (nonatomic,strong) NSMutableArray *rDataArray ;

@property (nonatomic,strong) NSMutableArray *rBannerDataArray ;
@property (nonatomic,strong) NSMutableArray *dataSourceArray;

@property (nonatomic,strong) JYProductModel *rCellModel ;
@property (nonatomic,assign) NSInteger rTimeSelect ;

@property (nonatomic ,strong) UITextField *rTextField ;

@property (nonatomic, strong) JYDBannerModel *bannerModel;


@property (nonatomic,strong) UIView *rTableBgView ;

@property (nonatomic ,strong) NSMutableArray *rNoticeArray ;

@property (nonatomic,strong) UILabel *rPayMoneyLab ; //还款金额


@end


static NSString *rCellTitles[] = {@"每月最低还款（元）",@"此次申请分期（期）",@"借款费用说明"} ;

@implementation JYLoanViewController


-(void)viewDidAppear:(BOOL)animated {
    
    
    [super viewDidAppear:animated];
    
    
    UIViewController *rooVC = [[UIApplication sharedApplication]keyWindow].rootViewController ;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rooVC];
    
    
    if (![currentVC isKindOfClass:[JYWebViewController class]]) {
        
        [self pvt_addGuideView:@"gui_message" View:self.rMessageButton Position:JYMaskPositionTopRight] ;
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"gui_message"] ;
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    
     
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated] ;
    
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    
    [self.rTableHeaderView adjustWhenControllerViewWillAppera] ;
    
    
    
    [self loadData];
    [self loadBannerData];
    
    [self homeCount];
    
    [self getNoticeData];
    
    
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
    if (user) {
        [self afn_getmessageCount] ;
        
    }
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO ;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.leftBarButtonItems = nil ;
    
    
    self.rTimeSelect = 4 ; //默认选择12个月
    
    self.rDataArray = [NSMutableArray array] ;
    self.rBannerDataArray = [NSMutableArray array];
    self.dataSourceArray = [NSMutableArray array];
    
    self.rNoticeArray = [NSMutableArray array] ;
    
    [self buildSubViewUI];
    
    self.rCellModel = [[JYProductModel alloc]init];
    self.rCellModel.lowestAmount = @" " ;
    self.rCellModel.highestAmount = @" " ;
    
    
    
    
}

#pragma mark - builUI
-(void)buildSubViewUI {
    
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }];
    
    
    [self.view addSubview:self.rTitleView];
    [self.view addSubview:self.rMessageButton];
    
    [self.rMessageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15) ;
        make.top.equalTo(self.view).offset(20) ;
        make.height.mas_equalTo(44) ;
        make.width.mas_equalTo(NAV_BUTTON_WIDTH) ;
    }] ;
    
    [self.rTableView addSubview:self.rTableBgView];
    [self.rTableView sendSubviewToBack:self.rTableBgView];
    
}


-(void)afn_getmessageCount{
    
    @weakify(self)
    [[AFHTTPSessionManager jy_sharedManager]POST:kMessageCountURL parameters:nil  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @strongify(self)
        NSInteger messCount = [responseObject[@"data"] integerValue] ;
        
        self.rMessageButton.selected = messCount> 0 ;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
}


-(void)loadData {
    [[AFHTTPSessionManager jy_sharedManager]POST:kProductListURL parameters:@{@"categoryId":@"2",kRequestJsonType:@"json"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *data = responseObject[@"data"] ;
        if (data.count) {
            self.rDataArray = [JYProductModel arrayOfModelsFromDictionaries:data error:nil] ;
        }
        
        [self pvt_selectIndex:self.rTimeSelect] ;
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
}
- (void)loadBannerData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
    [dic setValue:@"1" forKey:@"platform"] ;
    
    [dic setValue:@"2" forKey:@"position"] ;
    
    [[AFHTTPSessionManager jy_sharedManager ] POST:KBannerURL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *data = responseObject[@"data"] ;
        if (data.count) {
            
            [self.dataSourceArray  removeAllObjects];
            [self.rBannerDataArray removeAllObjects];
            
            self.rBannerDataArray = [JYDBannerModel arrayOfModelsFromDictionaries:data error:nil] ;
            for (JYDBannerModel *dic in self.rBannerDataArray) {
                NSString *bannrImage = dic.imageUrl;
                if (bannrImage) {
                    [self.dataSourceArray addObject:bannrImage];
                }
            }
            self.rTableHeaderView.imageURLStringsGroup = self.dataSourceArray;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }] ;
}



- (void)getNoticeData
{
    
    
    [[AFHTTPSessionManager jy_sharedManager ] POST:KGetNoticeURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *data = responseObject[@"data"] ;
        
        [self.rNoticeArray removeAllObjects];
        
        [self.rNoticeArray addObjectsFromArray:[JYNoticeModel arrayOfModelsFromDictionaries:data error:nil]] ;
        
         self.rNoticeView.titlesGroup =[self getNoticeTitles];
        
         [self.rTableView reloadData];
        
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }] ;
    
    
}

-(void)homeCount {
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kRootCountURL parameters:@{@"type":@"3"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"首页统计") ;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
}

-(NSArray*) getNoticeTitles{
    
    NSMutableArray *titlesArr = [NSMutableArray arrayWithCapacity:self.rNoticeArray.count] ;
    
    for (int i = 0; i< self.rNoticeArray.count; i++) {
        JYNoticeModel *model = self.rNoticeArray[i] ;
        
        NSString *title = model.title ;
        if (title) {
            [titlesArr addObject:title];
        }
    }
    return [titlesArr copy] ;
    
}

#pragma mark- SDCycleScrollViewDelegate


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    if (cycleScrollView  == self.rNoticeView) {
        
        JYNoticeModel *noticeModel = self.rNoticeArray[index] ;
        NSLog(@"点击通知 %@",noticeModel) ;
        
        JYMessageDetailController *detail = [[JYMessageDetailController alloc]initWithType:JYMessTypeNote];
        
        detail.rId = noticeModel.id ;
        [self.navigationController pushViewController:detail animated:YES];
        
        [self.rNoticeArray removeObject:noticeModel];
        
        self.rNoticeView.titlesGroup = [self getNoticeTitles] ;
        
        return ;
    }
    
    
    self.bannerModel = [self.rBannerDataArray objectAtIndex:index];
    [self jumpTheWebInterface:self.bannerModel.linkUrl index:index];
    NSLog(@"链接====%@",self.bannerModel.linkUrl);
}



#pragma mark - 跳转到web页面的共用方法
//- (void)jumpTheWebInterface:(NSString *)url index:(NSInteger)index
//{
//    if (url.length) {
//        
//          JYWebViewController *bannerVC = [[JYWebViewController alloc]initWithUrl:[NSURL URLWithString:url]];
//        
//        JYDBannerModel *model = self.rBannerDataArray[index];
//        bannerVC.title = model.name;
//        
//        [self.navigationController pushViewController:bannerVC animated:NO];
//    }
//}

- (void)jumpTheWebInterface:(NSString *)url index:(NSInteger)index
{
    if (url.length) {
        
        if ( [url containsString:@"{cellphone}"]){
        
            if ( ![JYSingtonCenter shareCenter].rUserModel) {
                
                @weakify(self)
                [[JYSingtonCenter shareCenter] pvt_autoLoginSuccess:^{
                    @strongify(self)
                    
                    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
                    
                    JYWebViewController *bannerVC = [[JYWebViewController alloc]initWithUrl:[NSURL URLWithString:[url  stringByReplacingOccurrencesOfString:@"{cellphone}" withString:user.cellphone]]];
                    
                    JYDBannerModel *model = self.rBannerDataArray[index];
                    bannerVC.title = model.name;
                    
                    [self.navigationController pushViewController:bannerVC animated:NO];
                    
                    
                } failure:^{
                    @strongify(self)
                    
                    [self pvt_logIn] ;
                }] ;
                
                
            }else{
                
                JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
                
                JYWebViewController *bannerVC = [[JYWebViewController alloc]initWithUrl:[NSURL URLWithString:[url  stringByReplacingOccurrencesOfString:@"{cellphone}" withString:user.cellphone]]];
                
                JYDBannerModel *model = self.rBannerDataArray[index];
                bannerVC.title = model.name;
                
                [self.navigationController pushViewController:bannerVC animated:NO];
            }

        
        }else{
        
            JYWebViewController *bannerVC = [[JYWebViewController alloc]initWithUrl:[NSURL URLWithString:url]];
            
            JYDBannerModel *model = self.rBannerDataArray[index];
            bannerVC.title = model.name;
            
            [self.navigationController pushViewController:bannerVC animated:NO];
        }
        
        
     }
}




#pragma mark- UITableViewDataSource/UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
        static NSString *identifier = @"identifier" ;
        
        JYLoanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        if (cell == nil) {
            cell = [[JYLoanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            self.rTextField = cell.rTextField ;
            
            @weakify(self)
            [RACObserve(cell.rTextField, text) subscribeNext:^(NSString *money) {
                @strongify(self)
                [self pvt_calculateShouldPayMoney];
            }];
            
        }
        
        
        cell.rMinLabel.text = self.rCellModel.lowestAmount ;
        cell.rMaxLabel.text = self.rCellModel.highestAmount ;
        
        
        cell.rSliderView.minimumValue = [self.rCellModel.lowestAmount integerValue]/500 ;
        cell.rSliderView.maximumValue = [self.rCellModel.highestAmount integerValue]/500 ;
        
        cell.rSliderView.value = [cell.rTextField.text integerValue]/500 ;
        
        return cell ;
        
    }
    
    if (indexPath.row == 1) {
        static NSString *identifier = @"identifierdd" ;
        
        JYLoanTimeCell *cellTime = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        if (cellTime == nil) {
            
            cellTime = [[JYLoanTimeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            @weakify(self)
            cellTime.rSelectBlock = ^(NSInteger index) {
                @strongify(self)
                
                self.rTimeSelect = index ;
                
                [self pvt_selectIndex:index] ;
            } ;
        }
        cellTime.rSelectIndex = self.rTimeSelect ;
        
        
        return cellTime ;
        
    }
    
    
    static NSString *identifier = @"identifierdd" ;
    
    UITableViewCell *cellTime = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    if (cellTime == nil) {
        
        cellTime = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cellTime.selectionStyle = UITableViewCellSelectionStyleNone ;
        cellTime.backgroundColor =
        cellTime.contentView.backgroundColor = [UIColor clearColor] ;
        
        cellTime.textLabel.font = [UIFont systemFontOfSize:14] ;
        cellTime.textLabel.textColor = kBlackSecColor ;
        
        cellTime.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = kLineColor ;
        
        [cellTime.contentView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(cellTime.contentView) ;
            make.height.mas_equalTo(0.5) ;
            make.left.equalTo(cellTime.contentView).offset(15) ;
            make.right.equalTo(cellTime.contentView).offset(-15) ;
        }] ;
        
        
        
    }
    
    if (indexPath.row == 2) {
        
        self.rPayMoneyLab = cellTime.detailTextLabel ;
        
        [self pvt_calculateShouldPayMoney];
        
    }else if(indexPath.row == 3) {
        cellTime.detailTextLabel.text = [NSString stringWithFormat:@"%zd",[kTimetitle[self.rTimeSelect] integerValue]];
    }
    
    if (indexPath.row == 4) {
        cellTime.detailTextLabel.textColor = kBlueColor ;
        
        cellTime.detailTextLabel.text = @"详情" ;
    }else{
        cellTime.detailTextLabel.textColor = kBlackSecColor ;
        
    }
    cellTime.textLabel.text = rCellTitles[indexPath.row - 2];
    
    
    return cellTime ;
    
}



-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    static NSString *headerIdentify = @"headerIdentify" ;
    
    UITableViewHeaderFooterView *headerView =[tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentify] ;;
    
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentify] ;
        headerView.contentView.backgroundColor =  UIColorFromRGB(0xd8981d) ;
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [leftBtn setTitle:@"  公告" forState:UIControlStateNormal] ;
        leftBtn.titleLabel.font = [UIFont systemFontOfSize:12] ;
        [leftBtn setImage:[UIImage imageNamed:@"notice_icon"] forState:UIControlStateNormal];
        [headerView.contentView addSubview:leftBtn];
        
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo (headerView.contentView).offset(15) ;
            make.centerY.equalTo(headerView.contentView) ;
            make.width.mas_equalTo(45) ;
        }] ;
        
        
        [headerView.contentView addSubview:self.rNoticeView] ;
        
        [self.rNoticeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftBtn.mas_right).offset(15) ;
            make.height.mas_equalTo(headerView.contentView) ;
            make.centerY.equalTo(headerView.contentView) ;
            
            make.width.mas_equalTo(SCREEN_WIDTH - 90) ;
        }] ;
        
        
    }
    
    
    return headerView ;
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row  == 4) {
        JYLoanAlterVC *vc = [[JYLoanAlterVC alloc]init];
        
        vc.rManageRate =self.rCellModel.manageRate ;
        vc.rYearInterest = self.rCellModel.yearInterest ;
        vc.rServiceRate = self.rCellModel.serviceRate ;
        
        [self.navigationController jy_showViewController:vc completion:nil];
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 138 ;
    }else if (indexPath.row == 1){
        
        return 115 ;
    }
    
    
    return 23 ;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (self.rNoticeArray.count) {
        return 20 ;
        
    }
    
    return 0 ;
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    self.rTitleView.alpha =  (scrollView.contentOffset.y/44.0);
    
}




#pragma mark- action

-(void)pvt_calculateShouldPayMoney {
    
    
    NSString *managementFee = [NSString stringWithFormat:@"%f",[self.rTextField.text integerValue] * 0.8/100 * [kTimetitle[self.rTimeSelect] integerValue]];
    NSString *interest = [NSString stringWithFormat:@"%f",[self.rTextField.text integerValue] * [self.rCellModel.yearInterest doubleValue] * 1/1200  * [kTimetitle[self.rTimeSelect] integerValue]];
    
    
    NSString *AllAmount = [NSString stringWithFormat:@"%f",managementFee.floatValue +interest.floatValue + [self.rTextField.text integerValue]];
    self.rPayMoneyLab.text = [NSString stringWithFormat:@"%.2f", AllAmount.floatValue / [kTimetitle[self.rTimeSelect] integerValue]];
    
}

-(void)pvt_message {
    
    
    if ( ![JYSingtonCenter shareCenter].rUserModel) {
        
        @weakify(self)
        [[JYSingtonCenter shareCenter] pvt_autoLoginSuccess:^{
            @strongify(self)
            JYMessageVController *message = [[JYMessageVController alloc]init];
            [self.navigationController pushViewController:message animated:YES];
            
        } failure:^{
            @strongify(self)
            
            [self pvt_logIn] ;
        }] ;
        
        
        
    }else{
        
        JYMessageVController *message = [[JYMessageVController alloc]init];
        [self.navigationController pushViewController:message animated:YES];
    }
    
    
}

-(void)pvt_selectIndex:(NSInteger)index {
    
    if (self.rDataArray.count <= 0|| index > self.rDataArray.count-1) {
        return ;
    }
    
    JYProductModel *model = self.rDataArray[index] ;
    self.rCellModel = model ;
    [self.rTableView reloadData];
    
    
}

-(void)pvt_beginLoan {
    
      
    if ( ![JYSingtonCenter shareCenter].rUserModel) {
        @weakify(self)
        [[JYSingtonCenter shareCenter] pvt_autoLoginSuccess:^{
            @strongify(self)
            
            [self pvt_loadRequest];
            
        } failure:^{
            @strongify(self)
            
            [self pvt_logIn] ;
        }] ;
        
        
    }else{
        
        
        if ([self.rTextField.text doubleValue] < [self.rCellModel.lowestAmount doubleValue]) {
            
            [JYProgressManager showBriefAlert:@"申请金额不能低于最小金额"] ;
            return ;
        }
        
        [self pvt_loadRequest];
    }
    
    
}

-(void)pvt_loadRequest {
    
    
    @weakify(self)
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kAuditStatusURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @strongify(self)
        
        if ([responseObject[@"code"]  integerValue] == 0) {
            [self pvt_requestFirstLimit] ;
        }else if ([responseObject[@"code"]  integerValue] == 1003 || [responseObject[@"code"]  integerValue] == 1010) {
            
            NSString *titleStr = @"借款前，请先前往认证" ;
            
            if ([responseObject[@"code"]  integerValue] == 101) {
                titleStr = @ "信息需补录，请先前往补录" ;
            }
            
            
            [UIAlertView alertViewWithTitle:titleStr  message:@"" cancelButtonTitle:@"否" otherButtonTitles:@[@"是"] onDismiss:^(NSInteger buttonIndex) {
                
                
                JYImproveInfoController *impvc = [[JYImproveInfoController alloc]init];
                [self.navigationController pushViewController:impvc animated:YES];
                
            } onCancel:^{
                
                
            }] ;
            
            
            
        }  else{
            
            [JYProgressManager showBriefAlert:responseObject[@"msg"]] ;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
}


-(void)pvt_requestFirstLimit {
    
    @weakify(self)
    [[AFHTTPSessionManager jy_sharedManager]POST:kIsFirstLoanURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @strongify(self)
        if ([responseObject[@"isFirstLoan"] boolValue] && [self.rTextField.text doubleValue] > 10000 ){
            
            [JYProgressManager showBriefAlert:@"首次借款最高可借额度为1万元"] ;
            
        }else{
            
            [self pvt_goLoadControl] ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
    
}


-(void)pvt_goLoadControl {
    
    JYLoanInfoController *infoVC = [[JYLoanInfoController alloc]init];
    
    infoVC.rProductId = self.rCellModel.id ;
    infoVC.rPrincipal = self.rTextField.text ;
    infoVC.rRepayPeriod = [NSString stringWithFormat:@"%zd",[kTimetitle[self.rTimeSelect] integerValue]] ;
    
    
    NSString *serviceFee = [NSString stringWithFormat:@"%.2f",[self.rTextField.text integerValue] * [self.rCellModel.serviceRate  doubleValue]];
    
    infoVC.rServiceFee = serviceFee;
    
    
    
    NSString *managementFee = [NSString stringWithFormat:@"%.2f",[self.rTextField.text integerValue] * [self.rCellModel.manageRate doubleValue] * [kTimetitle[self.rTimeSelect] integerValue]];
    infoVC.rManageFee = managementFee ;
    
    
    
    NSString *interest = [NSString stringWithFormat:@"%.2f",[self.rTextField.text integerValue] * [self.rCellModel.yearInterest doubleValue] * 1/1200  * [kTimetitle[self.rTimeSelect] integerValue]];
    infoVC.RrepayInterest = interest ;
    
    
    NSString *AllAmount = [NSString stringWithFormat:@"%.2f",managementFee.doubleValue +interest.doubleValue + [self.rTextField.text integerValue]];
    
    infoVC.RepayPerAmount = [NSString stringWithFormat:@"%.2f", AllAmount.doubleValue / [kTimetitle[self.rTimeSelect] integerValue]]; ;
    
    
    infoVC.RepayAmount = [NSString stringWithFormat:@"%.2f",[self.rTextField.text integerValue] + [managementFee doubleValue]  + [interest doubleValue]] ;
    
    
    
    [self.navigationController pushViewController:infoVC animated:YES] ;
}


-(void)pvt_logIn {
    
    JYLogInViewController *logVC =[[JYLogInViewController alloc]initWithLogType:JYLogFootViewTypeLogIn];
    UINavigationController *nvc =[[UINavigationController alloc]initWithRootViewController:logVC] ;
    
    [self presentViewController:nvc animated:YES completion:^{
    }] ;
    
}



#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor =  kBackGroundColor ;
        _rTableView.tableFooterView = [[UIView alloc]init];
        _rTableView.tableHeaderView = self.rTableHeaderView ;
        _rTableView.tableFooterView = self.rTableFootView ;
        _rTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        
    }
    return _rTableView ;
}

-(SDCycleScrollView*)rTableHeaderView {
    
    if (_rTableHeaderView == nil) {
        _rTableHeaderView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) delegate:self placeholderImage:nil] ;
        _rTableHeaderView.backgroundColor = kBlueColor ;
        _rTableHeaderView.hidesForSinglePage = YES ;
        _rTableHeaderView.autoScrollTimeInterval = 5 ;
    }
    
    return _rTableHeaderView ;
}

-(SDCycleScrollView*)rNoticeView {
    
    
    if (_rNoticeView == nil) {
        
        _rNoticeView = ( {
            
            SDCycleScrollView *loopScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(  120 , 0.5, SCREEN_WIDTH - 15-120 , 45) delegate:self placeholderImage:nil];
            loopScrollView.backgroundColor = [UIColor clearColor] ;
            loopScrollView.titleLabelBackgroundColor = [UIColor clearColor];
            loopScrollView.titleLabelTextFont = [UIFont systemFontOfSize:12];
            loopScrollView.titleLabelTextColor = [UIColor whiteColor];
            loopScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
            loopScrollView.onlyDisplayText = YES;
            loopScrollView.autoScrollTimeInterval = 5 ;
            loopScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone ;
            
            loopScrollView ;
        }
                        ) ;
        
        
    }
    
    return _rNoticeView ;
    
}

-(JYLoanFootVew*)rTableFootView {
    
    if (_rTableFootView == nil) {
        _rTableFootView = [[JYLoanFootVew alloc]init];
        _rTableFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100) ;
        _rTableFootView.backgroundColor = [UIColor clearColor] ;
        
        @weakify(self)
        [[_rTableFootView.rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            
            [self pvt_beginLoan] ;
        }] ;
    }
    
    return _rTableFootView ;
    
}

-(UILabel*)rTitleLabel {
    
    if (_rTitleLabel == nil) {
        _rTitleLabel = [self jyCreateLabelWithTitle:@"首页" font:18 color:[UIColor whiteColor] align:NSTextAlignmentCenter] ;
        
        _rTitleLabel.backgroundColor = [UIColor clearColor] ;
    }
    return _rTitleLabel ;
}

-(UIView*)rTitleView {
    
    if (_rTitleView == nil) {
        _rTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        _rTitleView.backgroundColor = kBlueColor ;
        _rTitleView.alpha  = 0 ;
        
        [_rTitleView addSubview:self.rTitleLabel];
        [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(_rTitleView) ;
            make.height.mas_equalTo(44) ;
        }] ;
    }
    
    return _rTitleView ;
}

-(UIButton*)rMessageButton {
    
    if (_rMessageButton == nil) {
        _rMessageButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        _rMessageButton.backgroundColor = [UIColor clearColor] ;
        
        _rMessageButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter ;
        [_rMessageButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight] ;
        
        [_rMessageButton setImage:[UIImage imageNamed:@"nav_message"] forState:UIControlStateNormal] ;
        //        [_rMessageButton setImage:[[UIImage imageNamed:@"nav_message"] jy_imageWithTintColor:UIColorFromRGB(0xe5e5e5)] forState:UIControlStateHighlighted];
        
        [_rMessageButton setImage:[UIImage imageNamed:@"nav_hasmessage"] forState:UIControlStateSelected];
        
        
        @weakify(self)
        [[_rMessageButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            
            [self pvt_message] ;
            
        }] ;
        
    }
    
    return _rMessageButton ;
}

-(UIView*)rTableBgView {
    
    if (_rTableBgView == nil) {
        _rTableBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)] ;
        _rTableBgView.backgroundColor = kBlueColor ;
    }
    
    return _rTableBgView ;
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
