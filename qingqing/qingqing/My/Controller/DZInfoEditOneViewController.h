//
//  DZInfoEditOneViewController.h
//  qingqing
//
//  Created by Gavin on 2018/6/23.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZParentClassViewController.h"

@interface DZInfoEditOneViewController : DZParentClassViewController
@property(nonatomic,assign)NSInteger type;//1：编辑个人资料；2：标签；
@property(nonatomic,assign)NSInteger row;//第几行
@property(nonatomic,strong)NSMutableArray *selectedArray;
@property (nonatomic,copy)  void(^type1Block)(NSString *titleS,NSString *desS);
@property (nonatomic,copy)  void(^type2Block)(NSInteger row,NSString *desS);
@end
