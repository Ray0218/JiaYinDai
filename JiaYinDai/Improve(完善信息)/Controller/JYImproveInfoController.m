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



@interface JYImproveInfoController (){
    NSArray *rDataArray ;
    
}


@property (nonatomic ,strong) UIButton *rTableFootView ;
@end


@implementation JYImproveInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"完善信息" ;
    
    rDataArray = @[
                   @{  keyTitle    : @"实名认证",
                       keyImage    : @"imp_name",
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
                   @{  keyTitle    : @"公积金查询",
                       keyImage    : @"imp_gjj",
                       },
                   @{  keyTitle    : @"征信报告（个人版）",
                       keyImage    : @"imp_zxbg",
                       }
                   ] ;
    
    [self initializeTableView];
}

-(void)initializeTableView {
    
    self.tableView.estimatedRowHeight = 45 ;
    self.tableView.rowHeight = UITableViewAutomaticDimension ;
    self.tableView.sectionHeaderHeight = 15 ;
    self.tableView.tableFooterView = self.rTableFootView ;
    self.tableView.separatorInset = UIEdgeInsetsZero ;
    
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
    
    
    if (indexPath.section == 0) {
        
        JYBankIdentifyController *vc = [[JYBankIdentifyController alloc]initWithHeaderType:JYIdentifyTypeName];
        [self.navigationController pushViewController:vc
                                             animated:YES];
    } else if(indexPath.section == 1){
        
        JYPersonIdentifController *vc = [[JYPersonIdentifController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.section == 2){
    
        JYJobIdentifyController *vc= [[JYJobIdentifyController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.section == 3){
        JYPhoneIndetyfyController *vc = [[JYPhoneIndetyfyController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
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
