//
//  DZRedAndYellowViewController.m
//  qingqing
//
//  Created by Gavin on 2018/5/22.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZRedAndYellowViewController.h"
#import "DZChatViewController.h"

@interface DZRedAndYellowViewController ()

@end

@implementation DZRedAndYellowViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self setupNav];
//    self.navigationController.navigationBar.hidden=NO;
    self.title=self.dz_GM_M.nickname;
    UIView *bgView=[[UIView alloc] init];
    bgView.frame=CGRectMake(15, dzNavigationBarH+20, 70, 70);;
    bgView.layer.cornerRadius=35;
    if (self.dz_GM_M.type==1) {
        bgView.backgroundColor=[UIColor redColor];
    }else if (self.dz_GM_M.type==2){
        bgView.backgroundColor=[UIColor greenColor];
    }else if (self.dz_GM_M.type==3){
        bgView.backgroundColor=[UIColor orangeColor];
    }else if (self.dz_GM_M.type==4){
        bgView.backgroundColor=DZColorFromRGB(0xFFB1CC);
    }else{
        bgView.backgroundColor=[UIColor grayColor];
    }
    
    //        bgView.backgroundColor=DZColorFromRGB(0xFFB1CC);
    [self.view addSubview:bgView];
    
    UIImageView *headImageV=[[UIImageView alloc] init];
    headImageV.frame=CGRectMake(0, 0, bgView.width-6, bgView.height-6);
    headImageV.center=CGPointMake(bgView.width*0.5, bgView.height*0.5);
    headImageV.backgroundColor=[UIColor whiteColor];
    headImageV.layer.cornerRadius= bgView.height*0.5-3;
    headImageV.clipsToBounds=YES;
    headImageV.contentMode=UIViewContentModeScaleAspectFill;
    [headImageV sd_setImageWithURL:[NSURL URLWithString:[NSString picUrlPath:self.dz_GM_M.headPicUrl]] placeholderImage:dzImageNamed(@"default_head")];
    [bgView addSubview:headImageV];
    
    if (self.dz_GM_M.type==1) {
        UIImageView *imageV=[[UIImageView alloc] init];
        imageV.image=dzImageNamed(@"timeRemind");
        imageV.frame=CGRectMake(CGRectGetMaxX(bgView.frame)-25, CGRectGetMaxY(bgView.frame)-25, 25, 25);
        [self.view addSubview:imageV];
        
        UILabel *timeL=[[UILabel alloc] init];
        timeL.frame=CGRectMake(0, 0, imageV.width, imageV.height);
        timeL.text=[NSString getMinutes:self.dz_GM_M.buildTime];
        timeL.font=dzFont(14);
        timeL.textAlignment=NSTextAlignmentCenter;
        timeL.textColor=[UIColor whiteColor];
        [imageV addSubview:timeL];
    }
    
    NSString *str;
    if (self.dz_GM_M.type==1) {
        str=[NSString stringWithFormat:@"%@分钟",[NSString getMinutes:self.dz_GM_M.buildTime]];
    }else{
        str=[NSString stringWithFormat:@"%@小时",[NSString getHour:self.dz_GM_M.buildTime]];
    }
    
    for (int i=0; i<3; i++) {
        UILabel *label=[[UILabel alloc] init];
        if (i==0) {
            label.frame=CGRectMake(CGRectGetMaxX(bgView.frame)+20, bgView.top+3, dzScreen_width-CGRectGetMaxX(bgView.frame)-20-15, 22);
            if ([[NSString memberSex] isEqualToString:@"男"]) {
                label.text=@"女士优先";
            }else{
                label.text=@"马上行动吧";
            }
            label.font=dzFont(16);
            label.textColor=DZColorFromRGB(0x979797);
        }else if (i==1){
            label.frame=CGRectMake(CGRectGetMaxX(bgView.frame)+20, bgView.top+3+22+5, dzScreen_width-CGRectGetMaxX(bgView.frame)-20-15, 100);
            if ([[NSString memberSex] isEqualToString:@"男"]) {
                label.text=[NSString stringWithFormat:@"她必须在%@内开始聊天，否则配对就会失效。",str];
            }else{
                label.text=[NSString stringWithFormat:@"您的配对将在%@后失效，马上开始与ta聊天吧！",str];
            }
            label.numberOfLines=0;
            label.font=dzFont(15);
            label.textColor=DZColorFromRGB(0x979797);
            [label sizeToFit];
            label.frame=CGRectMake(CGRectGetMaxX(bgView.frame)+20, bgView.top+3+22+5, dzScreen_width-CGRectGetMaxX(bgView.frame)-20-15, label.height);
        }else{
            label.frame=CGRectMake(bgView.left, CGRectGetMaxY(bgView.frame)+10, bgView.width, 100);
            label.text=str;
            label.font=dzFont(12);
            label.textAlignment=NSTextAlignmentCenter;
            label.backgroundColor=DZColorFromRGB(0xEBEBEB);
            [label sizeToFit];
            label.frame=CGRectMake(bgView.left+(bgView.width-label.width-5)*0.5, CGRectGetMaxY(bgView.frame)+10, label.width+5, label.height+3);
            label.layer.cornerRadius=label.height*0.5;
            label.clipsToBounds=YES;
        }
        
        [self.view addSubview:label];
    }
    
    if ([[NSString memberSex] isEqualToString:@"男"]) {
        UIImage *image=dzImageNamed(@"btn_bg_h");
        UIButton *hintBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        hintBtn.frame=CGRectMake(20, CGRectGetMaxY(bgView.frame)+150, dzScreen_width-40, (dzScreen_width-40)*image.size.height/image.size.width);
        hintBtn.layer.cornerRadius=image.size.height*0.5;
        [hintBtn setImage:dzImageNamed(@"clock_btn_w") forState:UIControlStateNormal];
        if (self.dz_GM_M.type==4) {//||self.dz_GM_M.type==5
            [hintBtn setBackgroundImage:dzImageNamed(@"btn_bg_n") forState:UIControlStateNormal];
            hintBtn.enabled=NO;
        }else{
            [hintBtn setBackgroundImage:image forState:UIControlStateNormal];
        }
        hintBtn.tag=101;
        [hintBtn setTitle:@"  延长24小时的等待时间" forState:UIControlStateNormal];
        hintBtn.titleLabel.font=dzFont(16);
        [hintBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        hintBtn.clipsToBounds=YES;
        [hintBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:hintBtn];
        if (self.dz_GM_M.type==1||self.dz_GM_M.type==3) {
            UILabel *hintLabel=[[UILabel alloc] init];
            hintLabel.frame=CGRectMake(15, CGRectGetMaxY(hintBtn.frame)+15, dzScreen_width-30, 22);
            hintLabel.text=@"耐心等待她迈出第一步哦";
            hintLabel.font=dzFont(15);
            hintLabel.textColor=DZColorFromRGB(0x979797);
            hintLabel.textAlignment=NSTextAlignmentCenter;
            [self.view addSubview:hintLabel];
        }
    }else{
        for (int i=0; i<2; i++) {//50
            UIButton *hintBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            hintBtn.frame=CGRectMake(15+i*((dzScreen_width-50)*0.5+20), CGRectGetMaxY(bgView.frame)+150, (dzScreen_width-50)*0.5, (dzScreen_width-50)*0.5*6/19);
            hintBtn.layer.cornerRadius=(dzScreen_width-50)*0.5*6/19*0.5;
            hintBtn.titleLabel.font=dzFont(16);
            if (i==0) {
                hintBtn.tag=100;
                if (self.dz_GM_M.type==5) {
                    [hintBtn setBackgroundImage:dzImageNamed(@"btn_bg_w_m") forState:UIControlStateNormal];
                    [hintBtn setBackgroundColor:[UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1.00]];
                    hintBtn.enabled=NO;
                }else{
                    [hintBtn setBackgroundImage:dzImageNamed(@"btn_bg_r") forState:UIControlStateNormal];
                }
                [hintBtn setTitle:@"发起对话" forState:UIControlStateNormal];
                [hintBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }else{
                if (self.dz_GM_M.type==4) {//||self.dz_GM_M.type==5
                    [hintBtn setBackgroundImage:dzImageNamed(@"btn_bg_w_m") forState:UIControlStateNormal];
                    [hintBtn setBackgroundColor:[UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1.00]];
                    hintBtn.enabled=NO;
                }else{
                    [hintBtn setBackgroundImage:dzImageNamed(@"btn_bg_w") forState:UIControlStateNormal];
                }
                hintBtn.tag=101;
                [hintBtn setImage:dzImageNamed(@"clock_btn_r") forState:UIControlStateNormal];
                [hintBtn setTitle:@"  再等24小时" forState:UIControlStateNormal];
                [hintBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
            [hintBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            hintBtn.clipsToBounds=YES;
            [self.view addSubview:hintBtn];
        }
    }
}
-(void)btnClick:(UIButton *)btn{
    if (btn.tag==100) {
        DZChatViewController *conversationVC = [[DZChatViewController alloc]init];
        conversationVC.conversationType = ConversationType_PRIVATE;
        conversationVC.targetId = [NSString stringWithFormat:@"%ld",(long)self.dz_GM_M.accountId];
        conversationVC.fromType=1;
        conversationVC.title = @"聊  天";
        [self.navigationController pushViewController:conversationVC animated:YES];
    }else if (btn.tag==101){
        //延长等待
        dzWeakSelf(self);
        [DZNetwork post_ph:post_applyExtension np:@{@"matchAccountId":@(self.dz_GM_M.accountId)} class:nil success:^(id data) {
            if ([data[@"resultCode"] integerValue]==0) {
                [weakself.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
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
