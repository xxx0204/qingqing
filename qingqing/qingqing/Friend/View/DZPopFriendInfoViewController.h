//
//  DZPopFriendInfoViewController.h
//  qingqing
//
//  Created by Gavin on 2018/5/22.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZFriendListModel.h"

@interface DZPopFriendInfoViewController : UIView

-(instancetype)initWithFrame:(CGRect)frame headImage:(NSString *)headImage isClock:(BOOL)isClock model:(DZGMModel *)model;
@property(nonatomic,copy)NSString *headImage;
@property(nonatomic,assign)BOOL isClock;
@property(nonatomic,strong)DZGMModel *dz_GM_M;
/**
 block 回调
 */
@property (nonatomic,copy)  void(^btnBlock)(void);
/**
 删除控制器
 */
-(void)deleteIscelect;

@end
