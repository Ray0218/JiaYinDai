//
//  JYBMoreViewController.m
//  JiaYinDai
//
//  Created by 陈侠 on 2017/5/12.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYBMoreViewController.h"
#import "JYPersonCell.h"
#import "feedbackViewController.h"
#import "JYWebViewController.h"


@interface JYBMoreViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *rDataArray ;
}
@property(nonatomic ,strong) UITableView *rTableView ;

@end

@implementation JYBMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更多";
    rDataArray = @[
                   //                   @[
                   //                       @{  keyTitle    : @"平台风控介绍",
                   //                           keyImage    : @"riskControlIntroduced",
                   //                           },
                   //                        ],
                   @[
                       //                       @{  keyTitle    : @"欢迎页",
                       //                           keyImage    : @"welcome page",
                       //                           },
                       
                       @{  keyTitle    : @"意见反馈",
                           keyImage    : @"feedback",
                           },
                       @{  keyTitle    : @"用户帮助",
                           keyImage    : @"userHelp",
                           },
                       @{  keyTitle    : @"给我点赞",
                           keyImage    : @"giveMeThumb Up",
                           },
//                       @{  keyTitle    : @"检查新版本",
//                           keyImage    : @"CheckNewVersion",
//                           },
                       @{  keyTitle    : @"客户热线",
                           keyImage    : @"customerHotline",
                           }
                       ],
                   @[ @{  keyTitle    : @"关于我们",
                          keyImage    : @"aboutUs",
                          }                                                                             ],
                   
                   ] ;
    
    [self buildSubViewUI];
    
    
    
    
    
    // Do any additional setup after loading the view.
}

#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _rTableView.backgroundColor = kBackGroundColor ;
        _rTableView.estimatedRowHeight = 45 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
        _rTableView.separatorInset = UIEdgeInsetsZero ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.tableFooterView = [UIView new] ;

     
        
    }
    return _rTableView ;
}

#pragma mark - builUI
-(void)buildSubViewUI {
    
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return rDataArray.count ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [rDataArray[section] count] ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return  0.01 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /*
    if(indexPath.section == 1 &&indexPath.row == 4) {
        static NSString *identifier = @"identifierLogin1" ;
        JYPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYPersonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            UILabel *versionLabel = [[UILabel alloc]init];
            [cell addSubview:versionLabel];
            versionLabel.text = @"已是最新版本";
            versionLabel.font = [UIFont systemFontOfSize:15];
            versionLabel.textColor = kTextBlackColor;
            [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.rRightImg.mas_left).offset(-5) ;
                make.centerY.equalTo(cell.contentView) ;
                
            }] ;
            
            
        }
        NSDictionary *dic = rDataArray[indexPath.section][indexPath.row] ;
        [cell rSetCellDtaWithDictionary:dic];
        return cell ;
        
    }else if(indexPath.section == 1 &&indexPath.row == 5){
        static NSString *identifier = @"identifierLogin2" ;
        JYPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYPersonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            UILabel *phoneLabel = [[UILabel alloc]init];
            [cell addSubview:phoneLabel];
            phoneLabel.text = @"400-138-6388";
            phoneLabel.font = [UIFont systemFontOfSize:15];
            phoneLabel.textColor = kTextBlackColor;
            [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.rRightImg.mas_left).offset(-5) ;
                make.centerY.equalTo(cell.contentView) ;
                
            }] ;
        }
        NSDictionary *dic = rDataArray[indexPath.section][indexPath.row] ;
        [cell rSetCellDtaWithDictionary:dic];
        return cell ;
        
    }else{
        
        
        */
        static NSString *identifier = @"identifierLogin" ;
        JYPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYPersonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        NSDictionary *dic = rDataArray[indexPath.section][indexPath.row] ;
        [cell rSetCellDtaWithDictionary:dic];
    
    if (indexPath.row == 3) {
        cell.rRightLabel.text = @"400-138-6388" ;
    }else{
        cell.rRightLabel.text = @"" ;
    }
    
        return cell ;
 }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.section == 0  ) {
        
        if (indexPath.row == 0) {
            
            feedbackViewController *fackbackVC = [[feedbackViewController alloc]init];
            [self.navigationController pushViewController:fackbackVC animated:YES];
            
        }else if(indexPath.row == 1){
            [self pvt_quest];

        } else if (indexPath.row == 2){
            
            
            
             //苹果商店评论页面
            NSString*str2 = [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8",@"1248134035"];
            
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str2]];

            
            
            
        }else if (indexPath.row == 3){
            // 客服热线
            NSString *deviceType=[UIDevice currentDevice].model;
            if([deviceType  isEqualToString:@"iPod touch"]||[deviceType  isEqualToString:@"iPad"]||[deviceType  isEqualToString:@"iPhone Simulator"]){
                UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil message:@"您的设备不能拨打电话" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                [alertView show];
                return;
            }
            UIWebView *callWebView=[[UIWebView alloc] init];
            NSURL *telURL=[NSURL URLWithString:@"tel:400-138-6388"];
            [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
            [self.view addSubview:callWebView];
        }
        
        
    }else{
    
        JYWebViewController *webVC = [[JYWebViewController alloc]initWithUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@/aboutUs",kServiceURL ]]] ;
        [self.navigationController pushViewController:webVC animated:YES];

    }
    
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
