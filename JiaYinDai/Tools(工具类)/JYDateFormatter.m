//
//  JYDateFormatter.m
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/22.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYDateFormatter.h"

static JYDateFormatter *_formatter = nil ;

@interface JYDateFormatter ()

@property(nonatomic, strong) NSDateFormatter *rYMDFormatter ;
@property(nonatomic, strong) NSDateFormatter *rYMDHMFormatter ;
@property(nonatomic, strong) NSDateFormatter *rYMDHMSFormatter ;
@property(nonatomic, strong) NSDateFormatter *rYMDHMSSFormatter ;


@end

@implementation JYDateFormatter

+(instancetype)shareFormatter {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _formatter = [[super allocWithZone:NULL]init] ;
    });
    return _formatter ;
}

+(id)allocWithZone:(struct _NSZone *)zone {
    return [JYDateFormatter shareFormatter] ;
}


#pragma mark -获取相应DateFormatter
-(NSDateFormatter *)jy_getFormatterWithType:(JYDateFormatType)type{
    NSDateFormatter *format ;
     switch (type) {
        case JYDateFormatTypeYMD:
            return self.rYMDFormatter ;
            break;
        case JYDateFormatTypeYMDHM :
            return self.rYMDHMFormatter ;
        case JYDateFormatTypeYMDHMS:
            return self.rYMDHMSFormatter ;
             
         case JYDateFormatTypeYMDHMSS:
             return self.rYMDHMSSFormatter ;
        default:
            break;
    }
    return  format ;
    
}


#pragma mark- getter

-(NSDateFormatter*)rYMDFormatter {
    
    if (_rYMDFormatter == nil) {
        _rYMDFormatter = [[NSDateFormatter alloc]init];
        _rYMDFormatter.dateFormat = @"yyyy-MM-dd" ;
    }
    return _rYMDFormatter ;
}

-(NSDateFormatter*)rYMDHMFormatter {
    
    if (_rYMDHMFormatter == nil) {
        _rYMDHMFormatter = [[NSDateFormatter alloc]init];
        _rYMDHMFormatter.dateFormat = @"yyyy-MM-dd HH:mm" ;
    }
    return _rYMDHMFormatter ;
}

-(NSDateFormatter*)rYMDHMSFormatter {
    
    if (_rYMDHMSFormatter == nil) {
        _rYMDHMSFormatter = [[NSDateFormatter alloc]init];
        _rYMDHMSFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss" ;
    }
    return _rYMDHMSFormatter ;
}

-(NSDateFormatter*)rYMDHMSSFormatter {
    
    if (_rYMDHMSSFormatter == nil) {
        _rYMDHMSSFormatter = [[NSDateFormatter alloc]init];
        _rYMDHMSSFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss:SS" ;
    }
    return _rYMDHMSSFormatter ;
}



@end
