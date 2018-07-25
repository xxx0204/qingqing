//
//  DZHeadPortraitsAuditViewController.m
//  qingqing
//
//  Created by Gavin on 2018/5/30.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZHeadPortraitsAuditViewController.h"

@interface DZHeadPortraitsAuditViewController ()

@end

@implementation DZHeadPortraitsAuditViewController

- (void)showPullDownVC{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window.rootViewController addChildViewController:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=dzRgba(0, 0, 0, 0.7);
    [self initV];
}

-(void)initV{
    UIView *bgView=[[UIView alloc]init];
    bgView.layer.borderWidth=1;
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.layer.borderColor=dzRgba(0.83, 0.83, 0.83, 1).CGColor;
    [self.view addSubview:bgView];
    
    UIImageView *imageView=[[UIImageView alloc] init];
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds=YES;
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString picUrlPath:[NSString memberFace]]] placeholderImage:dzImageNamed(@"default_head")];
    [bgView addSubview:imageView];
    
    UILabel *label=[[UILabel alloc]init];
    label.numberOfLines=0;
    label.font=dzFont(16);
    label.textAlignment=NSTextAlignmentCenter;
    
    UIImage *image=dzImageNamed(@"head_btn_bg");
    UIButton *hintBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    hintBtn.titleLabel.font=dzFont(16);
    [hintBtn setBackgroundImage:image forState:UIControlStateNormal];
    [hintBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [hintBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    if (self.pass) {
        bgView.layer.cornerRadius=10;
        label.textColor=[UIColor whiteColor];

        bgView.frame=CGRectMake(0, 0, dzScreen_width/2, dzScreen_width/2);
        bgView.center=CGPointMake(dzScreen_width*0.5, dzScreen_height*0.5-50);
        
        imageView.frame=CGRectMake(10, 10, bgView.width-20, bgView.width-20);

        label.frame=CGRectMake(bgView.left,CGRectGetMaxY(bgView.frame)+10, bgView.width, 70);
        label.text=@"恭喜头像已经审核通过\n\n添加跟多照片和资料\n增加配对机会哦";
        [self.view addSubview:label];

        hintBtn.frame=CGRectMake(bgView.left-20, CGRectGetMaxY(label.frame)+10,bgView.width+40, (bgView.width+40)*image.size.height/image.size.width);
        [hintBtn setTitle:@"现在就去" forState:UIControlStateNormal];
        [self.view addSubview:hintBtn];
    }else{
        bgView.layer.cornerRadius=20;
        label.textColor=DZColorFromRGB(0x7e7e7e);

        bgView.frame=CGRectMake(0, 0, dzScreen_width-60, 30+(dzScreen_width-60)*3/7-10+25+40+20+70+15);
        bgView.center=CGPointMake(dzScreen_width*0.5, dzScreen_height*0.5-50);
        imageView.frame=CGRectMake((bgView.width-bgView.width*3/7)*0.5, 30, bgView.width*3/7, bgView.width*3/7-10);
        UIImageView *warningImageV=[[UIImageView alloc] init];
        warningImageV.frame=CGRectMake(imageView.left-13, CGRectGetMaxY(imageView.frame)-15, 28, 28);
        warningImageV.image=dzImageNamed(@"warning");
        [bgView addSubview:warningImageV];
        
        label.frame=CGRectMake(0,CGRectGetMaxY(imageView.frame)+25, bgView.width, 40);
        label.text=@"请更换真实头像\n不然无法加入匹配队列哦";
        [bgView addSubview:label];
        
        hintBtn.frame=CGRectMake(20, CGRectGetMaxY(label.frame)+20,bgView.width-40, (bgView.width-40)*image.size.height/image.size.width);
        [hintBtn setTitle:@"去更换头像" forState:UIControlStateNormal];
        [bgView addSubview:hintBtn];
    }
}
-(void)btnClick:(UIButton *)btn{
    [self deleteIscelect];
    if (self.btnBlock) {
        self.btnBlock();
    }
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
