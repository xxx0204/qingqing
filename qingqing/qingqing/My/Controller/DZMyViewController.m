//
//  DZMyViewController.m
//  qingqing
//
//  Created by Gavin on 2018/5/14.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZMyViewController.h"
#import "DZSettingViewController.h"
#import "DZInfoViewController.h"

@interface DZMyViewController ()
@property(nonatomic,strong)UIButton *headBtn;
@end

@implementation DZMyViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.headBtn sd_setImageWithURL:[NSURL URLWithString:[NSString picUrlPath:[NSString memberFace]]] forState:UIControlStateNormal placeholderImage:dzImageNamed(@"default_head")];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"详细资料";
    self.view.backgroundColor=dzRgba(0.96, 0.96, 0.96, 1);
    UIImage *image=dzImageNamed(@"head_bg");
    UIImageView *headImageV=[[UIImageView alloc]init];
    headImageV.frame=CGRectMake((dzScreen_width-image.size.width)*0.5, dzNavigationBarH+30, image.size.width, image.size.width);
    headImageV.layer.cornerRadius=image.size.width*0.5;
    headImageV.image=image;
    [self.view addSubview:headImageV];
    headImageV.userInteractionEnabled=YES;
    
    UIButton *headBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    headBtn.frame=CGRectMake(0, 0, headImageV.width-14, headImageV.width-14);
    headBtn.center=CGPointMake(headImageV.width*0.5, headImageV.height*0.5);
    headBtn.layer.cornerRadius=headImageV.width*0.5-7;
    headBtn.clipsToBounds=YES;
    headBtn.tag=0;
    headBtn.imageView.contentMode=UIViewContentModeScaleAspectFill;
    [headBtn sd_setImageWithURL:[NSURL URLWithString:[NSString picUrlPath:[NSString memberFace]]] forState:UIControlStateNormal placeholderImage:dzImageNamed(@"default_head")];
    [headBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headImageV addSubview:headBtn];
    self.headBtn=headBtn;
    
    CGRect viewFrame=CGRectMake(25, CGRectGetMaxY(headImageV.frame)+30, dzScreen_width-50, 50);
    NSArray *iconArray=@[@"my_edit",@"my_setting",@"my_contact_us"];
    NSArray *textArray=@[@"编辑个人资料",@"设置",@"联系我们&常见问题"];//联系我们&常见问答
    for (int i=0; i<3; i++) {
        UIView *bgView=[[UIView alloc] init];
        bgView.frame=viewFrame;
        bgView.layer.cornerRadius=viewFrame.size.height*0.5;
        bgView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:bgView];
        viewFrame=CGRectMake(bgView.left, CGRectGetMaxY(bgView.frame)+20, bgView.width, bgView.height);
        
        UIImage *iconImage=dzImageNamed(iconArray[i]);
        UIImageView *imageV=[[UIImageView alloc] init];
        imageV.frame=CGRectMake(20, bgView.height*0.5-iconImage.size.height*0.5, iconImage.size.width, iconImage.size.height);
        imageV.image=iconImage;
        [bgView addSubview:imageV];
        
        UILabel *label=[[UILabel alloc]init];
        label.frame=CGRectMake(0, 0, bgView.width, bgView.height);
        label.text=textArray[i];
        label.textAlignment=NSTextAlignmentCenter;
        label.font=dzFont(16);
        label.textColor=DZColorFromRGB(0x979797);
        [bgView addSubview:label];
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0, 0, bgView.width, bgView.height);
        btn.layer.cornerRadius=bgView.height*0.5;
        btn.tag=i;
        btn.clipsToBounds=YES;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:btn];
    }
}
-(void)btnClick:(UIButton *)btn{
    NSLog(@"进入%ld",(long)btn.tag);
    if (btn.tag==1) {
        [self.navigationController pushViewController:[DZSettingViewController new] animated:YES];
    }else if (btn.tag==0){
        DZInfoViewController *dz_I_VC=[DZInfoViewController new];
        dz_I_VC.isEdit=YES;
        [self.navigationController pushViewController:dz_I_VC animated:YES];
    }else{
        [DZNetwork temporaryHintNetwork:@"进入H5界面"];
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
