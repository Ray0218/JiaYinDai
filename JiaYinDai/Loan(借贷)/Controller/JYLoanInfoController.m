//
//  JYLoanInfoController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/10.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoanInfoController.h"
#import "JYLogInCell.h"
#import "JYPersonInfoCell.h"
#import "JYLoanInfoModel.h"
#import "JYLoanInfoCell.h"
#import "JYBankCardController.h"
#import "JYLoanUsedController.h"
#import "JYImageAddController.h"
#import "JYLoactionManager.h"
#import "JYPayCommtController.h"
#import "JYWebViewController.h"


@interface JYLoanInfoController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *rTitlesArray ;
}

@property (nonatomic ,strong) UITableView *rTableView ;

@property(nonatomic ,strong)JYLogFootView *rTableFootView ;

@property (nonatomic ,strong) JYBankModel *rBankModel ;

@property (nonatomic ,strong) NSString *rTitleString ;

@property (nonatomic ,strong) NSString *rDetailString ;

@property (nonatomic ,strong) NSString *rImageURLs ;


@property (nonatomic ,strong) NSString *rAdress ;



@end

@implementation JYLoanInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"完善借款信息" ;
    
    rTitlesArray = [NSArray arrayWithObjects:@[[[JYLoanInfoModel alloc]initWithLeft:@"30000" right:@"3"]],@[[[JYLoanInfoModel alloc]initWithLeft:@"选择提现卡" right:@"选择已绑定借记卡"],[[JYLoanInfoModel alloc]initWithLeft:@"收入证明" right:@"上传银行流水扫描件/拍照上传"]],@[[[JYLoanInfoModel alloc]initWithLeft:@"借款用途" right:@"编辑借款用途"]],@[[[JYLoanInfoModel alloc]initWithLeft:@"所在位置" right:@"GPS定位"]] ,nil] ;
    
    
    [self initializeTableView];
    
    
    [self setNavRightButtonWithImage:[UIImage imageNamed:@"nav_help"] title:@""] ;
    
    
}

-(void)initializeTableView {
    
    
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }] ;
}



#pragma mark- UITableViewDataSource/UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        return 2 ;
    }
    return 1 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JYLoanInfoModel *model = rTitlesArray[indexPath.section][indexPath.row] ;
    
    
    if (indexPath.section == 0) {
        
        
        static NSString *identifier = @"identifierNormal" ;
        
        JYLoanInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYLoanInfoCell alloc]initWithStyle:UITableViewCellStyleDefault    reuseIdentifier:identifier];
        }
        cell.rLeftLabel.text = self.rPrincipal ;
        cell.rRightLabel.text = self.rRepayPeriod ;
        
        return cell ;
    }
    
    
    
    static NSString *identifier = @"identifierLoan" ;
    
    JYPersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPersonInfoCell alloc]initWithCellType:JYPernfoCellTypeNormal    reuseIdentifier:identifier];
    }
    
    cell.rTitleLabel.text = model.rLeftString ;
    cell.rDetailLabel.text = model.rRightString ;
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
            view;
        }) ;
        headerView.contentView.backgroundColor = [UIColor clearColor];
        
        UILabel *rTitlLab = [self jyCreateLabelWithTitle:@"" font:14 color:kBlackColor align:NSTextAlignmentLeft] ;
        rTitlLab.numberOfLines = 0 ;
        rTitlLab.tag = 999 ;
        rTitlLab.backgroundColor = [UIColor clearColor] ;
        [headerView.contentView addSubview:rTitlLab];
        
        [rTitlLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.equalTo(headerView.contentView) ;
            make.width.mas_equalTo(SCREEN_WIDTH - 30) ;
            make.centerX.equalTo(headerView.contentView) ;
        }] ;
        
        
    }
    
    
    if (section == 1) {
        UILabel *label = [headerView.contentView viewWithTag:999] ;
        
        label.text = @"嘉银贷均通过线上转账，请选择提现卡！" ;
    }
    
    return headerView ;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    
    
    static NSString *headerIdentifier = @"footerIdentifier" ;
    
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (footerView == nil) {
        footerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
        footerView.backgroundView = ({
            
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = [UIColor clearColor] ;
            view;
        }) ;
        footerView.contentView.backgroundColor = [UIColor clearColor];
        
        UILabel *rTitlLab = [self jyCreateLabelWithTitle:@"" font:13 color:kTextBlackColor align:NSTextAlignmentLeft] ;
        rTitlLab.numberOfLines = 0 ;
        rTitlLab.tag = 999 ;
        rTitlLab.backgroundColor = [UIColor clearColor] ;
        [footerView.contentView addSubview:rTitlLab];
        
        [rTitlLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.equalTo(footerView.contentView) ;
            make.width.mas_equalTo(SCREEN_WIDTH - 30) ;
            make.centerX.equalTo(footerView.contentView) ;        }] ;
        
        
    }
    UILabel *label = [footerView.contentView viewWithTag:999] ;
    
    if (section == 0) {
        label.text = [NSString stringWithFormat:@"*借款为每月还本付息，分%@期完成" ,self.rRepayPeriod];
        
    }else if(section == 3){
        label.text = @"嘉银贷所有借贷均为同城借贷，准确的地理位置\n可以让系统更快的匹配出推荐人，完成您的需要。" ;
        
        [UILabel changeLineSpaceForLabel:label WithSpace:5];
        
    }
    return footerView ;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0 ) {
        return 40 ;
    }
    
    if (section == 3) {
        return 80 ;
    }
    
    return 0.01 ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        return 45 ;
    }
    
    return 15 ;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    __block JYLoanInfoModel *model = rTitlesArray[indexPath.section][indexPath.row] ;
    
    
    __block JYPersonInfoCell *cell = [self.rTableView cellForRowAtIndexPath:indexPath] ;
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
            JYBankCardController *vc =[[JYBankCardController alloc]initWithType:JYBankCardVCTypDraw];
            
            
            vc.rBankBlock = ^(JYBankModel *bankModel) {
                self.rBankModel = bankModel ;
                model.rRightString =
                
                cell.rDetailLabel.text = bankModel.bankName ;
                
                [self  pvt_updateComiitiBtn] ;
            } ;
            
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            JYImageAddController *vc = [[JYImageAddController alloc]init];
            
            vc.rLastImges = self.rImageURLs ;
            
            @weakify(self)
            
            vc.rFinishBlock = ^(NSString *imageURLs) {
                @strongify(self)
                if(imageURLs.length){
                    
                    self.rImageURLs = imageURLs ;
                    
                    model.rRightString =
                    cell.rDetailLabel.text = @"已上传" ;
                    [self  pvt_updateComiitiBtn] ;
                    
                }
                
            } ;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section == 2){
        
        JYLoanUsedController *vc = [[JYLoanUsedController alloc]init];
        vc.rTitleStr = self.rTitleString ;
        vc.rDetailStr = self.rDetailString ;
        
        @weakify(self)
        vc.rUsedBlock = ^(NSString *rTitle, NSString *rDetail) {
            @strongify(self)
            self.rTitleString =  rTitle ;
            self.rDetailString = rDetail ;
            model.rRightString =
            cell.rDetailLabel.text = rTitle ;
            [self  pvt_updateComiitiBtn] ;
            
        } ;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 3) {
        
        
        [[JYLoactionManager shareManager ]startLocationComplete:^(NSString *address) {
            
            self.rAdress = address ;
            
            model.rRightString =
            cell.rDetailLabel.text = address ;
            [self  pvt_updateComiitiBtn] ;
            
            
        }];
        
    }
}

