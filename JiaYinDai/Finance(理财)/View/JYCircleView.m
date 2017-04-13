//
//  JYCircleView.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/1.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYCircleView.h"



@interface JYCircleView (){
    UILabel *_backLabel ;
}

@property (nonatomic,strong) UILabel *rTimeLabel ;

@end

@implementation JYCircleView


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor] ;
        [self builSubViewsUI];
        
     }
    return self;
}


-(void)didMoveToSuperview{
    [super didMoveToSuperview];
    
    [self startTimeGCD];
}




-(void)builSubViewsUI {
    
    _backLabel = [self jyCreateLabelWithTitle:@"返回首页" font:14 color:kTextBlackColor align:NSTextAlignmentCenter] ;
    [self addSubview:_backLabel];
    
    [self addSubview:self.rTimeLabel];
    self.rTimeLabel.attributedText = TTFormateNumString(@"5S", 40, 10, 1) ;
    
}

-(void)layoutSubviews {

    [_backLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self) ;
        make.top.equalTo(self.mas_centerY) ;
    }];
    
    [self.rTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self) ;
        make.bottom.equalTo(self.mas_centerY) ;
    }] ;
}


 // Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线条样式
    CGContextSetLineCap(context, kCGLineCapRound);
    //设置线条粗细宽度
    CGContextSetLineWidth(context, 3.0);
    
     CGContextSaveGState(context) ;
    //设置颜色
    CGContextSetRGBStrokeColor(context, 0.0, 0.36, 0.68, 1.0);
      //开始一个起始路径
    CGContextAddArc(context, rect.size.width/2.0, rect.size.height/2.0, MIN(rect.size.width, rect.size.height)/2.0 - 20, -90* M_PI /180, -40*M_PI/180, 1);
     CGContextDrawPath(context, kCGPathStroke) ;
    
    CGContextRestoreGState(context) ;
    
      CGContextSetRGBStrokeColor(context, 0.0, 0.36, 0.68, 1.0);
     CGContextAddArc(context, rect.size.width/2.0, rect.size.height/2.0, MIN(rect.size.width, rect.size.height)/2.0 - 20, -55* M_PI /180, -75*M_PI/180, 1);
    
     CGContextDrawPath(context, kCGPathStroke) ;

    
}






- (void)startTimeGCD
{
 
    @weakify(self)
    //设置倒计时总时长
    
    __block int timeout=5;
    
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
                
                
                if (self.rReturnBlock) {
                    self.rReturnBlock() ;
                }
                
                
            });
            
        }else{
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%ds", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                self.rTimeLabel.attributedText = TTFormateNumString(strTime, 40, 10, 1) ;

                
                //NSLog(@"____%@",strTime);
                
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




-(UILabel*)rTimeLabel {
    if (_rTimeLabel == nil) {
        _rTimeLabel = [self jyCreateLabelWithTitle:@"" font:10 color:kBlueColor align:NSTextAlignmentCenter] ;
    }
    
    return _rTimeLabel ;
}

@end
