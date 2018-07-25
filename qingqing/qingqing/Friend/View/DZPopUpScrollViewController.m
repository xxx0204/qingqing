//
//  DZPopUpScrollViewController.m
//  qingqing
//
//  Created by Gavin on 2018/5/31.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZPopUpScrollViewController.h"

@interface DZPopUpScrollViewController ()<UIScrollViewDelegate>

@end

@implementation DZPopUpScrollViewController
{
    UIScrollView *_scrollV;
    NSInteger _pageI;
}
-(instancetype)initWithFrame:(CGRect)frame array:(NSMutableArray *)array styleType:(StyleType)styleType{
    if (self = [super initWithFrame:frame]) {
        self.dataArray=array;
        self.backgroundColor=dzRgba(0, 0, 0, 0.7);
        _styleType = styleType;
        [self initV:styleType];
    }
    return self;
}

-(void)initV:(StyleType)styleType{
    _pageI=0;
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(dzScreen_width-60,20, 40, 40);
    [btn setImage:dzImageNamed(@"close") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    UIImage *image=dzImageNamed(@"info_bg");
    [_scrollV removeAllSubviews];
    _scrollV=[[UIScrollView alloc] init];
    _scrollV.frame=CGRectMake(0, 0, dzScreen_width-50, (dzScreen_width-50)*image.size.height/image.size.width+75);
    _scrollV.delegate=self;
    _scrollV.showsHorizontalScrollIndicator = NO;
    _scrollV.pagingEnabled = YES;
    [self addSubview:_scrollV];
    _scrollV.center=CGPointMake(dzScreen_width*0.5, dzScreen_height*0.5-50);
    for (int i=0; i<self.dataArray.count; i++) {
        _scrollV.contentSize=CGSizeMake((dzScreen_width-50)*self.dataArray.count, _scrollV.height);
        DZAccountModel *accountM=self.dataArray[i];
        UIView *headBgView=[[UIView alloc] init];
        headBgView.frame=CGRectMake(0,0, 70, 70);
        headBgView.layer.cornerRadius=35;
        if (styleType == 0) {
            headBgView.backgroundColor=[UIColor greenColor];
        } else {
            headBgView.backgroundColor=[UIColor grayColor];
        }
        [_scrollV addSubview:headBgView];
        
        headBgView.center=CGPointMake(_scrollV.width*0.5+i*_scrollV.width,35);
        UIButton *headBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        headBtn.frame=CGRectMake(0, 0, headBgView.width-6, headBgView.height-6);
        headBtn.center=CGPointMake(headBgView.width*0.5, headBgView.height*0.5);
        headBtn.backgroundColor=[UIColor whiteColor];
        headBtn.layer.cornerRadius= headBgView.height*0.5-3;
        headBtn.clipsToBounds=YES;
        headBtn.imageView.contentMode=UIViewContentModeScaleAspectFill;
        [headBtn sd_setImageWithURL:[NSURL URLWithString:[NSString picUrlPath:accountM.headPicUrl]] forState:UIControlStateNormal placeholderImage:dzImageNamed(@"default_head")];
        [headBtn addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [headBgView addSubview:headBtn];
        
        
        UIImageView *imageV=[[UIImageView alloc] init];
        imageV.frame=CGRectMake(10+i*_scrollV.width, 75, _scrollV.width-20, (_scrollV.width-20)*image.size.height/image.size.width);
        imageV.image=image;
        [_scrollV addSubview:imageV];
        
        NSInteger count;
        if (accountM.pictureUrlList.count>3) {
            count=3;
        }else{
            count=accountM.pictureUrlList.count;
        }
        for (int j=0; j<count; j++) {
            UIImageView *iconImageV=[[UIImageView alloc] init];
            iconImageV.frame=CGRectMake(10+j*((imageV.width-30)/3+5), 15, (imageV.width-30)/3, (imageV.width-30)/3*630/378);
            iconImageV.layer.cornerRadius=5;
            [iconImageV sd_setImageWithURL:[NSURL URLWithString:accountM.pictureUrlList[j]] placeholderImage:dzImageNamed(@"headIcon")];
            iconImageV.backgroundColor=[UIColor yellowColor];
            [imageV addSubview:iconImageV];
        }
        
        UILabel *titleL=[[UILabel alloc] init];
        titleL.frame=CGRectMake(10, 15+(imageV.width-30)/3*630/378+5, imageV.width-20, 50);
        titleL.text=[NSString stringWithFormat:@""];//@"Amy蔓越莓 28";
        titleL.text = [NSString stringWithFormat:@"%@ %ld ",accountM.nickname,(long)accountM.age];
        titleL.font=dzFont(16);
        titleL.textColor=DZColorFromRGB(0x8C8C8C);//[UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1];
        [titleL sizeToFit];
        titleL.frame=CGRectMake(10, 15+(imageV.width-30)/3*630/378+5, titleL.width, titleL.height);
        [imageV addSubview:titleL];
        
        UILabel *subtitleL=[[UILabel alloc] init];
        subtitleL.frame=CGRectMake(titleL.left, CGRectGetMaxY(titleL.frame)+5, imageV.width-20, 50);
        if (accountM.profession.length==0) {
            subtitleL.text =[NSString getNullStr:accountM.city];//@"学生 北京";
        }else{
            subtitleL.text =[NSString stringWithFormat:@"%@ %@",accountM.profession,[NSString getNullStr:accountM.city]];//@"学生 北京";
        }
        subtitleL.textColor=DZColorFromRGB(0xC0C0C0);//[UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1];
        subtitleL.font=dzFont(14);
        [subtitleL sizeToFit];
        subtitleL.frame=CGRectMake(titleL.left, CGRectGetMaxY(titleL.frame), subtitleL.width, subtitleL.height);
        [imageV addSubview:subtitleL];
    }
    UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame=CGRectMake(_scrollV.left-20, _scrollV.top, 30, _scrollV.height);
    [leftBtn setImage:dzImageNamed(@"left_wsad") forState:UIControlStateNormal];
    leftBtn.tag=100;
    [leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtn];
    
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(CGRectGetMaxX(_scrollV.frame)-10, _scrollV.top, 30, _scrollV.height);
    [rightBtn setImage:dzImageNamed(@"right_wsad") forState:UIControlStateNormal];
    rightBtn.tag=101;
    [rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    
    UIImage *btn_Image=dzImageNamed(@"btn_bg_w_m");
    UIButton *noInterestBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    if (styleType == 0) {
        noInterestBtn.frame=CGRectMake(_scrollV.left+10, CGRectGetMaxY(_scrollV.frame)+10, _scrollV.width*0.5-15, (_scrollV.width*0.5-15)*btn_Image.size.height/btn_Image.size.width);
        [noInterestBtn setTitle:@"不感兴趣" forState:UIControlStateNormal];
        [noInterestBtn setBackgroundImage:btn_Image forState:UIControlStateNormal];
    } else {
        noInterestBtn.frame=CGRectMake(_scrollV.left+10, CGRectGetMaxY(_scrollV.frame)+110, _scrollV.width - 20, (_scrollV.width*0.5-15)*btn_Image.size.height/btn_Image.size.width);
        [noInterestBtn setTitle:@"删除" forState:UIControlStateNormal];
        [noInterestBtn setBackgroundImage:dzImageNamed(@"btn_bg_w_m_e") forState:UIControlStateNormal];
    }
    noInterestBtn.titleLabel.font=dzFont(16);
    noInterestBtn.tag=201;
    [noInterestBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [noInterestBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:noInterestBtn];
    
    UIButton *interestBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    if (styleType == 0) {
        interestBtn.frame=CGRectMake(CGRectGetMaxX(noInterestBtn.frame)+10, CGRectGetMaxY(_scrollV.frame)+10,_scrollV.width*0.5-15, (_scrollV.width*0.5-15)*btn_Image.size.height/btn_Image.size.width);
        [interestBtn setTitle:@"与我配对吧" forState:UIControlStateNormal];
        [interestBtn setBackgroundImage:dzImageNamed(@"btn_bg_r_m") forState:UIControlStateNormal];
    } else {
        interestBtn.frame=CGRectMake(CGRectGetMinX(_scrollV.frame) + 10, CGRectGetMaxY(_scrollV.frame)+10, _scrollV.width - 20, (_scrollV.width*0.5-15)*btn_Image.size.height/btn_Image.size.width);
        [interestBtn setTitle:@"重新配对" forState:UIControlStateNormal];
        [interestBtn setBackgroundImage:dzImageNamed(@"btn_bg_r_m_e") forState:UIControlStateNormal];
    }
    interestBtn.titleLabel.font=dzFont(16);
    interestBtn.tag=202;
    [interestBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [interestBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:interestBtn];
}
-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    int index=fabs(scrollView.contentOffset.x)/scrollView.frame.size.width;
    _pageI=index;
}
-(void)headBtnClick:(UIButton *)btn{
    //    [self deleteIscelect];
    
}
-(void)btnClick:(UIButton *)btn{
    if (btn.tag==100) {
        if (_pageI>0) {
            _pageI--;
            [_scrollV setContentOffset:CGPointMake((dzScreen_width-50)*_pageI,0) animated:YES];
        }
    }
    if (btn.tag==101) {
        if (_pageI<self.dataArray.count-1) {
            _pageI++;
            [_scrollV setContentOffset:CGPointMake((dzScreen_width-50)*_pageI,0) animated:YES];
        }
    }
    if (btn.tag==201||btn.tag==202) {
        NSLog(@"%ld",(long)_pageI);
        NSArray *likeArr=@[];
        NSArray *unLikeArr=@[];
        DZAccountModel *model=self.dataArray[_pageI];
        if (btn.tag==201) {
            unLikeArr=@[@(model.id)];
        }else{
            likeArr=@[@(model.id)];
        }
        dzWeakSelf(self);
        [DZNetwork post_ph:post_upLikeAndUnLike np:@{@"likeAccountIds":likeArr,@"dontLikeAccountIds":unLikeArr} class:nil success:^(id data) {
            if ([data[@"resultCode"] integerValue]==0) {
                [weakself.dataArray removeObject:model];
                weakself.deleteBlock(model.id);
                if (weakself.dataArray.count!=0) {
                    [weakself initV:_styleType];
                }else{
                    [weakself deleteIscelect];
                }
            }
            NSLog(@"%@",data);
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}
-(void)closeBtnClick{
    [UIView animateWithDuration:0.25 animations:^{
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)deleteIscelect{
    [UIView animateWithDuration:0.25 animations:^{
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    if (self.btnBlock) {
        self.btnBlock();
    }
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
