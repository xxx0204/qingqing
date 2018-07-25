//
//  DZHomeViewController.m
//  qingqing
//
//  Created by Gavin on 2018/4/25.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZHomeViewController.h"
#import "DZHomeListViewController.h"
#import "DZMyViewController.h"
#import "DZFriendListViewController.h"
#import "DZRedAndYellowViewController.h"
#import "DZSetHeadPortraitsViewController.h"
#import "DZNavigationController.h"


@interface DZHomeViewController ()

@end

@implementation DZHomeViewController

- (void)correlationLike:(NSNotification *)notifycation{
    
    DZGMModel *model=[[DZGMModel alloc] init];
    if ([notifycation.userInfo[@"type"] integerValue]==2) {
        DZSetHeadPortraitsViewController *dz_SHP_VC=[DZSetHeadPortraitsViewController new];
        dz_SHP_VC.frameTypeI=1;
        [self.navigationController pushViewController:dz_SHP_VC animated:YES];
    }else if ([notifycation.userInfo[@"type"] integerValue]==3){
        model.accountId=[notifycation.userInfo[@"accountId"] integerValue];
        model.headPicUrl=notifycation.userInfo[@"headPicUrl"];
        model.nickname=notifycation.userInfo[@"nickname"];
        model.type=3;
        NSDate *senddate = [NSDate date];
        model.buildTime=[senddate timeIntervalSince1970]*1000;
        
        DZRedAndYellowViewController *dz_ray_vc=[[DZRedAndYellowViewController alloc] init];
        dz_ray_vc.dz_GM_M=model;
        [self.navigationController pushViewController:dz_ray_vc animated:YES];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title=@"情情";
    UIImageView *titleImageView=[[UIImageView alloc] init];
    titleImageView.frame=CGRectMake(0, 0, 45, 11.5);
    titleImageView.image=dzImageNamed(@"home_title");
    self.navigationItem.titleView=titleImageView;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(correlationLike:) name:@"like_to_remind_each_other" object:nil];

    DZHomeListViewController *conversationVC = [[DZHomeListViewController alloc]init];
    [self addChildViewController:conversationVC];
    [self.view addSubview:conversationVC.view];
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        // 处理耗时操作的代码块...
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //回调或者说是通知主线程刷新，
//        });
//        
//    });
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -15;
    
    UIButton *leftBtn = [[UIButton alloc] init];
    // 设置按钮的背景图片
    [leftBtn setImage:dzImageNamed(@"home_left") forState:UIControlStateNormal];
    [leftBtn setImage:dzImageNamed(@"home_left") forState:UIControlStateHighlighted];
    // 设置按钮的尺寸为背景图片的尺寸
    leftBtn.frame = CGRectMake(0, 0, 50, 44);
    //监听按钮的点击
    [leftBtn addTarget:self action:@selector(getIntoMy) forControlEvents:UIControlEventTouchUpInside];
    //设置导航栏的按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    //    self.navigationItem.rightBarButtonItem = backButton;
//    self.navigationItem.leftBarButtonItem=leftButton;
    self.navigationItem.leftBarButtonItems=@[negativeSpacer,leftButton];
    
    UIButton *rightBtn = [[UIButton alloc] init];
    // 设置按钮的背景图片
    [rightBtn setImage:dzImageNamed(@"home_right") forState:UIControlStateNormal];
    [rightBtn setImage:dzImageNamed(@"home_right") forState:UIControlStateHighlighted];
    // 设置按钮的尺寸为背景图片的尺寸
    rightBtn.frame = CGRectMake(0, 0, 50, 44);

    //监听按钮的点击
    [rightBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //设置导航栏的按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    //    self.navigationItem.rightBarButtonItem = backButton;
    self.navigationItem.rightBarButtonItems=@[negativeSpacer,rightButton];
}
-(void)getIntoMy{
    [self.navigationController pushViewController:[DZMyViewController new] animated:YES];
}
-(void)moreBtnClick{
    [self.navigationController pushViewController:[DZFriendListViewController new] animated:YES];
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