#pragma mark- action

-(void)pvt_clickButtonNavRight {
    
    [self pvt_quest];
}

-(void)pvt_updateComiitiBtn {
    
    
    if (self.rTitleString.length && self.rBankModel && self.rDetailString.length && self.rImageURLs.length && self.rAdress.length ) {
        
        
        self.rTableFootView.rCommitBtn.enabled = YES  ;
    }else{
        
        self.rTableFootView.rCommitBtn.enabled = NO   ;
        
    }
    
    
    
    
}


-(void)pvt_commit {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setValue:self.rTitleString forKey:@"applyTitle"];
    [dic setValue:self.rDetailString forKey:@"applyDetail"];
    [dic setValue:self.rAdress forKey:@"applyPosition"];
    [dic setValue: self.rImageURLs forKey:@"fileName"];
    
    
    [dic setValue:self.rBankModel.id forKey:@"bankId"];
    
    [dic setValue:self.rProductId forKey:@"productId"];
    [dic setValue:self.rPrincipal  forKey:@"principal"];
    [dic setValue:self.rServiceFee forKey:@"serviceFee"];
    [dic setValue:self.rManageFee forKey:@"manageFee"];
    [dic setValue:self.RepayAmount  forKey:@"repayAmount"];
    [dic setValue:self.RepayPerAmount forKey:@"repayPerAmount"];
    [dic setValue:self.RrepayInterest forKey:@"repayInterest"];
    [dic setValue:self.rRepayPeriod forKey:@"repayPeriod"];
    
    
    
    JYPayCommtController *payVC = [[JYPayCommtController alloc]initWithType:JYPayCommitTypeLoan];
    payVC.rLoanDic = dic ;
    [self.navigationController pushViewController:payVC animated:YES];
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
        _rTableView.tableFooterView =  self.rTableFootView ;
    }
    return _rTableView ;
}

-(JYLogFootView*)rTableFootView {
    
    if (_rTableFootView == nil) {
        _rTableFootView = [[JYLogFootView alloc]initWithType:JYLogFootViewTypeSetPassword] ;
        _rTableFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120) ;
        
        
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:@"阅读并同意嘉银贷《借贷协议》" attributes:@{NSForegroundColorAttributeName:kTextBlackColor,NSFontAttributeName:[UIFont systemFontOfSize:12]}] ;
        
        NSRange rang = [attString.string rangeOfString:@"《借贷协议》"] ;
        
        [attString addAttribute:NSForegroundColorAttributeName value:kBlueColor range:rang] ;
        [_rTableFootView.rAgreeView.rAgreeBtn setAttributedTitle:attString forState:UIControlStateNormal];
        
        
        [_rTableFootView.rCommitBtn setTitle:@"提交" forState:UIControlStateNormal];
        
        
        _rTableFootView.rCommitBtn.enabled = NO  ;
        @weakify(self)
        [[_rTableFootView.rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            
            if (!_rTableFootView.rAgreeView.rImageButton.selected) {
                
                [JYProgressManager showBriefAlert:@"您未认可嘉银贷的借贷协议，如需借贷请阅读并同意"] ;
                
            }else{
                
                [self pvt_commit ] ;
            }
            
            NSLog(@"点击") ;
            
        }] ;
        
        [[_rTableFootView.rAgreeView.rAgreeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            JYWebViewController *webVC = [[JYWebViewController alloc]initWithUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@/borrowAgree",kServiceURL ]]] ;
            [self.navigationController pushViewController:webVC animated:YES];
            
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
