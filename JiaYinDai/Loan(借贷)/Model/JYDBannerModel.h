//
//  JYDBannerModel.h
//  JiaYinDai
//
//  Created by 陈侠 on 2017/5/16.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JYDBannerModel : JSONModel
@property (nonatomic ,strong) NSString <Optional> *category ; //1 链接地址  0上传内容

@property (nonatomic ,strong) NSString <Optional> *createTime ; //创建时间

@property (nonatomic ,strong) NSString <Optional> *dynamicTime ;//动态时间 单位 秒  (广告显示时间)


@property (nonatomic ,strong) NSString <Optional> *endTime ; //截止时间

@property (nonatomic ,strong) NSString <Optional> *id ;

@property (nonatomic ,strong) NSString <Optional> *imageUrl ;//url地址


@property (nonatomic ,strong) NSString <Optional> *linkUrl ; //链接地址


@property (nonatomic ,strong) NSString <Optional> *modifyId ;//修改人id


@property (nonatomic ,strong) NSString <Optional> *modifyTime ; //修改时间
@property (nonatomic ,strong) NSString <Optional> *name ; //广告标题


@property (nonatomic ,strong) NSString <Optional> *platform ; //所属应用: 1嘉银贷款app  2官网web  3微信端


@property (nonatomic ,strong) NSString <Optional> *position ;// 广告位置  1 启动图广告   2首页轮播图广告  3首页bannner广告  4列表底部banner广告  5列表顶部banner广告  6首页弹出框广告  7理财频道轮播图 8 理财频道列表banner广告


@property (nonatomic ,strong) NSString <Optional> *remark ; //上传内容或url地址

@property (nonatomic ,strong) NSString <Optional> *shareContent ;//分享内容

@property (nonatomic ,strong) NSString <Optional> *sort ;//排序


@property (nonatomic ,strong) NSString <Optional> *startPicture ; //启动图  1 半屏广告  2全屏广告


@property (nonatomic ,strong) NSString <Optional> *startTime ;//开始时间

@property (nonatomic ,strong) NSString <Optional> *status ; //状态 0禁止 1启用

@property (nonatomic ,strong) NSString <Optional> *subtitle ;//副标题

@property (nonatomic ,strong) NSString <Optional> *sync ;//是否同步  1 不同步  2同步到微信






@end
