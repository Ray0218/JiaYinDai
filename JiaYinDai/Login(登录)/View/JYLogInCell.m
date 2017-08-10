//
//  JYLogInCell.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/5.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLogInCell.h"

@interface JYLogInCell (){
    
    JYLogCellType rType ;
}


@property (nonatomic,strong) UITextField *rTextField ;

@property (nonatomic,strong) UIImageView *rLeftImgView ;
@property (nonatomic,strong) UIButton *rRightBtn ;


@end

@implementation JYLogInCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(instancetype)initWithCellType:(JYLogCellType)type reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] ;
    if (self) {
        
        rType = type ;
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        [self buildSubViewsUI];
    }
    
    return self ;
}

-(void)buildSubViewsUI {
    
    [self.contentView addSubview:self.rTextField];
    [self.contentView addSubview:self.rLeftImgView];
    
    if (rType != JYLogCellTypeNormal) {
        [self.contentView addSubview:self.rRightBtn];
        
        
        //        @weakify(self)
        //        [[self.rRightBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        //
        //            @strongify(self)
        //
        //            if (rType == JYLogCellTypePassword) {
        //                self.rRightBtn.selected = !self.rRightBtn.selected ;
        //                self.rTextField.secureTextEntry = !self.rRightBtn.selected ;
        //            }else{
        //
        //                //                [self startTimeGCD];
        //
        //            }
        //
        //        }] ;
        
        
        
        
    }
    
    
    
    switch (rType) {
        case JYLogCellTypePassword:{
            self.rLeftImgView.image = [UIImage imageNamed:@"password_icon"] ;
            self.rTextField.placeholder = @"请输入登录密码" ;
            
            [self.rRightBtn setImage:[UIImage imageNamed:@"eye_icon"]  forState:UIControlStateSelected];
            [self.rRightBtn setImage:[UIImage imageNamed:@"eye_close"]  forState:UIControlStateNormal];
            self.rTextField.secureTextEntry = YES ;
            
            
            @weakify(self)
            [[self.rRightBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
                
                @strongify(self)
                
                self.rRightBtn.selected = !self.rRightBtn.selected ;
                self.rTextField.secureTextEntry = !self.rRightBtn.selected ;
            }] ;
            
            
        }
            break;
        case JYLogCellTypeMakesurePassword:{
            self.rLeftImgView.image = [UIImage imageNamed:@"makesure_icon"] ;
            self.rTextField.placeholder = @"确认登录密码" ;
            [self.rRightBtn setImage:[UIImage imageNamed:@"eye_icon"]  forState:UIControlStateSelected];
            [self.rRightBtn setImage:[UIImage imageNamed:@"eye_close"]  forState:UIControlStateNormal];
            self.rTextField.secureTextEntry = YES ;
            
            @weakify(self)
            [[self.rRightBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
                
                @strongify(self)
                
                self.rRightBtn.selected = !self.rRightBtn.selected ;
                self.rTextField.secureTextEntry = !self.rRightBtn.selected ;
            }] ;
            
            
        }break ;
        case JYLogCellTypeCode:{
            self.rLeftImgView.image = [UIImage imageNamed:@"code_icon"] ;
            self.rTextField.placeholder = @"请输入验证码" ;
            self.rRightBtn.backgroundColor = kBlueColor ;
            
        }break ;
        default:{
            self.rLeftImgView.image = [UIImage imageNamed:@"person_icon"] ;
            self.rTextField.placeholder = @"请输入手机号码" ;
        }
            
            break;
    }
    
    
    if (rType == JYLogCellTypePassword || rType == JYLogCellTypeMakesurePassword) {
        self.rTextField.keyboardType = UIKeyboardTypeDefault ;
    }else{
        
        self.rTextField.keyboardType = UIKeyboardTypeNumberPad ;
    }
    
    
    [self layoutSubviewsConstains];
    
    
    
    
    
}

