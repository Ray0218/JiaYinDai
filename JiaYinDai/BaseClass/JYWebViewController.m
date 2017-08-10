//
//  JYWebViewController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/20.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
#import "JYHtmlJSObject.h"


#define boundsWidth self.view.bounds.size.width
#define boundsHeight self.view.bounds.size.height

@interface JYWebViewController ()<UIWebViewDelegate,UINavigationControllerDelegate,UINavigationBarDelegate,NJKWebViewProgressDelegate>


@property (nonatomic)NJKWebViewProgress* progressProxy;
@property (nonatomic)NJKWebViewProgressView* progressView;

@property(nonatomic,strong)JSContext* jsContext;


/**
 *  array that hold snapshots
 */
@property (nonatomic)NSMutableArray* snapShotsArray;

/**
 *  current snapshotview displaying on screen when start swiping
 */
@property (nonatomic)UIView* currentSnapShotView;

/**
 *  previous view
 */
@property (nonatomic)UIView* prevSnapShotView;

/**
 *  background alpha black view
 */
@property (nonatomic)UIView* swipingBackgoundView;

/**
 *  left pan ges
 */
@property (nonatomic)UIPanGestureRecognizer* swipePanGesture;

/**
 *  if is swiping now
 */
@property (nonatomic)BOOL isSwipingBack;



@end

@implementation JYWebViewController


-(UIStatusBarStyle) preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - init
-(instancetype)initWithUrl:(NSURL *)url{
    self = [super init];
    if (self) {
        self.url = url;
        
        _progressViewColor = [UIColor whiteColor];
    }
    return self;
}

-(instancetype)initWithUrl:(NSString *)urlString urlWithParam:(NSMutableDictionary *)param{
    self = [super init];
    if (self) {
        
        NSMutableString * newStr = [NSMutableString stringWithFormat:@"%@?",urlString];
        //获取字典的所有keys
        NSArray * enumeratorKeys = [param allKeys];
        for(NSString *key in enumeratorKeys){
            NSString *urlWithParam = [NSString stringWithFormat:@"%@=%@&", key,[param objectForKey:key]];
            [newStr appendString:urlWithParam];
        }
        
        self.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[newStr substringToIndex:newStr.length-1]]];;
        
        
        NSLog(@"self.url=====%@",self.url);
        
        //        _progressViewColor = [UIColor colorWithRed:119.0/255 green:228.0/255 blue:115.0/255 alpha:1];
        _progressViewColor = [UIColor whiteColor];
    }
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //config navigation item
    //        self.navigationItem.leftItemsSupplementBackButton = YES;
    
    self.webView.delegate = self.progressProxy;
    [self.view addSubview:self.webView];
    
    [self.navigationController.navigationBar addSubview:self.progressView];
    
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pvt_zhimaBack) name:kZhimaNotification object:nil] ;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.progressView removeFromSuperview];
    //    self.webView.delegate = nil;
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kZhimaNotification  object:nil];
    
}

#pragma mark - public funcs
-(void)reloadWebView{
    [self.webView reload];
}

#pragma mark - logic of push and pop snap shot views
-(void)pushCurrentSnapshotViewWithRequest:(NSURLRequest*)request{
    NSURLRequest* lastRequest = (NSURLRequest*)[[self.snapShotsArray lastObject] objectForKey:@"request"];
    
    //如果url是很奇怪的就不push
    if ([request.URL.absoluteString isEqualToString:@"about:blank"]) {
        return;
    }
    //如果url一样就不进行push
    if ([lastRequest.URL.absoluteString isEqualToString:request.URL.absoluteString]) {
        return;
    }
    
    UIView* currentSnapShotView = [self.webView snapshotViewAfterScreenUpdates:YES];
    [self.snapShotsArray addObject:
     @{
       @"request":request,
       @"snapShotView":currentSnapShotView
       }
     ];
}

