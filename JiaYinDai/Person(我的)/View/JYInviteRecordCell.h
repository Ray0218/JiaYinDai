//
//  JYInviteRecordCell.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/6/5.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYInviteRecordCell : UITableViewCell


-(instancetype)initWithRowNum:(NSInteger)rowNum reuseIdentifier:(NSString *)reuseIdentifier  ;


-(void)pvt_LoadDataDicArray:(NSArray*) dicArr dicKey:(NSString*)keyStr  ;



@end


static inline NSString * TTTimeHMOnlyString(NSString *timeInterval ){
    
    if (timeInterval.length <= 0) {
        return @"" ;
    }
    
    NSTimeInterval times = [timeInterval longLongValue]/1000.0 ;
    
    NSDate *dateS = [NSDate dateWithTimeIntervalSince1970:times] ;
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"HH时mm分" ;
    
    NSString* timString = [format stringFromDate:dateS] ;
    
    
    return timString ;
    
} ;
