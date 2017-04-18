//
//  JYImageAddController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/11.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYImageAddController.h"
#import "JYAddImgView.h"

@interface JYImageAddController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    
    UIScrollView *_rScrollView ;
    
    NSMutableArray *rImgDataArr ;
    
    
}

@property (nonatomic, strong)UIView *rContentView ;

@property (nonatomic ,strong) UICollectionView *rCollectionView ;

@property (nonatomic ,strong) UIButton *rCommitBtn ;
@property (nonatomic ,strong) UITextField *rTipsView ;
@property (nonatomic ,strong) JYAddImgView *rAddView ;
@property (nonatomic ,strong) MASConstraint *rCollectionCons  ;



@end

static NSString *kCellIdentify = @"cellIdentify" ;




@implementation JYImageAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"银行收入流水" ;
    
    [self buildSubViewsUI];
    
    rImgDataArr = [[NSMutableArray alloc]init];
    
    
    
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
    [self.rContentView addSubview:self.rTipsView];
    
    
    
    [self.view setNeedsUpdateConstraints];
    
}

-(void)updateViewConstraints {
    
    
    [_rScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero) ;
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
        self.rCollectionCons = make.height.mas_equalTo(kImageHeigh ) ;
    }] ;
    
    
    [self.rTipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.rContentView) ;
        make.top.equalTo(self.rCollectionView.mas_bottom).offset(20);
        make.height.mas_equalTo(40) ;
        
    }];
    
    [self.rCommitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rContentView).offset(15) ;
        make.right.equalTo(self.rContentView).offset(-15) ;
        make.height.mas_equalTo(45) ;
        make.top.equalTo(self.rTipsView.mas_bottom).offset(30) ;
        make.bottom.equalTo(self.rContentView).offset(-20).priorityLow() ;
    }] ;
    
    
    [super updateViewConstraints];
    
}

#pragma mark - UICollectionViewDelegate/UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (rImgDataArr.count) {
        return rImgDataArr.count+1 ;
        
    }
    return 0 ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JYAddImgCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentify forIndexPath:indexPath ] ;
    
    if (indexPath.row == rImgDataArr.count) {
        cell.rCellView.rDeleteBtn.hidden = YES ;
    }else{
        cell.rCellView.rDeleteBtn.hidden= NO ;
    }
    
    @weakify(self)
    cell.rDeleteBlock = ^(JYAddImgCollectionViewCell *cell) {
        @strongify(self)
        NSIndexPath *path = [self.rCollectionView indexPathForCell:cell] ;
        
        if (indexPath.row < rImgDataArr.count) {
            [rImgDataArr removeObjectAtIndex:path.row] ;
            [self.rCollectionView reloadData];
            if (rImgDataArr.count <= 2) {
                self.rCollectionCons.mas_equalTo(kImageHeigh);
            }
            if (rImgDataArr.count == 0) {
                self.rAddView.hidden = NO ;
                
            }else{
                self.rAddView.hidden = YES ;
                
            }
            
        }
          
    } ;
    
    if (indexPath.row == rImgDataArr.count) {
        return cell ;
    }
    

    return cell ;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"ddd") ;
    
    if (indexPath.row == rImgDataArr.count) {
        [rImgDataArr addObject:@"new"] ;
        [self.rCollectionView reloadData];
    }
    
    
    if (rImgDataArr.count >= 3) {
        self.rCollectionCons.mas_equalTo(2*kImageHeigh+5) ;
    }
    
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
        @weakify(self)
        [[_rAddView.rBgView rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            
            self.rAddView.hidden = YES ;
            
            [rImgDataArr addObject:@"new"] ;
            [self.rCollectionView reloadData];
            
            
        }] ;
        
    }
    
    return _rAddView ;
}

-(UIButton*)rCommitBtn {
    if (_rCommitBtn == nil) {
        _rCommitBtn = [self jyCreateButtonWithTitle:@"提交"];
    }
    
    return _rCommitBtn ;
}

-(UITextField*)rTipsView {
    if (_rTipsView == nil) {
        _rTipsView = [[UITextField alloc]init];
        
        _rTipsView.leftViewMode = UITextFieldViewModeAlways ;
        _rTipsView.text = @"注意:工资卡或其他银行卡近期连续6个月的流水" ;
        _rTipsView.enabled = NO ;
        _rTipsView.font = [UIFont systemFontOfSize:14] ;
        _rTipsView.leftView = ({
            UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30) ];
            view.backgroundColor = [UIColor purpleColor] ;
            view ;
        }) ;
    }
    
    return _rTipsView ;
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