-(void)startPopSnapshotView{
    if (self.isSwipingBack) {
        return;
    }
    if (!self.webView.canGoBack) {
        return;
    }
    self.isSwipingBack = YES;
    //create a center of scrren
    CGPoint center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    self.currentSnapShotView = [self.webView snapshotViewAfterScreenUpdates:YES];
    
    //add shadows just like UINavigationController
    self.currentSnapShotView.layer.shadowColor = kBlackColor.CGColor;
    self.currentSnapShotView.layer.shadowOffset = CGSizeMake(3, 3);
    self.currentSnapShotView.layer.shadowRadius = 5;
    self.currentSnapShotView.layer.shadowOpacity = 0.75;
    
    //move to center of screen
    self.currentSnapShotView.center = center;
    
    self.prevSnapShotView = (UIView*)[[self.snapShotsArray lastObject] objectForKey:@"snapShotView"];
    center.x -= 60;
    self.prevSnapShotView.center = center;
    self.prevSnapShotView.alpha = 1;
    self.view.backgroundColor = kBlackColor;
    
    [self.view addSubview:self.prevSnapShotView];
    [self.view addSubview:self.swipingBackgoundView];
    [self.view addSubview:self.currentSnapShotView];
}

-(void)popSnapShotViewWithPanGestureDistance:(CGFloat)distance{
    if (!self.isSwipingBack) {
        return;
    }
    
    if (distance <= 0) {
        return;
    }
    
    CGPoint currentSnapshotViewCenter = CGPointMake(boundsWidth/2, boundsHeight/2);
    currentSnapshotViewCenter.x += distance;
    CGPoint prevSnapshotViewCenter = CGPointMake(boundsWidth/2, boundsHeight/2);
    prevSnapshotViewCenter.x -= (boundsWidth - distance)*60/boundsWidth;
    
    self.currentSnapShotView.center = currentSnapshotViewCenter;
    self.prevSnapShotView.center = prevSnapshotViewCenter;
    self.swipingBackgoundView.alpha = (boundsWidth - distance)/boundsWidth;
}

-(void)endPopSnapShotView{
    if (!self.isSwipingBack) {
        return;
    }
    
    //prevent the user touch for now
    self.view.userInteractionEnabled = NO;
    
    if (self.currentSnapShotView.center.x >= boundsWidth) {
        // pop success
        [UIView animateWithDuration:0.2 animations:^{
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            
            self.currentSnapShotView.center = CGPointMake(boundsWidth*3/2, boundsHeight/2);
            self.prevSnapShotView.center = CGPointMake(boundsWidth/2, boundsHeight/2);
            self.swipingBackgoundView.alpha = 0;
        }completion:^(BOOL finished) {
            [self.prevSnapShotView removeFromSuperview];
            [self.swipingBackgoundView removeFromSuperview];
            [self.currentSnapShotView removeFromSuperview];
            [self.webView goBack];
            [self.snapShotsArray removeLastObject];
            self.view.userInteractionEnabled = YES;
            
            self.isSwipingBack = NO;
        }];
    }else{
        //pop fail
        [UIView animateWithDuration:0.2 animations:^{
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            
            self.currentSnapShotView.center = CGPointMake(boundsWidth/2, boundsHeight/2);
            self.prevSnapShotView.center = CGPointMake(boundsWidth/2-60, boundsHeight/2);
            self.prevSnapShotView.alpha = 1;
        }completion:^(BOOL finished) {
            [self.prevSnapShotView removeFromSuperview];
            [self.swipingBackgoundView removeFromSuperview];
            [self.currentSnapShotView removeFromSuperview];
            self.view.userInteractionEnabled = YES;
            
            self.isSwipingBack = NO;
        }];
    }
}

#pragma mark - update nav items

-(void)updateNavigationItems{
    
    
    if (self.webView.canGoBack) {
        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceButtonItem.width = -6.5;
        
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        
        
    }else {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        //        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
        
        
    }
}


-(void)pvt_clickButtonNavLeft{
    
    if (self.webView.canGoBack) {
        [self.webView goBack];
        return ;
    }
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - events handler
-(void)swipePanGestureHandler:(UIPanGestureRecognizer*)panGesture{
    CGPoint translation = [panGesture translationInView:self.webView];
    CGPoint location = [panGesture locationInView:self.webView];
    
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        if (location.x <= 50 && translation.x > 0) {  //开始动画
            [self startPopSnapshotView];
        }
    }else if (panGesture.state == UIGestureRecognizerStateCancelled || panGesture.state == UIGestureRecognizerStateEnded){
        [self endPopSnapShotView];
    }else if (panGesture.state == UIGestureRecognizerStateChanged){
        [self popSnapShotViewWithPanGestureDistance:translation.x];
    }
}


