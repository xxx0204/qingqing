//
//  DZMatchingSuccessViewController.h
//  qingqing
//
//  Created by Gavin on 2018/5/30.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZMatchingSuccessViewController : UIViewController
@property(nonatomic,assign)BOOL pass;
@property(nonatomic,strong)NSString * nicknameS,*headPortraitS;
/**
 block 回调
 */
@property (nonatomic,copy)  void(^btnBlock)(void);
/**
 添加控制器
 */
- (void)showPullDownVC;
/**
 删除控制器
 */
-(void)deleteIscelect;

@end
