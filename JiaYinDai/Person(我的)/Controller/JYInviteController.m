//
//  JYInviteController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/6/5.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYInviteController.h"
#import "ShareConfig.h"
#import "ShareView.h"
#import "JYLogInCell.h"
#import "JYPersonInfoCell.h"
#import "JYInviteAwardController.h"
#import "JYInviteRecordController.h"
#import "JYWebViewController.h"



@interface JYInviteController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSArray *rTitlesArray ;
    
}

@property (nonatomic, strong) ShareView  *shareView;


@property(nonatomic ,strong) UITableView *rTableView ;
@property(nonatomic ,strong) UIView *rTableHeaderView ;
@property(nonatomic ,strong) JYLogFootView *rTableFootView ;
@property (nonatomic ,strong) UIImageView *rCodeImage ;

@property(nonatomic ,strong) NSString *rInviteCount ;
@property(nonatomic ,strong) NSString *rBrokeAge ;




@end

@implementation JYInviteController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"邀请好友";
    
    rTitlesArray = [NSArray arrayWithObjects:@[@"邀请记录",@"实发佣金额度"],@[@"如何获得邀请奖励",@"邀请规则"], nil] ;
    [self buildSubViews];
    
    [self pvt_loadData];
}


-(void)pvt_loadData {
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kInvitePostURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        NSDictionary *dic = responseObject[@"data"] ;
        
        
        self.rInviteCount = [NSString stringWithFormat:@"%zd人",[dic[@"countInvite"] integerValue]] ;
        
        self.rBrokeAge = [NSString stringWithFormat:@"%.2f元",[dic[@"brokerage"]  doubleValue]] ;
        
         [self.rTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
}



-(void)buildSubViews {
    
    
    [self.view addSubview:self.rTableView];
    
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }] ;
}


#pragma mark- action


- (void)pvt_clickInvite{
    
    NSLog(@"分享");
    if (!_shareView) {
        _shareView=[[[NSBundle mainBundle] loadNibNamed:@"CommenCell" owner:self options:nil] objectAtIndex:0];
    }
    JYUserModel *model = [JYSingtonCenter shareCenter].rUserModel ;
    NSString *shareStr= [NSString stringWithFormat:@"缺钱花，嘉银贷为您提供每月零花钱。3分钟审批到账5万元。无门槛，低利率。点我申请！"];
    //    NSString *userUrlStr=[NSString stringWithFormat:@"%@/login/",H5];
    
     NSString *userUrlStr = [NSString stringWithFormat:@"%@/registeract/%@",kServiceURL, [model.cellphone jy_Base64String]] ;

    [_shareView show:^(NSInteger PlatformTag) {
        
        [ShareConfig uMengContentConfigWithCellPhone:model.cellphone tag:PlatformTag presentVC:self shareContent:shareStr shareImage:nil  title:@"缺钱花，找嘉银贷" userUrlStr:userUrlStr succeedCallback:^{
        }];
    }];
    
    
    
}

#pragma mark- UITableViewDataSource/UITableViewDelegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        return  1 ;
    }
    return  2 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    if (indexPath.section == 0) {
        
     NSString *title = rTitlesArray[indexPath.section][indexPath.row] ;
    
    static NSString *identifier = @"identifierNormal" ;
    
    JYPersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYPersonInfoCell alloc]initWithCellType:JYPernfoCellTypeNormal reuseIdentifier:identifier];
    }
    cell.rTitleLabel.text = title  ;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.rDetailLabel.text = self.rInviteCount ;
        }else{
        
            cell.rDetailLabel.text = self.rBrokeAge ;
        }
    }
     
    return cell ;
    }
    
    
    static NSString *identifier = @"identifierBottom" ;
    
    JYInviteCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    
    if (cell  == nil) {
        
        cell = [[JYInviteCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        @weakify(self)
        [[cell.rRightButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
           @strongify(self)
            
            JYWebViewController *webVC = [[JYWebViewController alloc]initWithUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@/personal/actInvite",kServiceURL]]] ;
            
            [self.navigationController pushViewController:webVC animated:YES];
            
        }] ;
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
        
        if (indexPath.row == 0) {
            JYInviteRecordController *recordVC = [[JYInviteRecordController alloc]init];
            [self.navigationController pushViewController:recordVC animated:YES];
        }else{
            
            JYInviteAwardController *vc = [[JYInviteAwardController alloc]init];
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
        _rTableView.tableHeaderView = self.rTableHeaderView ;
        _rTableView.tableFooterView = self.rTableFootView ;
        _rTableView.separatorInset = UIEdgeInsetsZero ;
        _rTableView.estimatedRowHeight = 45 ;

        _rTableView.rowHeight = UITableViewAutomaticDimension ;
        
    }
    return _rTableView ;
}


-(UIView*)rTableHeaderView {
    
    if (_rTableHeaderView == nil) {
        _rTableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        _rTableHeaderView.backgroundColor = kBlueColor ;
        
        [_rTableHeaderView addSubview:self.rCodeImage];
        
        [self.rCodeImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_rTableHeaderView) ;
            make.width.height.mas_equalTo(125) ;
        }];
        
    }
    
    return _rTableHeaderView ;
}

-(JYLogFootView*)rTableFootView {
    
    if (_rTableFootView == nil) {
        _rTableFootView = [[JYLogFootView alloc]initWithType:JYLogFootViewTypeRegister ];
        _rTableFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 90) ;
        [_rTableFootView.rCommitBtn setTitle:@"点击邀请好友" forState:UIControlStateNormal] ;
        _rTableFootView.rCommitBtn.enabled = YES ;
        @weakify(self)
        [[_rTableFootView.rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            
            [self pvt_clickInvite] ;
        }] ;
    }
    
    return _rTableFootView ;
}

