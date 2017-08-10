//
//  JYFatherController.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/23.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYFatherController.h"
#import "JYWebViewController.h"

@interface JYFatherController ()

@property (nonatomic ,strong) UIButton *rQuestButton ; //常见问题

@property (nonatomic ,strong) UIButton *rTelButton ;//联系客服




@end

@implementation JYFatherController

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
     
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pvt_endRefresh) name:kEndRefreshNotification object:nil];
    
    
    [MobClick beginLogPageView:NSStringFromClass([self class])] ;
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pvt_loadData) name:kAutoLogFinishNotification object:nil];
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:NSStringFromClass([self class])];
    
    
    [self.view endEditing:YES];
    
    
    [self pvt_endRefresh];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kEndRefreshNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kAutoLogFinishNotification object:nil];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //背景颜色
    self.view.backgroundColor =kBackGroundColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self loadNavigationSetting];
    
    
    [self addScreenGesture] ;
    
    
}

- (void)addScreenGesture {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    // handleNavigationTransition:为系统私有API,即系统自带侧滑手势的回调方法，我们在自己的手势上直接用它的回调方法
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    panGesture.delegate = self; // 设置手势代理，拦截手势触发
    [self.view addGestureRecognizer:panGesture];
    
    // 一定要禁止系统自带的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
#pragma clang diagnostic pop
}

// 什么时候调用，每次触发手势之前都会询问下代理方法，是否触发
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 当当前控制器是根控制器时，不可以侧滑返回，所以不能使其触发手势
    if(self.navigationController.childViewControllers.count == 1)
    {
        return NO;
    }
    
    return YES;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    
    if ([JYProgressManager isShowingHUD]){
        
        //        NSLog(@"============滑动返回取消 ==========");
        
        return NO ;
    }
    //    NSLog(@" ++++++++++++++滑动返回开启++++++++++++++" ) ;
    
    return YES ;
    
}


- (void)loadNavigationSetting {
    //设置导航栏为不透明
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //    //导航栏标题颜色和字体大小
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:18.5], NSFontAttributeName,nil]];
    //    //导航栏背景颜色设置
    [self.navigationController.navigationBar setBackgroundImage:[UIImage jy_imageWithColor:kBlueColor] forBarMetrics:UIBarMetricsDefault];
    
    //    self.navigationController.navigationBar.barTintColor = kBlueColor;
    
    self.navigationController.navigationBar.shadowImage = [UIImage new] ;// [UIImage jy_imageWithColor:kBlueColor];
    
    
    [self setNavLeftButtonWithImage:NAV_LEFTBUTTON_ICON title:@""];
}

//设置导航栏左按钮图片和标题
- (void)setNavLeftButtonWithImage:(UIImage *)image title:(NSString *)title {
    UIButton *buttonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonLeft.frame = CGRectMake(10, 0, NAV_BUTTON_WIDTH, NAV_BUTTON_HEIGHT);
    buttonLeft.backgroundColor = [UIColor clearColor];
    [buttonLeft setTitle:title forState:UIControlStateNormal];
    [buttonLeft setTitleColor:NAV_BUTTON_COLOR forState:UIControlStateNormal];
    buttonLeft.titleLabel.font = NAV_BUTTON_FONT;
    buttonLeft.titleLabel.numberOfLines = 0;
    [buttonLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft] ;
    [buttonLeft setImage:image forState:UIControlStateNormal];
    
    [buttonLeft setImage:[image jy_imageWithTintColor:UIColorFromRGB(0xe5e5e5)] forState:UIControlStateHighlighted];
    
    [buttonLeft addTarget:self action:@selector(pvt_clickButtonNavLeft) forControlEvents:UIControlEventTouchUpInside];
    //buttonLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    UIView *viewButton = [[UIView alloc] init];
    viewButton.frame = CGRectMake(0, 0, NAV_BUTTON_WIDTH, NAV_BUTTON_HEIGHT);
    [viewButton addSubview:buttonLeft];
    buttonLeft.exclusiveTouch = YES ;
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -15;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,[[UIBarButtonItem alloc] initWithCustomView:viewButton]];
}

#pragma mark ---设置导航栏右按钮图片和标题
//设置导航栏右按钮图片和标题
- (void)setNavRightButtonWithImage:(UIImage *)image title:(NSString *)title {
    UIButton *buttonRight = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonRight.frame = CGRectMake(self.view.frame.size.width-NAV_BUTTON_WIDTH, 0, NAV_BUTTON_WIDTH, NAV_BUTTON_HEIGHT);
    [buttonRight setTitle:title forState:UIControlStateNormal];
    [buttonRight setTitleColor:NAV_BUTTON_COLOR forState:UIControlStateNormal];
    [buttonRight setTitleColor:[UIColor colorWithWhite:0 alpha:0.6] forState:UIControlStateHighlighted];
    [buttonRight setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight] ;
    
    buttonRight.titleLabel.font = NAV_BUTTON_FONT;
    buttonRight.titleLabel.numberOfLines = 0;
    [buttonRight setImage:image forState:UIControlStateNormal];
    [buttonRight setImage:[image jy_imageWithTintColor:UIColorFromRGB(0xe5e5e5)] forState:UIControlStateHighlighted];
    
    
    [buttonRight addTarget:self action:@selector(pvt_clickButtonNavRight) forControlEvents:UIControlEventTouchUpInside];
    buttonRight.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonRight];
}


#pragma mark -action

