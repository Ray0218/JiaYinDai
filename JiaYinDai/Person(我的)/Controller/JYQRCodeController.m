//
//  JYQRCodeController.m
//  JiaYinDai
//
//  Created by 孔亮 on 2017/6/2.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYQRCodeController.h"

@interface JYQRCodeController ()

@property (nonatomic ,strong) UIView *rBackView ;


@property (nonatomic ,strong) UIImageView *rHeaderView ;

@property (nonatomic ,strong) UILabel *rNameLabel ;

@property (nonatomic ,strong) UILabel *rAddressLabel ;

@property (nonatomic ,strong) UILabel *rBottomLabel ;

@property (nonatomic ,strong) UIImageView *rSexImg ;

@property (nonatomic ,strong) UIImageView *rCodeView ;

@end

@implementation JYQRCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的二维码" ;
    
    self.view.backgroundColor = UIColorFromRGB(0x6499d0) ;
    [self buildSubViewsUI] ;
    
}


-(void)buildSubViewsUI {
    
    
    JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
    
    UIImage *img = [self createQRForString:[NSString stringWithFormat:@"%@/registeract/%@",kServiceURL, [user.cellphone jy_Base64String]] withSize:SCREEN_WIDTH - 120] ;
    self.rCodeView.image = img ;
    
    
    self.rNameLabel.text =  user.realName ;
    
    
    self.rAddressLabel.text =  user.address ;
    
    if (user.address.length) {
        
        NSArray *addressArr = [user.address componentsSeparatedByString:@" "] ;
        
        self.rAddressLabel.text =  [addressArr firstObject] ;
        
        if (addressArr.count >= 2) {
            self.rAddressLabel.text = [NSString stringWithFormat:@"%@ %@",addressArr[0],addressArr[1]] ;
        }
        
        
    }
    
    
    
    if ([user.sex isEqualToString:@"1"]) { //男
        self.rSexImg.image = [UIImage imageNamed:@"sex_default"] ;
        
    }else if ([user.sex isEqualToString:@"2"]){
        
        self.rSexImg.image = [UIImage imageNamed:@"sex_female"] ;
        
    }else{
        self.rSexImg.image = [UIImage imageNamed:@"sex_human"] ;
        
    }
    
    
    
    [self.view addSubview:self.rBackView];
    [self.view addSubview:self.rHeaderView];
    [self.view addSubview:self.rNameLabel];
    [self.view addSubview:self.rSexImg];
    [self.view addSubview:self.rAddressLabel];
    [self.view addSubview:self.rCodeView];
    [self.view addSubview:self.rBottomLabel];
    
    [self.rBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(27.5) ;
        
        make.right.equalTo(self.view).offset(-27.5) ;
        
        make.centerY.equalTo(self.view).offset(-46) ;
    }] ;
    
    [self.rHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(64) ;
        make.left.top.equalTo(self.rBackView).offset(20) ;
    }] ;
    
    
    [self.rNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rHeaderView.mas_right).offset(11) ;
        
        make.top.equalTo(self.rBackView).offset(30) ;
    }] ;
    
    [self.rSexImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.rNameLabel) ;
        make.left.equalTo(self.rNameLabel.mas_right).offset(10) ;
        make.width.height.mas_equalTo(16) ;
    }] ;
    
    
    [self.rAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rNameLabel) ;
        make.top.equalTo(self.rNameLabel.mas_bottom).offset(15) ;
    }] ;
    
    
    [self.rCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(SCREEN_WIDTH - 120) ;
        make.centerX.equalTo(self.rBackView) ;
        make.top.equalTo(self.rHeaderView.mas_bottom).offset(23) ;
    }] ;
    
    [self.rBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view) ;
        make.top.equalTo(self.rCodeView.mas_bottom).offset(20) ;
        make.height.mas_equalTo(15) ;
        make.bottom.equalTo(self.rBackView).offset(-15) ;
    }] ;
    
    
}

