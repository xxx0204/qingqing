//
//  DZChatViewController.m
//  onebyone
//
//  Created by Gavin on 2018/1/22.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZChatViewController.h"
#import "DZRedAndYellowViewController.h"
#import "DZInfoViewController.h"

@interface DZChatViewController ()

@end

@implementation DZChatViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    for (UIViewController *vc in marr) {
        if ([vc isKindOfClass:[DZRedAndYellowViewController class]]) {
            [marr removeObject:vc];
            break;
        }
    }
    self.navigationController.viewControllers = marr;
    
    self.conversationMessageCollectionView.showsVerticalScrollIndicator = NO;//滚动条隐藏
}
//在需要拦截pop方法的类里面写
#pragma mark- BackButtonHandlerProtocol
-(BOOL)navigationShouldPopOnBackButton{
    NSLog(@"我拦截到了分类方法2");
    //相关逻辑处理
    
    return YES;
}
-(void)didTapCellPortrait:(NSString *)userId{
    NSLog(@"%@",userId);
    if ([userId integerValue]==[NSString accountId]) {
        DZInfoViewController *dz_I_VC=[DZInfoViewController new];
        dz_I_VC.isEdit=YES;
        [self.navigationController pushViewController:dz_I_VC animated:YES];
    }else{
        DZInfoViewController *dz_I_VC=[DZInfoViewController new];
        dz_I_VC.isEdit=NO;
        dz_I_VC.userId=[userId integerValue];
        [self.navigationController pushViewController:dz_I_VC animated:YES];
    }
}
- (void)didSendMessage:(NSInteger)status content:(RCMessageContent *)messageContent{
    if (status==0) {
        if (self.fromType==1) {
            //调接口
            [DZNetwork post_ph:post_firstMessage np:@{@"friendAccountId":[NSString getNullStr:self.targetId]} class:nil success:^(id data) {
                NSLog(@"%@",data);
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
        }
    }
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
