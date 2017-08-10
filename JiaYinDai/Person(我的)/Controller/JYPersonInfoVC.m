//
//  JYPersonInfoVC.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/6.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPersonInfoVC.h"
#import "JYLogInCell.h"
#import "JYPersonInfoCell.h"
#import "JYSecureSettingVC.h"
#import "JYLogInViewController.h"
#import "JYTabBarController.h"
#import "JYMediaPhotoHelper.h"
#import "JYActionSheet.h"
#import "JYQRCodeController.h"
#import "JPUSHService.h"


@interface JYPersonInfoVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *rTitlesArray ;
}

@property(nonatomic ,strong) UITableView *rTableView ;
@property(nonatomic ,strong) JYLogFootView *rTableFootView ;


@property(nonatomic ,strong) JYUserModel *rUserModel ;


@end



@implementation JYPersonInfoVC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated] ;
    
    self.rUserModel = [JYSingtonCenter shareCenter].rUserModel ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人信息";
    [self buildSubViewUI];
    
    rTitlesArray = [NSArray arrayWithObjects:@[@"头像",@"我的二维码"],@[@"真实姓名",@"身份证号",@"性别",@"现居地"],@[@"安全设置"], nil] ;
    
    
    
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
    
    
    NSString *title = rTitlesArray[indexPath.section][indexPath.row] ;
    
    if (indexPath.section == 0 ) {
        
        if (indexPath.row == 0) {
            
            static NSString *identifier = @"identifierHeader" ;
            
            JYPersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
            
            if (cell  == nil) {
                
                cell = [[JYPersonInfoCell alloc]initWithCellType:JYPernfoCellTypeHeader reuseIdentifier:identifier];
            }
            cell.rTitleLabel.text = title ;
            
            JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
            
            [cell.rRightImgView  sd_setImageWithURL:[NSURL URLWithString:user.headImage]  placeholderImage:[UIImage imageNamed:@"per_header"]] ;
            
            return cell ;
        }
        
        static NSString *identifier = @"identifierCode" ;
        
        JYPersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYPersonInfoCell alloc]initWithCellType:JYPernfoCellTypeCode reuseIdentifier:identifier];
        }
        cell.rTitleLabel.text = title ;
        
        return cell ;
        
    }
    
    if (indexPath.section == 1) {
        static NSString *identifier = @"identifierName" ;
        
        JYPersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell  == nil) {
            
            cell = [[JYPersonInfoCell alloc]initWithCellType:JYPernfoCellTypeName reuseIdentifier:identifier];
        }
        cell.rTitleLabel.text = title ;
        cell.rDetailLabel.text = @"" ;
        
        if (indexPath.row == 0) {
            
            if (self.rUserModel.realName.length) {
                cell.rDetailLabel.text = [self.rUserModel.realName  stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"*"];
                
            }
        }else if(indexPath.row == 1){
            
            if (self.rUserModel.idcard.length >= 18) {
                cell.rDetailLabel.text = [self.rUserModel.idcard stringByReplacingCharactersInRange:NSMakeRange(4, 10) withString:@"**********"] ;
            }else{
            }
        }else
            
            if (indexPath.row == 2) {
                if ([self.rUserModel.sex isEqualToString:@"1"]) {
                    cell.rDetailLabel.text = @"男" ;
                }else if ([self.rUserModel.sex isEqualToString:@"2"]) {
                    cell.rDetailLabel.text = @"女" ;
                }else{
                    cell.rDetailLabel.text = @"" ;
                    
                }
            }else if (indexPath.row == 3){
                
                cell.rDetailLabel.text = self.rUserModel.address ;
            }
        
        
        return cell ;
        
    }
    static NSString *identifier = @"identifierNormal" ;
    
    JYPersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPersonInfoCell alloc]initWithCellType:JYPernfoCellTypeNormal reuseIdentifier:identifier];
    }
    cell.rTitleLabel.text = title ;
    
    cell.rDetailLabel.text = @"" ;
    
    //        if (indexPath.row == 2) {
    //            if ([self.rUserModel.sex isEqualToString:@"1"]) {
    //                cell.rDetailLabel.text = @"男" ;
    //            }else if ([self.rUserModel.sex isEqualToString:@"2"]) {
    //                cell.rDetailLabel.text = @"女" ;
    //            }else{
    //                cell.rDetailLabel.text = @"" ;
    //
    //            }
    //        }else if (indexPath.row == 3){
    //
    //            cell.rDetailLabel.text = self.rUserModel.address ;
    //        }
    
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
            
            JYPersonInfoCell *cell = [self.rTableView cellForRowAtIndexPath:indexPath];
            
            UIImageView *imageView = cell.rRightImgView ;
            [self pvt_loadImage:imageView] ;
        }else{
            
            
            JYQRCodeController *vc = [[JYQRCodeController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }
    
    if (indexPath.section == 2) {
        JYSecureSettingVC *setVC = [[JYSecureSettingVC alloc]init];
        [self.navigationController pushViewController:setVC animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80   ;
    }
    
    return 45 ;
}


#pragma mark -action

-(void)pvt_loadImage:(UIImageView*)rImageView {
    
    
    // 照片选择
    JYActionSheet *actionSheet = [[JYActionSheet alloc] initWithCancelStr:@"取消" otherButtonTitles:@[ @"拍照上传", @"本地上传" ] AttachTitle:@""];
    [actionSheet ChangeTitleColor:kBlackColor AndIndex:1];
    [actionSheet ButtonIndex:^(NSInteger Buttonindex) {
        
        switch (Buttonindex) {
            case 1: {
                [[JYMediaPhotoHelper shareInstance] getPhotoByICLibry:self SourcType:EIMediaPhotoType_Camera mediaphotoSuccessFn:^(UIImage *resultImage) {
                    
                    
                    rImageView.image = resultImage ;
                    
                    
                    [self pvt_uploadImage:resultImage ] ;
                    
                    
                }  mediaphotoFailedFn:^(NSError *error){
                    
                }];
            } break;
                
            case 2: {
                [[JYMediaPhotoHelper shareInstance] getPhotoByICLibry:self SourcType:EIMediaPhotoType_Album mediaphotoSuccessFn:^(UIImage *resultImage) {
                    
                    rImageView.image = resultImage ;
                    
                    [self pvt_uploadImage:resultImage  ] ;
                    
                } mediaphotoFailedFn:^(NSError *error){
                    
                }];
                
            } break;
                
            default:
                break;
        }
        
    }];
    
    
    
}

-(void)pvt_uploadImage:(UIImage*)image   {
    
    
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.6) ;
    
    NSString *dataStr = [NSString stringWithFormat:@"base64,%@", [imageData base64EncodedStringWithOptions:0]];
    
    NSString *imageName = @"ddd.jpg" ;// [[JYDateFormatter shareFormatter]jy_getCurrentDateString] ;
    
    NSMutableDictionary *dic  =[ NSMutableDictionary dictionary];
    [dic setValue:@(7) forKey:@"type"] ;
    [dic setValue:dataStr forKey:@"files"] ;
    [dic setValue:imageName forKey:@"filename"] ;
    
    
    [JYProgressManager showWaitingWithTitle:@"图片上传中..." inView:self.view] ;
    
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kUploadPicURL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [JYProgressManager hideAlert] ;
        [JYProgressManager showBriefAlert:@"图片上传成功！"] ;
        
        NSString *imageUrl = responseObject[@"filename"] ;
        
        JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
        user.headImage = imageUrl ;
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }] ;
    
}


