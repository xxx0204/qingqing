//
//  DZPrivacyPolicyViewController.h
//  qingqing
//
//  Created by Gavin on 2018/7/5.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZParentClassViewController.h"

@interface DZPrivacyPolicyViewController : DZParentClassViewController
@property(nonatomic,assign)BOOL isShieldAddressBook;
@property (nonatomic,copy)  void(^isAddressBookBlock)(BOOL isAddressBook);
@end
