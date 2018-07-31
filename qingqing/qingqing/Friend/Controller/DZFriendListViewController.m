//
//  DZFriendListViewController.m
//  qingqing
//
//  Created by Gavin on 2018/5/15.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZFriendListViewController.h"
#import "DZFriendListTableViewCell.h"
#import "DZFriendHeadTableViewCell.h"
#import "DZChatViewController.h"
#import "DZRedAndYellowViewController.h"
#import "DZPopFriendInfoViewController.h"
#import <RongIMLib/RongIMLib.h>
#import "DZPopUpScrollViewController.h"
#import "DZFriendHeadNullTableViewCell.h"

@interface DZFriendListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableV;
/** 定时器(这里不用带*，因为dispatch_source_t就是个类，内部已经包含了*) */
@property (nonatomic, strong) dispatch_source_t timer;
@property(nonatomic,strong)NSMutableArray *friendListArray,*chatArray,*headArray;
@property (nonatomic,strong)DZFriendListModel *friendListM;
@end

@implementation DZFriendListViewController

-(void)startTimer{
    // 获得队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 创建一个定时器(dispatch_source_t本质还是个OC对象)
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 设置定时器的各种属性（几时开始任务，每隔多长时间执行一次）
    // GCD的时间参数，一般是纳秒（1秒 == 10的9次方纳秒）
    // 何时开始执行第一个任务
    // dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC) 比当前时间晚3秒
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(10.0 * NSEC_PER_SEC);
    dispatch_source_set_timer(self.timer, start, interval, 0);
    dzWeakSelf(self);
    // 设置回调
    dispatch_source_set_event_handler(self.timer, ^{
        NSLog(@"------------%@", [NSThread currentThread]);
        [weakself.tableV reloadData];
//            // 取消定时器
//            dispatch_cancel(self.timer);
//            self.timer = nil;
    });
    
    // 启动定时器
    dispatch_resume(self.timer);
}
-(void)dealloc{
    // 取消定时器
    dispatch_cancel(self.timer);
    self.timer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RefreshFriend" object:nil];
}
- (void)statusBarChangeNoti:(NSNotification *)notifycation{
    [self getData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self getData];
}
- (void)setupNav {
    UIView *navBarView= [[UIView alloc] init];
    navBarView.frame = CGRectMake(0, 0, dzScreen_width, dzNavigationBarH);
    navBarView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:navBarView];
    
    UILabel *titleL=[[UILabel alloc]init];
    titleL.frame=CGRectMake(60, dzStatusBarH,dzScreen_width-120, 44);
    titleL.text=@"好友";
    titleL.font=dzFont(20);
    titleL.textAlignment=NSTextAlignmentCenter;
    titleL.textColor=dzRgba(1, 0.41, 0.51, 1);
    [navBarView addSubview:titleL];
    
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:dzImageNamed(@"back") forState:UIControlStateNormal];
    rightBtn.frame=CGRectMake(0, dzStatusBarH, 50, 44);
    [rightBtn addTarget:self action:@selector(navBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navBarView addSubview:rightBtn];
}
-(void)navBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self startTimer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarChangeNoti:) name:@"RefreshFriend" object:nil];
    
    [NSString timeStr:nil timeFormat:@"ss"];
