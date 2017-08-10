//
//  JYApplyRecordModel.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/11.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JYApplyRecordModel : JSONModel

@property (nonatomic ,strong) NSString <Optional> * applyNo ; //订单号
@property (nonatomic ,strong) NSString <Optional> *applyTime ; //申请时间
@property (nonatomic ,strong) NSString <Optional> *auditStatus ; //审核状态 0,1,10代表审核中  2,5代表筹款中  3.4,11代表拒绝  6,7代表放款成功 9打款失败
@property (nonatomic ,strong) NSString <Optional> *principal ; //借款本金


@property (nonatomic ,strong) NSString <Optional> *auditOpinion  ; //审核意见
@property (nonatomic ,strong) NSString <Optional> *lendTime  ; //放款时间  计息时间


@property (nonatomic ,strong) NSString <Optional> *refuseType  ; // 1代表需要补录 0不需要补录 先判断 refusetype是否为1 ，在判断aduitState



@end


@interface JYRecordDetailModel : JSONModel


@property (nonatomic ,strong) NSString <Optional> *bankName  ; //银行名称
@property (nonatomic ,strong) NSString <Optional> *cardNoWh  ; //银行卡尾号
@property (nonatomic ,strong) JYApplyRecordModel <Optional> *creditOrder ;
@property (nonatomic ,strong) NSString <Optional> *productName ; //产品名称


@end
