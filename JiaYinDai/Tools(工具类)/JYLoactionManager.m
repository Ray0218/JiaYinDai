//
//  JYLoactionManager.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/9.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYLoactionManager.h"

@interface JYLoactionManager ()<CLLocationManagerDelegate>

@property (nonatomic ,strong)CLLocationManager *locationManager ;

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *rAddress;// 省市区
@property (nonatomic, strong) NSString *name;



@property (nonatomic, copy) JYLoactionBlock rFinishBlock;


@end

static JYLoactionManager *manager = nil ;

@implementation JYLoactionManager


+(instancetype)shareManager {
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[super allocWithZone:NULL]init];
    });
    
    return manager ;
    
}

+(instancetype)allocWithZone:(struct _NSZone *)zone {
    
    return [JYLoactionManager shareManager];
}


-(CLLocationManager*)locationManager {
    
    if (_locationManager == nil) {
        
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        //控制定位精度,越高耗电量越
        _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        // 总是授权
        _locationManager.distanceFilter = 10.0f;
        //
        
        
        /** 由于IOS8中定位的授权机制改变 需要进行手动授权
         * 获取授权认证，两个方法：
         * [self.locationManager requestWhenInUseAuthorization];
         * [self.locationManager requestAlwaysAuthorization];
         */
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            NSLog(@"requestWhenInUseAuthorization");
            [_locationManager requestWhenInUseAuthorization];
            
        }else{
            
            [_locationManager requestAlwaysAuthorization];
        }
        
        
        
        
    }
    
    return _locationManager ;
}


- (void)startLocationComplete:(JYLoactionBlock) complete   {
    
    
    
    
    
    
    if ([CLLocationManager locationServicesEnabled]) {
        //开始定位，不断调用其代理方法
        [self.locationManager startUpdatingLocation];
        
    }else{
        
        [JYProgressManager showBriefAlert:@"定位服务不可用！"] ;
    }
    
    
    
    self.rFinishBlock = complete ;
    
}




//开始定位
- (void)startLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        
        //开始定位，不断调用其代理方法
        [self.locationManager startUpdatingLocation];
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        [UIAlertView alertViewWithTitle:@"温馨提示" message:@"您的位置暂未允许访问，请去设置->隐私里面授权!" cancelButtonTitle:@"知道了" otherButtonTitles:nil onDismiss:^(NSInteger buttonIndex) {
            
        } onCancel:^{
            
        }] ;   }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //经度和纬度
    NSString *longitude = [NSString stringWithFormat:@"%lf", newLocation.coordinate.longitude];
    NSString *latitude =  [NSString stringWithFormat:@"%lf", newLocation.coordinate.latitude];
    NSLog(@"longitude=======%@   latitude========%@",longitude,latitude);
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    @weakify(self)
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        @strongify(self)
      
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            //将获得的所有信息显示到label上
            
            //administrativeArea 浙江省  subLocality 江干区  //name迪凯银座 //thoroughfare公园路和解放东路路口
            NSString *administrativeArea = placemark.administrativeArea;
            NSString *locality = placemark.locality;
            NSString *subLocality = placemark.subLocality;
            //            NSString *name = placemark.name ;
            
            
            if (locality.length) {
                self.rAddress = [administrativeArea stringByAppendingString:locality];
            }
            
            if (subLocality.length) {
                self.rAddress = [self.rAddress stringByAppendingString:subLocality];
            }
            
            //            if (name) {
            //                self.rAddress = [self.rAddress stringByAppendingString:name];
            //            }
            
            NSLog(@"Provinces====== %@", self.rAddress);
            //获取城市
            self.city = placemark.locality;
            if (self.city.length <= 0) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                self.city = placemark.administrativeArea;
                self.rAddress = [administrativeArea stringByAppendingString:subLocality];
            }
            NSLog(@"city = %@", self.rAddress);
            
            if (self.rFinishBlock) {
                self.rFinishBlock(self.rAddress) ;
            }
            
            //            [_cityButton setTitle:city forState:UIControlStateNormal];
        }else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}


 

@end
