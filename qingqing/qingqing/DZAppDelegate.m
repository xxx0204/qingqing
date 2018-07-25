//
//  DZAppDelegate.m
//  qingqing
//
//  Created by Gavin on 2018/4/25.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZAppDelegate.h"
#import "DZHomeViewController.h"
#import "DZAccountViewController.h"
#import "DZNavigationController.h"
#import "DZLikeMeListModel.h"

//防止崩溃
#import "AvoidCrash.h"
//头像审核提醒显示
#import "DZHeadPortraitsAuditViewController.h"
//匹配成功
#import "DZMatchingSuccessViewController.h"
#import "DZMatchingSuccessView.h"

#import "NSObject+DZLogicProcessing.h"
//融云
#import <RongIMKit/RongIMKit.h>

@interface DZAppDelegate ()<RCIMUserInfoDataSource,RCIMGroupInfoDataSource,RCIMReceiveMessageDelegate>

@end

@implementation DZAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /*******************防止异常崩溃*************************/
    [AvoidCrash makeAllEffective];
    NSArray *noneSelClassStrings = @[
                                     @"NSString"
                                     ];
    [AvoidCrash setupNoneSelClassStringsArr:noneSelClassStrings];
    NSArray *noneSelClassPrefix = @[
                                    @"AvoidCrash"
                                    ];
    [AvoidCrash setupNoneSelClassStringPrefixsArr:noneSelClassPrefix];
    //监听通知:AvoidCrashNotification, 获取AvoidCrash捕获的崩溃日志的详细信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:AvoidCrashNotification object:nil];
    /*******************防止异常崩溃*************************/
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [NSString addFirstStart];
//    });

    [[RCIM sharedRCIM] initWithAppKey:@"mgb7ka1nmwbdg"];
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    [[RCIM sharedRCIM] setGroupInfoDataSource:self];
    [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
    [self push:application];
    self.window.rootViewController = [[DZNavigationController alloc] initWithRootViewController:[[DZHomeViewController alloc] init]];
    if ([NSString isLogin]) {
        [self logout];
    }else{
        [self gotoLogin:NO];
    }
    [self performSelectorInBackground:@selector(multiThread) withObject:nil];
    if ([NSObject isWhetherData]) {
        NSLog(@"不重新创建");
    }else{
        [NSObject createLike];
    }
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self matchingSuccess:1];
////        [self HeadPortraitsFinalDecisionRemind:NO];
//    });
    
    return YES;
}
-(void)push:(UIApplication *)application{
    /**
     * 推送处理1
     */
    if ([application
         respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, 用于iOS8以及iOS8之后的系统
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge |
                                                                  UIUserNotificationTypeSound |
                                                                  UIUserNotificationTypeAlert)
                                                categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        //注册推送，用于iOS8之前的系统
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeAlert |
        UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
}
/**
 * 推送处理2
 */
//注册用户通知设置
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    // register to receive notifications
    [application registerForRemoteNotifications];
}

