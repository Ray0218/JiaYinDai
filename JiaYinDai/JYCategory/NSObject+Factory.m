//
//  NSObject+Factory.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/3/31.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "NSObject+Factory.h"

@implementation NSObject (Factory)

- (UILabel*)jyCreateLabelWithTitle:(NSString*)title font:(CGFloat)font color:(UIColor*)color align:(NSTextAlignment) align{
    
    UILabel *label = [[UILabel alloc]init];
    label.text = title ;
    label.textColor = color ;
    label.font = [UIFont systemFontOfSize:font] ;
    label.textAlignment = align ;
    label.backgroundColor = [UIColor clearColor] ;
    
    return label ;
}

-(UIButton*)jyCreateButtonWithTitle:(NSString*)title {

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom] ;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter ;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
    button.clipsToBounds = YES ;
    button.layer.cornerRadius = 5 ;
    button.titleLabel.font = [UIFont systemFontOfSize:19] ;

    
    button.backgroundColor = [UIColor clearColor] ;
    [button setBackgroundImage:[UIImage jy_imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled] ;
    [button setBackgroundImage:[UIImage jy_imageWithColor: kBlueColor] forState:UIControlStateNormal] ;

    
     return button ;

}

-(void)jychangeLineSpaceForLabel:(UILabel *)label baseString:(NSString*)baseString WithSpace:(float)space {
    
    NSString *labelText = label.text;
    if (labelText.length <= 0) {
        return ;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:kBlueColor range:NSMakeRange(0, labelText.length)] ;
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:kTextBlackColor range:NSMakeRange(0, baseString.length)] ;
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter ;
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}



@end