-(void)pvt_loadData { //请求数据
    
    
    NSLog(@"登录成功后继续上次的数据请求！") ;
    
}
//点击导航栏左按钮
- (void)pvt_clickButtonNavLeft {
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



//点击导航栏右按钮
- (void)pvt_clickButtonNavRight  {
    
}

-(void)pvt_endRefresh {
    
    
}


-(void)pvt_callPhone {
    
    //     客服热线
    //        NSString *deviceType=[UIDevice currentDevice].model;
    //        if([deviceType  isEqualToString:@"iPod touch"]||[deviceType  isEqualToString:@"iPad"]||[deviceType  isEqualToString:@"iPhone Simulator"]){
    //            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil message:@"您的设备不能拨打电话" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    //            [alertView show];
    //            return;
    //        }
    //        UIWebView *callWebView=[[UIWebView alloc] init];
    //        NSURL *telURL=[NSURL URLWithString:@"tel:400-800-3322"];
    //        [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
    //        [self.view addSubview:callWebView];
    
    
    
    
    
    NSMutableString *str=[[NSMutableString alloc]initWithFormat:@"tel:%@",@"400-138-6388"];
    
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"400-138-6388" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    
}


-(void)pvt_quest {
    
    JYWebViewController *webVc = [[JYWebViewController alloc]initWithUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kServiceURL,kQuestURL]] ];
    
    [self.navigationController pushViewController:webVc animated:YES];
    
    
}


#pragma mark -引导


- (void)pvt_addGuideView:(NSString*) imageName  View:(UIView*)view Position:(JYMaskPosition) position{
    
    
    BOOL hasLoad = [[NSUserDefaults standardUserDefaults]boolForKey:imageName];
    
    if (hasLoad) {
        return ;
    }
    
    
    
    //    UIImage *image = [UIImage imageNamed:imageName];
    //    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    //    imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    //    imageView.userInteractionEnabled = YES;
    //
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pvt_dismissGuideView:)];
    //    [imageView addGestureRecognizer:tap];
    //
    //
    //    [[UIApplication sharedApplication].keyWindow addSubview:imageView] ;
    
    
    
    // 这里创建指引在这个视图在window上
    CGRect frame = [UIScreen mainScreen].bounds;
    UIView * bgView = [[UIView alloc]initWithFrame:frame];
    
    
    CGRect  rect = [self.navigationController.view convertRect:view.frame fromView:view.superview] ;
    
    bgView.backgroundColor =  [UIColor colorWithWhite:0 alpha:0.8];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pvt_dismissGuideView:)];
    [bgView addGestureRecognizer:tap];
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    
    
    UIImage *image = [UIImage imageNamed:imageName] ;
    
    
    
    CGRect imageFrame = CGRectMake(0, 0, image.size.width, image.size.height) ;
    
    
    
    //create path 重点来了（**这里需要添加第一个路径）
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:frame];
    
    if (position == JYMaskPositionTopRight) {
        
        // 这里添加第二个路径 （这个是圆）
        
        [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width - rect.size.height/2.0+ rect.origin.x + 10, MAX(20, rect.origin.y )+ rect.size.height/2.0 ) radius:MIN(rect.size.width /2.0 + 10, rect.size.height/2.0 +2) startAngle:0 endAngle:2*M_PI clockwise:NO]];
        
        imageFrame.origin.x = rect.size.width - rect.size.height/2.0+ rect.origin.x + 10  - image.size.width ;
        
    }else{
        
        
        // 这里添加第二个路径 （这个是矩形）
        [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(rect.origin.x - 3, rect.origin.y - 3, rect.size.width + 6, rect.size.height+6) cornerRadius:5] bezierPathByReversingPath]];
        
        
        imageFrame.origin.x = rect.origin.x + 30  ;
        
    }
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    [bgView.layer setMask:shapeLayer];
    
    
    imageFrame.origin.y = rect.size.height + rect.origin.y + 15 ;
    
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:imageFrame];
    
    imageView.image = [UIImage imageNamed:imageName];
    imageView.contentMode= UIViewContentModeTop ;
    
    [bgView addSubview:imageView];
    
    
    
}



 
-(void)pvt_dismissGuideView:(UIGestureRecognizer*)gesture {
    
    UIView *view = gesture.view ;
    
    [view removeGestureRecognizer:gesture];
    
    [view removeFromSuperview] ;
}



#pragma mark- getter
-(UIButton*)rQuestButton {
    
    if (_rQuestButton == nil) {
        _rQuestButton = ({
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
            btn.titleLabel.font = [UIFont systemFontOfSize:12] ;
            [btn setTitleColor:kTextBlackColor forState:UIControlStateNormal];
            
            [btn setTitle:@"常见问题" forState:UIControlStateNormal] ;
            btn.backgroundColor = [UIColor clearColor] ;
            
            @weakify(self)
            [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
                @strongify(self)
                [self pvt_quest] ;
            }] ;
            
            btn ;
            
        }) ;
    }
    return _rQuestButton ;
}

-(UIButton*)rTelButton {
    
    
    if (_rTelButton == nil) {
        _rTelButton =  ({
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
            btn.titleLabel.font = [UIFont systemFontOfSize:12] ;
            [btn setTitleColor:kTextBlackColor forState:UIControlStateNormal];
            
            [btn setTitle:@"联系客服" forState:UIControlStateNormal] ;
            btn.backgroundColor = [UIColor clearColor] ;
            btn ;
            
        }) ;
        
        @weakify(self)
        [[_rTelButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            [self pvt_callPhone];
        }] ;
        
    }
    return _rTelButton ;
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
