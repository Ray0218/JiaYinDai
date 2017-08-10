  //
//  feedbackViewController.m
//  JiaYinDai
//
//  Created by 陈侠 on 2017/5/12.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "feedbackViewController.h"
#define TextViewDefaultText @"请输入您的意见，我们会及时处理！"

@interface feedbackViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UITextView *contentTV;
@property (nonatomic, strong) UIButton *commitBT;// 提交按钮
@property (nonatomic, strong) UIButton *phoneButton;// 如有疑问请咨询


@end

@implementation feedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor = kBackGroundColor;
    [self UIDecorate];
}


-(void)pvt_loadData {
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
    [dic setValue:self.contentTV.text forKey:@"content"] ;
    
    [[AFHTTPSessionManager jy_sharedManager]POST:kFeekbackURL parameters:dic  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [JYProgressManager showBriefAlert:@"感谢您的反馈，我们会及时处理！"] ;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kShowTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
         });
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
}

- (void)UIDecorate
{
    self.contentTV = [[UITextView alloc] initWithFrame:CGRectMake(17, 25, SCREEN_WIDTH - 34, 180)];
    [self.view addSubview:self.contentTV];
    self.contentTV.delegate = self;
    self.contentTV.backgroundColor = [UIColor whiteColor];
    self.contentTV.text = TextViewDefaultText;
    self.contentTV.textColor = kTextBlackColor;
    self.contentTV.font = [UIFont systemFontOfSize:13];
    self.contentTV.layer.borderWidth =1.0;
    self.contentTV.layer.borderColor = kLineColor.CGColor;
    [self.contentTV.layer setCornerRadius:4];
 
    
    self.commitBT = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.commitBT.frame = CGRectMake(30, 270, SCREEN_WIDTH - 60, 50);
    self.commitBT.backgroundColor = kBlueColor;
    [self.commitBT setTitle:@"提交" forState:(UIControlStateNormal)];
    [self.commitBT setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.commitBT addTarget:self action:@selector(cleckButton:) forControlEvents:(UIControlEventTouchUpInside)];
    self.commitBT.layer.cornerRadius = 5;
    self.commitBT.layer.masksToBounds = YES;
    [self.view addSubview:self.commitBT];
    
    
    [self.rTelButton setTitle:@"客服热线：400-138-6388" forState:UIControlStateNormal] ;
    
    [self.view addSubview:self.rTelButton];
    
    [self.rTelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view) ;
        make.bottom.equalTo(self.view).offset(-15) ;
    }] ;

    
}


- (void)cleckButton:(UIButton *)button
{
    [self.contentTV resignFirstResponder];
    if (self.contentTV.text.length==0||[self.contentTV.text isEqualToString:TextViewDefaultText]) {
        [JYProgressManager showBriefAlert:@"反馈内容不能为空！"] ;
        return;
    }
    [self pvt_loadData];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (range.location>30) {
        return NO;
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:TextViewDefaultText]) {
        textView.text = nil;
    }
    textView.textColor = kBlackColor;
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
