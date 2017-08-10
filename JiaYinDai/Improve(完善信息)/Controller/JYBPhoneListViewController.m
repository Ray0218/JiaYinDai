//
//  JYBPhoneListViewController.m
//  JiaYinDai
//
//  Created by 陈侠 on 2017/5/8.
//  Copyright © 2017年 嘉远控股. All rights reserved.
//

#import "JYBPhoneListViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
@interface JYBPhoneListViewController ()<ABPeoplePickerNavigationControllerDelegate,UINavigationControllerDelegate>

@end

@implementation JYBPhoneListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通讯录";
    [self visitAddressBook];
    // Do any additional setup after loading the view.
}





- (void)visitAddressBook
{//授权
    __weak typeof(self)weakSelf = self;
    ABAddressBookRef bookref = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    /*kABAuthorizationStatusNotDetermined = 0,    // 未进行授权选择
     kABAuthorizationStatusRestricted,           // 未授权，且用户无法更新，如家长控制情况下
     kABAuthorizationStatusDenied,               // 用户拒绝App使用
     kABAuthorizationStatusAuthorized            // 已授权，可使用*/
    if (status == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(bookref, ^(bool granted, CFErrorRef error) {
            if (error) {
                NSLog(@"授权错误");
            }
            if (granted) {
                NSLog(@"授权chengg");
                ABPeoplePickerNavigationController *peosonVC = [[ABPeoplePickerNavigationController alloc] init];
                peosonVC.peoplePickerDelegate = weakSelf;
                peosonVC.displayedProperties = @[[NSNumber numberWithInt:kABPersonPhoneProperty]];
                [weakSelf presentViewController:peosonVC animated:YES completion:nil];
            }
        });
    }
    if (status == kABAuthorizationStatusAuthorized) {
        ABPeoplePickerNavigationController *peosonVC = [[ABPeoplePickerNavigationController alloc] init];
        peosonVC.peoplePickerDelegate = weakSelf;
        peosonVC.displayedProperties = @[[NSNumber numberWithInt:kABPersonPhoneProperty]];
        [weakSelf presentViewController:peosonVC animated:YES completion:nil];
    }else
    {
        
        @"您未开启通讯录权限,请前往设置中心开启";
    }
    
}
#pragma mark iOS7通讯录代理方法
//取消选择 7上必须有,否则崩lzc,切记
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    return YES;
}
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    // 获取该联系人多重属性--电话号
    ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    // 获取该联系人的名字，简单属性，只需ABRecordCopyValue取一次值
    ABMutableMultiValueRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString *firstname = (__bridge NSString *)(firstName);
    ABMutableMultiValueRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
    NSString *lastname = (__bridge NSString *)(lastName);
    // 获取点击的联系人的电话
    NSLog(@"联系人名字 ： %@%@",lastname,firstname);
    
    // 点击某个联系人电话后dismiss联系人控制器，并回调点击的数据
    [self dismissViewControllerAnimated:YES completion:^{
        // 从多重属性——电话号中取值，参数2是取点击的索引
        NSString *aPhone =  (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phoneMulti, ABMultiValueGetIndexForIdentifier(phoneMulti,identifier)) ;
        // 获取点击的联系人的电话，也可以取标签等
        NSLog(@"联系人电话 ： %@",aPhone);
        // 去掉电话号中的 "-"
        aPhone = [aPhone stringByReplacingOccurrencesOfString:@"-" withString:@"" ];
        NSLog(@"去掉-号 ： %@",aPhone);
        
    }];
    
    return NO;//如果不返回NO,会有别的效果,希望你动动手,我就不告诉你--LZC
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
