//
//  AddressViewController.h
//  AddressDemo
//

//

 #import "JYFatherController.h"


typedef void(^JYAddressBlock)(NSString *rAddress);


typedef NS_ENUM(NSUInteger, JYAddressType) {
    JYAddressTypeProvince, //省
    JYAddressTypeCity,//市
    JYAddressTypeArea, //区
};

@interface AddressViewController : JYFatherController<UITableViewDelegate,UITableViewDataSource>



@property (nonatomic ,copy) JYAddressBlock rSelectBlock ;
 
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,assign)JYAddressType rDisplayType;
@property(nonatomic,strong)NSArray *provinces;
@property(nonatomic,strong)NSArray *citys;
@property(nonatomic,strong)NSArray *areas;
@property(nonatomic,strong)NSString *selectedProvince;//选中的省
@property(nonatomic,strong)NSString *selectedCity;//选中的市
@property(nonatomic,strong)NSString *selectedArea;//选中的区


- (instancetype)initWithAddressType:(JYAddressType) type ;

@end
