//
//  JYPersonInfoCell.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/4/7.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYPersonInfoCell.h"

@interface JYPersonInfoCell (){
    JYPernfoCellType rCellType ;
}

@property (nonatomic,strong) UILabel *rTitleLabel ;
@property (nonatomic,strong) UILabel *rDetailLabel ;
@property (nonatomic,strong) UIImageView *rRightImgView ;
@property (nonatomic,strong) UIImageView *rArrowView ;

@end

@implementation JYPersonInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithCellType:(JYPernfoCellType)type reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    if (self) {
        rCellType = type ;
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        [self buildSubViewsUI] ;
    }
    
    return self ;
}

-(void)buildSubViewsUI {
    
    if (rCellType == JYPernfoCellTypeHeader) {
        self.rRightImgView.layer.cornerRadius = 5 ;
        self.rRightImgView.clipsToBounds = YES ;
    }else{
        self.rRightImgView.image = [UIImage imageNamed:@"per_code"] ;
    }
    
    [self.contentView addSubview:self.rTitleLabel];
    
    if (rCellType != JYPernfoCellTypeName) {
        [self.contentView addSubview:self.rArrowView];
        
    }
    
    if (rCellType == JYPernfoCellTypeHeader || rCellType == JYPernfoCellTypeCode) {
        [self.contentView addSubview:self.rRightImgView];
        
    }else{
        [self.contentView addSubview:self.rDetailLabel];
        
    }
    
    [self layoutSubviewContains];
    
    
}


-(void)layoutSubviewContains{
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15) ;
        make.centerY.equalTo(self.contentView) ;
    }] ;
    
    if (rCellType == JYPernfoCellTypeHeader) {
        [self.rRightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10) ;
            make.right.equalTo(self.rArrowView.mas_left).offset(-10) ;
            make.width.mas_equalTo(60) ;
            make.height.mas_equalTo(60) ;
        }] ;
    }else if (rCellType == JYPernfoCellTypeCode){
        
        [self.rRightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(15) ;
            make.right.equalTo(self.rArrowView.mas_left).offset(-10) ;
            make.height.and.width.mas_equalTo(15) ;
        }] ;
    }
    
    if (rCellType == JYPernfoCellTypeName) {
        [self.rDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15) ;
            make.centerY.equalTo(self.contentView) ;
            
        }] ;
    }else{
        [self.rArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15) ;
            make.centerY.equalTo(self.contentView) ;
        }] ;
        
        
        if (rCellType == JYPernfoCellTypeNormal) {
            [self.rDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.rArrowView.mas_left).offset(-15) ;
                make.centerY.equalTo(self.contentView) ;
                
            }] ;
        }
    }
    
}
#pragma mark- getter

-(UILabel*)rTitleLabel {
    
    if (_rTitleLabel == nil) {
        _rTitleLabel = [self jyCreateLabelWithTitle:@"头像" font:18 color:[UIColor blackColor] align:NSTextAlignmentLeft] ;
    }
    return _rTitleLabel ;
}

-(UILabel*)rDetailLabel {
    if (_rDetailLabel == nil) {
        _rDetailLabel = [self jyCreateLabelWithTitle:@"男" font:16 color:kTextBlackColor align:NSTextAlignmentRight] ;
    }
    
    return _rDetailLabel ;
}

-(UIImageView*)rRightImgView {
    
    if (_rRightImgView == nil) {
        _rRightImgView = [[UIImageView alloc]init];
        _rRightImgView.backgroundColor = [UIColor lightGrayColor] ;
    }
    
    return _rRightImgView ;
}

-(UIImageView*)rArrowView {
    
    if (_rArrowView == nil) {
        _rArrowView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"more"] jy_imageWithTintColor:[UIColor blackColor]]] ;
    }
    
    return _rArrowView ;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
