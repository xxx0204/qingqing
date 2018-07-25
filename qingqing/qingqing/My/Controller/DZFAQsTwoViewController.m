//
//  DZFAQsTwoViewController.m
//  qingqing
//
//  Created by Gavin on 2018/6/24.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZFAQsTwoViewController.h"
#import "DZInfoViewController.h"
#import <TPKeyboardAvoidingScrollView.h>

@interface DZFAQsTwoViewController ()<UIScrollViewDelegate,UITextViewDelegate>
@property(nonatomic,strong)TPKeyboardAvoidingScrollView *myScrollView;
@property(nonatomic,strong)UITextView *textV;
@property (strong, nonatomic)UILabel *placeHolder,*titleL;
//@property (weak, nonatomic) IBOutlet UIButton *commitButton;
@property (strong, nonatomic)UILabel *stirngLenghLabel;

@end

@implementation DZFAQsTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -20;
    
    UIButton *rightBtn = [[UIButton alloc] init];
    rightBtn.tag=1;
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:DZColorFromRGB(0x979797) forState:UIControlStateNormal];
    // 设置按钮的尺寸为背景图片的尺寸
    rightBtn.frame = CGRectMake(0, 0, 50, 44);
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    //    self.navigationItem.rightBarButtonItem = backButton;
    self.navigationItem.rightBarButtonItems=@[negativeSpacer,rightButton];
    self.title=@"编辑答案";
    
    [self.view addSubview:self.myScrollView];
    [self.myScrollView addSubview:self.titleL];
    [self.myScrollView addSubview:self.textV];
    [self.textV addSubview:self.placeHolder];
    [self.textV addSubview:self.stirngLenghLabel];
}
-(TPKeyboardAvoidingScrollView *)myScrollView{
    if (!_myScrollView) {
        _myScrollView = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:
                         CGRectMake(0, 0, dzScreen_width, dzScreen_height-dzNavigationBarH)];
        _myScrollView.accessibilityActivationPoint = CGPointMake(100, 100);
        _myScrollView.minimumZoomScale = 0.5;
        _myScrollView.maximumZoomScale = 3;
        _myScrollView.contentSize = CGSizeMake(dzScreen_width,
                                               dzScreen_height-dzNavigationBarH);
        _myScrollView.delegate = self;
    }
    return _myScrollView;
}
-(UILabel *)placeHolder{
    if (!_placeHolder) {
        _placeHolder=[[UILabel alloc]init];
        _placeHolder.frame=CGRectMake(5,5,dzScreen_width, 20);
        _placeHolder.text=@"请输入内容";
        _placeHolder.font=dzFont(15);
        _placeHolder.textColor=DZColorFromRGB(0x979797);
        _placeHolder.userInteractionEnabled = NO;
        if (self.textV.text.length!=0) {
            _placeHolder.hidden=YES;
        }
    }
    return _placeHolder;
}
-(UILabel *)stirngLenghLabel{
    if (!_stirngLenghLabel) {
        _stirngLenghLabel=[[UILabel alloc]init];
        _stirngLenghLabel.frame=CGRectMake(self.textV.width-60,self.textV.height-25,60, 20);
        _stirngLenghLabel.text=[NSString stringWithFormat:@"0/%ld",(long)self.lengthS];
        _stirngLenghLabel.font=dzFont(13);
        _stirngLenghLabel.userInteractionEnabled = NO;
        if (self.lengthS==0) {
            _stirngLenghLabel.hidden=YES;
        }
    }
    return _stirngLenghLabel;
}
-(UILabel *)titleL{
    if (!_titleL) {
        _titleL=[[UILabel alloc]init];
        _titleL.frame=CGRectMake(15,0,dzScreen_width-30, 30);
        _titleL.text=[NSString getNullStr:self.questionS];
        _titleL.font=dzFont(13);
        _titleL.userInteractionEnabled = NO;
    }
    return _titleL;
}
-(UITextView *)textV{
    if (!_textV) {
        _textV=[[UITextView alloc] init];
        _textV.frame=CGRectMake(15,30, dzScreen_width-30, 150);
        _textV.backgroundColor=[UIColor whiteColor];
        _textV.delegate=self;
        _textV.font=dzFont(15);
        _textV.text=self.textS;
    }
    return _textV;
}
//正在改变
- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"%@", textView.text);
    
    self.placeHolder.hidden = YES;
    //允许提交按钮点击操作
    //    self.commitButton.backgroundColor = FDMainColor;
    //    self.commitButton.userInteractionEnabled = YES;
    //实时显示字数
    if (self.lengthS!=0) {
        self.stirngLenghLabel.text = [NSString stringWithFormat:@"%lu/%ld", (unsigned long)textView.text.length,(long)self.lengthS];
        //字数限制操作
        if (textView.text.length >=self.lengthS) {
            textView.text = [textView.text substringToIndex:self.lengthS];
            self.stirngLenghLabel.text =[NSString stringWithFormat:@"%ld/%ld",(long)self.lengthS,(long)self.lengthS];// @"100/100";
        }
    }
    
    //取消按钮点击权限，并显示提示文字
    if (textView.text.length == 0) {
        self.placeHolder.hidden = NO;
        //        self.commitButton.userInteractionEnabled = NO;
        //        self.commitButton.backgroundColor = [UIColor lightGrayColor];
    }
}
-(void)moreBtnClick{
    if (self.source==1) {
        [self editorInfo];
    }else{
    if (self.textV.text.length==0) {
        [DZNetwork hintNetwork:@"请输入内容"];
    }else{
        [self editorInfo];
    }
    }
}
-(void)editorInfo{
    dzWeakSelf(self);
    [DZNetwork post_ph:post_saveFAQs np:@{@"questionCode":@(self.questionCodeS),@"question":[NSString getNullStr:self.questionS],@"answer":self.textV.text} class:nil success:^(id data) {
            if ([data[@"resultCode"] integerValue]==0) {
                if (weakself.FAQsBlock) {
                    weakself.FAQsBlock(weakself.questionS, weakself.textV.text, weakself.questionCodeS);
                }
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[DZInfoViewController class]]) {
                        [weakself.navigationController popToViewController:controller animated:YES];
                    }
                }
            }else{
                [DZNetwork hintNetwork:[NSString getNullStr:data[@"desc"]]];
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
