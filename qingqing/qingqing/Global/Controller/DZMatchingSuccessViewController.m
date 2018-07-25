//
//  DZMatchingSuccessViewController.m
//  qingqing
//
//  Created by Gavin on 2018/5/30.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZMatchingSuccessViewController.h"
#import "DZLikeMeListModel.h"

@interface DZMatchingSuccessViewController ()<CAAnimationDelegate>
@property(nonatomic,strong)UIImageView *leftImage,*rightImage;
@end

@implementation DZMatchingSuccessViewController

- (void)showPullDownVC{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
//    [window.rootViewController addChildViewController:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    UIView *bgView=[[UIView alloc]init];
    bgView.frame=CGRectMake(0, 0, dzScreen_width, dzScreen_height);
    bgView.backgroundColor=dzRgba(0, 0, 0, 0.7);
    [self.view addSubview:bgView];
    [self initV];
}

-(void)initV{
    UILabel *label=[[UILabel alloc]init];
    label.numberOfLines=0;
    label.font=dzFont(48);
    label.textAlignment=NSTextAlignmentCenter;
    label.frame=CGRectMake(0,70, dzScreen_width, 60);
    label.text=@"Congratulations!";
    label.textColor=[UIColor colorWithRed:0.85 green:0.77 blue:0.79 alpha:1.00];
    [self.view addSubview:label];
    
    for (int i=0; i<2; i++) {
        UIImageView *imageView=[[UIImageView alloc] init];
        
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds=YES;
        imageView.layer.borderWidth=5;
        imageView.layer.cornerRadius=75;
        imageView.backgroundColor=[UIColor whiteColor];
        imageView.layer.borderColor=[UIColor whiteColor].CGColor;
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        if (i==0) {
            imageView.frame=CGRectMake(0, label.bottom+10, 150, 150);
            [UIView animateWithDuration:1 animations:^{
                imageView.frame=CGRectMake(dzScreen_width*0.5-140, 130, 150, 150);
                //            imageView.frame=CGRectMake((dzScreen_width-240-10)*0.5+i*110, 130, 120, 120);
//                imageView.frame=CGRectMake(dzScreen_width*0.5-140, 130, 150, 150);
            } completion:^(BOOL finished) {
//                imageView.frame=CGRectMake(dzScreen_width*0.5-140, 130, 150, 150);
                [UIView animateWithDuration:0.25 animations:^{
                    imageView.frame=CGRectMake(dzScreen_width*0.5-140-5, 130, 150, 150);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.25 animations:^{
                        imageView.frame=CGRectMake(dzScreen_width*0.5-140, 130, 150, 150);
                    } completion:^(BOOL finished) {

                    }];
                }];
            }];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString picUrlPath:[NSString memberFace]]] placeholderImage:dzImageNamed(@"default_head")];
            self.leftImage=imageView;
        }else{
            imageView.frame=CGRectMake(dzScreen_width, 130, 150, 150);
            [UIView animateWithDuration:1 animations:^{
                imageView.frame=CGRectMake(dzScreen_width*0.5-10, 130, 150, 150);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.25 animations:^{
                    imageView.frame=CGRectMake(dzScreen_width*0.5-5, 130, 150, 150);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.25 animations:^{
                        imageView.frame=CGRectMake(dzScreen_width*0.5-10, 130, 150, 150);
                    } completion:^(BOOL finished) {
                        
                    }];
                }];
            }];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString picUrlPath:self.headPortraitS]] placeholderImage:dzImageNamed(@"default_head")];
            self.rightImage=imageView;
        }
        [self.view addSubview:imageView];
    }

    UILabel *hintLabel=[[UILabel alloc]init];
    hintLabel.numberOfLines=0;
    hintLabel.font=dzFont(20);
    hintLabel.textAlignment=NSTextAlignmentCenter;
    hintLabel.frame=CGRectMake(20,self.rightImage.bottom+30, dzScreen_width-40, 30);
    hintLabel.text=[NSString stringWithFormat:@"你和%@互相喜欢了对方",[NSString getNullStr:self.nicknameS]];
    hintLabel.textColor=[UIColor whiteColor];
    [self.view addSubview:hintLabel];
    
    for (int i=0; i<2; i++) {
        UIImage *image=dzImageNamed(@"btn_bg_h");
        UIButton *hintBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        hintBtn.frame=CGRectMake(20,CGRectGetMaxY(hintLabel.frame)+50+i*(image.size.height+20),dzScreen_width-40, (dzScreen_width-40)*image.size.height/image.size.width);
        hintBtn.tag=100+i;
        hintBtn.titleLabel.font=dzFont(16);
        if (i==0) {
            [hintBtn setTitle:@"开始聊天" forState:UIControlStateNormal];
            [hintBtn setBackgroundImage:image forState:UIControlStateNormal];
            [hintBtn setBackgroundImage:image forState:UIControlStateSelected];
            [hintBtn setBackgroundImage:image forState:UIControlStateHighlighted];
        }else{
            [hintBtn setTitle:@"继续情情" forState:UIControlStateNormal];
            [hintBtn setBackgroundImage:dzImageNamed(@"btn_bg_red_border") forState:UIControlStateNormal];
            [hintBtn setBackgroundImage:dzImageNamed(@"btn_bg_red_border") forState:UIControlStateSelected];
            [hintBtn setBackgroundImage:dzImageNamed(@"btn_bg_red_border") forState:UIControlStateHighlighted];
        }
        
        [hintBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [hintBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:hintBtn];
    }
}
-(void)btnClick:(UIButton *)btn{
    [self deleteIscelect];
    if (btn.tag==100) {
        if (self.btnBlock) {
            self.btnBlock();
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)deleteIscelect{
    [UIView animateWithDuration:0.25 animations:^{
        
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
            
        }];
//        [self.view removeFromSuperview];
//        [self removeFromParentViewController];
    }];
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
