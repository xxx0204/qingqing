//
//  DZMatchingSuccessView.h
//  qingqing
//
//  Created by Gavin on 2018/7/7.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZMatchingSuccessView : UIView

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
