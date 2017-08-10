//
//  JYTextView.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/26.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYTextView.h"
#define kMaxLength 120



@interface JYTextView ()<UITextViewDelegate>

@property (nonatomic, strong)UILabel * rTextLable;

@property (nonatomic, strong)UILabel * rPlaceLabel;


@property (nonatomic, assign)NSInteger res;

@end

@implementation JYTextView

//- (instancetype)initWithFrame:(CGRect)frame{
//    
//    if (self = [super initWithFrame:frame]) {
//        
//        self.backgroundColor = [UIColor grayColor];
//        self.font = [UIFont systemFontOfSize:13];
//        
//        self.contentInset = UIEdgeInsetsMake(0, 0, 50, 0) ;
//        
//        
//        self.res = kMaxLength;
//        
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewEditChanged:) name:UITextViewTextDidChangeNotification object:self];
//        
//        self.delegate = self;
//        
//        self.rPlaceLabel.hidden = NO ;
//        [self addSubview:self.rTextLable];
//    }
//    return self;
//}

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor grayColor];
        self.font = [UIFont systemFontOfSize:13];
        
        self.contentInset = UIEdgeInsetsMake(0, 0, 50, 0) ;
        
        
        self.res = kMaxLength;
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewEditChanged:) name:UITextViewTextDidChangeNotification object:self];
        
        self.delegate = self;
        
        self.rPlaceLabel.hidden = NO ;
        
        self.rTextLable.text = [NSString stringWithFormat:@"0/%d",kMaxLength] ;
     }
    return self;
}


- (UILabel *)rTextLable{
    
    if (_rTextLable == nil) {
        
        _rTextLable = [[UILabel alloc]init];

        _rTextLable = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 50, self.bounds.size.width-15, 45)];
        _rTextLable.textAlignment = NSTextAlignmentRight;
        _rTextLable.font = [UIFont systemFontOfSize:13];
        _rTextLable.textColor = kTextBlackColor ;
        _rTextLable.text = [NSString stringWithFormat:@"0/%d",kMaxLength] ;
        
        [self addSubview:_rTextLable] ;
    }
    return _rTextLable;
}

-(UILabel*)rPlaceLabel {
    
    if (_rPlaceLabel == nil) {
        _rPlaceLabel = [self jyCreateLabelWithTitle:@"详细说明本次借款用途，自身优势和按时还款承诺等信息，限20-120字" font:13 color:[UIColor lightGrayColor]  align:NSTextAlignmentLeft ] ;
        
         _rPlaceLabel.numberOfLines = 0 ;
        
        [self addSubview:_rPlaceLabel] ;
    }
    
    return _rPlaceLabel ;
}


-(void)layoutSubviews {
    
    [self.rPlaceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(8) ;
        make.left.equalTo(self).offset(7) ;
        make.width.mas_equalTo(SCREEN_WIDTH-30 - 14) ;
        
    }] ;
    
    
    [self.rTextLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(150) ;
        make.height.mas_equalTo(45) ;
         make.width.mas_equalTo(SCREEN_WIDTH-30 - 14) ;
         make.left.equalTo(self) ;
     }];
    
}

-(void)textViewEditChanged:(NSNotification *)obj{
//    UITextView *textView = obj.object;
    
    UITextView *textView =  self;

    NSString *toBeString = textView.text;
    self.rPlaceLabel.hidden = textView.text.length  ;
    
    
    // 键盘输入模式
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage;
    
    // 简体中文输入，包括简体拼音，健体五笔，简体手写
    if ([lang isEqualToString:@"zh-Hans"]) {
        
        //获取高亮部分
        UITextRange *selectedRange = [textView markedTextRange];
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kMaxLength) {
                textView.text = [toBeString substringToIndex:kMaxLength];
            }
            self.res = kMaxLength-textView.text.length;
            self.rTextLable.text = [NSString stringWithFormat:@"%ld/%d", textView.text.length  ,kMaxLength];
            
            
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
        }
        
    }else{
        if (toBeString.length > kMaxLength) {
            textView.text = [toBeString substringToIndex:kMaxLength];
        }
        self.rTextLable.text = [NSString stringWithFormat:@"%ld/%d", textView.text.length,kMaxLength];
        self.res = kMaxLength-textView.text.length;
        
    }
}

@end