/**
 * 推送处理3
 */
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *token =[[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"%@",userInfo);
}
- (void)dealwithCrashMessage:(NSNotification *)note {
    NSLog(@"崩溃原因>>%@",note);
    //不论在哪个线程中导致的crash，这里都是在主线程
    
    //注意:所有的信息都在userInfo中
    //你可以在这里收集相应的崩溃信息进行相应的处理(比如传到自己服务器)
    //详细讲解请查看 https://github.com/chenfanfang/AvoidCrash
}
-(void)gotoLogin:(BOOL)isHint{
    typedef void (^Animation)(void);
    UIWindow* window = self.window;
    Animation animation = ^{
        if (![NSString isLogin]) {
            [[RCIM sharedRCIM] logout];
        }
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        DZAccountViewController *dz_a_vc=[DZAccountViewController new];
        dz_a_vc.isHint=isHint;
        DZNavigationController *nag=[[DZNavigationController alloc] initWithRootViewController:dz_a_vc];
//        nag.navigationBarHidden=YES;
        self.window.rootViewController =nag;
        [UIView setAnimationsEnabled:oldState];
    };
    [UIView transitionWithView:window
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
}
-(void)logout{
    typedef void (^Animation)(void);
    UIWindow* window = self.window;
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        self.window.rootViewController = [[DZNavigationController alloc]initWithRootViewController:[DZHomeViewController new]];
        [UIView setAnimationsEnabled:oldState];
    if ([NSString isLogin]) {
        [[RCIM sharedRCIM] connectWithToken:[NSString sessionToken] success:^(NSString *userId) {
            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
            [[RCIM sharedRCIM] currentUserInfo].userId=userId;
            [[RCIM sharedRCIM] currentUserInfo].name=[NSString memberNickName];
            [[RCIM sharedRCIM] currentUserInfo].portraitUri=[NSString memberFace];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"homeType" object:nil userInfo:@{@"type":@"1"}];
            
        } error:^(RCConnectErrorCode status) {
            NSLog(@"登陆的错误码为:%ld", (long)status);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"homeType" object:nil userInfo:@{@"type":@"2"}];
        } tokenIncorrect:^{
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            NSLog(@"token错误");
            [[NSNotificationCenter defaultCenter]postNotificationName:@"homeType" object:nil userInfo:@{@"type":@"3"}];
        }];
    }
};
    [UIView transitionWithView:window
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
}
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
    if ([userId integerValue]==[[NSString memberId] integerValue]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId=[NSString memberId];
        user.name=[NSString memberNickName];
        user.portraitUri=[NSString memberFace];
        return completion(user);
    }else{
        [DZNetwork post_ph:post_likeMeList np:@{@"otherAccountIds":@[[NSString getNullStr:userId]]} class:[DZLikeMeListModel class] success:^(DZLikeMeListModel * data) {
                if (data.resultCode==0&&data.otherAccountList.count!=0) {
                    DZAccountModel *accountM=data.otherAccountList[0];
                    RCUserInfo *user = [[RCUserInfo alloc]init];
                    user.userId=[NSString stringWithFormat:@"%ld",(long)accountM.id];
                    user.name=accountM.nickname;
                    user.portraitUri=accountM.headPicUrl;
                    return completion(user);
                }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}

- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *))completion{
    
}
/**
 *  网络状态变化。
 *
 *  @param status 网络状态。
 */
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
//        UIAlertView *alert = [[UIAlertView alloc]
//                              initWithTitle:@"提示"
//                              message:@"您"
//                              @"的帐号在别的设备上登录，您被迫下线！"
//                              delegate:nil
//                              cancelButtonTitle:@"知道了"
//                              otherButtonTitles:nil, nil];
//        MS_LoginFirstViewController *loginfirst = [[MS_LoginFirstViewController alloc] init];
//        MS_NavigationController *nav = [[MS_NavigationController alloc] initWithRootViewController:loginfirst];
//
//        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//
//        window.rootViewController = nav;
        
//        [alert show];
        
    } else if (status == ConnectionStatus_TOKEN_INCORRECT) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
//            UIAlertView *alertView =
//            [[UIAlertView alloc] initWithTitle:nil
//                                       message:@"已过期，请重新登录"
//                                      delegate:nil
//                             cancelButtonTitle:@"确定"
//                             otherButtonTitles:nil, nil];
            
//            MS_LoginFirstViewController *loginfirst = [[MS_LoginFirstViewController alloc] init];
//            MS_NavigationController *nav = [[MS_NavigationController alloc] initWithRootViewController:loginfirst];
            
//            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//
//            window.rootViewController = nav;
            
//            [alertView show];
        });
    }
}
/*!
 接收消息的回调方法
 
 @param message     当前接收到的消息
 @param left        还剩余的未接收的消息数，left>=0
 
 @discussion 如果您设置了IMKit消息监听之后，SDK在接收到消息时候会执行此方法（无论App处于前台或者后台）。
 其中，left为还剩余的、还未接收的消息数量。比如刚上线一口气收到多条消息时，通过此方法，您可以获取到每条消息，left会依次递减直到0。
 您可以根据left数量来优化您的App体验和性能，比如收到大量消息时等待left为0再刷新UI。
 */