-(void)layoutSubviewsConstains {
    
    
    [self.rLeftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15) ;
        make.width.and.height.mas_equalTo(30) ;
        make.centerY.equalTo(self.contentView) ;
    }] ;
    
    
    if (rType == JYLogCellTypeNormal) {
        [self.rTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.rLeftImgView.mas_right).offset(15) ;
            make.centerY.equalTo(self.contentView) ;
            make.right.equalTo(self.contentView).offset(-15) ;
            make.height.mas_equalTo(44) ;
            
            
        }] ;
    }else{
        
        [self.rTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.rLeftImgView.mas_right).offset(15) ;
            make.centerY.equalTo(self.contentView) ;
            make.right.equalTo(self.rRightBtn.mas_left).offset(-5) ;
            make.height.mas_equalTo(44) ;

        }] ;
        
        
        if (rType == JYLogCellTypeCode) {
            
            [_rRightBtn setTitle:@"获取验证码" forState:UIControlStateNormal] ;
            
            [self.rRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.contentView).offset(-15) ;
                make.centerY.equalTo(self.contentView) ;
                make.height.mas_equalTo(30) ;
                make.width.mas_equalTo(80) ;
                
            }];
            
        }else{
            
            
            [self.rRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.contentView).offset(-15) ;
                make.centerY.equalTo(self.contentView) ;
                make.width.and.height.mas_equalTo(30) ;
            }];
            
        }
        
    }
    
    
}

- (void)startTimeGCD

{
    
    @weakify(self)
    //设置倒计时总时长
    
    __block int timeout= 59;
    
    //创建队列(全局并发队列)
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        @strongify(self)
        
        if(timeout<=0){
            
            //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            //回到主线程更新UI
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                [self.rRightBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.rRightBtn.enabled = YES ;
                self.rRightBtn.backgroundColor = kBlueColor ;
            });
            
        }else{
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%ds", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                [self.rRightBtn setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
                self.rRightBtn.enabled = NO ;
                [self.rRightBtn setBackgroundColor:[UIColor lightGrayColor] ];
                
                
                //                [UIView beginAnimations:nil context:nil];
                
                //                [UIView setAnimationDuration:1];
                
                //                [self.btn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                //
                //                //                [UIView commitAnimations];
                //
                //                self.btn.userInteractionEnabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
    
}




#pragma mark- getter

-(UITextField*)rTextField {
    if (_rTextField == nil) {
        _rTextField = [[UITextField alloc]init];
        _rTextField.backgroundColor =[ UIColor clearColor] ;
        _rTextField.font = [UIFont systemFontOfSize:13] ;
    }
    return _rTextField ;
}

-(UIImageView*)rLeftImgView {
    if (_rLeftImgView == nil) {
        _rLeftImgView = [[UIImageView alloc]init];
        _rLeftImgView.backgroundColor  = [UIColor clearColor] ;
        _rLeftImgView.contentMode = UIViewContentModeCenter ;
    }
    
    return _rLeftImgView ;
}

