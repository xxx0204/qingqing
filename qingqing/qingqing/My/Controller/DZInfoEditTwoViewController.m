//
//  DZInfoEditTwoViewController.m
//  qingqing
//
//  Created by Gavin on 2018/6/23.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZInfoEditTwoViewController.h"
#import <TPKeyboardAvoidingScrollView.h>
#import "DZInfoViewController.h"

@interface DZInfoEditTwoViewController ()<UIScrollViewDelegate,UITextViewDelegate>
@property(nonatomic,strong)TPKeyboardAvoidingScrollView *myScrollView;
@property(nonatomic,strong)UITextView *textV;
@property (strong, nonatomic)UILabel *placeHolder;
//@property (weak, nonatomic) IBOutlet UIButton *commitButton;
@property (strong, nonatomic)UILabel *stirngLenghLabel;
@end

@implementation DZInfoEditTwoViewController

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
    
    if (self.type==1) {
        switch (self.row) {
            case 0:{
                self.title=@"添加行业";
            }
                break;
            case 1:{
                self.title=@"添加工作领域";
            }
                break;
            case 2:{
                self.title=@"来自";
            }
                break;
            case 3:{
                self.title=@"经常出没";
            }
                break;
            case 4:{
                self.title=@"个性签名";
            }
                break;
            default:
                break;
        }
    }else if (self.type==2){
        switch (self.row) {
            case 1:{
                self.title=@"添加标签标签";
            }
                break;
            case 2:{
                self.title=@"添加旅行标签";
            }
                break;
            case 3:{
                self.title=@"添加电影标签";
            }
                break;
            case 4:{
                self.title=@"添加音乐标签";
            }
                break;
            case 5:{
                self.title=@"添加运动标签";
            }
                break;
            case 6:{
                self.title=@"添加食物标签";
            }
                break;
            default:
                break;
        }
    }else if (self.type==3){
        self.title=@"意见和反馈";
    }
    [self.view addSubview:self.myScrollView];
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
        if (self.type==1) {
            switch (self.row) {
                case 0:{
                    _placeHolder.text=@"添加行业";
                }
                    break;
                case 1:{
                    _placeHolder.text=@"添加工作领域";
                }
                    break;
                case 2:{
                    _placeHolder.text=@"来自";
                }
                    break;
                case 3:{
                    self.title=@"经常出没";
                    _placeHolder.text=@"经常出没（例如：国贸，北京，三里屯）";
                }
                    break;
                case 4:{
                    _placeHolder.text=@"设置自己的个性签名";
                }
                    break;
                default:{
                    _placeHolder.text=@"请输入内容";
                }
                    break;
            }
        }else if (self.type==2){
            _placeHolder.text=self.title;
        }else if (self.type==3){
            _placeHolder.text=@"有什么想对小情说的么？";
        } else{
            _placeHolder.text=@"请输入内容";
        }
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
-(UITextView *)textV{
    if (!_textV) {
        _textV=[[UITextView alloc] init];
        _textV.frame=CGRectMake(0, 0, dzScreen_width, 150);
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
    if (self.textV.text.length==0) {
        [DZNetwork hintNetwork:@"请输入内容"];
    }else{
    if (self.type==1) {
        [self editorInfo];
    }else if (self.type==2){
        if (self.type2Block) {
            self.type2Block(self.textV.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else if (self.type==3){
        dzWeakSelf(self);
        [DZNetwork post_ph:post_submitFeedback np:@{@"content":self.textV.text} class:nil success:^(id data) {
            if ([data[@"resultCode"] integerValue]==0) {
                [DZNetwork hintNetwork:@"提交成功"];
                [weakself.navigationController popViewControllerAnimated:YES];
            }else{
                [DZNetwork hintNetwork:data[@"desc"]];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    }
}
-(void)editorInfo{
    dzWeakSelf(self);
    NSDictionary *dic=@{};
    NSString *titleS=@"";
    if (self.type==1) {
        switch (self.row) {
            case 0:{
                titleS=@"行业";
                dic=@{@"industry":self.textV.text};
            }
                break;
            case 1:{
                titleS=@"工作领域";
                dic=@{@"profession":self.textV.text};
            }
                break;
            case 2:{
                self.title=@"来自";
                dic=@{@"city":self.textV.text};
            }
                break;
            case 3:{
                titleS=@"经常出没";
                dic=@{@"oftenIn":self.textV.text};
            }
                break;
            case 4:{
                titleS=@"个性签名";
                dic=@{@"signature":self.textV.text};
            }
                break;
            default:
                break;
        }
    [DZNetwork post_ph:post_getEditorInfo np:@{@"account":dic} class:nil success:^(id data) {
        if ([data[@"resultCode"] integerValue]==0) {
            if (weakself.type1Block) {
                weakself.type1Block(titleS, weakself.textV.text);
            }
//            if (weakself.isFirst) {
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[DZInfoViewController class]]) {
                        [weakself.navigationController popToViewController:controller animated:YES];
                    }
                }
//            }else{
//                [weakself.navigationController popViewControllerAnimated:YES];
//            }
        }else{
            [DZNetwork hintNetwork:[NSString getNullStr:data[@"desc"]]];
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