-(void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left{
    if ([message.content isMemberOfClass:[RCTextMessage class]]) {
        RCTextMessage *testMessage = (RCTextMessage *)message.content;
        NSLog(@"消息内容：%@", testMessage.content);
        NSDictionary *dict=[self dictionaryWithJsonString:testMessage.extra];
        NSLog(@"附加消息：%@",dict[@"type"]);
        if ([dict[@"type"] integerValue]==1) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self HeadPortraitsFinalDecisionRemind:YES];
            });
        }else if ([dict[@"type"] integerValue]==2){
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self HeadPortraitsFinalDecisionRemind:NO];
            });
        }else if ([dict[@"type"] integerValue]==3){
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self matchingSuccess:[dict[@"friendAccountId"] integerValue]];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"RefreshFriend" object:nil userInfo:nil];
            });
        }
        //type 1:头像审核通过  2:头像失败   3:匹配成功
        
    }
    NSLog(@"还剩余的未接收的消息数：%d", left);
}
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//开启多线程
-(void)multiThread{
    if (![NSThread isMainThread]) {
        // 第1种方式
        //此种方式创建的timer已经添加至runloop中
        //[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        //保持线程为活动状态，才能保证定时器执行
        //  [[NSRunLoop currentRunLoop] run];//已经将nstimer添加到NSRunloop中了
        //第2种方式
        //此种方式创建的timer没有添加至runloop中
        NSTimer *timer = [NSTimer timerWithTimeInterval:10.0f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        //将定时器添加到runloop中
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
        NSLog(@"多线程结束");
    }
}
- (void)timerAction{
    //定时器也是在子线程中执行的
    if (![NSThread isMainThread]){
        NSLog(@"定时器");
        if ([NSObject isWhetherData]) {
            NSDictionary *dict=[NSObject upReadLike];
            [DZNetwork post_ph:post_upLikeAndUnLike np:@{@"likeAccountIds":dict[@"like"],@"dontLikeAccountIds":dict[@"unLike"]} class:nil success:^(id data) {
                if ([data[@"resultCode"] integerValue]==0) {
                    [NSObject deleteLike];
                }else{
                    [NSObject failureLike];
                }
                NSLog(@"%@",data);
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
                [NSObject failureLike];
            }];
        }
    }
}
/******************/
-(void)HeadPortraitsFinalDecisionRemind:(BOOL)pass{
    DZHeadPortraitsAuditViewController *dz_PFI_VC=[DZHeadPortraitsAuditViewController new];
    dz_PFI_VC.pass=pass;
    dz_PFI_VC.btnBlock = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (!pass) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"like_to_remind_each_other" object:nil userInfo:@{@"type":@(2)}];
            }
        });
    };
    [dz_PFI_VC showPullDownVC];
}
-(void)matchingSuccess:(NSInteger)accountId{
    [DZNetwork post_ph:post_likeMeList np:@{@"otherAccountIds":@[@(accountId)]} class:[DZLikeMeListModel class] success:^(DZLikeMeListModel * data) {
        if (data.resultCode==0&&data.otherAccountList.count!=0) {
            DZAccountModel *accountM=data.otherAccountList[0];
            DZMatchingSuccessViewController *dz_PFI_VC=[DZMatchingSuccessViewController new];
            dz_PFI_VC.nicknameS=accountM.nickname;
            dz_PFI_VC.headPortraitS=accountM.headPicUrl;
            dz_PFI_VC.btnBlock = ^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"like_to_remind_each_other" object:nil userInfo:@{@"type":@(3),@"accountId":@(accountId),@"headPicUrl":[NSString getNullStr:accountM.headPicUrl],@"nickname":[NSString getNullStr:accountM.nickname]}];
                });
            };
            [self.window.rootViewController presentViewController:dz_PFI_VC animated:NO completion:^{
                
            }];
//            [dz_PFI_VC showPullDownVC];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