#pragma mark - InterpolatedUIImage
- (UIImage *)createQRForString:(NSString *)qrString withSize:(CGFloat) size {
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // Create the filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    CGRect extent = CGRectIntegral(qrFilter.outputImage.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // create a bitmap image that we'll draw into a bitmap context at the desired size;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:qrFilter.outputImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // Create an image with the contents of our bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    // Cleanup
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    
    CGColorSpaceRelease(cs) ;
    
    UIImage *resultImg =  [UIImage imageWithCGImage:scaledImage];
    
    CGImageRelease(scaledImage) ;
    
    return  [resultImg copy];
    
    
}

/*
 
 void ProviderReleaseData (void *info, const void *data, size_t size){
 free((void*)data);
 }
 - (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
 const int imageWidth = image.size.width;
 const int imageHeight = image.size.height;
 size_t      bytesPerRow = imageWidth * 4;
 uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
 // create context
 CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
 CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
 CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
 // traverse pixe
 int pixelNum = imageWidth * imageHeight;
 uint32_t* pCurPtr = rgbImageBuf;
 for (int i = 0; i < pixelNum; i++, pCurPtr++){
 if ((*pCurPtr & 0xFFFFFF00) < 0x99999900){
 // change color
 uint8_t* ptr = (uint8_t*)pCurPtr;
 ptr[3] = red; //0~255
 ptr[2] = green;
 ptr[1] = blue;
 }else{
 uint8_t* ptr = (uint8_t*)pCurPtr;
 ptr[0] = 0;
 }
 }
 // context to image
 CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
 CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
 kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
 NULL, true, kCGRenderingIntentDefault);
 CGDataProviderRelease(dataProvider);
 UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
 // release
 CGImageRelease(imageRef);
 CGContextRelease(context);
 CGColorSpaceRelease(colorSpace);
 return resultUIImage;
 }
 */


#pragma  mark- getter

-(UIView*)rBackView {
    if (_rBackView == nil) {
        _rBackView = [[UIView alloc]init];
        _rBackView.backgroundColor = [UIColor whiteColor] ;
        _rBackView.layer.cornerRadius = 5 ;
    }
    
    return _rBackView ;
}

-(UIImageView*)rHeaderView {
    
    if (_rHeaderView == nil) {
        _rHeaderView = [[UIImageView alloc]init];
        
        
        JYUserModel *user = [JYSingtonCenter shareCenter].rUserModel ;
        
        [_rHeaderView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",user.headImage]] placeholderImage:[UIImage imageNamed:@"per_header"] ] ;
        _rHeaderView.layer.cornerRadius = 4 ;
        _rHeaderView.layer.borderColor = kLineColor.CGColor ;
        _rHeaderView.layer.borderWidth = 0.5 ;
    }
    
    return _rHeaderView ;
    
}

-(UILabel*)rNameLabel {
    if (_rNameLabel == nil) {
        _rNameLabel = [self jyCreateLabelWithTitle:@"mly" font:19 color:kBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rNameLabel ;
    
}

-(UILabel*)rAddressLabel {
    if (_rAddressLabel == nil) {
        _rAddressLabel = [self jyCreateLabelWithTitle:@"浙江 杭州" font:12 color:kTextBlackColor align:NSTextAlignmentLeft] ;
    }
    
    return _rAddressLabel ;
}

-(UILabel*)rBottomLabel {
    
    if (_rBottomLabel == nil) {
        _rBottomLabel = [self jyCreateLabelWithTitle:@"扫描上面的二维码，完成好友邀请" font:12 color:kTextBlackColor align:NSTextAlignmentCenter] ;
    }
    
    return _rBottomLabel ;
}


-(UIImageView*)rCodeView {
    
    if (_rCodeView == nil) {
        _rCodeView = [[UIImageView alloc]init];
        
        _rCodeView.backgroundColor = [UIColor clearColor] ;
    }
    
    return _rCodeView ;
}

-(UIImageView*)rSexImg {
    
    if (_rSexImg == nil) {
        _rSexImg = [[UIImageView alloc]init];
        _rSexImg.contentMode = UIViewContentModeCenter ;
    }
    
    return _rSexImg ;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
