//
//  JYMediaPhotoHelper.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/5/8.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYMediaPhotoHelper.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <sys/sysctl.h>

#import<AVFoundation/AVMediaFormat.h>
#import<AVFoundation/AVCaptureDevice.h>




@interface JYMediaPhotoHelper()

@property (nonatomic,strong) UIImagePickerController *imagePicker;
@property (nonatomic,strong) UIPopoverController *popoverVC;
@property (nonatomic, copy) mediaphotoSuccessFn successFn;
@property (nonatomic, copy) mediaphotoFailedFn faliedFn;

@end

@implementation JYMediaPhotoHelper

#pragma mark - Init
+ (JYMediaPhotoHelper *)shareInstance{
    
    static JYMediaPhotoHelper *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JYMediaPhotoHelper alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.imagePicker = [[UIImagePickerController alloc] init];
    }
    return self;
}

#pragma mark - getMethods
//获取当前系统
- (NSString *) getSysInfoByName:(char *)typeSpecifier {
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    return results;
}

//获取照片
-(void)getPhotoByICLibry:(UIViewController *)desViewController SourcType:(EIMediaPhotoType)photoType mediaphotoSuccessFn:(mediaphotoSuccessFn)successFn mediaphotoFailedFn:(mediaphotoFailedFn)failedFn {
    self.successFn = successFn;
    self.faliedFn = failedFn;
    
    //iPad1和模拟器，都没有摄像头,不支持拍照功能
    NSString *platform = [self getSysInfoByName:"hw.machine"];
    if ( photoType == EIMediaPhotoType_Camera && ([platform hasPrefix:@"iPad1"] || [platform hasPrefix:@"x86"])) {
        //设备不支持
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"设备不支持拍照功能" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil];
        [alert show];
        return;
    }
    
    
    
    NSString *rAlterTitle = @"相册" ;
    
    //获取照片
    self.imagePicker.delegate = self;
    switch (photoType) {
        case EIMediaPhotoType_Album:{
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            rAlterTitle = @"相册" ;
        }
            break;
        case EIMediaPhotoType_Camera:{
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            rAlterTitle = @"相机" ;
            
        }
            break;
        default:
            break;
    }
    self.imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    //    self.imagePicker.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:self.imagePicker.sourceType])
    {
        void(^blk)() =  ^() {
            //从相册中选取在iPhone上和iPad上是有区别的，iPhone上可以直接presentModalViewController，但是在iPad上需要使用UIPopoverController进行弹出
            if (DEVICE_IPHONEORPAD == UIUserInterfaceIdiomPhone) {
                
                 [desViewController presentViewController:self.imagePicker animated:YES completion:nil];
                
                
            }else{
                //在iPad上处理
                UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:self.imagePicker];
                if (self.popoverVC != nil) {
                    [self.popoverVC dismissPopoverAnimated:NO];
                    self.popoverVC = nil;
                }
                self.popoverVC = popover;
                [popover presentPopoverFromRect:CGRectMake(0, 0, 1024, 50)
                                         inView:desViewController.view
                       permittedArrowDirections:UIPopoverArrowDirectionAny
                                       animated:YES];
            }
        };
        
        if (photoType == EIMediaPhotoType_Album) {
            
            
            ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
            
            if(author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied){
                
                //无权限
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"您的%@暂未允许访问，请去设置->隐私里面授权!",rAlterTitle] delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
                
                [alert show];
                
            }else{
                blk();

            }
            
        }else{ //相机
        
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            
            if(authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
                
                //无权限
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"您的%@暂未允许访问，请去设置->隐私里面授权!",rAlterTitle] delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
                
                [alert show];
                
            }else{
                blk();

            }
        
        
        }
        
     }
}

#pragma mark - UINavigationControllerDelegate methods
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

#pragma mark - ImagePickerDelegate
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera || picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        //获取原始图片
        UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        
        
        
        UIImage *tempImage = nil;
        if (originalImage.imageOrientation != UIImageOrientationUp) {
            UIGraphicsBeginImageContext(originalImage.size);
            [originalImage drawInRect:CGRectMake(0, 0, originalImage.size.width, originalImage.size.height)];
            tempImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        } else {
            tempImage = originalImage;
        }
        
        
        self.successFn(tempImage);
        
    }else {
        //读取图片错误
        NSError *error = [NSError errorWithDomain:@"读取照片错误" code:400 userInfo:@{@"error_msg": @"无法获取图片"}];
        self.faliedFn(error);
    }
    
    //隐藏泡泡
    if (self.popoverVC != nil) {
        [self.popoverVC dismissPopoverAnimated:YES];
        self.popoverVC = nil;
    }
    //隐藏照片选择器
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSError *error = [NSError errorWithDomain:@"关闭" code:0 userInfo:@{@"error_msg": @"关闭"}];
    self.faliedFn(error);
    if (self.popoverVC != nil) {
        [self.popoverVC dismissPopoverAnimated:YES];
        self.popoverVC = nil;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
