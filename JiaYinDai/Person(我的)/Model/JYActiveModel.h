//
//  JYActiveModel.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/22.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JYActiveModel : JSONModel


@property (nonatomic ,strong) NSString<Optional> *beginDate ;
@property (nonatomic ,strong) NSString<Optional> *createTime  ;
@property (nonatomic ,strong) NSString<Optional> *endDate  ;
@property (nonatomic ,strong) NSString<Optional> *id  ;
@property (nonatomic ,strong) NSString<Optional> *imageUrl ;
@property (nonatomic ,strong) NSString<Optional> *link  ;
@property (nonatomic ,strong) NSString<Optional> *remark ;


@property (nonatomic ,strong) NSString<Optional> *appLink  ;


@property (nonatomic ,strong) NSString<Optional> *sort ;
@property (nonatomic ,strong) NSString<Optional> *status  ;
@property (nonatomic ,strong) NSString<Optional> *title ;

@end
