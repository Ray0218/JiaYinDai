//
//  JYEstimateView.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/29.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYEstimateView.h"

@interface JYEstimateView (){
    UILabel *_titleLab ;
}

@property(nonatomic ,strong)UILabel *rTitleLabel ; //

@property(nonatomic ,strong)UITextField *rTextField  ; //输入框

@property(nonatomic ,strong)UIButton *rCommitBtn  ; //计算

@property(nonatomic ,strong)UILabel *rResultLab  ; //预估值


@end

@implementation JYEstimateView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor] ;
        self.layer.borderWidth = 1 ;
        self.layer.borderColor = kLineColor.CGColor ;
        
        [self buildSubViewsUI];
    }
    return self;
}

-(void)buildSubViewsUI {

    _titleLab = [self createLabelWithTitle:@"投标金额" font:14 color:kTextBlackColor align:NSTextAlignmentLeft];
    [self addSubview:_titleLab];
    
    [self addSubview:self.rTextField];
    [self addSubview:self.rCommitBtn];
    [self addSubview:self.rResultLab];
    
    
}

-(void)layoutSubviews {

    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15) ;
        make.top.equalTo(self).offset(15) ;
    }];
    
    [self.rTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLab) ;
        make.top.equalTo(_titleLab.mas_bottom).offset(15) ;
        make.right.equalTo(self).offset(-130) ;
        make.height.mas_equalTo(35) ;
    }];
    
    
    [self.rCommitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15) ;
        make.top.equalTo(_titleLab.mas_bottom).offset(15) ;
        make.width.mas_equalTo(100)  ;
        make.height.mas_equalTo(35) ;

    }];
    
    [self.rResultLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLab) ;
        make.bottom.equalTo(self).offset(-15) ;
    }];
}

#pragma mark- getter

-(UITextField*)rTextField {

    if (_rTextField == nil) {
        _rTextField = [[UITextField alloc]init];
        _rTextField.backgroundColor = [UIColor clearColor] ;
        _rTextField.rightViewMode = UITextFieldViewModeAlways ;
        _rTextField.leftViewMode = UITextFieldViewModeAlways ;

        _rTextField.placeholder = @"请输入金额" ;
        _rTextField.keyboardType = UIKeyboardTypePhonePad ;
        _rTextField.font = [UIFont systemFontOfSize:14] ;
        _rTextField.rightView = ({
             UILabel* lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
            lab.font = [UIFont systemFontOfSize:14] ;
            lab.textAlignment = NSTextAlignmentLeft ;
            lab.text = @"元" ;
            lab ;
        }) ;
        
        _rTextField.leftView = ({
            UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
              view ;
        }) ;
        
        _rTextField.layer.borderColor = kLineColor.CGColor ;
        _rTextField.layer.borderWidth = 1 ;
        _rTextField.layer.cornerRadius = 4 ;
        
        [_rTextField.rac_textSignal  subscribeNext:^(NSString* x) {
            
            if (x.length) {
                _rTextField.text = [NSString stringWithFormat:@"%zd",[x integerValue] ];
             }
            
        }] ;
      
    
    }
    return _rTextField ;
}

-(UIButton*)rCommitBtn {
    if (_rCommitBtn == nil) {
        _rCommitBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [_rCommitBtn setTitle:@"计算" forState:UIControlStateNormal];
        [_rCommitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rCommitBtn.titleLabel.font = [UIFont systemFontOfSize:14] ;
        _rCommitBtn.layer.cornerRadius = 4 ;
        _rCommitBtn.clipsToBounds = YES ;
        _rCommitBtn.backgroundColor = kBlueColor ;
        [_rCommitBtn addTarget:self action:@selector(pvt_commit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rCommitBtn ;
}

-(UILabel*)rResultLab {
    if (_rResultLab == nil) {
        _rResultLab = [self createLabelWithTitle:@"投标预估收益632.30元" font:14 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    return _rResultLab ;
}


- (UILabel*)createLabelWithTitle:(NSString*)title font:(CGFloat)font color:(UIColor*)color align:(NSTextAlignment) align{
    
    UILabel *label = [[UILabel alloc]init];
    label.text = title ;
    label.textColor = color ;
    label.font = [UIFont systemFontOfSize:font] ;
    label.textAlignment = align ;
    label.backgroundColor = [UIColor clearColor] ;
    
    return label ;
}


#pragma mark- action

-(void)pvt_commit{
    NSLog(@"计算") ;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


//[_rTextField.rac_textSignal subscribeNext:^(NSString* x) {
//    static NSInteger const maxIntegerLength=8;//最大整数位
//    static NSInteger const maxFloatLength=2;//最大精确到小数位
//    
//    if (x.length) {
//        //第一个字符处理
//        //第一个字符为0,且长度>1时
//        if ([[x substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"]) {
//            if (x.length>1) {
//                if ([[x substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"0"]) {
//                    //如果第二个字符还是0,即"00",则无效,改为"0"
//                    _rTextField.text=@"0";
//                }else if (![[x substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"."]){
//                    //如果第二个字符不是".",比如"03",清除首位的"0"
//                    _rTextField.text=[x substringFromIndex:1];
//                }
//            }
//        }
//        //第一个字符为"."时,改为"0."
//        else if ([[x substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"."]){
//            _rTextField.text=@"0.";
//        }
//        
//        //2个以上字符的处理
//        NSRange pointRange = [x rangeOfString:@"."];
//        NSRange pointsRange = [x rangeOfString:@".."];
//        if (pointsRange.length>0) {
//            //含有2个小数点
//            _rTextField.text=[x substringToIndex:x.length-1];
//        }
//        else if (pointRange.length>0){
//            //含有1个小数点时,并且已经输入了数字,则不能再次输入小数点
//            if ((pointRange.location!=x.length-1) && ([[x substringFromIndex:x.length-1]isEqualToString:@"."])) {
//                _rTextField.text=[x substringToIndex:x.length-1];
//            }
//            if (pointRange.location+maxFloatLength<x.length) {
//                //输入位数超出精确度限制,进行截取
//                
//                _rTextField.text=[x substringToIndex:pointRange.location+maxFloatLength+1];
//            }
//        }
//        else{
//            if (x.length>maxIntegerLength) {
//                _rTextField.text=[x substringToIndex:maxIntegerLength];
//            }
//        }
//        
//    }
//}] ;
