//
//  JYLoanUsedController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/10.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoanUsedController.h"
#import "JYLoanUsedCollectionViewCell.h"
#import "JYPayCommtController.h"

#import "JYTextView.h"
#import "UITextField+Limit.h"




@interface JYLoanUsedController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate>{
    UIScrollView *_rScrollView ;
    
    UIView *rBackView ;
    UIView *rLineView ;
    UILabel *rTitleLabel ;
    
    UILabel *rDescLabel ;
    
    
}
@property (nonatomic, strong)UIView *rContentView ;

@property (nonatomic ,strong) UICollectionView *rCollectionView ;


@property (nonatomic, strong)JYTextView *rTextView ;

@property (nonatomic, strong)UIButton *rCommitBtn ;

@property (nonatomic ,strong) UITextField *rTextField ;


@property (nonatomic ,strong) MASConstraint *rCollectionCons  ;

@property (nonatomic ,strong) NSMutableArray *rUsedArray ;



@end

static NSString *kCellIdentify = @"cellIdentify" ;
static NSString *kHeaderIdentify = @"kHeaderIdentify" ;




@implementation JYLoanUsedController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.rTextField.text = self.rTitleStr ;
    
    self.rTextView.text = self.rDetailStr ;
    
    [self.rTextView  textViewEditChanged:nil ];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title  = @"借款用途" ;
    [self buildSubViewUI];
    
    
    self.rUsedArray = [NSMutableArray arrayWithObjects: @"资金周转，诚信借贷",
                       @"短期借款，随借随还",
                       @"信誉保证，高额回报",
                       @"筹资装修，临时周转",
                       @"短期急用，回报可观",
                       @"买车缺额，按约还款",
                       @"有借有还，信誉良好",
                       @"结婚周转，按约还款",
                       @"小店开张，恳请支持",
                       @"房租周转，按期还款", nil] ;
    
    
}

-(void)buildSubViewUI {
    
    
    
    _rScrollView = [[UIScrollView alloc]init];
    _rScrollView.showsVerticalScrollIndicator = NO ;
    _rScrollView.backgroundColor = [UIColor clearColor] ;
    [self.view addSubview:_rScrollView];
    
    [_rScrollView addSubview:self.rContentView];
    
    
    [self.rContentView addSubview:self.rTextView];
    [self.rContentView addSubview:self.rCommitBtn];
    
    
    rBackView = ({
        UIView *view = [[UIView alloc]init];
        view.layer.borderColor = kLineColor.CGColor ;
        view.layer.borderWidth = 1 ;
        view.layer.cornerRadius = 5 ;
        view.backgroundColor = [UIColor whiteColor] ;
        view ;
    }) ;
    
    rTitleLabel =[ self jyCreateLabelWithTitle:@"借款标题" font:16 color:kBlackColor align:NSTextAlignmentLeft] ;
    
    rDescLabel = [ self jyCreateLabelWithTitle:@"借款描述" font:14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    
    rLineView = ({
        UIView *view = [[UIView alloc]init];
        view.backgroundColor =  kLineColor;
        view ;
    }) ;
    
    
    [self.rContentView addSubview:rBackView];
    [self.rContentView addSubview:rTitleLabel];
    [self.rContentView addSubview:rLineView];
    
    [self.rContentView addSubview:self.rTextField];
    
    [self.rContentView addSubview:self.rCollectionView];
    
    [self.rContentView addSubview:rDescLabel];
    
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
    
    
    [rBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self.rContentView).offset(15) ;
        make.right.equalTo(self.rContentView).offset(-15) ;
        make.height.mas_equalTo(45) ;
    }];
    
    
    
    [self.rCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rBackView.mas_bottom) ;
        make.left.equalTo(self.rContentView).offset(15) ;
        make.right.equalTo(self.rContentView).offset(-15) ;
        self.rCollectionCons = make.height.mas_equalTo(0) ;
    }] ;
    
    
    [rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rBackView).offset(15) ;
        make.centerY.equalTo(rBackView) ;
        make.width.mas_equalTo(66) ;
        
    }] ;
    
    
    [rLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rTitleLabel.mas_right).offset(15) ;
        make.width.mas_equalTo(1) ;
        make.centerY.equalTo(rBackView) ;
        make.height.mas_equalTo(35) ;
    }];
    
    [self.rTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rBackView).offset(-5) ;
        make.centerY.equalTo(rBackView) ;
        make.left.equalTo(rLineView.mas_right).offset(15) ;
        make.height.mas_equalTo(45) ;
        
    }] ;
    
    
    [rDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rCollectionView.mas_bottom);
        make.left.equalTo(self.rContentView).offset(15) ;
        make.height.mas_equalTo(40) ;
    }] ;
    
    [self.rTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rDescLabel.mas_bottom)  ;
        make.centerX.equalTo(self.rContentView) ;
        make.width.mas_equalTo(SCREEN_WIDTH-30) ;
        make.height.mas_equalTo(200) ;
    }] ;
    
    
    
    
    [self.rCommitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rTextView.mas_bottom).offset(25) ;
        make.left.equalTo(self.rContentView).offset(15) ;
        make.right.equalTo(self.rContentView).offset(-15) ;
        make.bottom.equalTo(self.rContentView).offset(-20).priorityLow() ;
        make.height.mas_equalTo(45) ;
    }] ;
    
    
    
    [super updateViewConstraints];
    
}




