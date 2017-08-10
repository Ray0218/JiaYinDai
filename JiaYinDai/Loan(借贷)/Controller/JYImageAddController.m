//
//  JYImageAddController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/11.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYImageAddController.h"
#import "JYAddImgView.h"
#import "JYActionSheet.h"
#import "JYMediaPhotoHelper.h"

@interface JYImageAddController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    
    UIScrollView *_rScrollView ;
    
    //    NSMutableArray *rImgDataArr ;
    
    UIImage * rLastImage ;
    
}

@property (nonatomic, strong)UIView *rContentView ;

@property (nonatomic ,strong) UICollectionView *rCollectionView ;

@property (nonatomic ,strong) UIButton *rCommitBtn ;
@property (nonatomic ,strong) UITextField *rTipsField ;
@property (nonatomic ,strong) UILabel *rTitleLabel ;

@property (nonatomic ,strong) UIImageView *rTipImage ;

@property (nonatomic ,strong) JYAddImgView *rAddView ;
@property (nonatomic ,strong) MASConstraint *rCollectionCons  ;



@property (nonatomic ,strong) NSMutableArray *rSelectImageURL  ;



@end

static NSString *kCellIdentify = @"cellIdentify" ;




@implementation JYImageAddController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"银行收入流水" ;
    
    //    rImgDataArr = [[NSMutableArray alloc]init];
    
    self.rSelectImageURL = [[NSMutableArray alloc]init];
    
    
    if (self.rLastImges.length) {
        [self.rSelectImageURL addObjectsFromArray:[self.rLastImges componentsSeparatedByString:@","]] ;
    }
    
    self.rAddView.hidden = self.rSelectImageURL.count ;
    
    [self buildSubViewsUI];
    
    
    
}

-(void)buildSubViewsUI {
    
    
    _rScrollView = [[UIScrollView alloc]init];
    _rScrollView.showsVerticalScrollIndicator = NO ;
    _rScrollView.backgroundColor = [UIColor clearColor] ;
    [self.view addSubview:_rScrollView];
    
    [_rScrollView addSubview:self.rContentView];
    
    
    [self.rContentView addSubview:self.rCollectionView];
    [self.rContentView addSubview:self.rAddView];
    
    
    [self.rContentView addSubview:self.rCommitBtn];
    [self.rContentView addSubview:self.rTipsField];
    
    
    [self.view addSubview:self.rQuestButton];
    [self.view addSubview:self.rTelButton];
    
    
    
    [self.view setNeedsUpdateConstraints];
    
}

-(void)updateViewConstraints {
    
    
    [_rScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
    }] ;
    
    
    [self.rQuestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-15) ;
        make.right.equalTo(self.view.mas_centerX).offset(-15) ;
    }] ;
    
    
    [self.rTelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-15) ;
        make.left.equalTo(self.view.mas_centerX).offset(15) ;
    }] ;
    
    
    [self.rContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_rScrollView);
        make.height.mas_greaterThanOrEqualTo(SCREEN_HEIGHT);
        make.width.mas_equalTo(SCREEN_WIDTH) ;
        
    }];
    
    
    
    [self.rAddView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.rContentView) ;
        make.width.and.height.mas_equalTo(kImageHeigh) ;
        make.top.equalTo(self.rContentView).offset(5) ;
    }] ;
    
    [self.rCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rContentView).offset(5) ;
        make.left.equalTo(self.rContentView).offset(15) ;
        make.right.equalTo(self.rContentView).offset(-5) ;
        if (self.rSelectImageURL.count >= 3) {
            self.rCollectionCons= make.height.mas_equalTo(2*kImageHeigh+5) ;
        }else{
            self.rCollectionCons = make.height.mas_equalTo(kImageHeigh) ;
            
        }
    }] ;
    
    
        
    
    [self.rTipsField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.rContentView)  ;
        make.top.equalTo(self.rCollectionView.mas_bottom).offset(20);
        make.height.mas_equalTo(20) ;
        
    }];
    
    [self.rCommitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(15) ;
        make.right.equalTo(self.rContentView).offset(-15) ;
        make.height.mas_equalTo(45) ;
        make.top.equalTo(self.rTipsField.mas_bottom).offset(30) ;
        make.bottom.equalTo(self.rContentView).offset(-20).priorityLow() ;
    }] ;
    
    
    [super updateViewConstraints];
    
}

