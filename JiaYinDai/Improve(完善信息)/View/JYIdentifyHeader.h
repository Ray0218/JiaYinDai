//
//  JYIdentifyHeader.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/17.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAddImgView.h"

typedef NS_ENUM(NSUInteger, JYIdentifyType) {
    JYIdentifyTypeName,
    JYIdentifyTypeNameOnly, //没有顶部进度

    JYIdentifyTypeBank,
    JYIdentifyTypePassword,
};


typedef void(^JYIndentifyImageBlok)(JYAddImgView* addImageView);

@interface JYIdentifyHeader : UIView


@property (nonatomic ,strong,readonly) NSMutableArray  *rImageArray  ;


@property (nonatomic ,copy) JYIndentifyImageBlok  rAddImageBlock  ;



- (instancetype)initWithType:(JYIdentifyType)type ;


@end



@interface JYImageLabe : UIView

@property (nonatomic, strong) UIImageView *rImageView ;

@property (nonatomic ,strong) UILabel *rLabel ;

@property (nonatomic ,assign) BOOL rHighlighted ;


@end
