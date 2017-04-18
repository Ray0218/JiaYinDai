//
//  JYPickerView.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/18.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPickerView.h"

@interface JYPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    NSInteger selectRow;
    
}

@property (nonatomic ,strong) UIButton *rCancleButton ;
@property (nonatomic ,strong) UIButton *rCommitButton ;

@property (nonatomic ,strong) UIPickerView *rPickerView ;



@end

@implementation JYPickerView



- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        self.backgroundColor = kBlueColor ;
        [self addSubview:self.rCommitButton];
        [self addSubview:self.rCancleButton];
        [self addSubview:self.rPickerView];
    }
    return self;
}

-(void)layoutSubviews {
    
    [self.rCancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15) ;
        make.top.equalTo(self).offset(10) ;
        
    }] ;
    
    [self.rCommitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15) ;
        make.top.equalTo(self).offset(10) ;
    }] ;
    
    [self.rPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self) ;
        make.top.equalTo(self.rCommitButton.mas_bottom).offset(10) ;
    }] ;
}


-(void)setRDataArray:(NSArray *)rDataArray {
    
    _rDataArray = [rDataArray copy] ;
    [self.rPickerView reloadAllComponents] ;
}

#pragma mark - UIPickerViewDataSource

//返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

//每列对应多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return  self.rDataArray.count;
}

//每行显示的数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return  self.rDataArray[row] ;
}


#pragma mark - UIPickerViewDelegate

//选中pickerView的某一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"%zd",row) ;
    selectRow = row;
    
    
}



#pragma mark- getter
-(UIPickerView*)rPickerView {
    
    if (_rPickerView == nil) {
        _rPickerView = [[UIPickerView alloc]init];
        _rPickerView.delegate = self ;
        _rPickerView.dataSource = self ;
        _rPickerView.backgroundColor =[ UIColor whiteColor] ;
    }
    
    return _rPickerView ;
    
}

-(UIButton*)rCommitButton {
    
    if (_rCommitButton == nil) {
        _rCommitButton =({
            UIButton *btn =  [UIButton buttonWithType:UIButtonTypeCustom] ;
            [btn setTitle:@"确认" forState:UIControlStateNormal] ;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14] ;
            btn ;
            
        }) ;
        
        @weakify(self)
        [[[_rCommitButton rac_signalForControlEvents:UIControlEventTouchUpInside] map:^id(id value) {
            return self.rDataArray[selectRow] ;
        }]  subscribeNext:^(NSString* x) {
            @strongify(self)
            if (self.rSelectBlock) {
                self.rSelectBlock(x) ;
            }
            self.hidden = YES ;
        }] ;
        
    }
    
    return _rCommitButton ;
}


-(UIButton*)rCancleButton {
    if (_rCancleButton == nil) {
        _rCancleButton = ({
            UIButton *btn =  [UIButton buttonWithType:UIButtonTypeCustom] ;
            [btn setTitle:@"取消" forState:UIControlStateNormal] ;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14] ;
            btn ;
            
        }) ;
        
        @weakify(self)
        [[_rCancleButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            self.hidden = YES ;
        }] ;
    }
    
    return _rCancleButton ;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
