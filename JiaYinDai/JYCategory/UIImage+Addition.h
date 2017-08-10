//
//  UIImage+Addition.h
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/23.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Addition)

+ (UIImage *)jy_imageWithColor:(UIColor *)color  ;
- (UIImage *)jy_imageWithTintColor:(UIColor *)tintColor  ;
- (UIImage *)jy_resizedImageToSize:(CGSize)dstSize  ;



+(UIImage*)jy_logoQrCodeWithString:(NSString *) titleStr logo:(UIImage*)logo ;

@end
