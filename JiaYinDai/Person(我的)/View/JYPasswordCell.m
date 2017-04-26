//
//  JYPasswordCell.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/7.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPasswordCell.h"

@interface JYPasswordCell (){
    JYPassCellType rCellType ;
    
    
    CGFloat rLabelWidth ;
}

@property (nonatomic, strong) UILabel*rTitleLabel ;
@property (nonatomic, strong) UITextField*rTextField  ;

@property (nonatomic, strong) UIButton *rCodeButon  ;

@property (nonatomic, strong) UIButton *rRightArrow  ;


@property (nonatomic, strong) UIButton *rManButton  ;
@property (nonatomic, strong) UIButton *rWomenButton  ;




@end

@implementation JYPasswordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



-(instancetype)initWithCellType:(JYPassCellType)type reuseIdentifier:(NSString *)reuseIdentifier maxWidth:(CGFloat)width{
    
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] ;
    if (self) {
        rCellType = type ;
        
        if (width > 0  ) {
            rLabelWidth = width ;
        }else{
            rLabelWidth = 80 ;
        }
        
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        [self buildSubViewsUI];
    }
    
    return self ;
}


-(instancetype)initWithCellType:(JYPassCellType)type reuseIdentifier:(NSString *)reuseIdentifier{
    
    return [self initWithCellType:type reuseIdentifier:reuseIdentifier maxWidth:0];
}

-(void)setDataModel:(JYPasswordSetModel*)model {
    
    self.rTitleLabel.text = model.rTitle ;
    self.rTextField.text = model.rTFTitle ;
    self.rTextField.placeholder = model.rTFPlaceholder ;
}



-(void)buildSubViewsUI {
    
    UIView *rLineView = ({
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = kLineColor ;
        view ;
    }) ;
    
    [self.contentView addSubview:rLineView ];
    [self.contentView addSubview:self.rTitleLabel];
    
    
    if (rCellType == JYPassCellTypeTwoBtn) {
        
        
        [self.contentView addSubview:self.rManButton];
        [self.contentView addSubview:self.rWomenButton];
        
        
        
        [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15) ;
            make.centerY.equalTo(self.contentView) ;
            make.width.mas_equalTo(rLabelWidth) ;
        }] ;
        
        [rLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.rTitleLabel.mas_right).offset(15) ;
            make.centerY.equalTo(self.contentView) ;
            make.height.mas_greaterThanOrEqualTo(25) ;
            make.width.mas_equalTo(1) ;
        }];
        
        
        [self.rManButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rLineView.mas_right).offset(15) ;
            make.centerY.equalTo(self.contentView) ;
        }];
        
        [self.rWomenButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.rManButton.mas_right).offset(15) ;
            make.centerY.equalTo(self.contentView) ;
        }] ;
        
        
        return ;
    }
    
    
    
    [self.contentView addSubview:self.rTextField];
    
    if (rCellType == JYPassCellTypeEye){
        [self.rRightArrow setImage:[UIImage imageNamed:@"eye_icon"] forState:UIControlStateNormal] ;
    }
    
    if (rCellType == JYPassCellTypeArrow) {
        self.rTextField.enabled = NO ;
        
    }
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15) ;
        make.centerY.equalTo(self.contentView) ;
        make.width.mas_lessThanOrEqualTo(rLabelWidth) ;
    }] ;
    
    [rLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rTitleLabel.mas_right).offset(15) ;
        make.centerY.equalTo(self.contentView) ;
        make.height.mas_greaterThanOrEqualTo(25) ;
        make.width.mas_equalTo(1) ;
    }];
    
    
    if (rCellType == JYPassCellTypeCode) {
        
        [self.contentView addSubview:self.rCodeButon];
        
        [self.rCodeButon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15) ;
            make.centerY.equalTo(self.contentView) ;
            make.height.mas_equalTo(35) ;
            make.width.mas_equalTo(90) ;
        }];
        
        [self.rTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(rLineView.mas_right).offset(15) ;
            make.centerY.equalTo(self.contentView) ;
            make.right.equalTo(self.rCodeButon.mas_left).offset(-5) ;
        }] ;
        
        
    }else if (rCellType == JYPassCellTypeArrow || rCellType == JYPassCellTypeEye) {
        
        
        [self.contentView addSubview:self.rRightArrow];
        
        [self.rRightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-5) ;
            make.centerY.equalTo(self.contentView) ;
            make.height.mas_equalTo(35) ;
            make.width.mas_equalTo(35) ;
        }];
        
        [self.rTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(rLineView.mas_right).offset(15) ;
            make.centerY.equalTo(self.contentView) ;
            make.right.equalTo(self.rRightArrow.mas_left).offset(-5) ;
        }] ;
        
        
    } else{
        
        [self.rTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rLineView.mas_right).offset(15) ;
            make.right.equalTo(self.contentView).offset(-15) ;
            make.centerY.equalTo(self.contentView) ;
        }] ;
    }
}

