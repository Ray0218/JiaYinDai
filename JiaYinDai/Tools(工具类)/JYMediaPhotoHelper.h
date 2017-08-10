//
//  JYMediaPhotoHelper.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/8.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^mediaphotoSuccessFn)(UIImage *resultImage);
typedef void(^mediaphotoFailedFn)(NSError *error);

typedef NS_ENUM(NSInteger, EIMediaPhotoType) {
    EIMediaPhotoType_Album = 1,            //通过相册获取图片
    EIMediaPhotoType_Camera = 2,           //通过相机获取图片
};


@interface JYMediaPhotoHelper : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>



//分配内存
+ (JYMediaPhotoHelper *)shareInstance;

//获取照片
-(void)getPhotoByICLibry:(UIViewController *)desViewController SourcType:(EIMediaPhotoType)photoType mediaphotoSuccessFn:(mediaphotoSuccessFn)successFn mediaphotoFailedFn:(mediaphotoFailedFn)failedFn;


@end
