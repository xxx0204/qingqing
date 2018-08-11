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
{
    UIView *firstLuanchView;
}
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

- (void)isFirstLuanch {
    BOOL isStartedApp = [[NSUserDefaults standardUserDefaults] boolForKey:@"isStartedApp"];
    if (!isStartedApp) {//没有启动过
        NSLog(@"没有启动过");
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isStartedApp"];
        firstLuanchView = [[UIView alloc] init];
        firstLuanchView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
        [[UIApplication sharedApplication].keyWindow addSubview:firstLuanchView];
        [firstLuanchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo([UIApplication sharedApplication].keyWindow);
        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"特别功能";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:20.0f];
        titleLabel.textColor = [UIColor whiteColor];
        [firstLuanchView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(firstLuanchView.centerX);
            make.top.equalTo(firstLuanchView.mas_top).offset(127);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(100);
        }];

        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.text = @"屏蔽联系人：你的手机通讯录的联系人\n将不会看到你，你也看不到他们哦。";
        contentLabel.textColor = [UIColor whiteColor];
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.font = [UIFont systemFontOfSize:18.0f];
        contentLabel.numberOfLines = 0;
        [firstLuanchView addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(14);
            make.centerX.mas_equalTo(titleLabel.centerX);
            make.left.equalTo(firstLuanchView.mas_left).offset(0);
            make.right.equalTo(firstLuanchView.mas_right).offset(0);
            make.height.mas_greaterThanOrEqualTo(50);
        }];
        
        UIImageView *contractImgV = [[UIImageView alloc] init];
        contractImgV.image = dzImageNamed(@"contract");
        [firstLuanchView addSubview:contractImgV];
        [contractImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentLabel.mas_bottom).offset(64);
            make.centerX.mas_equalTo(contentLabel.centerX);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(106);
        }];
        
        UIView *openContractView = [[UIView alloc] init];
        openContractView.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0.0f];
        [firstLuanchView addSubview:openContractView];
        [openContractView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contractImgV.mas_bottom).offset(98);
            make.centerX.mas_equalTo(contractImgV.centerX);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(150);
        }];
        
        UILabel *openContractLabel = [[UILabel alloc] init];
        openContractLabel.text = @"开启屏蔽联系人";
        openContractLabel.textColor = [UIColor whiteColor];
        [openContractView addSubview:openContractLabel];
        [openContractLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.and.bottom.equalTo(openContractView);
            make.width.mas_equalTo(125);
        }];
        
        UIButton *openContractBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [openContractBtn setBackgroundImage:dzImageNamed(@"rect") forState:(UIControlStateNormal)];
        [openContractBtn setBackgroundImage:dzImageNamed(@"rect") forState:(UIControlStateHighlighted)];
        [openContractBtn setImage:nil forState:(UIControlStateNormal)];
        [openContractBtn setImage:dzImageNamed(@"select") forState:(UIControlStateSelected)];
        openContractBtn.selected = YES;
        [openContractBtn addTarget:self action:@selector(openContractBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [openContractView addSubview:openContractBtn];
        [openContractBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(openContractView.mas_right).offset(-3);
            make.width.mas_equalTo(16);
            make.height.mas_equalTo(16);
            make.centerY.mas_equalTo(openContractLabel.centerY);
        }];
        
        UIButton *startAppBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [startAppBtn setTitle:@"开始情情" forState:UIControlStateNormal];
        [startAppBtn setBackgroundImage:dzImageNamed(@"btn_bg_h") forState:UIControlStateNormal];
        startAppBtn.titleLabel.font=dzFont(16);
        [startAppBtn setBackgroundImage:dzImageNamed(@"btn_bg_h") forState:UIControlStateSelected];
        [startAppBtn setBackgroundImage:dzImageNamed(@"btn_bg_h") forState:UIControlStateHighlighted];
        [startAppBtn addTarget:self action:@selector(startBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [startAppBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [firstLuanchView addSubview:startAppBtn];
        [startAppBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(openContractView.mas_bottom).offset(30);
            make.height.mas_equalTo(60);
            make.left.equalTo(firstLuanchView.mas_left).offset(27);
            make.right.equalTo(firstLuanchView.mas_right).offset(-27);
        }];
    }
}

- (void)openContractBtnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
}

- (void)startBtnClick:(UIButton *)btn {
    [btn.superview removeFromSuperview];
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
    
    [self isFirstLuanch];
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
