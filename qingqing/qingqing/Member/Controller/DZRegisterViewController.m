//
//  DZRegisterViewController.m
//  qingqing
//
//  Created by Gavin on 2018/5/2.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZRegisterViewController.h"
#import "GEBirthdaySelectViewController.h"
#import "DZSetHeadPortraitsViewController.h"

@interface DZRegisterViewController ()<UITextFieldDelegate>

@end

@implementation DZRegisterViewController
{
    UIButton *_hintBtn;
    UIButton *_manBtn,*_wuManBtn;
    NSInteger _sexS;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"个人资料";
    [self createUI];
    
    UIImage *image=dzImageNamed(@"btn_bg_h");
    
    UIButton *hintBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    hintBtn.frame=CGRectMake(20, dzNavigationBarH+15+2*60+50+2+50+89, dzScreen_width-40, (dzScreen_width-40)*image.size.height/image.size.width);
    [hintBtn setTitle:@"完成" forState:UIControlStateNormal];
    [hintBtn setBackgroundImage:image forState:UIControlStateNormal];
    [hintBtn setBackgroundImage:dzImageNamed(@"btn_bg_h") forState:UIControlStateSelected];
    [hintBtn setBackgroundImage:dzImageNamed(@"btn_bg_h") forState:UIControlStateHighlighted];
    [hintBtn addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
    [hintBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:hintBtn];
    hintBtn.enabled=NO;
    hintBtn.selected=NO;
    _hintBtn=hintBtn;
}
-(void)createUI{
    for (int i=0; i<3; i++) {
        //横线
        UIView *bgView = [[UIView alloc]init];
        bgView.frame=CGRectMake(16, dzNavigationBarH+15+i*60, dzScreen_width-32, 50);
        //    bgView.backgroundColor = [UIColor grayColor];
        bgView.layer.borderWidth=1;
        bgView.layer.borderColor=DZColorFromRGB(0xFFEDED).CGColor;
        [self.view addSubview:bgView];
        
        UILabel *label=[[UILabel alloc] init];
        label.frame=CGRectMake(0, 0.5, 50, bgView.height-1);
        label.textColor=DZColorFromRGB(0xCDCDCD);
        label.font=dzFont(16);
        label.textAlignment=NSTextAlignmentCenter;
        [bgView addSubview:label];
        
        //上方的手机号码输入框
        UITextField *phoneNum_tf = [[UITextField alloc]init];
        phoneNum_tf.frame=CGRectMake(60, 0.5+0.5, bgView.width-60, bgView.height-1);
        phoneNum_tf.delegate = self;
        phoneNum_tf.tag=1001+i;
        phoneNum_tf.font = dzFont(16);
        phoneNum_tf.textColor=DZColorFromRGB(0x888888);
        [phoneNum_tf addTarget:self action:@selector(phoneNum_tfChange:) forControlEvents:UIControlEventEditingChanged];
        
//        phoneNum_tf.keyboardType = UIKeyboardTypeNumberPad;
        //实时更新输入框内容
//        [phoneNum_tf addTarget:self action:@selector(phoneNum_tfChange:) forControlEvents:UIControlEventEditingChanged];
        [bgView addSubview:phoneNum_tf];
        if (i==0) {
            label.text=@"昵称";
            phoneNum_tf.placeholder = @"请输入昵称";
        }else if (i==1){
            label.text=@"生日";
            phoneNum_tf.placeholder = @"请选择生日";
            phoneNum_tf.enabled=NO;
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=phoneNum_tf.frame;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:btn];
            btn.userInteractionEnabled=YES;
        }else{
            label.hidden=YES;
            bgView.frame=CGRectMake(16, dzNavigationBarH+15+i*60+50+2, dzScreen_width-32, 50);
            phoneNum_tf.placeholder = @"设置密码（6个字符以上）";
            phoneNum_tf.keyboardType = UIKeyboardTypeASCIICapable;
            //密码隐藏
            phoneNum_tf.secureTextEntry=YES;
            phoneNum_tf.frame=CGRectMake(10, 0.5+0.5, bgView.width-20, bgView.height-1);
        }
    }
    
    for (int i=0; i<2; i++) {
        UILabel *label=[[UILabel alloc] init];
        if (i==0) {
            label.text=@"男";
        }else{
            label.text=@"女";
        }
        label.frame=CGRectMake(28+i*(dzScreen_width*0.5-16), dzNavigationBarH+15+60+50+18, 16, 22);
        label.textColor=DZColorFromRGB(0xCDCDCD);
        label.font=dzFont(16);
        label.textAlignment=NSTextAlignmentCenter;
        [self.view addSubview:label];
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(CGRectGetMaxX(label.frame)+47, label.top, 22, 22);
        
        btn.tag=i;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        if (i==0) {
            [btn setImage:dzImageNamed(@"man") forState:UIControlStateNormal];
            [btn setImage:dzImageNamed(@"man_high") forState:UIControlStateSelected];
            _manBtn=btn;
        }else{
            [btn setImage:dzImageNamed(@"woman") forState:UIControlStateNormal];
            [btn setImage:dzImageNamed(@"woman_high") forState:UIControlStateSelected];
            _wuManBtn=btn;
        }
    }
}

#pragma mark - 实时更新输入框
- (void)phoneNum_tfChange:(UITextField *)textField{
    [self btnUI];
}
-(void)BtnClick{
    [self.view endEditing:YES];
    UITextField *textF=(UITextField *)[self.view viewWithTag:1001];
    UITextField *textF1=(UITextField *)[self.view viewWithTag:1002];
    UITextField *textF2=(UITextField *)[self.view viewWithTag:1003];
    
    DZSetHeadPortraitsViewController *dz_SHP_VC=[DZSetHeadPortraitsViewController new];
    dz_SHP_VC.phoneNumS=self.phoneNumS;
    dz_SHP_VC.passwordS=textF2.text;
    dz_SHP_VC.nicknameS=textF.text;
    dz_SHP_VC.birthDateS=textF1.text;
    dz_SHP_VC.sexS=_sexS;
    dz_SHP_VC.mobileCodeS=self.mobileCodeS;
    [self.navigationController pushViewController:dz_SHP_VC animated:YES];
}
-(void)btnUI{
    UITextField *textF=(UITextField *)[self.view viewWithTag:1001];
    UITextField *textF1=(UITextField *)[self.view viewWithTag:1002];
    UITextField *textF2=(UITextField *)[self.view viewWithTag:1003];
    if (textF.text.length>0&&textF1.text.length>0&&textF2.text.length>=6&&_sexS!=0) {
        _hintBtn.enabled=YES;
        _hintBtn.selected=YES;
    }else{
        _hintBtn.enabled=NO;
        _hintBtn.selected=NO;
    }
}
-(void)click:(UIButton *)btn{
    if (btn.tag==0) {
        _manBtn.selected=YES;
        _wuManBtn.selected=NO;
        _sexS=1;
    }else{
        _manBtn.selected=NO;
        _wuManBtn.selected=YES;
        _sexS=2;
    }
    [self btnUI];
}
-(void)btnClick:(UIButton *)btn{
   
    dzWeakSelf(self);
    GEBirthdaySelectViewController *geBSVC=[GEBirthdaySelectViewController new];
    geBSVC.selectBlock = ^(BOOL isSelect, NSString *valueStr) {
        if (isSelect) {
            //调接口
            UITextField *textF1=(UITextField *)[self.view viewWithTag:1002];
            textF1.text=[NSString getNullStr:valueStr];
            [weakself btnUI];
        }
    };
    [geBSVC showPullDownVC];
    
    [self.view endEditing:YES];
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
