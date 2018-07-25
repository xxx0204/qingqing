//
//  DZChatViewController.h
//  onebyone
//
//  Created by Gavin on 2018/1/22.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>
#import "UIViewController+BackButtonHandler.h"

@interface DZChatViewController : RCConversationViewController
//1、首次发送界面时触发；
@property(nonatomic,assign)NSInteger fromType;
@end
