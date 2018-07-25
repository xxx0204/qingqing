//
//  DZPopFriendInfoViewController.m
//  qingqing
//
//  Created by Gavin on 2018/5/22.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZPopFriendInfoViewController.h"

@interface DZPopFriendInfoViewController ()

@end

@implementation DZPopFriendInfoViewController


-(instancetype)initWithFrame:(CGRect)frame headImage:(NSString *)headImage isClock:(BOOL)isClock model:(DZGMModel *)model{
    if (self = [super initWithFrame:frame]) {
        self.headImage=headImage;
        self.isClock=isClock;
        self.dz_GM_M=model;
        self.backgroundColor=dzRgba(0, 0, 0, 0.7);
        [self initV];
    }
    return self;
}

-(void)initV{
    UIView *bgView=[[UIView alloc]init];
    bgView.frame=CGRectMake(0, 0, dzScreen_width-40, (dzScreen_width-40)*24/34);
    bgView.layer.cornerRadius=20;
    bgView.layer.borderWidth=1;
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.layer.borderColor=dzRgba(0.83, 0.83, 0.83, 1).CGColor;
    [self addSubview:bgView];
    
    UIView *headBgView=[[UIView alloc] init];
    headBgView.frame=CGRectMake((bgView.width-70)*0.5, 20, 70, 70);;
    headBgView.layer.cornerRadius=35;
    if (self.dz_GM_M.type==1) {
        headBgView.backgroundColor=[UIColor redColor];
    }else if (self.dz_GM_M.type==2){
        headBgView.backgroundColor=[UIColor greenColor];
    }else if (self.dz_GM_M.type==3){
        headBgView.backgroundColor=[UIColor orangeColor];
    }else if (self.dz_GM_M.type==4){
        headBgView.backgroundColor=DZColorFromRGB(0xFFB1CC);
    }else{
        headBgView.backgroundColor=[UIColor grayColor];
    }
//    headBgView.backgroundColor=[UIColor redColor];
    //        bgView.backgroundColor=DZColorFromRGB(0xFFB1CC);
    [bgView addSubview:headBgView];
    
    UIButton *headBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    headBtn.frame=CGRectMake(0, 0, headBgView.width-6, headBgView.height-6);
    headBtn.center=CGPointMake(headBgView.width*0.5, headBgView.height*0.5);
    headBtn.backgroundColor=[UIColor whiteColor];
    headBtn.layer.cornerRadius= headBgView.height*0.5-3;
    headBtn.clipsToBounds=YES;
    headBtn.imageView.contentMode=UIViewContentModeScaleAspectFill;
    [headBtn sd_setImageWithURL:[NSURL URLWithString:[NSString picUrlPath:self.dz_GM_M.headPicUrl]] forState:UIControlStateNormal placeholderImage:dzImageNamed(@"default_head")];
//    if (self.dz_GM_M.headPicUrl.length==0) {
//        [headBtn setImage:dzImageNamed(@"default_head") forState:UIControlStateNormal];
//    }
    [headBtn addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headBgView addSubview:headBtn];
    
    if (self.dz_GM_M.type==1) {
        UIImageView *imageV=[[UIImageView alloc] init];
        imageV.image=dzImageNamed(@"timeRemind");
        imageV.frame=CGRectMake(CGRectGetMaxX(headBgView.frame)-25, CGRectGetMaxY(headBgView.frame)-25, 25, 25);
        imageV.hidden=self.isClock;
        [bgView addSubview:imageV];
        
        UILabel *timeL=[[UILabel alloc] init];
        timeL.frame=CGRectMake(0, 0, imageV.width, imageV.height);
        timeL.text=[NSString getMinutes:self.dz_GM_M.buildTime];
        timeL.font=dzFont(14);
        timeL.textAlignment=NSTextAlignmentCenter;
        timeL.textColor=[UIColor whiteColor];
        [imageV addSubview:timeL];
    }
    UILabel *titleL=[[UILabel alloc]init];
    titleL.frame=CGRectMake(0,CGRectGetMaxY(headBgView.frame)+15, bgView.width,30);
    if (self.dz_GM_M.type==1) {
        titleL.text=@"红边的TA";
    }else if (self.dz_GM_M.type==2){
        titleL.text=@"绿色的TA";
    }else if (self.dz_GM_M.type==3){
        titleL.text=@"橙边的TA";
    }else if (self.dz_GM_M.type==4){
        titleL.text=@"粉色的TA";
    }else{
        titleL.text=@"灰色的TA";
    }
    titleL.font=dzFont(20);
    if (self.dz_GM_M.type==1) {
        titleL.textColor=[UIColor redColor];
    }else if (self.dz_GM_M.type==2){
        titleL.textColor=[UIColor greenColor];
    }else if (self.dz_GM_M.type==3){
        titleL.textColor=[UIColor orangeColor];
    }else if (self.dz_GM_M.type==4){
        titleL.textColor=DZColorFromRGB(0xFFB1CC);
    }else{
        titleL.textColor=[UIColor grayColor];
    }
    titleL.textAlignment=NSTextAlignmentCenter;
    [bgView addSubview:titleL];
    [titleL sizeToFit];
    titleL.frame=CGRectMake(0,CGRectGetMaxY(headBgView.frame)+15, bgView.width,titleL.height);

    UILabel *subtitleL=[[UILabel alloc]init];
    subtitleL.frame=CGRectMake(0,CGRectGetMaxY(titleL.frame)+20, bgView.width, 30);
    if (self.dz_GM_M.type==1) {
        subtitleL.text=@"24小时之内不说话就会永远消失哦";
    }else if (self.dz_GM_M.type==2){
        subtitleL.text=@"这里都是偷偷喜欢你的人哦";
    }else if (self.dz_GM_M.type==3){
        subtitleL.text=@"你们已经互相欣赏了，马上开始聊天吧";
    }else if (self.dz_GM_M.type==4){
        subtitleL.text=@"延迟过配对时间的人";
    }else{
        subtitleL.text=@"你们已经过了最迟回复时间";
    }
    subtitleL.numberOfLines=0;
    subtitleL.font=dzFont(16);
    subtitleL.textColor=DZColorFromRGB(0x7e7e7e);
    subtitleL.textAlignment=NSTextAlignmentCenter;
    [bgView addSubview:subtitleL];
    [subtitleL sizeToFit];
    subtitleL.frame=CGRectMake(0,CGRectGetMaxY(titleL.frame)+20, bgView.width,subtitleL.height);
    
    UILabel *hintL=[[UILabel alloc]init];
    hintL.frame=CGRectMake(0,CGRectGetMaxY(subtitleL.frame)+5, bgView.width, 30);
    if (self.dz_GM_M.type==1) {
        hintL.text=@"请多关注右下角的倒计时，有一次延长时间的机会哦";
    }else if (self.dz_GM_M.type==2){
        hintL.text=@"快去查看有没有你也喜欢的Ta";
    }else if (self.dz_GM_M.type==3){
        hintL.text=@"只有女生才可以主动聊天哦";
    }else if (self.dz_GM_M.type==4){
        hintL.text=@"ta已经知道你为ta延迟了时间 请耐心等待回复吧";
    }else{
        hintL.text=@"回到首页重新开始你的交友吧";
    }
    hintL.numberOfLines=0;
    hintL.font=dzFont(13);
    hintL.textColor=DZColorFromRGB(0x7e7e7e);
    hintL.textAlignment=NSTextAlignmentCenter;
    [bgView addSubview:hintL];
    [hintL sizeToFit];
    hintL.frame=CGRectMake(0,CGRectGetMaxY(subtitleL.frame)+5, bgView.width,hintL.height);
    
    bgView.frame=CGRectMake(0, 0,bgView.width , CGRectGetMaxY(hintL.frame)+20);
    bgView.center=CGPointMake(dzScreen_width*0.5, dzScreen_height*0.5-80);
    
    UIImage *image=dzImageNamed(@"btn_bg_h");
    UIButton *hintBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    hintBtn.frame=CGRectMake(bgView.left, CGRectGetMaxY(bgView.frame)+20,bgView.width , bgView.width*image.size.height/image.size.width);
    [hintBtn setTitle:@"我知道叻" forState:UIControlStateNormal];
    hintBtn.titleLabel.font=dzFont(16);
    [hintBtn setBackgroundImage:image forState:UIControlStateNormal];
    [hintBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [hintBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:hintBtn];
}
-(void)headBtnClick:(UIButton *)btn{
//    [self deleteIscelect];
    
}
-(void)btnClick:(UIButton *)btn{
    [self deleteIscelect];
    if (self.btnBlock) {
        self.btnBlock();
    }
}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
-(void)deleteIscelect{
    [UIView animateWithDuration:0.25 animations:^{
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
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
