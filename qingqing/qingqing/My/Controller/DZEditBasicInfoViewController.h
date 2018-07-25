//
//  DZEditBasicInfoViewController.h
//  qingqing
//
//  Created by Gavin on 2018/6/24.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZParentClassViewController.h"

@interface DZEditBasicInfoViewController : DZParentClassViewController
@property(nonatomic,copy)NSString *nicknameS,*birthdayS,*sexS;
@property (nonatomic,copy)  void(^editBasicInfoBlock)(NSString *nicknameS,NSString *birthdayS,NSString *sexS);
@end