-(void)pvt_logOut {
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kLogoutURL parameters:@{@"customerId":[JYSingtonCenter shareCenter].rUserModel.id} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        [SSKeychain deletePasswordForService:kSSKeyService account:[JYSingtonCenter shareCenter].rUserModel.cellphone] ;
        
        
        [JYSingtonCenter shareCenter].rUserModel = nil ;
        
        
        [JPUSHService setTags:nil aliasInbackground:nil] ;
        
        
        JYTabBarController *tab= (JYTabBarController*)[[[UIApplication sharedApplication]keyWindow ]rootViewController] ;
        UINavigationController *navc = tab.selectedViewController   ;
        
        
        [tab setSelectedIndex:0] ;
        
        [navc popToRootViewControllerAnimated:NO] ;
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
}


-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.f;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

#pragma  mark- getter

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        _rTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _rTableView.backgroundColor = kBackGroundColor ;
        
        
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.tableFooterView = self.rTableFootView ;
        
        
        _rTableView.separatorInset = UIEdgeInsetsZero ;
        
    }
    return _rTableView ;
}

-(JYLogFootView*)rTableFootView {
    
    if (_rTableFootView == nil) {
        _rTableFootView = [[JYLogFootView alloc]initWithType:JYLogFootViewTypeRegister ];
        _rTableFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 90) ;
        [_rTableFootView.rCommitBtn setTitle:@"退出" forState:UIControlStateNormal] ;
        _rTableFootView.rCommitBtn.enabled = YES ;
        @weakify(self)
        [[_rTableFootView.rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            
            [self pvt_logOut] ;
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
