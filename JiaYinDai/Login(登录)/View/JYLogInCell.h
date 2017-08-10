//
//  JYLogInCell.h
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/5.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAgreeView.h"


typedef NS_ENUM(NSUInteger, JYLogCellType) {
    JYLogCellTypeNormal,
    JYLogCellTypePassword, //密码
    JYLogCellTypeMakesurePassword, //确认密码
     JYLogCellTypeCode, //验证码
};




@interface JYLogInCell : UITableViewCell

@property (nonatomic,strong,readonly) UITextField *rTextField ;
@property (nonatomic,strong,readonly) UIImageView *rLeftImgView ;
@property (nonatomic,strong,readonly) UIButton *rRightBtn ;


-(void)startTimeGCD ;
-(instancetype)initWithCellType:(JYLogCellType)type reuseIdentifier:(NSString *)reuseIdentifier ;


@end


typedef NS_ENUM(NSUInteger, JYLogFootViewType) {
    
    
    JYLogFootViewTypeNormal, //只有文字

    JYLogFootViewTypeLogIn, //登录 有两个安妞
    JYLogFootViewTypeRegister, //注册
    
    JYLogFootViewTypeSetPassword, //设置登录密码 有同意协议
    JYLogFootViewTypeReSetPassword, //重置登录设置密码

    JYLogFootViewTypeGetBackPass, //找回密码

};


@interface JYLogFootView : UIView


@property (nonatomic ,strong,readonly) UIButton *rCommitBtn ;
@property (nonatomic ,strong,readonly) UIButton *rForgetBtn ;
@property (nonatomic ,strong,readonly) UIButton *rRegisterBtn;
 

@property (nonatomic ,strong,readonly) UILabel *rDescLabel;


@property (nonatomic ,strong,readonly) JYAgreeView *rAgreeView ;



- (instancetype)initWithType:(JYLogFootViewType)type ;


@end
