//
//  JYSecureSettingVC.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/7.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYSecureSettingVC.h"
#import "JYPersonInfoCell.h"
#import "JYPasswodSettingVC.h"



@interface JYSecureSettingVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *rTitlesArray ;
}

@property(nonatomic ,strong) UITableView *rTableView ;

@end

@implementation JYSecureSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"安全设置" ;
    [self buildSubViewUI];
    
//    rTitlesArray = [NSArray arrayWithObjects:@[@"修改登录密码",@"修改交易密码",@"更换手机"],
    rTitlesArray = [NSArray arrayWithObjects:@[@"修改登录密码",@"修改交易密码"],

//  @[@"修改公积金账户"],
                    nil] ;
    
}


#pragma mark - builUI
-(void)buildSubViewUI {
    
    
    
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }];
    
}

#pragma mark- UITableViewDataSource/UITableViewDelegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return rTitlesArray.count ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [rTitlesArray[section] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *identifier = @"identifierNormal" ;
    
    JYPersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPersonInfoCell alloc]initWithCellType:JYPernfoCellTypeNormal reuseIdentifier:identifier];
    }
    
    NSString *title = rTitlesArray[indexPath.section][indexPath.row] ;

    cell.rTitleLabel.text = title ;
    
    if (indexPath.section == 0 && indexPath.row == 2) {
        
        
        JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
        if (user.cellphone.length >=11) {
            cell.rDetailLabel.text = [user.cellphone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"] ;
        }
    }else{
        cell.rDetailLabel.text = @"" ;
    }
    
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
    }
    
    return headerView ;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) { //修改登录密码
            JYPasswodSettingVC *vc = [[JYPasswodSettingVC alloc]initWithVCType:JYPassVCTypeChangeLogPass];
            [self.navigationController pushViewController:vc animated:YES];

        }else if (indexPath.row== 1) {
            JYPasswodSettingVC *vc = [[JYPasswodSettingVC alloc]initWithVCType:JYPassVCTypeChangePass];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            JYPasswodSettingVC *vc = [[JYPasswodSettingVC alloc]initWithVCType:JYPassVCTypeChangeTelNum];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
   
    
}



#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = kBackGroundColor ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.sectionHeaderHeight = 15 ;
        _rTableView.tableFooterView = [UIView new] ;
        _rTableView.separatorInset = UIEdgeInsetsZero ;
        _rTableView.estimatedRowHeight = 45 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension ;
        
    }
    return _rTableView ;
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
