//
//  JYPersonCell.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/6.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYPersonCell : UITableViewCell
@property (nonatomic,strong) UIImageView* rRightImg ;
@property (nonatomic ,strong,readonly) UILabel *rRightLabel ;

-(void)rSetCellDtaWithDictionary:(NSDictionary*)dic ;

@end


#define keyTitle     @"titles"
#define keyImage     @"imageNames"
