//
//  JYInviteRecordCell.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/6/5.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYInviteRecordCell.h"


@interface JYInviteRecordCell ()


@property (nonatomic ,strong) UIView *rBackView ;

@property (nonatomic ,strong) UILabel *rTitleLabel ;

@property (nonatomic ,strong) NSMutableArray *rRowsArray ;


@property (nonatomic ,strong) NSMutableArray *rLinesArray ;



@end

@implementation JYInviteRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(instancetype)initWithRowNum:(NSInteger)rowNum reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] ;
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        self.backgroundColor =
        self.contentView.backgroundColor = [UIColor clearColor] ;
        
        
        self.rRowsArray = [NSMutableArray array] ;
        self.rLinesArray = [NSMutableArray array] ;
        [self buildSubViewsUIWithNum:rowNum];
        
    }
    
    return self ;
    
}

-(void)buildSubViewsUIWithNum:(NSInteger) rowNum {
    
    [self.contentView addSubview:self.rBackView];
    [self.contentView addSubview:self.rTitleLabel];
    
    
    for (int i = 0; i< rowNum; i++) {
        
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:3] ;
        
        for (int j = 0; j< 3; j++) {
            UILabel *lab = [self jyCreateLabelWithTitle:@"已交易" font:14 color:kTextBlackColor align:NSTextAlignmentCenter] ;
            
            if (j == 0) {
                lab.textAlignment = NSTextAlignmentLeft ;
            }else if (j == 2){
                lab.textAlignment = NSTextAlignmentRight ;
            }
            
            [self.contentView addSubview:lab];
            [arr addObject:lab];
        }
        
        [self.rRowsArray  addObject:arr];
        
        
        UIView *lines = [[UIView alloc]init] ;
        lines.backgroundColor  = kLineColor ;
        [self.contentView addSubview:lines];
        
        [self.rLinesArray addObject:lines];
        
        
        
    }
    
    
    [self.rBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15) ;
        make.top.equalTo(self.contentView).offset(10) ;
        make.right.equalTo(self.contentView).offset(-15) ;
        
        make.bottom.equalTo(self.contentView) ;
    }] ;
    
    
    
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rBackView).offset(18) ;
        make.top.equalTo(self.rBackView) ;
        make.height.mas_equalTo(30) ;
    }] ;
    
    if (rowNum) {
        
        
        UIView *firstLine = self.rLinesArray[0] ;
        
        if (rowNum == 1) {
            [firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.rBackView) ;
                make.top.equalTo(self.rTitleLabel.mas_bottom) ;
                make.height.mas_equalTo(0.5) ;
                make.bottom.equalTo(self.contentView).offset(-30) ;
            }] ;
            
        }else{
            
            [firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.rBackView) ;
                make.top.equalTo(self.rTitleLabel.mas_bottom) ;
                make.height.mas_equalTo(0.5) ;
            }] ;
            
        }
        
        
        
        UIView *rLastLine = firstLine ;
        
        for (int i = 0; i < rowNum; i++) {
            
            NSMutableArray *rLabels = self.rRowsArray[i] ;
            
            [rLabels mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:5 leadSpacing:19+15 tailSpacing:19+15] ;
            
            [rLabels mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(rLastLine.mas_bottom) ;
                make.height.mas_equalTo(30) ;
            }] ;
            
            
            
            
            if (i < rowNum-1) {
                
                UIView *lineView= self.rLinesArray[i+1] ;
                
                
                if (i == rowNum - 2) {
                    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.rBackView).offset(22.5) ;
                        make.right.equalTo(self.rBackView).offset(-22.5) ;
                        make.height.mas_equalTo(0.5) ;
                        make.top.equalTo(rLastLine.mas_bottom).offset(30) ;
                        make.bottom.equalTo(self.rBackView).offset(-30) ;
                    }] ;
                }else{
                    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.rBackView).offset(22.5) ;
                        make.right.equalTo(self.rBackView).offset(-22.5) ;
                        make.height.mas_equalTo(0.5) ;
                        make.top.equalTo(rLastLine.mas_bottom).offset(30) ;
                    }] ;
                    
                }
                rLastLine = lineView ;
                
            }
            
            
            
        }
        
        
        
    }
    
    
    
    
}

#pragma mark- setter

-(void)pvt_LoadDataDicArray:(NSArray*) dicArr dicKey:(NSString*)keyStr {
    
    
    self.rTitleLabel.text = [NSString stringWithFormat:@"%@日",keyStr] ;
    
    
     
    for (int i = 0; i < self.rRowsArray.count; i ++ ) {
        
        NSMutableArray *labs = self.rRowsArray[i] ;
        
        
        UILabel *firstLab = labs[0] ;
        UILabel *secondLab = labs[1] ;
        
        UILabel *thirdLab = labs[2] ;
        
        
        NSDictionary *dic  = dicArr[i] ;
        
        firstLab.text = TTTimeHMOnlyString([NSString stringWithFormat:@"%@",dic[@"registerTime"] ]);
        
        NSString *telStr = dic[@"cellphone"] ;
        secondLab.text = @"" ;
        
        if (telStr.length > 7) {
            secondLab.text = [telStr stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"] ;
        }
        
        
        
        NSString *statuStr = [NSString stringWithFormat:@"%@",dic[@"auditStatus"]] ;

        NSString *firstTradeTime = [NSString stringWithFormat:@"%@", dic[@"firstTradeTime"] ];
        
        if ([[dic allKeys] containsObject:@"firstTradeTime"] && firstTradeTime.length) {
            thirdLab.text =  @"已交易";
        }else if([statuStr isEqualToString:@"0"]){
        
            thirdLab.text = @"未认证" ;
        }else{
            thirdLab.text = @"已认证" ;
        }
        
         
    }
    
    
    
    
}



#pragma mark- getter

-(UIView*)rBackView {
    
    if (_rBackView == nil) {
        _rBackView = [[UIView alloc]init];
        _rBackView.backgroundColor = [UIColor whiteColor] ;
        _rBackView.layer.cornerRadius = 5 ;
        _rBackView.layer.borderWidth = 0.5 ;
        _rBackView.layer.borderColor = kLineColor.CGColor ;
    }
    
    return _rBackView ;
}


-(UILabel*)rTitleLabel {
    
    if (_rTitleLabel == nil) {
        _rTitleLabel = [self jyCreateLabelWithTitle:@"" font:21 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rTitleLabel ;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
