//
//  DZAppDelegate.h
//  qingqing
//
//  Created by Gavin on 2018/4/25.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZAppDelegate : UIResponder <UIApplicationDelegate>
/*!
 IMKit消息接收的监听器
 
 @warning 如果您使用IMKit，可以设置并实现此Delegate监听消息接收；
 如果您使用IMLib，请使用RCIMClient中的RCIMClientReceiveMessageDelegate监听消息接收，而不要使用此方法。
 */
@property (strong, nonatomic) UIWindow *window;
-(void)gotoLogin:(BOOL)isHint;
-(void)logout;
@end

