//
//  JYPasswordSetModel.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/7.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JYPasswordSetModel : JSONModel

@property (nonatomic,strong) NSString *rTitle ; //标题文字
@property (nonatomic,strong) NSString *rTFTitle ; //输入框文字
 @property (nonatomic,strong) NSString *rTFPlaceholder ; //输入框默认文字
@property (nonatomic,assign) BOOL  rHasCode ; //是否有验证码按钮

- (instancetype)initWithTitle:(NSString*)title fieldText:(NSString*)text placeHolder:(NSString*)place hasCode:(BOOL)hasCode ;

@end
