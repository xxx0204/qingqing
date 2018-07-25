//
//  DZFAQsTwoViewController.h
//  qingqing
//
//  Created by Gavin on 2018/6/24.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZParentClassViewController.h"

@interface DZFAQsTwoViewController : DZParentClassViewController
@property(nonatomic,assign)NSInteger source;//1、信息也
@property(nonatomic,assign)NSInteger lengthS;//当为0时默认不限制字数
@property(nonatomic,copy)NSString *textS,*questionS;//文字内容
@property(nonatomic,assign)NSInteger questionCodeS;
@property (nonatomic,copy)  void(^FAQsBlock)(NSString *questionS,NSString *answer,NSInteger questionCodeS);
//@property (nonatomic,copy)  void(^type2Block)(NSString *desS);
@end
