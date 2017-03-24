//
//  JYMessageModel.h
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/24.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JYMessageModel : JSONModel

typedef NS_ENUM(NSInteger, JYMessageType) {
    JYMessageTypeSystem,    // 系统消息
    JYMessageTypeAction,     // 活动消息
    JYMessageTypeDeal,     // 交易消息
};

@property (nonatomic, strong, readonly) NSString *rSystemIdentifier;
@property (nonatomic, strong, readonly) NSString *rActionIdentifier;
@property (nonatomic, strong, readonly) NSString *rDealIndentifier;

@property(nonatomic ,strong)NSMutableArray *rDataArray ;
@property (nonatomic, assign) JYMessageType gameLiveType;


/**
 *  获取指定位置上cell的重用标识
 *
 *  @param indexPath [in]行索引
 *  @param tab       [in]标签
 *
 *  @return 重用字符串标识
 */
- (NSString *)cellIdentifierAtIndexPath:(NSIndexPath *)indexPath forTab:(JYMessageType)tab;



@end
