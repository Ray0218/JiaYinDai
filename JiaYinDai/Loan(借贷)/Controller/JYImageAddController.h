//
//  JYImageAddController.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/11.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYFatherController.h"


 
typedef void(^JYImageAddBlock)(NSString* imageURLs);


@interface JYImageAddController : JYFatherController


@property (nonatomic ,strong) NSString*rLastImges ; //已选择的图片

@property (nonatomic ,copy) JYImageAddBlock rFinishBlock ;

 
@end
