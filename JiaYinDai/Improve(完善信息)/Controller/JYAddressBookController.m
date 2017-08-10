//
//  JYAddressBookController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/6/7.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYAddressBookController.h"
#import "JYAddressBookCell.h"
#import "HCSortString.h"
#import "ZYPinYinSearch.h"
#import <objc/runtime.h>
#import "JYActionSheet.h"



@interface JYAddressBookController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating>
@property (nonatomic, strong) UITableView *rTableView;

@property (strong, nonatomic) PPPersonModel *student;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSArray *ary;
@property (strong, nonatomic) NSMutableArray *dataSource;/**<排序前的整个数据源*/
@property (strong, nonatomic) NSDictionary *allDataSource;/**<排序后的整个数据源*/
@property (strong, nonatomic) NSMutableArray *searchDataSource;/**<搜索结果数据源*/
@property (strong, nonatomic) NSArray *indexDataSource;/**<索引数据源*/



@end

@implementation JYAddressBookController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"添加联系人" ;
    
     
    //获取按联系人姓名首字拼音A~Z排序(已经对姓名的第二个字做了处理)
    [PPGetAddressBook getOrderAddressBook:^(NSDictionary<NSString *,NSArray *> *addressBookDict, NSArray *nameKeys) {
        //addressBookDict: 装着所有联系人的字典
        //nameKeys: A~Z拼音字母数组;
        //刷新 tableView
        
        
        NSLog(@"dddd") ;
        
        _allDataSource   = [addressBookDict copy];
        _indexDataSource = [HCSortString sortForStringAry:[_allDataSource allKeys]];
        _searchDataSource = [NSMutableArray new];
        
        
        [self.rTableView reloadData];
        
    } authorizationFailure:^{
        NSLog(@"请在iPhone的“设置-隐私-通讯录”选项中，允许访问您的通讯录");
        
        [self _showAlert] ;
    }];
    
    
    [self buildSubViewsUI];
    
    
}

-(void)buildSubViewsUI {
    
    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }] ;
}


#pragma mark - -------
- (void)_showAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您的通讯录暂未允许访问，请去设置->隐私里面授权!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
    [alert show];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.searchController.active) {
        return _indexDataSource.count;
    }else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.searchController.active) {
        NSArray *value = [_allDataSource objectForKey:_indexDataSource[section]];
        return value.count;
    }else {
        return _searchDataSource.count;
    }
}
//头部索引标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (!self.searchController.active) {
        return _indexDataSource[section];
    }else {
        return nil;
    }
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    static NSString *headerIdentifier = @"headerIdentifier" ;
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
        
        headerView.contentView.backgroundColor = kBackGroundColor;
        headerView.textLabel.textColor = kTextBlackColor ;
        
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = kLineColor ;
        [headerView.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(headerView.contentView) ;
            make.height.mas_equalTo(0.5) ;
        }] ;
        
        
    }
    
    
    return headerView ;
    
}





//右侧索引列表
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (!self.searchController.active) {
        return _indexDataSource;
    }else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *identufy = @"cellIdentify" ;
    JYAddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:identufy] ;
    
    if (cell == nil) {
        cell = [[JYAddressBookCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identufy];
    }
    
    if (!self.searchController.active) {
        NSArray *value = [_allDataSource objectForKey:_indexDataSource[indexPath.section]];
        _student = value[indexPath.row];
    }else{
        _student = _searchDataSource[indexPath.row];
    }
    [cell configCellWithModel:_student];
    return cell;
}
//索引点击事件
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return index;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    
    
    if (!self.searchController.active) {
        NSArray *value = [_allDataSource objectForKey:_indexDataSource[indexPath.section]];
        _student = value[indexPath.row];
    }else{
        _student = _searchDataSource[indexPath.row];
    }
    
    
    if (_student.mobileArray.count) {
        
        if (_student.mobileArray.count == 1) {
            
            if (self.block) {
                
                self.block(_student.name, [_student.mobileArray firstObject]);
            }
            
            self.searchController.active = NO;
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            
             JYActionSheet *actionSheet = [[JYActionSheet alloc] initWithCancelStr:@"取消" otherButtonTitles:_student.mobileArray  AttachTitle:@"请选择电话号码"];
            
            @weakify(self)
            [actionSheet ButtonIndex:^(NSInteger Buttonindex) {
                @strongify(self)
                
                if (Buttonindex) {
                    
                    if (self.block) {
                        
                        self.block(_student.name, [_student.mobileArray objectAtIndex:Buttonindex-1]);
                    }
                    
                    self.searchController.active = NO;
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
            }];
            
            
            
        }
        
        
    }else{
        
        [JYProgressManager showBriefAlert:@"没有获取到电话号码"] ;
    }
    
    
    
}

#pragma mark - UISearchDelegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [_searchDataSource removeAllObjects];
    
    //对排序好的数据进行搜索
    NSArray *ary  = [HCSortString getAllValuesFromDict:_allDataSource];
    
    if (searchController.searchBar.text.length == 0) {
        [_searchDataSource addObjectsFromArray:ary];
    }else {
        ary = [ZYPinYinSearch searchWithOriginalArray:ary andSearchText:searchController.searchBar.text andSearchByPropertyName:@"name"];
        [_searchDataSource addObjectsFromArray:ary];
    }
    [self.rTableView reloadData];
}

#pragma mark - block
- (void)didSelectedItem:(SelectedItem)block {
    self.block = block;
}



#pragma mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        
        
        _rTableView = [[UITableView alloc] init ];
        _rTableView.delegate = self;
        _rTableView.dataSource = self;
        _rTableView.backgroundColor = kBackGroundColor;
        
        _rTableView.estimatedRowHeight = 80 ;
        _rTableView.rowHeight = UITableViewAutomaticDimension;
        
        _rTableView.tableFooterView = [UIView new];
        _rTableView.tableHeaderView = self.searchController.searchBar ;
        
        _rTableView.sectionIndexColor = kBlackColor ;
//        _rTableView.sectionIndexBackgroundColor = [UIColor clearColor] ;
        
    }
    
    return _rTableView ;
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = NO;
        _searchController.searchBar.placeholder = @"搜索";
        [_searchController.searchBar sizeToFit];
        _searchController.searchBar.backgroundColor = [UIColor clearColor] ;
        _searchController.searchBar.backgroundImage = [UIImage jy_imageWithColor:[UIColor clearColor]] ;
    }
    return _searchController;
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