#pragma mark - UICollectionViewDelegate/UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.rSelectImageURL.count) {
        self.rCommitBtn.enabled = YES ;
        return self.rSelectImageURL.count+1 ;
    }
    
    self.rCommitBtn.enabled = NO  ;
    
    return 0 ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JYAddImgCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentify forIndexPath:indexPath ] ;
    
    if (indexPath.row == self.rSelectImageURL.count) {
        cell.rCellView.rDeleteBtn.hidden = YES ;
        
        cell.rCellView.rImageView.image = [UIImage imageNamed:@"imp_imgDefult"] ;
    }else{
        cell.rCellView.rDeleteBtn.hidden= NO ;
    }
    
    @weakify(self)
    cell.rDeleteBlock = ^(JYAddImgCollectionViewCell *cell) {
        @strongify(self)
        NSIndexPath *path = [self.rCollectionView indexPathForCell:cell] ;
        
        if (indexPath.row < self.rSelectImageURL.count) {
            [self.rSelectImageURL removeObjectAtIndex:path.row] ;
            [self.rCollectionView reloadData];
            if (self.rSelectImageURL.count <= 2) {
                self.rCollectionCons.mas_equalTo(kImageHeigh);
            }
            if (self.rSelectImageURL.count == 0) {
                self.rAddView.hidden = NO ;
                
            }else{
                self.rAddView.hidden = YES ;
                
            }
            
        }
        
    } ;
    
    if (indexPath.row == self.rSelectImageURL.count) {
        return cell ;
    }
    
    [cell.rCellView.rImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.rSelectImageURL[indexPath.row]]] placeholderImage:[UIImage imageNamed:@"imp_imgDefult"]] ; ;
    
    
    //    cell.rCellView.rImageView.image = self.rSelectImageURL[indexPath.row] ;
    
    return cell ;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"ddd") ;
    
    if (indexPath.row == self.rSelectImageURL.count) {
        
        
        
        [self pvt_addNewImage] ;
    }
    
    
    //    if (self.rSelectImageURL.count >= 3) {
    //        self.rCollectionCons.mas_equalTo(2*kImageHeigh+5) ;
    //    }
    
}


#pragma mark- action


-(void)pvt_loadData {

    [self pvt_uploadImage:rLastImage];

}


-(void)pvt_uploadImage:(UIImage*)image {
    
    rLastImage = image ;
    
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.6) ;
    
    NSString *dataStr = [NSString stringWithFormat:@"base64,%@", [imageData base64EncodedStringWithOptions:0]];
    
    NSString *imageName = @"ddd.jpg" ;// [[JYDateFormatter shareFormatter]jy_getCurrentDateString] ;
    
    NSMutableDictionary *dic  =[ NSMutableDictionary dictionary];
    
    
    [dic setValue:@"4" forKey:@"type"] ;
    
    [dic setValue:dataStr forKey:@"files"] ;
    [dic setValue:imageName forKey:@"filename"] ;
    
    @weakify(self)
    
    [JYProgressManager showWaitingWithTitle:@"图片上传中..." inView:self.view] ;
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kUploadPicURL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @strongify(self)
        [JYProgressManager hideAlert] ;
        NSString *imageUrl = responseObject[@"filename"] ;
        if (imageUrl) {
            [self.rSelectImageURL addObject:imageUrl] ;
         }

        if (self.rSelectImageURL.count >= 3) {
            self.rCollectionCons.mas_equalTo(2*kImageHeigh+5) ;
        }
        
        [self.rCollectionView reloadData] ;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }] ;
    
}

