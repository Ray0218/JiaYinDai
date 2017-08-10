//
//  JYProductModel.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/4.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JYProductModel : JSONModel

@property (nonatomic ,strong) NSString <Optional> *adminId ;
@property (nonatomic ,strong) NSString <Optional> *adminName ;
@property (nonatomic ,strong) NSString <Optional> *bonusId ;
@property (nonatomic ,strong) NSString <Optional> *categoryId ;
@property (nonatomic ,strong) NSString <Optional> *contractId;

@property (nonatomic ,strong) NSString <Optional> *description ;

@property (nonatomic ,strong) NSString <Optional> *highestAmount ;

@property (nonatomic ,strong) NSString <Optional> *id ;


@property (nonatomic ,strong) NSString <Optional> *interestDate ;

@property (nonatomic ,strong) NSString <Optional> *label ;

@property (nonatomic ,strong) NSString <Optional> *lendPeriod ;


@property (nonatomic ,strong) NSString <Optional> *lowestAmount ;


@property (nonatomic ,strong) NSString <Optional> *name ;


@property (nonatomic ,strong) NSString <Optional> *recommend ;


@property (nonatomic ,strong) NSString <Optional> *refund ;


@property (nonatomic ,strong) NSString <Optional> *risk ;


@property (nonatomic ,strong) NSString <Optional> *shippedTime ;

@property (nonatomic ,strong) NSString <Optional> *sort ;

@property (nonatomic ,strong) NSString <Optional> *status ;

@property (nonatomic ,strong) NSString <Optional> *term ;

@property (nonatomic ,strong) NSString <Optional> *yearInterest ;


@property (nonatomic ,strong) NSString <Optional> *manageRate  ;//资金管理费 千分之8
@property (nonatomic ,strong) NSString <Optional> *serviceRate  ; //服务费 百分之5







@end
