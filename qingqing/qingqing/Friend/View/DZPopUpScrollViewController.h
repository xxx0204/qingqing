//
//  DZPopUpScrollViewController.h
//  qingqing
//
//  Created by Gavin on 2018/5/31.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZLikeMeListModel.h"

typedef NS_ENUM(NSUInteger, StyleType) {
    /** 默认样式，按钮水平排列 */
    StyleTypeDefault = 0,
    /** 按钮垂直排列 */
    StyleTypeExpire
};

@interface DZPopUpScrollViewController : UIView

-(instancetype)initWithFrame:(CGRect)frame array:(NSMutableArray *)array styleType:(StyleType)styleType;
/**
 block 回调
 */
@property (nonatomic,copy)  void(^btnBlock)(void);
@property (nonatomic,copy)  void(^deleteBlock)(NSInteger accountId);
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) StyleType styleType;
/**
 删除控制器
 */
-(void)deleteIscelect;

@end
