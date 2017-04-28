//
//  JYUserModel.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/28.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JYUserModel : JSONModel

@property(nonatomic ,strong) NSString <Optional>*address ;
@property(nonatomic ,strong) NSString <Optional>*age ;
@property(nonatomic ,strong) NSString  <Optional>*auditStatus ;
@property(nonatomic ,strong) NSString <Optional>*cellphone ;
@property(nonatomic ,strong) NSString <Optional>*channel ;

@property(nonatomic ,strong) NSString <Optional>*channelId ;

@property(nonatomic ,strong) NSString <Optional>*children;
@property(nonatomic ,strong) NSString <Optional>*comments;
@property(nonatomic ,strong) NSString <Optional>*company;
@property(nonatomic ,strong) NSString <Optional>*contact1;
@property(nonatomic ,strong) NSString <Optional>*contact1Comments ;
@property(nonatomic ,strong) NSString <Optional>*contact1Name;
@property(nonatomic ,strong) NSString <Optional>*contact1Phone ;
@property(nonatomic ,strong) NSString <Optional>*contact2 ;
@property(nonatomic ,strong) NSString <Optional>*contact2Comments;
@property(nonatomic ,strong) NSString <Optional>*contact2Name;
@property(nonatomic ,strong) NSString <Optional>*contact2Phone;
@property(nonatomic ,strong) NSString <Optional>*education;
@property(nonatomic ,strong) NSString <Optional>*family;
@property(nonatomic ,strong) NSString <Optional>*firstTradeTime;
@property(nonatomic ,strong) NSString <Optional>*id;
@property(nonatomic ,strong) NSString <Optional>*idcard;
@property(nonatomic ,strong) NSString <Optional>*introducerPhone;
@property(nonatomic ,strong) NSString <Optional>*investigater;
@property(nonatomic ,strong) NSString <Optional>*inviterPhone;
@property(nonatomic ,strong) NSString <Optional>*latestLoginDevice;

@property(nonatomic ,strong) NSString <Optional>*latestLoginTime;

@property(nonatomic ,strong) NSString <Optional>*latestTradeTime;

@property(nonatomic ,strong) NSString <Optional>*loginPassword;
@property(nonatomic ,strong) NSString <Optional>*marriage;
@property(nonatomic ,strong) NSString <Optional>*origin;
@property(nonatomic ,strong) NSString <Optional>*realName;
@property(nonatomic ,strong) NSString <Optional>*registerDevice;
@property(nonatomic ,strong) NSString <Optional>*registerTime;
@property(nonatomic ,strong) NSString <Optional>*score;
@property(nonatomic ,strong) NSString <Optional>*sex;
@property(nonatomic ,strong) NSString <Optional>*tradePassword;

@end
