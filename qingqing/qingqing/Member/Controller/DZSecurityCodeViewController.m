//
//  DZSecurityCodeViewController.m
//  qingqing
//
//  Created by Gavin on 2018/4/25.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZSecurityCodeViewController.h"
#import "DZCodeView.h"
#import "JKCountDownButton.h"
#import "DZSetPasswordViewController.h"
#import "DZRegisterViewController.h"

@interface DZSecurityCodeViewController ()
@property(nonatomic,strong)JKCountDownButton *countDownCode;
@property(nonatomic,strong)DZCodeView *codeV;
@end

@implementation DZSecurityCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"短信验证";
    for (int i=0; i<2; i++) {
        UILabel *label=[[UILabel alloc] init];
        label.frame=CGRectMake(20, dzNavigationBarH+30+i*25, dzScreen_width-40, 22);
        label.textAlignment=NSTextAlignmentCenter;
        label.font=dzFont(16);
        if (i==0) {
            label.textColor=DZColorFromRGB(0xCDCDCD);
            label.text=@"验证码已通过短信发送至";
        }else{
            label.textColor=DZColorFromRGB(0x888888);
            label.text=[NSString stringWithFormat:@"+%@ %@",self.countryCodeS,self.showNumS];
        }
        [self.view addSubview:label];
    }
    dzWeakSelf(self);
    DZCodeView *codeV = [[DZCodeView alloc] initWithFrame:CGRectMake((dzScreen_width-316)*0.5, dzNavigationBarH+55+50, 316, 90)];
    codeV.finishBlock = ^(NSString *codeS) {
        NSLog(@"%@",codeS);
        [weakself checkVerifyCode:codeS];
    };
    [self.view addSubview:codeV];
    [codeV beginEdit];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, codeV.width, codeV.height);
    [btn addTarget:self action:@selector(btnCilck) forControlEvents:UIControlEventTouchUpInside];
    [codeV addSubview:btn];
    self.codeV=codeV;
    
    JKCountDownButton *countDownCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
    countDownCode.frame = CGRectMake((dzScreen_width-120)*0.5,codeV.bottom+50,120, 50);
    [countDownCode setTitle:@"重新发送" forState:UIControlStateNormal];
    [countDownCode setTitleColor:dzRgba(1, 0.41, 0.51, 1) forState:UIControlStateNormal];
    countDownCode.titleLabel.font=dzFont(16);
    [self.view addSubview:countDownCode];
    self.countDownCode=countDownCode;
    [countDownCode countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
        [weakself sendVerifyCode];
        [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            countDownButton.enabled = YES;
            [countDownButton setTitleColor:dzRgba(1, 0.41, 0.51, 1) forState:UIControlStateNormal];
            return @"重新发送";
        }];
    }];
    
    [self sendVerifyCode];
}
-(void)btnCilck{
    [self.codeV beginEdit];
}
-(void)checkVerifyCode:(NSString *)codeS{
    dzWeakSelf(self);
    [self.view endEditing:YES];
    [DZNetwork post_ph:post_checkVerifyCode np:@{@"phone":[NSString getNullStr:self.phoneNumS],@"codeType":@(self.countryType),@"verifyCode":[NSString getNullStr:codeS]} class:nil success:^(id data) {
        NSLog(@"%@",data);
        if ([data[@"resultCode"] integerValue]==0) {
            if (weakself.countryType==1) {
                DZRegisterViewController*dzR_VC=[DZRegisterViewController new];
                dzR_VC.phoneNumS=weakself.phoneNumS;
                dzR_VC.showNumS=weakself.showNumS;
                dzR_VC.countryCodeS=weakself.countryCodeS;
                dzR_VC.mobileCodeS=codeS;
                [self.navigationController pushViewController:dzR_VC animated:YES];
            }
            if (weakself.countryType==2) {
                DZSetPasswordViewController *dzSp_VC=[DZSetPasswordViewController new];
                dzSp_VC.phoneNumS=weakself.phoneNumS;
                dzSp_VC.showNumS=weakself.showNumS;
                dzSp_VC.countryCodeS=weakself.countryCodeS;
                dzSp_VC.mobileCodeS=codeS;
                [weakself.navigationController pushViewController:dzSp_VC animated:YES];
            }
        }else{
            [DZNetwork hintNetwork:data[@"desc"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)sendVerifyCode{
    dzWeakSelf(self);
    [DZNetwork post_ph:post_sendVerifyCode np:@{@"phone":[NSString getNullStr:self.phoneNumS],@"codeType":@(self.countryType)} class:nil success:^(id data) {
        NSLog(@"%@",data);
        if ([data[@"resultCode"] integerValue]==0) {
            [DZNetwork temporaryHintNetwork:[NSString stringWithFormat:@"验证码：%@",data[@"desc"]]];
            weakself.countDownCode.enabled = NO;
            [weakself.countDownCode setTitleColor:dzRgba(0.83, 0.83, 0.83, 1) forState:UIControlStateNormal];
            [weakself.countDownCode startCountDownWithSecond:60];
            weakself.countDownCode.titleLabel.adjustsFontSizeToFitWidth = YES;
            [weakself.countDownCode countDownChanging:^NSString *(JKCountDownButton *countButton,NSUInteger second) {
                NSString *title = [NSString stringWithFormat:@"重新发送（%zds）",second];
                return title;
            }];
        }else{
            [DZNetwork hintNetwork:data[@"desc"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
