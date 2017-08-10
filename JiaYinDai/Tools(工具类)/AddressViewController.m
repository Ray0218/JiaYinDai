//
//  AddressViewController.m
//  AddressDemo
//

//

#import "AddressViewController.h"

@interface AddressViewController ()


@property(nonatomic,strong)NSIndexPath *selectedIndexPath;//当前选中的NSIndexPath
@property (nonatomic, strong) NSString *msg;


@property (nonatomic, strong) NSString *rLoalAddress;

@end

@implementation AddressViewController

- (instancetype)initWithAddressType:(JYAddressType) type
{
    self = [super init];
    if (self) {
        
        
        self.rDisplayType = type ;
        
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad] ;
    self.title = @"选择地区";
    
    [self configureData];
    [self configureViews];
    
    
    if (self.rDisplayType == JYAddressTypeProvince) {
        
        @weakify(self)
        [[JYLoactionManager shareManager] startLocationComplete:^(NSString *address) {
            @strongify(self)
            self.rLoalAddress = address;//定位的地址
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone] ;
            
        }];
        
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    
}
-(void)configureData{
    if (self.rDisplayType == JYAddressTypeProvince) {
        //从文件读取地址字典
        NSString *addressPath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"plist"];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:addressPath];
        self.provinces = [dict objectForKey:@"address"];
    }
}

-(void)configureViews
{
    self.tableView = [[UITableView alloc]init ];
    self.tableView.tableFooterView = [UIView new] ;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }] ;
}

// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.rDisplayType == JYAddressTypeProvince) {
        return 2;
    }else{
        return 1;
    }
}
// cell 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.rDisplayType == JYAddressTypeProvince) {
        return 50;
    }else{
        return 0;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.rDisplayType == JYAddressTypeProvince) {
        
        if (section == 0) {
            return 1;
        }else{
            
            return self.provinces.count;
        }
    }else if (self.rDisplayType == JYAddressTypeCity){
        return self.citys.count;
    }else{
        return self.areas.count;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.rDisplayType == JYAddressTypeProvince) {
        if (section==0) {
            return @"常用位置";
        }
        
        if (section==1) {
            return @"切换城市";
        }
        return nil;
    }
    return nil;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.rDisplayType == JYAddressTypeProvince) {
        if (indexPath.section == 0) {
            static NSString* ID = @"cityCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
                
            }
            
            cell.textLabel.text = self.rLoalAddress ;
            return cell;
        }else{
            
            static NSString* ID = @"cityCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            if (self.rDisplayType == JYAddressTypeProvince) {
                NSDictionary *province = self.provinces[indexPath.row];
                NSString *provinceName = [province objectForKey:@"name"];
                cell.textLabel.text= provinceName;
            }else if (self.rDisplayType == JYAddressTypeCity){
                NSDictionary *city = self.citys[indexPath.row];
                NSString *cityName = [city objectForKey:@"name"];
                cell.textLabel.text= cityName;
            }else{
                cell.textLabel.text= self.areas[indexPath.row];
            }
            return cell;
        }
    }else{
        static NSString* ID = @"cityCellOne";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        if (self.rDisplayType == JYAddressTypeProvince) {
            NSDictionary *province = self.provinces[indexPath.row];
            NSString *provinceName = [province objectForKey:@"name"];
            cell.textLabel.text= provinceName;
        }else if (self.rDisplayType == JYAddressTypeCity){
            NSDictionary *city = self.citys[indexPath.row];
            NSString *cityName = [city objectForKey:@"name"];
            cell.textLabel.text= cityName;
        }else{
            cell.textLabel.text= self.areas[indexPath.row];
        }
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.rDisplayType == JYAddressTypeProvince) {
        
        NSDictionary *province = self.provinces[indexPath.row];
        NSArray *citys = [province objectForKey:@"sub"];
        self.selectedProvince = [province objectForKey:@"name"];
        
        
        if (indexPath.section == 0) {
            
            
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath] ;
            if (self.rSelectBlock) {
                self.rSelectBlock(cell.textLabel.text) ;
            }
            
            [self.navigationController popViewControllerAnimated:YES] ;
            return ;
        }
        
        
        
        //构建下一级视图控制器
        AddressViewController *cityVC = [[AddressViewController alloc]initWithAddressType:JYAddressTypeCity];
        //        cityVC.rDisplayType = JYAddressTypeCity;//显示模式为城市
        cityVC.citys = citys;
        cityVC.selectedProvince = self.selectedProvince;
        
        cityVC.rSelectBlock = ^(NSString *rAddress) {
            
            if (self.rSelectBlock) {
                self.rSelectBlock(rAddress) ;
            }
        } ;
        
        
        [self.navigationController pushViewController:cityVC animated:YES];
        //        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        //        [self.tableView reloadSections:indexSet withRowAnimation:(UITableViewRowAnimationNone)];
    }else if (self.rDisplayType == JYAddressTypeCity){
        NSDictionary *city = self.citys[indexPath.row];
        self.selectedCity = [city objectForKey:@"name"];
        NSArray *areas = [city objectForKey:@"sub"];
        //构建下一级视图控制器
        AddressViewController *areaVC = [[AddressViewController alloc]initWithAddressType:JYAddressTypeArea]; ////显示模式为区域
        
        //        areaVC.rDisplayType = JYAddressTypeArea;//显示模式为区域
        areaVC.areas = areas;
        areaVC.selectedCity = self.selectedCity;
        areaVC.selectedProvince = self.selectedProvince;
        
        areaVC.rSelectBlock = ^(NSString *rAddress) {
            
            if (self.rSelectBlock) {
                self.rSelectBlock(rAddress) ;
            }
        } ;
        
        
        [self.navigationController pushViewController:areaVC animated:YES];
        //        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        //        [self.tableView reloadSections:indexSet withRowAnimation:(UITableViewRowAnimationNone)];
    }else{
        //保存
        self.selectedArea = self.areas[indexPath.row];
        self.selectedIndexPath = indexPath;
        self.msg = [NSString stringWithFormat:@"%@%@%@",self.selectedProvince,self.selectedCity,self.selectedArea];
        NSLog(@"选择的地址=======%@",self.msg);
        
        
        if (self.rSelectBlock) {
            self.rSelectBlock(self.msg) ;
        }
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"JYPersonIdentifController" object:@"selectedAddress" userInfo:(NSDictionary *)self.msg];
        
        
        NSArray *viewcontrols = self.navigationController.viewControllers ;
        
        [viewcontrols enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UIViewController *control = (UIViewController*)obj ;
            if (![control isKindOfClass:[AddressViewController class]]) {
                
                [self.navigationController popToViewController:control animated:YES];
                *stop = YES ;
            }
        }] ;
        
        
    }
}



@end