#pragma mark - UICollectionViewDelegate/UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.rUsedArray.count ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JYLoanUsedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentify forIndexPath:indexPath ] ;
    cell.rTitleLabel.text = self.rUsedArray[indexPath.item] ;
    
    return cell ;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    MyHeadView *headerView   = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderIdentify forIndexPath:indexPath  ] ;
    
    return headerView ;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    JYLoanUsedCollectionViewCell *cell = (JYLoanUsedCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath] ;
    
    self.rTextField.text = cell.rTitleLabel.text ;
    [self.rTextField endEditing:YES];
}


#pragma mark- action

-(void)pvt_dissKeyBoard {
    
    
    [self.view endEditing:YES];
}



#pragma mark- getter

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
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-45)/2.0, 40) ;
        layout.minimumLineSpacing = 15 ;
        layout.minimumInteritemSpacing = 15 ;
        layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 50) ;
        
        _rCollectionView =[[ UICollectionView  alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [_rCollectionView registerClass:[JYLoanUsedCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentify];
        [_rCollectionView registerClass:[MyHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderIdentify];
        
        _rCollectionView.delegate = self ;
        _rCollectionView.dataSource = self ;
        _rCollectionView.backgroundColor = [UIColor clearColor] ;
        
    }
    
    return _rCollectionView ;
}

-(JYTextView*)rTextView {
    
    if (_rTextView == nil) {
        _rTextView = [[JYTextView alloc]init ];
        _rTextView.textAlignment = NSTextAlignmentLeft ;
        _rTextView.layer.cornerRadius = 5 ;
        _rTextView.layer.borderColor = kLineColor.CGColor ;
        _rTextView.layer.borderWidth = 1 ;
        _rTextView.backgroundColor = [UIColor whiteColor] ;
        _rTextView.font = [UIFont systemFontOfSize:13] ;
        
    }
    
    
    return _rTextView ;
}


-(UITextField*)rTextField {
    
    if (_rTextField == nil) {
        _rTextField = [[UITextField alloc]init];
        _rTextField.placeholder = @"请如实填写您的借款用途，8-15字" ;
        _rTextField.font = [UIFont systemFontOfSize:13] ;
        [_rTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone] ;
        @weakify(self)
        [[_rTextField rac_signalForControlEvents:UIControlEventEditingDidBegin]subscribeNext:^(id x) {
            @strongify(self)
            
            [self.rCollectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(rBackView.mas_bottom) ;
                make.left.equalTo(self.rContentView).offset(15) ;
                make.right.equalTo(self.rContentView).offset(-15) ;
                make.height.mas_equalTo(300) ;
            }] ;
            
            
        }] ;
        
        [[_rTextField rac_signalForControlEvents:UIControlEventEditingDidEnd]subscribeNext:^(UITextField* textField) {
            @strongify(self)
            
            [self.rCollectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(rBackView.mas_bottom) ;
                make.left.equalTo(self.rContentView).offset(15) ;
                make.right.equalTo(self.rContentView).offset(-15) ;
                make.height.mas_equalTo(0) ;
            }] ;
            
            
            NSString *temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            NSString *text = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
            
            _rTextField.text = text ;
            
        }] ;
        
        
        _rTextField.rMaxLength = 15 ;
        
        [[_rTextField rac_signalForControlEvents:UIControlEventEditingChanged]subscribeNext:^(id x) {
            
            [_rTextField jy_textViewEditChanged] ;
        }] ;
        
    }
    
    return _rTextField ;
}

-(UIButton*)rCommitBtn {
    
    if (_rCommitBtn == nil) {
        _rCommitBtn = [self jyCreateButtonWithTitle:@"提交"] ;
        
        @weakify(self)
        [[_rCommitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            
            
            if (self.rTextField.text.length <= 0) {
                [JYProgressManager showBriefAlert:@"标题不能为空"] ;
                
                return  ;
            }
            
            if (self.rTextView.text.length <= 0) {
                [JYProgressManager showBriefAlert:@"借款描述不能为空"] ;
                return ;
            }
            
            
            @strongify(self)
            if (self.rUsedBlock) {
                self.rUsedBlock(self.rTextField.text, self.rTextView.text) ;
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }] ;
    }
    
    return _rCommitBtn ;
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