-(UIButton*)rRightBtn {
    if (_rRightBtn == nil) {
        _rRightBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        //        _rRightBtn.backgroundColor =  kBlueColor;
        _rRightBtn.layer.cornerRadius = 4;
        _rRightBtn.clipsToBounds = YES ;
        _rRightBtn.titleLabel.font = [UIFont systemFontOfSize:14] ;
        
    }
    return _rRightBtn ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end



@interface JYLogFootView ()
{
    
    JYLogFootViewType rLogType ;
}
@property (nonatomic ,strong) UIButton *rCommitBtn ;
@property (nonatomic ,strong) UIButton *rForgetBtn ;
@property (nonatomic ,strong) UIButton *rRegisterBtn;

@property (nonatomic ,strong) UILabel *rDescLabel;


@property (nonatomic ,strong) JYAgreeView *rAgreeView ;



@end

@implementation JYLogFootView

- (instancetype)initWithType:(JYLogFootViewType)type
{
    self = [super init];
    if (self) {
        rLogType = type ;
        [self buildSubUIWithType:type];
        
        
    }
    return self;
}

-(void)buildSubUIWithType:(JYLogFootViewType)type {
    
    [self addSubview:self.rCommitBtn];
    
    
    
    if (type == JYLogFootViewTypeLogIn) {
        
        [self.rCommitBtn setTitle:@"登录" forState:UIControlStateNormal];
        [self addSubview:self.rForgetBtn];
        [self addSubview:self.rRegisterBtn];
        
        
        
    }else if (type == JYLogFootViewTypeSetPassword) {
        
         
        [self addSubview:self.rAgreeView];
        
        
        [self.rCommitBtn setTitle:@"完成" forState:UIControlStateNormal];
        
        
        
    }else if(type == JYLogFootViewTypeNormal){
        
        [self addSubview:self.rDescLabel];
        [self.rCommitBtn setTitle:@"完成" forState:UIControlStateNormal];
        
        
        
    } else{
        [self.rCommitBtn setTitle:@"下一步" forState:UIControlStateNormal];
        
        
        
    }
    
}

-(void)layoutSubviews {
    
    
    if (rLogType == JYLogFootViewTypeLogIn) {
        
        
        [self.rCommitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15) ;
            make.right.equalTo(self).offset(-15) ;
            make.height.mas_equalTo(45) ;
            make.top.equalTo(self).offset(20) ;
            
        }];
        
        
        [self.rForgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15) ;
            make.top.equalTo(self.rCommitBtn.mas_bottom).offset(10) ;
            make.height.mas_equalTo(30)  ;
        }] ;
        
        
        [self.rRegisterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15) ;
            make.top.equalTo(self.rCommitBtn.mas_bottom).offset(10) ;
            make.height.mas_equalTo(30)  ;
        }] ;
        
        
        
    }else if (rLogType == JYLogFootViewTypeSetPassword) {
        
        
        [self.rAgreeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15) ;
            make.top.equalTo(self).offset(15) ;
            make.height.mas_equalTo(25) ;
            make.right.equalTo(self).offset(-15) ;
            
        }] ;
        
        
        
        
        [self.rCommitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15) ;
            make.right.equalTo(self).offset(-15) ;
            make.height.mas_equalTo(45) ;
            make.bottom.equalTo(self).offset(-15) ;
            
        }];
        
        
    }else  if(rLogType == JYLogFootViewTypeNormal){
        
        [self.rDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(15) ;
            make.top.equalTo(self).offset(15) ;
            make.right.equalTo(self).offset(-15) ;
        }] ;
        
        [self.rCommitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15) ;
            make.right.equalTo(self).offset(-15) ;
            make.height.mas_equalTo(45) ;
            make.bottom.equalTo(self).offset(-15) ;
            
        }];
        
    }else{
        
        
        [self.rCommitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15) ;
            make.right.equalTo(self).offset(-15) ;
            make.height.mas_equalTo(45) ;
            //            make.top.equalTo(self).offset(40) ;
            make.bottom.equalTo(self).offset(-15);
            
        }];
    }
    
    
}


-(UIButton*)rCommitBtn {
    if (_rCommitBtn == nil) {
        _rCommitBtn = [self jyCreateButtonWithTitle:@""] ;
        _rCommitBtn.backgroundColor = [UIColor clearColor] ;
        [_rCommitBtn setBackgroundImage:[UIImage jy_imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled] ;
        [_rCommitBtn setBackgroundImage:[UIImage jy_imageWithColor: kBlueColor] forState:UIControlStateNormal] ;
        _rCommitBtn.enabled = NO ;
        
    }
    
    return _rCommitBtn ;
}

-(UIButton*)rForgetBtn {
    
    if (_rForgetBtn == nil) {
        _rForgetBtn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
            btn.titleLabel.font = [UIFont systemFontOfSize:14] ;
            [btn setTitleColor:kBlueColor forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor clearColor] ;
            [btn setTitle:@"忘记密码" forState:UIControlStateNormal] ;
            
            btn ;
            
        }) ;
    }
    
    return _rForgetBtn ;
}

-(UIButton*)rRegisterBtn {
    
    if (_rRegisterBtn == nil) {
        _rRegisterBtn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
            btn.titleLabel.font = [UIFont systemFontOfSize:14] ;
            [btn setTitleColor:kBlueColor forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor clearColor] ;
            [btn setTitle:@"免费注册" forState:UIControlStateNormal] ;
            btn ;
            
        }) ;
    }
    
    return _rRegisterBtn ;
}


-(UILabel*)rDescLabel {
    
    if (_rDescLabel == nil) {
        _rDescLabel = [self jyCreateLabelWithTitle:@"" font:12 color:kTextBlackColor align:NSTextAlignmentLeft] ;
        _rDescLabel.numberOfLines = 0 ;
    }
    
    
    return _rDescLabel ;
}


-(JYAgreeView*)rAgreeView {
    
    if (_rAgreeView == nil) {
        _rAgreeView = [[JYAgreeView alloc]init];
        
        
    }
    
    return _rAgreeView ;
    
}


@end



