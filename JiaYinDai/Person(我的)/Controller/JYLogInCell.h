//
//  JYLogInCell.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/5.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JYLogCellType) {
    JYLogCellTypeNormal,
    JYLogCellTypePassword, //密码
    JYLogCellTypeCode, //验证码
};




@interface JYLogInCell : UITableViewCell

@property (nonatomic,strong,readonly) UITextField *rTextField ;


-(instancetype)initWithCellType:(JYLogCellType)type reuseIdentifier:(NSString *)reuseIdentifier ;


@end


typedef NS_ENUM(NSUInteger, JYLogFootViewType) {
    JYLogFootViewTypeLogIn, //登录
    JYLogFootViewTypeRegister, //注册
    
    JYLogFootViewTypeSetPassword, //设置密码
    JYLogFootViewTypeGetBackPass, //找回密码

};


@interface JYLogFootView : UIView


@property (nonatomic ,strong,readonly) UIButton *rCommitBtn ;
@property (nonatomic ,strong,readonly) UIButton *rForgetBtn ;
@property (nonatomic ,strong,readonly) UIButton *rRegisterBtn;
@property (nonatomic ,strong,readonly) UIButton *rAgreeBtn;


- (instancetype)initWithType:(JYLogFootViewType)type ;


@end