-(void)pvt_addNewImage {
    
    
    // 照片选择
    JYActionSheet *actionSheet = [[JYActionSheet alloc] initWithCancelStr:@"取消" otherButtonTitles:@[ @"拍照上传", @"本地上传" ] AttachTitle:@""];
    [actionSheet ChangeTitleColor:kBlackColor AndIndex:1];
    [actionSheet ButtonIndex:^(NSInteger Buttonindex) {
        
        switch (Buttonindex) {
            case 1: {
                [[JYMediaPhotoHelper shareInstance] getPhotoByICLibry:self SourcType:EIMediaPhotoType_Camera mediaphotoSuccessFn:^(UIImage *resultImage) {
                    
                     [self.rCollectionView  reloadData] ;
                    
                    self.rAddView.hidden = self.rSelectImageURL.count ;
                    
                    
                    [self pvt_uploadImage:resultImage] ;
                    
                    
                }  mediaphotoFailedFn:^(NSError *error){
                    
                }];
            } break;
                
            case 2: {
                [[JYMediaPhotoHelper shareInstance] getPhotoByICLibry:self SourcType:EIMediaPhotoType_Album mediaphotoSuccessFn:^(UIImage *resultImage) {
                    
                     [self.rCollectionView  reloadData] ;
                    
                    self.rAddView.hidden = self.rSelectImageURL.count ;
                    
                    [self pvt_uploadImage:resultImage] ;
                } mediaphotoFailedFn:^(NSError *error){
                    
                }];
                
            } break;
                
            default:
                break;
        }
        
    }];
    
    
    
    return ;
    
    
    
    
}


#pragma mark- gettr

-(UIView*)rContentView {
    if (_rContentView == nil) {
        _rContentView = [[UIView alloc]init];
        _rContentView.backgroundColor = kBackGroundColor ;
    }
    
    return _rContentView ;
}

-(UICollectionView*)rCollectionView {
    
    if (_rCollectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init] ;
        layout.itemSize = CGSizeMake(kImageHeigh, kImageHeigh) ;
        layout.minimumLineSpacing = 5 ;
        layout.minimumInteritemSpacing = 5 ;
        
        
        _rCollectionView =[[ UICollectionView  alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [_rCollectionView registerClass:[JYAddImgCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentify];
        _rCollectionView.scrollEnabled = NO ;
        _rCollectionView.delegate = self ;
        _rCollectionView.dataSource = self ;
        _rCollectionView.backgroundColor = [UIColor clearColor] ;
        
    }
    
    return _rCollectionView ;
}


-(JYAddImgView*)rAddView {
    if (_rAddView == nil) {
        _rAddView = [[JYAddImgView alloc]init];
        _rAddView.rImageView.userInteractionEnabled = NO  ;
        _rAddView.rDeleteBtn.hidden = YES ;
        _rAddView.rImageView.image = [UIImage imageNamed:@"imp_imgDefult"] ;
        @weakify(self)
        [[_rAddView.rBgView rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            
            
            [self pvt_addNewImage] ;
            
            
        }] ;
        
    }
    
    return _rAddView ;
}

-(UIButton*)rCommitBtn {
    if (_rCommitBtn == nil) {
        _rCommitBtn = [self jyCreateButtonWithTitle:@"提交"];
        _rCommitBtn.enabled = NO ;
        @weakify(self)
        [[_rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            
            if (self.rFinishBlock) {
                self.rFinishBlock([self.rSelectImageURL componentsJoinedByString:@","]) ;
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }] ;
    }
    
    return _rCommitBtn ;
}

-(UITextField*)rTipsField {
    if (_rTipsField == nil) {
        _rTipsField = [[UITextField alloc]init];
        
        
        _rTipsField.enabled = NO ;
        
        _rTipsField.leftViewMode = UITextFieldViewModeAlways ;
        _rTipsField.leftView = self.rTipImage ;
        _rTipsField.font = [UIFont systemFontOfSize:12] ;
        _rTipsField.textColor = kTextBlackColor ;
        _rTipsField.text = @" 注意:工资卡或其他银行卡近期连续6个月的流水" ;
        _rTipsField.textAlignment = NSTextAlignmentLeft ;
    }
    
    return _rTipsField ;
}

-(UILabel*)rTitleLabel {
    if (_rTitleLabel == nil) {
        _rTitleLabel = [self jyCreateLabelWithTitle:@"劳动合同或在职证明，拍照上传即可！" font:16 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rTitleLabel ;
}

-(UIImageView*)rTipImage {
    
    if (_rTipImage == nil) {
        _rTipImage = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@"imp_attention"] ] ;
        _rTipImage.contentMode = UIViewContentModeCenter ;
        _rTipImage.frame = CGRectMake(0, 0, 20, 20) ;
        
    }
    
    return _rTipImage ;
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
