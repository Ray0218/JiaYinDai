//
//  JYBankModel.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/3.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JYBankModel : JSONModel

@property (nonatomic ,strong) NSString <Optional> *bankNo ;
@property (nonatomic ,strong) NSString <Optional> *bankName ;
@property (nonatomic ,strong) NSString <Optional> *dayLimit ;
@property (nonatomic ,strong) NSString <Optional> *id ;
@property (nonatomic ,strong) NSString <Optional> *monthLimit ;
@property (nonatomic ,strong) NSString <Optional> *payChannel ;
@property (nonatomic ,strong) NSString <Optional> *singleLimit ;
 @property (nonatomic ,strong) NSString <Optional> *cardNo ; //卡号



@property (nonatomic ,strong) NSString <Optional> *rBankMoney ; //钱数

@property (nonatomic ,strong) NSString <Optional> *rBankType ; //银行卡类型



@end
