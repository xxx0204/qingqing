//
//  DZInfoEditTwoViewController.h
//  qingqing
//
//  Created by Gavin on 2018/6/23.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZParentClassViewController.h"

@interface DZInfoEditTwoViewController : DZParentClassViewController
@property(nonatomic,assign)NSInteger type;//1：编辑个人资料;2：添加标签//3：意见和反馈
@property(nonatomic,assign)BOOL isFirst;//是否直接回到上上层，YES 是的
@property(nonatomic,copy)NSString *titleS;//当 type = 2 时有效
@property(nonatomic,assign)NSInteger lengthS;//当为0时默认不限制字数
@property(nonatomic,copy)NSString *textS;//文字内容
@property(nonatomic,assign)NSInteger row;//第几行
@property (nonatomic,copy)  void(^type1Block)(NSString *titleS,NSString *desS);
@property (nonatomic,copy)  void(^type2Block)(NSString *desS);
@end