#pragma mark- action

- (void)startTimeGCD

{
    
    @weakify(self)
    //设置倒计时总时长
    
    __block int timeout= 5;
    
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
                
                
                [self.rCodeButon setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.rCodeButon.enabled = YES ;
                self.rCodeButon.backgroundColor = kBlueColor ;
            });
            
        }else{
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%ds", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                [self.rCodeButon setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
                self.rCodeButon.enabled = NO ;
                [self.rCodeButon setBackgroundColor:[UIColor lightGrayColor] ];
                
                
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



#pragma mark- gtter -

-(UILabel*)rTitleLabel {
    
    if (_rTitleLabel == nil) {
        _rTitleLabel = [self jyCreateLabelWithTitle:@"交易密码" font:16 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rTitleLabel ;
}

-(UITextField*)rTextField {
    if (_rTextField == nil) {
        _rTextField = [[UITextField alloc]init];
        _rTextField.backgroundColor =[ UIColor clearColor] ;
        _rTextField.font = [UIFont systemFontOfSize:16] ;
    }
    return _rTextField ;
}

-(UIButton*)rRightArrow {
    if (_rRightArrow == nil) {
        _rRightArrow = [UIButton buttonWithType:UIButtonTypeCustom] ;
        
        [_rRightArrow setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal] ;
    }
    
    return _rRightArrow ;
}


-(UIButton*)rCodeButon {
    if (_rCodeButon == nil) {
        _rCodeButon = [UIButton buttonWithType:UIButtonTypeCustom] ;
        _rCodeButon.backgroundColor =  kBlueColor;
        _rCodeButon.layer.cornerRadius = 4;
        _rCodeButon.clipsToBounds = YES ;
        _rCodeButon.titleLabel.font = [UIFont systemFontOfSize:14] ;
        [_rCodeButon setTitle:@"获取验证码" forState:UIControlStateNormal] ;
        
        @weakify(self)
        [[_rCodeButon rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            
            @strongify(self)
            
            [self startTimeGCD];
            
        }] ;
        
        
    }
    return _rCodeButon ;
}

-(UIButton*)rManButton {
    
    if (_rManButton == nil) {
        _rManButton = ({
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
            [btn setTitle:@" 先生" forState:UIControlStateNormal] ;
            btn.titleLabel.font = [UIFont systemFontOfSize:14] ;
            [btn setTitleColor:kTextBlackColor forState:UIControlStateNormal] ;
            [btn setImage:[UIImage imageNamed:@"imp_unselect"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"imp_select"] forState:UIControlStateSelected];
            btn.selected = YES ;
            
            
            @weakify(self)
            [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton* x) {
                @strongify(self)
                
                x.selected =  YES ;
                self.rWomenButton.selected =  NO ;
            }] ;
            
            btn ;
            
        }) ;
    }
    
    return _rManButton ;
}

-(UIButton*)rWomenButton {
    if (_rWomenButton == nil) {
        _rWomenButton = ({
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
            [btn setTitle:@" 女士" forState:UIControlStateNormal] ;
            btn.titleLabel.font = [UIFont systemFontOfSize:14] ;
            [btn setTitleColor:kTextBlackColor forState:UIControlStateNormal] ;
            [btn setImage:[UIImage imageNamed:@"imp_unselect"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"imp_select"] forState:UIControlStateSelected];
            btn.selected = NO  ;
            
            @weakify(self)
            [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton* x) {
                @strongify(self)
                
                x.selected =  YES ;
                self.rManButton.selected =  NO ;
            }] ;

            btn ;
            
        }) ;
    }
    
    return _rWomenButton ;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
