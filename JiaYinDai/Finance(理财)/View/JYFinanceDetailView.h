//
//  JYFinanceDetailView.h
//  JiaYinDai
//
//  Created by 吴孔亮 on 2017/3/28.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol JYFinanceDelegate <NSObject>

-(void)detailShowAlterView ;

@end

@interface JYFinanceDetailView : UIView 

@property (nonatomic,weak) id<JYFinanceDelegate>delegate ;

@end


@interface JYDetailBottomView : UIView

@end
