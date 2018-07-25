//
//  DZPopRegisterRemindViewController.h
//  qingqing
//
//  Created by Gavin on 2018/5/9.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZPopRegisterRemindViewController : UIViewController

@property(nonatomic,strong)UIImage *headImage;
/**
 block 回调
 */
@property (nonatomic,copy)  void(^btnBlock)();

/**
 添加控制器
 */
- (void)showPullDownVC;
/**
 删除控制器
 */
-(void)deleteIscelect;
@end
