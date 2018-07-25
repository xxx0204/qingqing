//
//  DZFAQsViewController.h
//  qingqing
//
//  Created by Gavin on 2018/6/24.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZParentClassViewController.h"

@interface DZFAQsViewController : DZParentClassViewController
@property(nonatomic,strong)NSMutableArray *currentArray;
@property (nonatomic,copy)  void(^FAQsBlock)(NSString *questionS,NSString *answer,NSInteger questionCodeS);
@end
