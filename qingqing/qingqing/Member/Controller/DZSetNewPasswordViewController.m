//
//  DZSetNewPasswordViewController.m
//  qingqing
//
//  Created by Gavin on 2018/7/6.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZSetNewPasswordViewController.h"

@interface DZSetNewPasswordViewController ()<UITextFieldDelegate>

@end

@implementation DZSetNewPasswordViewController{
    UIButton *_hintBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"设置新密码";
    
    [self createUI];
    
    UIImage *image=dzImageNamed(@"btn_bg_h");
    
    UIButton *hintBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    hintBtn.frame=CGRectMake(20, dzNavigationBarH+55+50+80+54, dzScreen_width-40, (dzScreen_width-40)*image.size.height/image.size.width);
    [hintBtn setTitle:@"完成" forState:UIControlStateNormal];
    [hintBtn setBackgroundImage:image forState:UIControlStateNormal];
    hintBtn.titleLabel.font=dzFont(16);
    [hintBtn setBackgroundImage:dzImageNamed(@"btn_bg_h") forState:UIControlStateSelected];
    [hintBtn setBackgroundImage:dzImageNamed(@"btn_bg_h") forState:UIControlStateHighlighted];
    [hintBtn addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
    [hintBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:hintBtn];
    hintBtn.enabled=NO;
    hintBtn.selected=NO;
    _hintBtn=hintBtn;
    
}
- (void)createUI{
    for (int i=0; i<2; i++) {
        //横线
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(16, dzNavigationBarH+55+i*80, dzScreen_width-32, 50)];
        //    bgView.backgroundColor = [UIColor grayColor];
        bgView.layer.borderWidth=1;
        bgView.layer.borderColor=DZColorFromRGB(0xFFEDED).CGColor;
        [self.view addSubview:bgView];
        
        //上方的手机号码输入框
        UITextField *password_tf = [[UITextField alloc]initWithFrame:CGRectMake(10, 0.5, bgView.width-20, bgView.height-1)];
        password_tf.delegate = self;
        password_tf.tag=1000+i;
        if (i==0) {
            password_tf.placeholder = @"输入旧密码";
        }else{
            password_tf.placeholder = @"设置新密码（6个字符以上）";
        }
        password_tf.keyboardType = UIKeyboardTypeASCIICapable;
        password_tf.textAlignment=NSTextAlignmentCenter;
        //密码隐藏
        password_tf.secureTextEntry=YES;
        password_tf.font = dzFont(16);
        password_tf.textColor=DZColorFromRGB(0xE5E5E5);
        [password_tf addTarget:self action:@selector(phoneNum_tfChange:) forControlEvents:UIControlEventEditingChanged];
        [bgView addSubview:password_tf];
    }
}
#pragma mark - 实时更新输入框
- (void)phoneNum_tfChange:(UITextField *)textField{
    UITextField *tf1=[self.view viewWithTag:1000];
    UITextField *tf2=[self.view viewWithTag:1001];
    if (tf1.text.length==0) {
        _hintBtn.enabled=NO;
        _hintBtn.selected=NO;
        return;
    }
    if (tf2.text.length<6) {
        _hintBtn.enabled=NO;
        _hintBtn.selected=NO;
        return;
    }
    if (tf1.text.length!=0 && tf2.text.length>20) {
        tf2.text = [tf2.text substringToIndex:20];
        [EasyTextView showText:@"密码长度为6—20个字符" config:^EasyTextConfig *{
            EasyTextConfig *config = [EasyTextConfig shared];
            config.bgColor = [UIColor lightGrayColor];
            config.shadowColor = [UIColor clearColor];
            config.animationType = TextAnimationTypeFade;
            config.statusType = TextStatusTypeBottom;
            return config;
        }];
    }
    _hintBtn.enabled=YES;
    _hintBtn.selected=YES;
}
-(void)BtnClick{
    [self.view endEditing:YES];//verifyType  2  用旧密码  verifyPara 旧密码
    UITextField *tf1=[self.view viewWithTag:1000];
    UITextField *tf2=[self.view viewWithTag:1001];
    dzWeakSelf(self);
    [DZNetwork post_ph:post_setPassword np:@{@"verifyType":@(2),@"loginname":[NSString memberAccount],@"newPassword":tf2.text,@"verifyPara":tf1.text} class:nil success:^(id data) {
        NSLog(@"%@",data);
        if ([data[@"resultCode"] integerValue]==0) {
            [DZNetwork hintNetwork:@"新密码设置成功"];
            [weakself.navigationController popViewControllerAnimated:YES];
        }else{
            [DZNetwork hintNetwork:data[@"desc"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
