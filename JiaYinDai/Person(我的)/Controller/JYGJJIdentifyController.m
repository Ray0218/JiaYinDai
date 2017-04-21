//
//  JYGJJIdentifyController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/20.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYGJJIdentifyController.h"
#import "JYPasswordCell.h"
#import "JYPasswordSetModel.h"


@interface JYGJJIdentifyController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSArray *rDataArray ;
    
}
@property(nonatomic ,strong) UITableView *rTableView ;

@property(nonatomic ,strong) UIView *rTableFootView ;



@end

@implementation JYGJJIdentifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"绑定社保账户" ;
    [self buildSubViewUI];
    
    
    rDataArray = @[
                   @[
                       [[JYPasswordSetModel alloc]initWithTitle:@"社保类型" fieldText:@"" placeHolder:@"" hasCode:NO]
                       ],
                   @[
                       [[JYPasswordSetModel alloc]initWithTitle:@"登录名" fieldText:@"" placeHolder:@"请输入" hasCode:NO],[[JYPasswordSetModel alloc]initWithTitle:@"密码" fieldText:@"" placeHolder:@"请输入密码" hasCode:NO],
                       ]
                   
                   ] ;
    
//    [self registerForKeyboardNotifications] ;
}

/*

//先添加两个通知监听
- (void) registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
}
//显示键盘后
- (void) keyboardWasShown:(NSNotification *) notif{
    NSDictionary* userInfo = [notif userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardFrame];

     [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - keyboardFrame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
}
//隐藏键盘后
- (void) keyboardWasHidden:(NSNotification *) notif{
    NSDictionary* userInfo = [notif userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + keyboardFrame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
}
*/

#pragma mark - builUI
-(void)buildSubViewUI {
    
    
    
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }];
    
}

#pragma mark- UITableViewDataSource/UITableViewDelegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1 ;
    }
    return  2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JYPasswordSetModel *model = rDataArray[indexPath.section][indexPath.row] ;
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
         static NSString *identifier = @"identifierButton" ;
        
        JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeTwoBtn reuseIdentifier:identifier ];
            [cell.rManButton setTitle:@"省级" forState:UIControlStateNormal];
            [cell.rWomenButton setTitle:@"市级" forState:UIControlStateNormal];
        }
        
        
        [cell setDataModel:model] ;
        
        
        return cell ;
    }
    
    
    static NSString *identifier = @"identifierCode" ;
    
    JYPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPasswordCell alloc]initWithCellType:JYPassCellTypeNormal reuseIdentifier:identifier ];
        
    }
    [cell setDataModel:model] ;

    
    return cell ;
    
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        
     static NSString *headerIdentifier = @"headerIdentifier" ;
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
        headerView.contentView.backgroundColor = [UIColor clearColor];
        
        
        NSString *titles[] = {@"客户号",@"用户名",@"市民邮箱"} ;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:3] ;
        for (int i = 0; i < 3; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14] ;
            [btn setTitleColor:kTextBlackColor forState:UIControlStateNormal];
            [headerView.contentView addSubview:btn];
            btn.tag = 1000+i ;
            [arr addObject:btn];
        }
        
        [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:25 tailSpacing:110] ;
        [arr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(headerView.contentView) ;
        }] ;
        
        
        
    }
    
    return headerView ;
    }
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor] ;
    return view ;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 15 ;
    }
    
    
    return 50 ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark- action


#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]init];
        _rTableView.backgroundColor = kBackGroundColor ;
        _rTableView.estimatedRowHeight = 45 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
        _rTableView.tableFooterView = self.rTableFootView ;
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        
    }
    return _rTableView ;
}


-(UIView*)rTableFootView {

    if (_rTableFootView == nil) {
        _rTableFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 120)];
        
        
        UIButton *commitBtn = [self jyCreateButtonWithTitle:@"确认"] ;
        commitBtn.frame = CGRectMake(15, 30, SCREEN_WIDTH-30, 45);
        [_rTableFootView addSubview:commitBtn];

        
        UILabel *descLabe = [self jyCreateLabelWithTitle:@"如担心信息安全可在绑定之后到公积金网就该密码" font:14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
        descLabe.frame = CGRectMake(15, CGRectGetMaxY(commitBtn.frame)+15, SCREEN_WIDTH-30, 16) ;
        [_rTableFootView addSubview:descLabe];
        
        
        
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
