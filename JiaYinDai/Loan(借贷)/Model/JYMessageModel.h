//
//  JYMessageModel.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/15.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JYMessageModel : JSONModel

@property (nonatomic ,strong) NSString <Optional> *audit ;
@property (nonatomic ,strong) NSString <Optional> *category ;
@property (nonatomic ,strong) NSString <Optional> *content ;
@property (nonatomic ,strong) NSString <Optional> *createTime  ;
@property (nonatomic ,strong) NSString <Optional> *customerId  ;
@property (nonatomic ,strong) NSString <Optional> *effectTime  ;
@property (nonatomic ,strong) NSString <Optional> *id  ;
@property (nonatomic ,strong) NSString <Optional> *status  ; //1已读 0未读
@property (nonatomic ,strong) NSString <Optional> *title  ;
@end


@interface JYMessageListModel : JSONModel

@property (nonatomic ,strong) NSString <Optional> *endRow  ;
@property (nonatomic ,strong) NSString <Optional> *firstPage  ;
@property (nonatomic ,strong) NSString <Optional> *hasNextPage  ;
@property (nonatomic ,strong) NSString <Optional> *hasPreviousPage  ;
@property (nonatomic ,strong) NSString <Optional> *isFirstPage  ;
@property (nonatomic ,strong) NSString <Optional> *isLastPage  ;
@property (nonatomic ,strong) NSString <Optional> *lastPage  ;
@property (nonatomic ,strong) NSString <Optional> *navigatePages ;
@property (nonatomic ,strong) NSString <Optional> *navigatepageNums ;

@property (nonatomic ,strong) NSString <Optional> *nextPage  ;
@property (nonatomic ,strong) NSString <Optional> *orderBy  ;
@property (nonatomic ,strong) NSString <Optional> *pageNum  ;
@property (nonatomic ,strong) NSString <Optional> *pageSize  ;
@property (nonatomic ,strong) NSString <Optional> *pages  ;
@property (nonatomic ,strong) NSString <Optional> *prePage ;



@property (nonatomic ,strong) NSArray <JYMessageModel*> *rows ;


@property (nonatomic ,strong) NSString <Optional> *size  ;
@property (nonatomic ,strong) NSString <Optional> *startRow  ;
@property (nonatomic ,strong) NSString <Optional> *total  ;

@end