//    self.isEject=NO;
    [self setupNav];
    self.title=@"好友";
    [self.view addSubview:self.tableV];
    
    self.chatArray=[[[RCIMClient sharedRCIMClient] getConversationList:@[@(ConversationType_PRIVATE)]] mutableCopy];
    for (RCConversation *conversation in self.chatArray) {
        NSLog(@"未读数：%ld", (long)conversation.unreadMessageCount);
        if ([conversation.objectName isEqualToString:@"RC:TxtMsg"]){//([conversation.objectName isMemberOfClass:[RCTextMessage class]]) {
            RCTextMessage *testMessage = (RCTextMessage *)conversation.lastestMessage;
            NSLog(@"会话类型：%lu，目标会话id：%@，内容：%@",(unsigned long)conversation.conversationType, conversation.targetId,testMessage.content);
        }else if([conversation.objectName isEqualToString:@"RC:ImgMsg"]){ //if ([conversation.objectName isMemberOfClass:[RCImageMessage class]]){
            RCImageMessage *testMessage = (RCImageMessage *)conversation.lastestMessage;
            NSLog(@"会话类型：%lu，目标会话id：%@，内容：%@",(unsigned long)conversation.conversationType, conversation.targetId,testMessage.imageUrl);
        }else if([conversation.objectName isEqualToString:@"RC:VcMsg"]){//if ([conversation.objectName isMemberOfClass:[RCVoiceMessage class]]){
            RCVoiceMessage *testMessage = (RCVoiceMessage *)conversation.lastestMessage;
            NSLog(@"会话类型：%lu，目标会话id：%@，内容：%ld",(unsigned long)conversation.conversationType, conversation.targetId,testMessage.duration);
        }else if ([conversation.objectName isEqualToString:@"RC:LBSMsg"]){//if ([conversation.objectName isMemberOfClass:[RCLocationMessage class]]){
            RCLocationMessage *testMessage = (RCLocationMessage *)conversation.lastestMessage;
            NSLog(@"会话类型：%lu，目标会话id：%@，内容：%@",(unsigned long)conversation.conversationType, conversation.targetId,testMessage.locationName);
        }
    }
}
-(void)getData{
    dzWeakSelf(self);
    self.friendListArray=[[NSMutableArray alloc] init];
    self.headArray=[[NSMutableArray alloc] init];
    [DZNetwork post_ph:post_friendsList np:@{} class:[DZFriendListModel class] success:^(DZFriendListModel *data) {
        NSLog(@"%@",data);
        weakself.friendListM=data;
        if (data.resultCode==0) {
            [self.headArray addObjectsFromArray:data.matchNearExpireList];
            if (data.likeMeList.count>0) {
                [self.headArray addObject:data.likeMeList[0]];
            }
            [self.headArray addObjectsFromArray:data.matchList];
            [self.headArray addObjectsFromArray:data.matchExtensionList];
            [self.headArray addObjectsFromArray:data.matchExpireList];
            [weakself.friendListArray addObjectsFromArray:data.friendList];
            [weakself.tableV reloadData];
        }else{
            [DZNetwork hintNetwork:data.desc];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0,dzNavigationBarH, dzScreen_width, dzScreen_height-dzNavigationBarH)];
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.backgroundColor=[UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.delegate = self;
        _tableV.dataSource = self;
    }
    return _tableV;
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"=>%lu",(unsigned long)self.headArray.count);
//    if (self.headArray.count==0) {
//        return 1;
//    }
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (self.headArray.count==0) {
//        return self.friendListArray.count;
//    }
    if (section==0) {
        return 1;
    }
    return self.friendListArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.headArray.count==0&&indexPath.section==0) {
        return (dzScreen_width-55)/9*2+30;
    }
    if (indexPath.section==0) {
        return 110;
    }
    return 90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView=[[UIView alloc]init];
    bgView.frame=CGRectMake(0, 0, dzScreen_width, 30);
    bgView.backgroundColor=dzRgba(0.98, 0.98, 0.98, 1);
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(15, 0, dzScreen_width-30, bgView.height);
    label.font=dzFont(14);
    label.textColor=DZColorFromRGB(0x979797);
    if (section==0) {
        label.text=@"配对";
    }else{
        label.text=@"聊天";
    }
    [bgView addSubview:label];
    return bgView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.section==0) {
            if (self.headArray.count!=0) {
                DZFriendHeadTableViewCell *cell = [DZFriendHeadTableViewCell cellWithTableView:tableView];
                cell.countI=self.friendListM.likeMeList.count;
                cell.array=self.headArray;
                dzWeakSelf(self);
                cell.headPortraitsBlock = ^(UIButton *btn) {
                    [weakself btnTag:btn.tag];
                };
                return cell;
            }else{
                DZFriendHeadNullTableViewCell *cell = [DZFriendHeadNullTableViewCell cellWithTableView:tableView];
                cell.type=1;
                return cell;
            }
        }else{
            DZFriendListTableViewCell *cell = [DZFriendListTableViewCell cellWithTableView:tableView];
            DZGMModel *mgModel;
            if (indexPath.row+1<=self.friendListArray.count) {
                mgModel=self.friendListArray[indexPath.row];
            }
            for (RCConversation *conversation in self.chatArray) {
                if (mgModel.accountId==[conversation.targetId integerValue]) {
                    cell.rcconVerMode=conversation;
                    break;
                }
                NSLog(@"12345678");
            }
            cell.model=mgModel;
//                    cell.infopL.text=@"对话将在18小时后失效";
//                }else{
//            cell.infopL.text=@"";
//                }
            return cell;
        }
}
-(void)btnTag:(NSInteger)tag{
    DZGMModel *da_GM_M=self.headArray[tag];
    if ([NSString isStatus:da_GM_M.type]) {
        DZPopFriendInfoViewController *dz_PFI_VC=[[DZPopFriendInfoViewController alloc]initWithFrame:CGRectMake(0, 0, dzScreen_width, dzScreen_height) headImage:nil isClock:NO model:da_GM_M];
        dzWeakSelf(self);
        dz_PFI_VC.btnBlock = ^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [NSString changeStatus:da_GM_M.type];
                [weakself skipNextPage:da_GM_M];
            });
        };
        [self.view addSubview:dz_PFI_VC];
    }else{
        [self skipNextPage:da_GM_M];
    }
}
-(void)skipNextPage:(DZGMModel *)da_GM_M{
    if (da_GM_M.type!=2 && da_GM_M.type != 5) {
        DZRedAndYellowViewController *dz_RAY_VC=[DZRedAndYellowViewController new];
        dz_RAY_VC.dz_GM_M=da_GM_M;
        [self.navigationController pushViewController:dz_RAY_VC animated:YES];
    } else if (da_GM_M.type == 5) {
        NSMutableArray *likeArr=[[NSMutableArray alloc] init];
        for (DZGMModel *model in self.friendListM.matchExpireList) {
            [likeArr addObject:@(model.accountId)];
        }
        dzWeakSelf(self);
        [DZNetwork post_ph:post_likeMeList np:@{@"otherAccountIds":likeArr} class:[DZLikeMeListModel class] success:^(DZLikeMeListModel * data) {
            if (data.resultCode==0) {
                DZPopUpScrollViewController *dz_PFI_VC=[[DZPopUpScrollViewController alloc] initWithFrame:CGRectMake(0, 0, dzScreen_width, dzScreen_height) array:[data.otherAccountList mutableCopy] styleType:(StyleTypeExpire)];
                dz_PFI_VC.deleteBlock = ^(NSInteger accountId) {
                    NSLog(@"%ld=%@",(long)accountId,weakself.friendListM.matchExpireList);
                    for (DZGMModel *model in weakself.friendListM.matchExpireList) {
                        if (accountId==model.accountId) {
//                            [weakself.friendListM.matchExpireList removeObject:model];
                            break;
                        }
                    }
                    [weakself getData];
                };
                dz_PFI_VC.btnBlock = ^{
                    [weakself refreshHead];
                    [weakself getData];
                };
                [weakself.view addSubview:dz_PFI_VC];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    } else {
        NSMutableArray *likeArr=[[NSMutableArray alloc] init];
        for (DZGMModel *model in self.friendListM.likeMeList) {
            [likeArr addObject:@(model.accountId)];
        }
        dzWeakSelf(self);
        [DZNetwork post_ph:post_likeMeList np:@{@"otherAccountIds":likeArr} class:[DZLikeMeListModel class] success:^(DZLikeMeListModel * data) {
            if (data.resultCode==0) {
                DZPopUpScrollViewController *dz_PFI_VC=[[DZPopUpScrollViewController alloc] initWithFrame:CGRectMake(0, 0, dzScreen_width, dzScreen_height) array:[data.otherAccountList mutableCopy] styleType:(StyleTypeDefault)];
                dz_PFI_VC.deleteBlock = ^(NSInteger accountId) {
                    NSLog(@"%ld=%@",(long)accountId,weakself.friendListM.likeMeList);
                    for (DZGMModel *model in weakself.friendListM.likeMeList) {
                        if (accountId==model.accountId) {
                            [weakself.friendListM.likeMeList removeObject:model];
                            break;
                        }
                    }
                    [weakself getData];
                };
                dz_PFI_VC.btnBlock = ^{
                    [weakself refreshHead];
                    [weakself getData];
                };
                [weakself.view addSubview:dz_PFI_VC];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.section==1) {
            DZGMModel *dz_GM_M;
            if (indexPath.row+1<=self.friendListArray.count) {
                dz_GM_M=self.friendListArray[indexPath.row];
            }
            DZChatViewController *conversationVC = [[DZChatViewController alloc]init];
            conversationVC.conversationType = ConversationType_PRIVATE;
            conversationVC.targetId = [NSString stringWithFormat:@"%ld",(long)dz_GM_M.accountId];
            conversationVC.title = @"聊  天";
            if (dz_GM_M.relationStatus==2) {
                conversationVC.fromType=1;
            }
            [self.navigationController pushViewController:conversationVC animated:YES];
        }
}
-(void)refreshHead{
    self.headArray=[[NSMutableArray alloc] init];
    [self.headArray addObjectsFromArray:self.friendListM.matchNearExpireList];
    if (self.friendListM.likeMeList.count>0) {
        [self.headArray addObject:self.friendListM.likeMeList[0]];
    }
    [self.headArray addObjectsFromArray:self.friendListM.matchList];
    [self.headArray addObjectsFromArray:self.friendListM.matchExtensionList];
    [self.headArray addObjectsFromArray:self.friendListM.matchExpireList];
    [self.tableV reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