-(void)customBackItemClicked{
    if (self.webView.canGoBack) {
        [self.webView goBack];
        return ;
    }
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)pvt_zhimaBack {
    [self.navigationController popViewControllerAnimated:YES];
    
}


/**加载js调用的object*/
-(void)loadJSBoject:(UIWebView*)webView{
    //初始化js调用接口
    
    
    if (self.jsContext == nil) {
        
        self.jsContext = [webView valueForKeyPath:
                          @"documentView.webView.mainFrame.javaScriptContext"];
        [self.jsContext setExceptionHandler:^(JSContext *ctx, JSValue *value) {
            NSLog(@"error: %@", value);
        }];
    }
    
    JYHtmlJSObject  *jsObject = [[JYHtmlJSObject alloc]init];
    
    self.jsContext[@"jsObject"]=jsObject;
    
}


#pragma mark - webView delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [self loadJSBoject:webView];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    switch (navigationType) {
        case UIWebViewNavigationTypeLinkClicked: {
            [self pushCurrentSnapshotViewWithRequest:request];
            break;
        }
        case UIWebViewNavigationTypeFormSubmitted: {
            [self pushCurrentSnapshotViewWithRequest:request];
            break;
        }
        case UIWebViewNavigationTypeBackForward: {
            break;
        }
        case UIWebViewNavigationTypeReload: {
            break;
        }
        case UIWebViewNavigationTypeFormResubmitted: {
            break;
        }
        case UIWebViewNavigationTypeOther: {
            
            [self pushCurrentSnapshotViewWithRequest:request];
            break;
        }
        default: {
            break;
        }
    }
    [self updateNavigationItems];
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self loadJSBoject:webView];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self updateNavigationItems];
    NSString *theTitle=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (theTitle.length > 10) {
        theTitle = [[theTitle substringToIndex:9] stringByAppendingString:@"…"];
    }
    NSLog(@"self.navigationItem.title======%@",self.navigationItem.title) ;
    
    self.navigationItem.title = theTitle;
    //    [self.progressView setProgress:1 animated:NO];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - NJProgress delegate

-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [self.progressView setProgress:progress animated:NO];
}


#pragma mark - setters and getters
-(void)setUrl:(NSURL *)url{
    _url = url;
}

-(void)setProgressViewColor:(UIColor *)progressViewColor{
    _progressViewColor = progressViewColor;
    //    self.progressView.progressColor = progressViewColor;
}

-(UIWebView*)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
        _webView.delegate = (id)self;
        _webView.scalesPageToFit = YES;
        //        _webView.backgroundColor = [UIColor whiteColor];
        _webView.backgroundColor = kBackGroundColor;
        
        //        [_webView addGestureRecognizer:self.swipePanGesture];
    }
    return _webView;
}


-(UIView*)swipingBackgoundView{
    if (!_swipingBackgoundView) {
        _swipingBackgoundView = [[UIView alloc] initWithFrame:self.view.bounds];
        _swipingBackgoundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }
    return _swipingBackgoundView;
}

-(NSMutableArray*)snapShotsArray{
    if (!_snapShotsArray) {
        _snapShotsArray = [NSMutableArray array];
    }
    return _snapShotsArray;
}

-(BOOL)isSwipingBack{
    if (!_isSwipingBack) {
        _isSwipingBack = NO;
    }
    return _isSwipingBack;
}

-(UIPanGestureRecognizer*)swipePanGesture{
    if (!_swipePanGesture) {
        _swipePanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipePanGestureHandler:)];
        [_swipePanGesture requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
    }
    return _swipePanGesture;
}

-(NJKWebViewProgress*)progressProxy{
    if (!_progressProxy) {
        _progressProxy = [[NJKWebViewProgress alloc] init];
        _progressProxy.webViewProxyDelegate = (id)self;
        _progressProxy.progressDelegate = (id)self;
    }
    return _progressProxy;
}

-(NJKWebViewProgressView*)progressView{
    if (!_progressView) {
        CGFloat progressBarHeight = 3.0f;
        CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
        //        CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight-0.5, navigaitonBarBounds.size.width, progressBarHeight);
        CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height, navigaitonBarBounds.size.width, progressBarHeight);
        _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
        //        _progressView.progressColor = self.progressViewColor;
        _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    }
    return _progressView;
}

@end
