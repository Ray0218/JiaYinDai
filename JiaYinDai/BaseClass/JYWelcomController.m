//
//  JYWelcomController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/26.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYWelcomController.h"
#import "JYTabBarController.h"


@interface JYWelcomController ()<UIScrollViewDelegate>

@end

@implementation JYWelcomController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupScrollView];
    
    [self setupPageControl];
}

//创建程序第一次加载要显示的视图

- (void)setupScrollView

{
    
    CGRect r = [[UIScreen mainScreen] applicationFrame];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    scrollView.delegate =self;
    
    [self.view addSubview:scrollView];
    
    //关闭水平方向上的滚动条
    
    scrollView.showsHorizontalScrollIndicator =NO;
    
    //是否可以整屏滑动
    
    scrollView.pagingEnabled =YES;
    
    scrollView.tag =200;
    
    scrollView.contentSize =CGSizeMake(r.size.width *3, [UIScreen mainScreen].bounds.size.height);
    
    for (int i = 0; i < 3; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(r.size.width * i,0,r.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"t%d_full", i +1]ofType:@"jpg"]];
        
        [scrollView addSubview:imageView];
        
    }
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button.backgroundColor=[UIColor darkGrayColor];
    
    [button setTitle:@"开始体验" forState:UIControlStateNormal];
    
    button.frame=CGRectMake(r.size.width*2+r.size.width/2-50, [UIScreen mainScreen].bounds.size.height -80, 100, 30);
    
    [button addTarget:self action:@selector(showDocList) forControlEvents:UIControlEventTouchUpInside];
    
    [button setImage:[UIImage imageNamed:@"start.png"] forState:UIControlStateNormal];
    
    button.imageEdgeInsets=UIEdgeInsetsMake(0, 80, 0, 0);
    
    button.titleEdgeInsets=UIEdgeInsetsMake(0, -40, 0, 20);
    
    [scrollView addSubview:button];
    
}


//跳转到主页面

-(void)showDocList{
    
    JYTabBarController *mainList=[[ JYTabBarController alloc]init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = mainList ;
    
//    [self presentViewController:mainList animated:NO completion:nil];
    
}

- (void)setupPageControl

{
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height -40, [UIScreen mainScreen].bounds.size.width, 20)];
    pageControl.backgroundColor = [UIColor greenColor] ;
    
    pageControl.tag =100;
    
    //设置表示的页数
    
    pageControl.numberOfPages =3;
    
    //设置选中的页数
    
    pageControl.currentPage =0;
    
    //设置未选中点的颜色
    
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    
    //设置选中点的颜色
    
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    
    //添加响应事件
    
    [pageControl addTarget:self action:@selector(handlePageControl:)forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:pageControl];
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView

{
    
    UIPageControl *pagControl = (UIPageControl *)[self.view viewWithTag:100];
    
    pagControl.currentPage = scrollView.contentOffset.x /SCREEN_WIDTH;
    
}

- (void)handlePageControl:(UIPageControl *)pageControl

{
    
    //切换pageControl .对应切换scrollView不同的界面
    
    UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:200];
    
    //
    
    [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * pageControl.currentPage,0)animated:YES];
    
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
