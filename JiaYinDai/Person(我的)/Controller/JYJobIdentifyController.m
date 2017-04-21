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



@interface JYJobIdentifyController ()
@property (nonatomic ,strong) JYLogFootView *rTableFootView ;

@property (nonatomic ,strong)NSArray *rDataArray ;

@property (nonatomic ,strong) JYPickerView *rPickerView ;




@end

@implementation JYJobIdentifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"工作信息" ;
    [self initializeTableView];
    
    self.rDataArray = [NSArray arrayWithObjects:
                       @[
                         [[JYPasswordSetModel alloc]initWithTitle:@"税前月收入" fieldText:@"" placeHolder:@"请选择" hasCode:NO]
                         ],
                       @[
                         [[JYPasswordSetModel alloc]initWithTitle:@"工作单位" fieldText:@"" placeHolder:@"请填写公司名称" hasCode:NO],[[JYPasswordSetModel alloc]initWithTitle:@"单位证明" fieldText:@"" placeHolder:@"上传劳动合同或在职证明" hasCode:NO],[[JYPasswordSetModel alloc]initWithTitle:@"联系电话" fieldText:@"" placeHolder:@"请填写单位座机/前台电话" hasCode:NO],
                         
                         [[JYPasswordSetModel alloc]initWithTitle:@"单位地址" fieldText:@"" placeHolder:@"省份|市|区" hasCode:NO],[[JYPasswordSetModel alloc]initWithTitle:@"详细地址" fieldText:@"" placeHolder:@"请输入详细地址:街道|小区|幢|单元|室" hasCode:NO]
                         
                         ],
                       
                       nil];
    
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
            
            cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeArrow reuseIdentifier:identifier maxWidth:100 ];
        }
        
        [cell setDataModel:model] ;
        
        
        return cell ;
    }
    
    if ((indexPath.section == 1 && (indexPath.row == 1 || indexPath.row == 3)) ) {
        
        
        static NSString *identifier = @"identifierButton" ;
        
        JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeArrow reuseIdentifier:identifier ];
        }
        
        
        if (indexPath.row == 3) {
            [cell.rRightArrow setImage:[UIImage imageNamed:@"ident_address"] forState:UIControlStateNormal] ;
            
        }else{
            [cell.rRightArrow setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal] ;
            
        }
        
        [cell setDataModel:model] ;
        
        
        return cell ;
    }
    
    
    
    
    
    static NSString *identifier = @"identifierNormal" ;
    
    JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeNormal reuseIdentifier:identifier ];
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
    
    
    if (indexPath.row == 1  ) {
        JYImageAddController *control = [[JYImageAddController alloc]initWithType:JYImageAddTypeJob];
        [self.navigationController pushViewController:control animated:YES];
        return ;
    }
    
    
    self.rPickerView.hidden = NO ;
    
    self.rPickerView.rDataArray = @[@"硕士研究生或以上",@"本科",@"专科",@"高中或中专",@"初中或初中以下"] ;
    
    
    
    @weakify(self)
    self.rPickerView.rSelectBlock = ^(NSString *selectString) {
        @strongify(self)
        JYPasswordSetModel *model = self.rDataArray[indexPath.section][indexPath.row] ;
        model.rTFTitle = selectString ;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone] ;
    } ;
    
}

#pragma mark- action




#pragma  mark- getter

-(JYLogFootView*)rTableFootView {
    
    if (_rTableFootView == nil) {
        _rTableFootView = [[JYLogFootView alloc]initWithType:JYLogFootViewTypeSetPassword] ;
        [_rTableFootView.rCommitBtn setTitle:@"提交" forState:UIControlStateNormal] ;
        [_rTableFootView.rAgreeBtn setTitleColor:kTextBlackColor forState:UIControlStateNormal] ;
        _rTableFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 140) ;
        _rTableFootView.rAgreeBtn.titleLabel.numberOfLines = 0 ;
        [_rTableFootView.rAgreeBtn setTitle:@"请仔细填写，一经提交将不可更改。\n我申明以上信息为本人真实信息。" forState:UIControlStateNormal] ;
        
        [[_rTableFootView.rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            
            
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
