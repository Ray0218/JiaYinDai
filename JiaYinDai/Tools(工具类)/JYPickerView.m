//
//  JYPickerView.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/18.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPickerView.h"

@interface JYPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    
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

-(void)setRSelectRow:(NSInteger)rSelectRow{
    
    _rSelectRow = rSelectRow ;
    
    if (self.rDataArray.count > rSelectRow) {
        [self.rPickerView selectRow:rSelectRow inComponent:0 animated:NO] ;
     }

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
    self.rSelectRow = row;
    
    
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
            return self.rDataArray[self.rSelectRow] ;
        }]  subscribeNext:^(NSString* x) {
            @strongify(self)
            if (self.rSelectBlock) {
                self.rSelectBlock(x,self.rSelectRow+1) ;
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


@interface JYDatePicker()
@property (nonatomic ,strong) UIButton *rCancleButton ;
@property (nonatomic ,strong) UIButton *rCommitButton ;

@property (nonatomic ,strong) UIDatePicker *rDatePicker ;

@property (nonatomic ,strong) NSString *rDateString ;


@end

@implementation JYDatePicker

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        self.backgroundColor = kBlueColor ;
        [self addSubview:self.rCommitButton];
        [self addSubview:self.rCancleButton];
        [self addSubview:self.rDatePicker];
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
    
    [self.rDatePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self) ;
        make.top.equalTo(self.rCommitButton.mas_bottom).offset(10) ;
    }] ;
}



#pragma mark - 实现oneDatePicker的监听方法
- (void)pvt_valueChange:(UIDatePicker *) sender {
    
    NSDate *select = [sender date]; // 获取被选中的时间
    
     self.rDateString = [[[JYDateFormatter shareFormatter]jy_getFormatterWithType:JYDateFormatTypeYMD]stringFromDate:select] ;
    
    // 在控制台打印消息
    NSLog(@"%@", [sender date]);
}




#pragma mark- getter
-(UIDatePicker*)rDatePicker  {
    
    if (_rDatePicker == nil) {
        //创建一个UIPickView对象
        _rDatePicker = [[UIDatePicker alloc]init];
        _rDatePicker.minimumDate = [NSDate date] ;
        //设置背景颜色
        _rDatePicker.backgroundColor = [UIColor whiteColor];
         //设置本地化支持的语言（在此是中文)
        _rDatePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        //显示方式是只显示年月日
        _rDatePicker.datePickerMode = UIDatePickerModeDate;
        [_rDatePicker addTarget:self action:@selector(pvt_valueChange:) forControlEvents:UIControlEventValueChanged] ;
    }
    
    return _rDatePicker ;
    
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
        
        [[_rCommitButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)

            self.hidden = YES ;
            
            if (self.rSelectBlock) {
                self.rSelectBlock(self.rDateString) ;
            }

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




@end


