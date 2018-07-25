//
//  DZAccountViewController.m
//  qingqing
//
//  Created by Gavin on 2018/4/25.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZAccountViewController.h"
#import "DZSecurityCodeViewController.h"
#import "DZLoginViewController.h"
#import "EasyTextView.h"

@interface DZAccountViewController ()<UITextFieldDelegate>

@end

@implementation DZAccountViewController
{
    //手机号输入框
    UITextField *phoneNum_tf;
    NSString    *_previousTextFieldContent;
    UITextRange *_previousSelection;
    UIButton *_hintBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"手机号";
    
    UILabel *label=[[UILabel alloc] init];
    label.frame=CGRectMake(20, dzNavigationBarH+30, dzScreen_width-40, 22);
    label.textAlignment=NSTextAlignmentCenter;
    label.font=dzFont(16);
    label.textColor=DZColorFromRGB(0xCDCDCD);
    label.text=@"请输入正确的手机号码，并点击继续";
    [self.view addSubview:label];
    
    [self createUI];
    
    UIImage *image=dzImageNamed(@"btn_bg_n");
    UIButton *hintBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    hintBtn.frame=CGRectMake(20, dzNavigationBarH+30+22+50+50+54, dzScreen_width-40, (dzScreen_width-40)*image.size.height/image.size.width);
    hintBtn.enabled=NO;
    [hintBtn setTitle:@"继续" forState:UIControlStateNormal];
    hintBtn.titleLabel.font=dzFont(16);
    [hintBtn setBackgroundImage:image forState:UIControlStateNormal];
    [hintBtn setBackgroundImage:dzImageNamed(@"btn_bg_h") forState:UIControlStateSelected];
    [hintBtn setBackgroundImage:dzImageNamed(@"btn_bg_h") forState:UIControlStateHighlighted];
    [hintBtn addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
    [hintBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:hintBtn];
    _hintBtn=hintBtn;
    
    if (self.isHint) {
        [DZNetwork hintNetwork:@"登录过期，请重新登录"];
    }
}
- (void)createUI{
    //横线
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(16, dzNavigationBarH+30+22+50, dzScreen_width-32, 50)];
//    bgView.backgroundColor = [UIColor grayColor];
    bgView.layer.borderWidth=1;
    bgView.layer.borderColor=DZColorFromRGB(0xFFEDED).CGColor;
    [self.view addSubview:bgView];
    
    //横线
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(50, 14, 0.5, 22)];
    lineView1.backgroundColor =dzRgba(0.85, 0.85, 0.85, 1);
    [bgView addSubview:lineView1];
    
    UILabel *label=[[UILabel alloc] init];
    label.frame=CGRectMake(0, 0.5, 50, bgView.height-1);
    label.text=@"+86";
    label.textColor=DZColorFromRGB(0xCDCDCD);
    label.font=dzFont(16);
    label.textAlignment=NSTextAlignmentCenter;
    [bgView addSubview:label];
    
    //上方的手机号码输入框
    phoneNum_tf = [[UITextField alloc]initWithFrame:CGRectMake(75, 0.5, bgView.width-75, bgView.height-1)];
    phoneNum_tf.delegate = self;
    phoneNum_tf.placeholder = @"请输入手机号";
    phoneNum_tf.font = dzFont(16);
    phoneNum_tf.textColor=DZColorFromRGB(0x888888);
    phoneNum_tf.keyboardType = UIKeyboardTypeNumberPad;
    //实时更新输入框内容
    [phoneNum_tf addTarget:self action:@selector(phoneNum_tfChange:) forControlEvents:UIControlEventEditingChanged];
    [bgView addSubview:phoneNum_tf];
}

#pragma mark - 实时更新输入框
- (void)phoneNum_tfChange:(UITextField *)textField
{
    /**
     *  判断正确的光标位置
     */
    NSUInteger targetCursorPostion = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textField.selectedTextRange.start];
    NSString *phoneNumberWithoutSpaces = [self removeNonDigits:textField.text andPreserveCursorPosition:&targetCursorPostion];
    
    if([phoneNumberWithoutSpaces length]>11)
    {
        /**
         *  避免超过11位的输入
         */
        
        [textField setText:_previousTextFieldContent];
        textField.selectedTextRange = _previousSelection;
        
        return;
    }
    if ([phoneNumberWithoutSpaces length]>=11&&textField.text.length==13){
        [textField resignFirstResponder];
    }
