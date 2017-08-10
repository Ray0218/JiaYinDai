//
//  JYBillCell.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/21.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBillListModel.h"

 

@interface JYBillCell : UITableViewCell

@property (nonatomic ,strong) JYBillListModel *rDataModel ;

-(void)setCellColor:(UIColor*) colorStyle ;

@end


@class JYBillAlterCell ;
typedef void(^JYBillBlock)(NSInteger index ,JYBillAlterCell *curCell);

@interface JYBillAlterCell : UITableViewCell

@property (nonatomic ,copy) JYBillBlock rBlock ;

-(void)setTitles:(NSArray*)titles images:(NSArray*)images ;

@end


 
