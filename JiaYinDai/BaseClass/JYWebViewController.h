//
//  JYWebViewController.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/20.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYFatherController.h"

@interface JYWebViewController : JYFatherController

/**
 *  origin url
 */
@property (nonatomic,strong)NSURL* url;

/**
 *  embed webView
 */
@property (nonatomic)UIWebView* webView;

/**
 *  tint color of progress view
 */
@property (nonatomic)UIColor* progressViewColor;

/**
 *  get instance with url
 *
 *  @param url url
 *
 *  @return instance
 */
-(instancetype)initWithUrl:(NSURL*)url;

/**
 *  get instance with url
 *
 *  @param   url
 *
 *  @return instance
 */
//-(instancetype)initWithUrl:(NSString*)urlString urlWithParam:(NSMutableDictionary*)param;


-(void)reloadWebView;


@end
