//
//  JYAddImgView.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/11.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYAddImgView : UIView


@property (nonatomic,strong,readonly) UIImageView *rImageView ;

@property (nonatomic,strong,readonly) UIButton *rBgView ;

@property (nonatomic,strong,readonly) UIButton *rDeleteBtn  ;


@end

@class JYAddImgCollectionViewCell ;

typedef void(^DeleteBlock)(JYAddImgCollectionViewCell *cell);

@interface JYAddImgCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)JYAddImgView *rCellView ;


 
@property (nonatomic,copy) DeleteBlock rDeleteBlock ;


@end


#define kImageHeigh  (SCREEN_WIDTH-15-5-5-5)/3.0