-(UIImageView*)rCodeImage {
    
    
    if (_rCodeImage == nil) {
        _rCodeImage = [[UIImageView alloc]init];
        _rCodeImage.layer.cornerRadius = 10 ;
        _rCodeImage.clipsToBounds = YES ;
        
        JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
        
        
        NSString *imageStr = [NSString stringWithFormat:@"%@/registeract/%@",kServiceURL, [user.cellphone jy_Base64String]] ;
        
        
        UIImage *image = [UIImage jy_logoQrCodeWithString:imageStr logo:[UIImage imageNamed:@"invite_logo"] ] ;
                              
        _rCodeImage.image = image ;
 
        
     }
    return _rCodeImage ;


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


@interface JYInviteCell ()

@property (nonatomic ,strong) UILabel *rTitleLabel ;


@property (nonatomic ,strong) UIButton *rRightButton ;


@property (nonatomic ,strong) UIImageView *rBottomImage ;



@end

@implementation JYInviteCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{


    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ;
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        
        [self buildSubViewsUI];
    }
    
    return self ;
}

-(void)buildSubViewsUI {

    [self.contentView addSubview:self.rTitleLabel];
    [self.contentView addSubview:self.rRightButton];
    [self.contentView addSubview:self.rBottomImage];
    
    
    UIView *rLine = [[UIView alloc]init];
    rLine.backgroundColor = kLineColor ;
    [self.contentView addSubview:rLine];
    
    
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15) ;
        make.top.equalTo(self.contentView) ;
        make.height.mas_equalTo(38) ;
    }] ;
    
    [self.rRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.rTitleLabel) ;
        make.right.equalTo(self.contentView).offset(-15) ;
        make.height.mas_equalTo(38) ;
    }] ;
    
    
    [rLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rTitleLabel.mas_bottom) ;
        make.height.mas_equalTo(0.5) ;
        make.left.equalTo(self.contentView).offset(15) ;
        make.right.equalTo(self.contentView).offset(-15) ;
    }] ;
    
    
    [self.rBottomImage mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerX.equalTo(self.contentView) ;
        make.top.equalTo(rLine.mas_bottom).offset(20) ;
        make.bottom.equalTo(self.contentView).offset(-5) ;
    }];
    

}



#pragma mark- getter

-(UILabel*)rTitleLabel{
    if (_rTitleLabel == nil) {
        _rTitleLabel = [self jyCreateLabelWithTitle:@"如何获得邀请奖励" font:16 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rTitleLabel ;

}

-(UIButton*)rRightButton {
    
    if (_rRightButton == nil) {
        _rRightButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [_rRightButton setTitleColor:kBlueColor forState:UIControlStateNormal] ;
        [_rRightButton setImage:[UIImage imageNamed:@"invite_rule"] forState:UIControlStateNormal] ;
        [_rRightButton setTitle:@"邀请规则" forState:UIControlStateNormal] ;
        _rRightButton.titleLabel.font = [UIFont systemFontOfSize:14] ;
    }
    
    
    return _rRightButton ;

}

-(UIImageView *)rBottomImage {

    if (_rBottomImage == nil) {
        _rBottomImage = [[UIImageView alloc]init];
        _rBottomImage.backgroundColor = [UIColor clearColor] ;
        _rBottomImage.image = [UIImage imageNamed:@"invite_des"] ;
    }
    
    return _rBottomImage ;
}

@end






