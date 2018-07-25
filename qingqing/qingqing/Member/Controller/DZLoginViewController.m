//
//  DZLoginViewController.m
//  qingqing
//
//  Created by Gavin on 2018/4/26.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZLoginViewController.h"
#import "DZSecurityCodeViewController.h"

@interface DZLoginViewController ()<UITextFieldDelegate>

@end

@implementation DZLoginViewController
{
    //密码输入框
    UITextField *password_tf;
 }
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"输入密码";
    for (int i=0; i<2; i++) {
        UILabel *label=[[UILabel alloc] init];
        label.frame=CGRectMake(20, dzNavigationBarH+30+i*25, dzScreen_width-40, 22);
        label.textAlignment=NSTextAlignmentCenter;
        label.font=dzFont(16);
        if (i==0) {
            label.textColor=DZColorFromRGB(0xCDCDCD);
            label.text=@"输入密码，开始qingqing";
        }else{
            label.textColor=DZColorFromRGB(0x888888);
            label.text=[NSString stringWithFormat:@"+%@ %@",self.countryCodeS,self.showNumS];
        }
        [self.view addSubview:label];
    }
    
    [self createUI];
    
    UIImage *image=dzImageNamed(@"btn_bg_h");
    
    UIButton *hintBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    hintBtn.frame=CGRectMake(20, dzNavigationBarH+30+22+50+50+54, dzScreen_width-40, (dzScreen_width-40)*image.size.height/image.size.width);
    [hintBtn setTitle:@"登录" forState:UIControlStateNormal];
    [hintBtn setBackgroundImage:image forState:UIControlStateNormal];
    hintBtn.titleLabel.font=dzFont(16);
    [hintBtn setBackgroundImage:dzImageNamed(@"btn_bg_h") forState:UIControlStateSelected];
    [hintBtn addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
    [hintBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:hintBtn];
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(hintBtn.frame)-120, CGRectGetMaxY(hintBtn.frame)+10, 120, 20)];
    NSString *titleStr;
    titleStr=@"忘记密码?";
    [button setTitleColor:DZColorFromRGB(0xCDCDCD) forState:UIControlStateNormal];
    button.titleLabel.font=dzFont(16);
    [button setTitle:titleStr forState:UIControlStateNormal];
    [button.titleLabel setFont:dzFont(16)];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tag=202;
    [self.view addSubview:button];
    [button.titleLabel sizeToFit];
}
- (void)createUI{
    //横线
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(16, dzNavigationBarH+30+22+50, dzScreen_width-32, 50)];
    //    bgView.backgroundColor = [UIColor grayColor];
    bgView.layer.borderWidth=1;
    bgView.layer.borderColor=DZColorFromRGB(0xFFEDED).CGColor;
    [self.view addSubview:bgView];
    
    //上方的手机号码输入框
    password_tf = [[UITextField alloc]initWithFrame:CGRectMake(10, 0.5, bgView.width-20, bgView.height-1)];
    password_tf.delegate = self;
    password_tf.placeholder = @"请输入密码";
    //密码隐藏
    password_tf.secureTextEntry=YES;
    password_tf.font = dzFont(16);
    password_tf.textColor=DZColorFromRGB(0x888888);
    password_tf.keyboardType = UIKeyboardTypeNumberPad;
    [bgView addSubview:password_tf];
}
-(void)BtnClick{
    [self.view endEditing:YES];
    [DZNetwork post_ph:post_login np:@{@"loginName":[NSString getNullStr:self.phoneNumS],@"password":[NSString getNullStr:password_tf.text]} class:[DZMemberModel class] success:^(DZMemberModel *data) {
        NSLog(@"%@",data);
        if (data.resultCode==0) {
            [NSString saveMember:data];
            DZAppDelegate *appDelegate = (DZAppDelegate *) [[UIApplication sharedApplication] delegate];
            [appDelegate logout];
        }else{
            [DZNetwork hintNetwork:data.desc];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)btnClick:(UIButton *)btn{
    DZSecurityCodeViewController *dzSC_VC=[DZSecurityCodeViewController new];
    dzSC_VC.phoneNumS=self.phoneNumS;
    dzSC_VC.showNumS=self.showNumS;
    dzSC_VC.countryCodeS=self.countryCodeS;
    dzSC_VC.countryType=2;
    [self.navigationController pushViewController:dzSC_VC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
