//
//  DZPopRegisterRemindViewController.m
//  qingqing
//
//  Created by Gavin on 2018/5/9.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZPopRegisterRemindViewController.h"

@interface DZPopRegisterRemindViewController ()

@end

@implementation DZPopRegisterRemindViewController

- (void)showPullDownVC{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window.rootViewController addChildViewController:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=dzRgba(0, 0, 0, 0.6);
    [self initV];
}
-(void)initV{
    UIView *bgView=[[UIView alloc]init];
    bgView.frame=CGRectMake(0, 0, dzScreen_width*2/3, dzScreen_width*2/3);
    bgView.layer.cornerRadius=20;
    bgView.layer.borderWidth=1;
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.layer.borderColor=dzRgba(0.83, 0.83, 0.83, 1).CGColor;
    [self.view addSubview:bgView];
    bgView.center=CGPointMake(dzScreen_width*0.5, dzScreen_height*0.5-50);
    
    UIImageView *imageView=[[UIImageView alloc] init];
    imageView.frame=CGRectMake(bgView.width/3, bgView.height/3-bgView.width/9, bgView.width/3, bgView.width/3);
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds=YES;
    imageView.image=self.headImage;
    [bgView addSubview:imageView];
    
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(0,CGRectGetMaxY(imageView.frame), bgView.width, bgView.height*2/3-bgView.width*2/9-10);
    label.text=@"头像照片已经提交审核\n请注意查收通知";
    label.numberOfLines=0;
    label.font=dzFont(16);
    label.textColor=DZColorFromRGB(0x7e7e7e);
    label.textAlignment=NSTextAlignmentCenter;
    [bgView addSubview:label];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(bgView.center.x-20, CGRectGetMaxY(bgView.frame)+5, 40, 40);
    [btn setImage:dzImageNamed(@"close") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)btnClick:(UIButton *)btn{
    if (self.btnBlock) {
        self.btnBlock();
    }
    [self deleteIscelect];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)deleteIscelect{
    [UIView animateWithDuration:0.25 animations:^{
        
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
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