//    if (phoneNum_tf.text.length > 0){
//        if (dzScreen_width < 375){
//            phoneNum_tf.font = [UIFont systemFontOfSize:21];
//        }else{
//            phoneNum_tf.font = [UIFont systemFontOfSize:24];
//        }
//    }else{
//        phoneNum_tf.font = [UIFont systemFontOfSize:19];
//    }
    
    NSString *phoneNumberWithSpaces = [self insertSpacesEveryFourDigitsIntoString:phoneNumberWithoutSpaces andPreserveCursorPosition:&targetCursorPostion];
    
    textField.text = phoneNumberWithSpaces;
    UITextPosition *targetPostion = [textField positionFromPosition:textField.beginningOfDocument offset:targetCursorPostion];
    [textField setSelectedTextRange:[textField textRangeFromPosition:targetPostion toPosition:targetPostion]];
    
    if ([phoneNumberWithoutSpaces length]>=11&&textField.text.length==13){
        NSString *regex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:phoneNumberWithoutSpaces];
        if (isMatch) {
            _hintBtn.enabled=YES;
            _hintBtn.selected=YES;
        } else {
            [EasyTextView showText:@"无效的手机号码,请重新输入..." config:^EasyTextConfig *{
                EasyTextConfig *config = [EasyTextConfig shared];
                config.bgColor = [UIColor lightGrayColor] ;
                config.shadowColor = [UIColor clearColor] ;
                config.animationType = TextAnimationTypeBounce;
                config.statusType = TextStatusTypeBottom ;
                return config ;
            }];
        }
    }else{
        _hintBtn.enabled=NO;
        _hintBtn.selected=NO;
    }
}

/**
 *  除去非数字字符，确定光标正确位置
 *
 *  @param string         当前的string
 *  @param cursorPosition 光标位置
 *
 *  @return 处理过后的string
 */
- (NSString *)removeNonDigits:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition {
    NSUInteger originalCursorPosition =*cursorPosition;
    NSMutableString *digitsOnlyString = [NSMutableString new];
    
    for (NSUInteger i=0; i<string.length; i++) {
        unichar characterToAdd = [string characterAtIndex:i];
        
        if(isdigit(characterToAdd)) {
            NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
            [digitsOnlyString appendString:stringToAdd];
        }
        else {
            if(i<originalCursorPosition) {
                (*cursorPosition)--;
            }
        }
    }
    return digitsOnlyString;
}

/**
 *  将空格插入我们现在的string 中，并确定我们光标的正确位置，防止在空格中
 *
 *  @param string         当前的string
 *  @param cursorPosition 光标位置
 *
 *  @return 处理后有空格的string
 */
- (NSString *)insertSpacesEveryFourDigitsIntoString:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition{
    NSMutableString *stringWithAddedSpaces = [NSMutableString new];
    NSUInteger cursorPositionInSpacelessString = *cursorPosition;
    
    for (NSUInteger i=0; i<string.length; i++) {
        if(i>0)
        {
            if(i==3 || i==7) {
                [stringWithAddedSpaces appendString:@" "];
                
                if(i<cursorPositionInSpacelessString) {
                    (*cursorPosition)++;
                }
            }
        }
        
        unichar characterToAdd = [string characterAtIndex:i];
        NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
        [stringWithAddedSpaces appendString:stringToAdd];
    }
    return stringWithAddedSpaces;
}

#pragma mark - UITextFieldDelegate 判断输入框是否还可以编辑
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    _previousSelection = textField.selectedTextRange;
    _previousTextFieldContent = textField.text;
    
    if(range.location==0) {
        if(string.integerValue >1)
        {
            return NO;
        }
    }
    
    return YES;
}

-(void)BtnClick{    
    NSUInteger targetCursorPostion = [phoneNum_tf offsetFromPosition:phoneNum_tf.beginningOfDocument toPosition:phoneNum_tf.selectedTextRange.start];
    NSString *phoneNumberWithoutSpaces = [self removeNonDigits:phoneNum_tf.text andPreserveCursorPosition:&targetCursorPostion];
    NSLog(@"%@=%@",phoneNum_tf.text,phoneNumberWithoutSpaces);
    
    [DZNetwork post_ph:post_verifyRegister np:@{@"phone":[NSString getNullStr:phoneNumberWithoutSpaces]} class:nil success:^(id data) {
        NSLog(@"%@",data);
        if ([data[@"resultCode"] integerValue]==0) {
            DZLoginViewController *dzL_VC=[DZLoginViewController new];
            dzL_VC.phoneNumS=phoneNumberWithoutSpaces;
            dzL_VC.showNumS=phoneNum_tf.text;
            dzL_VC.countryCodeS=@"86";
            [self.navigationController pushViewController:dzL_VC animated:YES];
        }else if ([data[@"resultCode"] integerValue]==1){
            DZSecurityCodeViewController *dzSC_VC=[DZSecurityCodeViewController new];
            dzSC_VC.phoneNumS=phoneNumberWithoutSpaces;
            dzSC_VC.showNumS=phoneNum_tf.text;
            dzSC_VC.countryCodeS=@"86";
            dzSC_VC.countryType=1;
            [self.navigationController pushViewController:dzSC_VC animated:YES];
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
