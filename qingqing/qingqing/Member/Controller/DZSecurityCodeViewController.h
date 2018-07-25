//
//  DZSecurityCodeViewController.h
//  qingqing
//
//  Created by Gavin on 2018/4/25.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZMemberViewController.h"

@interface DZSecurityCodeViewController : DZMemberViewController
@property(nonatomic,assign)NSInteger countryType;
@property(nonatomic,strong)NSString *phoneNumS,*showNumS,*countryCodeS;
@end
