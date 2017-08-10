//
//  JYNoticeModel.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/6/5.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JYNoticeModel : JSONModel


//
@property (nonatomic ,strong) NSString <Optional> *add_adminId;
@property (nonatomic ,strong) NSString <Optional> *content  ;
@property (nonatomic ,strong) NSString <Optional> *create_time;
@property (nonatomic ,strong) NSString <Optional> *edit_adminId;
@property (nonatomic ,strong) NSString <Optional> *edit_time;
@property (nonatomic ,strong) NSString <Optional> *end_time;
@property (nonatomic ,strong) NSString <Optional> *id  ;
@property (nonatomic ,strong) NSString <Optional> *image_url;

@property (nonatomic ,strong) NSString <Optional> *news_id;
@property (nonatomic ,strong) NSString <Optional> *notice_user;
@property (nonatomic ,strong) NSString <Optional> *realName  ;
@property (nonatomic ,strong) NSString <Optional> *remark  ;
@property (nonatomic ,strong) NSString <Optional> *sendType  ;
@property (nonatomic ,strong) NSString <Optional> *sort  ;
@property (nonatomic ,strong) NSString <Optional> *start_time;
@property (nonatomic ,strong) NSString <Optional> *status ;
@property (nonatomic ,strong) NSString <Optional> *title  ;
@property (nonatomic ,strong) NSString <Optional> *type  ;


@end
