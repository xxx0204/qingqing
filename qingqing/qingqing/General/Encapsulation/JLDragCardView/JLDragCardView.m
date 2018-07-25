//
//  JLDragCardView.m
//  JLCardAnimation
//
//  Created by job on 16/8/31.
//  Copyright © 2016年 job. All rights reserved.
//

#import "JLDragCardView.h"

#define iPhone5AndEarlyDevice (([[UIScreen mainScreen] bounds].size.height*[[UIScreen mainScreen] bounds].size.width <= 320*568)?YES:NO)
#define Iphone6 (([[UIScreen mainScreen] bounds].size.height*[[UIScreen mainScreen] bounds].size.width <= 375*667)?YES:NO)

static inline float lengthFit(float iphone6PlusLength)
{
    if (iPhone5AndEarlyDevice) {
        return iphone6PlusLength *320.0f/414.0f;
    }
    if (Iphone6) {
        return iphone6PlusLength *375.0f/414.0f;
    }
    return iphone6PlusLength;
}

#define ACTION_MARGIN_RIGHT lengthFit(150)
#define ACTION_MARGIN_LEFT lengthFit(150)
#define ACTION_VELOCITY 400
#define SCALE_STRENGTH 4
#define SCALE_MAX .93
#define ROTATION_MAX 1
#define ROTATION_STRENGTH lengthFit(414)

#define BUTTON_WIDTH lengthFit(40)

@interface JLDragCardView() {
    CGFloat xFromCenter;
    CGFloat yFromCenter;
}
@property (strong, nonatomic) UILabel *nameLabel,*alertLabel,*constellationL;
@property (strong, nonatomic) UIButton *liekBtn;
@property (strong, nonatomic) UIButton *disLikeBtn;
@property (strong, nonatomic) UIButton *potoNumBtn;


@end

@implementation JLDragCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius      = 19.2;
//        self.layer.shadowRadius      = 3;
//        self.layer.shadowOpacity     = 0.2;
//        self.layer.shadowOffset      = CGSizeMake(1, 1);
//        self.layer.shadowPath        = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;

        self.panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(beingDragged:)];
        [self addGestureRecognizer:self.panGesture];
        
        UIView *bgView            = [[UIView alloc]initWithFrame:self.bounds];
        bgView.layer.cornerRadius = 19.2;
        bgView.clipsToBounds      = YES;
        [self addSubview:bgView];
        
        
        UIView *imageBgView=[UIButton buttonWithType:UIButtonTypeCustom];
//        imageBgView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-120);
        imageBgView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        imageBgView.layer.cornerRadius = 19.2;
        imageBgView.backgroundColor=[UIColor whiteColor];
        imageBgView.layer.shadowColor =[UIColor blackColor].CGColor;
        imageBgView.layer.shadowOffset=CGSizeMake(0, 3);
        imageBgView.layer.shadowOpacity=0.25;
        [bgView addSubview:imageBgView];
        
        
        self.headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageBgView.frame.size.width, imageBgView.frame.size.height)];
        self.headerImageView.backgroundColor = [UIColor lightGrayColor];
        self.headerImageView.userInteractionEnabled = YES;
        self.headerImageView.layer.cornerRadius=19.2;
        self.headerImageView.contentMode=UIViewContentModeScaleAspectFill;
        self.headerImageView.clipsToBounds=YES;
        [imageBgView addSubview:self.headerImageView];
        
        
        UIView *labelV=[UIButton buttonWithType:UIButtonTypeCustom];
        labelV.frame=CGRectMake(5, bgView.height-90, bgView.width - 10, 85);
        labelV.layer.cornerRadius = 19.2;
        labelV.backgroundColor=[UIColor whiteColor];
        labelV.layer.shadowColor =[UIColor blackColor].CGColor;
        labelV.layer.shadowOffset=CGSizeMake(0, 3);
        labelV.layer.shadowOpacity=0.25;
        [bgView addSubview:labelV];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        [bgView addGestureRecognizer:tap];
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        [labelV addGestureRecognizer:tap1];
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 16, labelV.width - 40, 32)];
        self.nameLabel.font = [UIFont systemFontOfSize:23];
        self.nameLabel.textColor = DZColorFromRGB(0x8C8C8C);
        [labelV addSubview:self.nameLabel];
        
        UILabel *alertLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 49,labelV.width - 40, 21)];
        alertLabel.font = [UIFont systemFontOfSize:15.36];
        alertLabel.textColor = DZColorFromRGB(0xC0C0C0);//[UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1];
        [labelV addSubview:alertLabel];
        self.alertLabel=alertLabel;
        
        UILabel *constellationL = [[UILabel alloc]initWithFrame:CGRectMake(20, 49,labelV.width - 40, 19)];
        constellationL.centerY=self.nameLabel.centerY;
        constellationL.backgroundColor=[UIColor colorWithRed:1.00 green:0.50 blue:0.58 alpha:1.00];
        constellationL.font = [UIFont systemFontOfSize:13.44];
        constellationL.textColor = DZColorFromRGB(0xFFFFFF);
        constellationL.textAlignment=NSTextAlignmentCenter;
        constellationL.layer.cornerRadius = 9.5;
        constellationL.clipsToBounds      = YES;

        [labelV addSubview:constellationL];
        self.constellationL=constellationL;
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(20, 15, 40, 24);
        [btn setImage:dzImageNamed(@"home_photoIcon") forState:UIControlStateNormal];
        [btn setTitle:@" 0" forState:UIControlStateNormal];
        btn.layer.cornerRadius=8;
        btn.titleLabel.font=dzFont(16);
        btn.backgroundColor=dzRGBA(0, 0, 0, 0.15);
        [self addSubview:btn];
        self.potoNumBtn=btn;
        
        self.disLikeBtn       = [UIButton buttonWithType:UIButtonTypeCustom];
        self.disLikeBtn.frame =CGRectMake(self.width-60-10 ,btn.bottom, 60, 60);
        [self.disLikeBtn setImage:[UIImage imageNamed:@"dislikeBtn"] forState:UIControlStateNormal];
        [self.disLikeBtn addTarget:self action:@selector(leftButtonClickAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.disLikeBtn];
        
        self.liekBtn       = [UIButton buttonWithType:UIButtonTypeCustom];
        self.liekBtn.frame = CGRectMake(10,btn.bottom, 60, 60);
        [self.liekBtn setImage:[UIImage imageNamed:@"likeBtn"] forState:UIControlStateNormal];
        [self.liekBtn addTarget:self action:@selector(rightButtonClickAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.liekBtn];
        
        self.liekBtn.hidden=YES;
        self.disLikeBtn.hidden=YES;
        
        self.layer.allowsEdgeAntialiasing                 = YES;
        bgView.layer.allowsEdgeAntialiasing               = YES;
        self.headerImageView.layer.allowsEdgeAntialiasing = YES;
    }
    return self;
}

-(void)tapGesture:(UITapGestureRecognizer *)sender {
    if (!self.canPan) {
        return;
    }
    NSLog(@"tap") ;
//    [DZNetwork hintNetwork:@"进入详情"];
    [self.delegate clickImage:(long)self.homeListM.id];
//    NSLog(@"%@",self.infoDict[@"number"]);
    NSLog(@"%ld",(long)self.homeListM.id);
}

-(void)layoutSubviews {
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %ld ",self.homeListM.nickname,(long)self.homeListM.age];
    [self.potoNumBtn setTitle:[NSString stringWithFormat:@" %ld",(long)self.homeListM.picCount] forState:UIControlStateNormal];
//    self.nameLabel.text = [NSString stringWithFormat:@"郑爽 %@号 ",self.infoDict[@"number"]];
//    self.headerImageView.image = [UIImage imageNamed:self.infoDict[@"image"]];
    NSString *imgUrl = [NSString picUrlPath:self.homeListM.headPicUrl];
    imgUrl = [imgUrl stringByReplacingOccurrencesOfString:@".jpeg" withString:@"_long.jpeg"];
    imgUrl = [imgUrl stringByReplacingOccurrencesOfString:@".jpg" withString:@"_long.jpg"];
    imgUrl = [imgUrl stringByReplacingOccurrencesOfString:@".png" withString:@"_long.png"];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:dzImageNamed(@"default_head")];
    if (self.homeListM.profession.length==0) {
        self.alertLabel.text =[NSString getNullStr:self.homeListM.city];//@"学生 北京";
    }else{
        self.alertLabel.text =[NSString stringWithFormat:@"%@ %@",self.homeListM.profession,[NSString getNullStr:self.homeListM.city]];//@"学生 北京";
    }
    self.constellationL.text=[NSString getNullStr:self.homeListM.constellation];//@"处女座";

    [self.nameLabel sizeToFit];
    [self.alertLabel sizeToFit];
    [self.constellationL sizeToFit];
    self.nameLabel.frame=CGRectMake(20, 16, self.nameLabel.width, 32);
    self.alertLabel.frame=CGRectMake(20, 49, self.alertLabel.width, 21);
    self.constellationL.frame=CGRectMake(CGRectGetMaxX(self.nameLabel.frame), 0, self.constellationL.width+15, self.constellationL.height+5);
    self.constellationL.centerY=self.nameLabel.centerY;
    self.constellationL.layer.cornerRadius = self.constellationL.height*0.5;

}

#pragma mark ------------- 拖动手势
-(void)beingDragged:(UIPanGestureRecognizer *)gesture {
    if (!self.canPan) {
        return ;
    }
    xFromCenter = [gesture translationInView:self].x;
    yFromCenter = [gesture translationInView:self].y;
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged: {
            CGFloat rotationStrength = MIN(xFromCenter / ROTATION_STRENGTH, ROTATION_MAX);
            
            CGFloat rotationAngel = (CGFloat) (ROTATION_ANGLE * rotationStrength);
            
            CGFloat scale = MAX(1 - fabs(rotationStrength) / SCALE_STRENGTH, SCALE_MAX);
            
            self.center = CGPointMake(self.originalCenter.x + xFromCenter, self.originalCenter.y + yFromCenter);
            
            CGAffineTransform transform = CGAffineTransformMakeRotation(rotationAngel);
            
            CGAffineTransform scaleTransform = CGAffineTransformScale(transform, scale, scale);
            
            self.transform = scaleTransform;
            [self updateOverLay:xFromCenter];
            
        }
            break;
        case UIGestureRecognizerStateEnded: {
            [self followUpActionWithDistance:xFromCenter andVelocity:[gesture velocityInView:self.superview]];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark ----------- 滑动时候，按钮变大
- (void) updateOverLay:(CGFloat)distance {
    if (distance==0) {
        self.liekBtn.hidden=YES;
        self.disLikeBtn.hidden=YES;
    }
    if (distance > 0) {
        self.liekBtn.hidden=NO;
        self.liekBtn.alpha=distance/150;
        self.disLikeBtn.hidden=YES;
    }
    if (distance<0) {
        self.liekBtn.hidden=YES;
        self.disLikeBtn.hidden=NO;
        self.disLikeBtn.alpha=-distance/150;
    }
     [self.delegate moveCards:distance];
}

#pragma mark ----------- 后续动作判断
-(void)followUpActionWithDistance:(CGFloat)distance andVelocity:(CGPoint)velocity {
    self.liekBtn.hidden=YES;
    self.disLikeBtn.hidden=YES;
    if (xFromCenter > 0 && (distance > ACTION_MARGIN_RIGHT || velocity.x > ACTION_VELOCITY )) {
        [self rightAction:velocity];
    } else if(xFromCenter < 0 && (distance < - ACTION_MARGIN_RIGHT || velocity.x < -ACTION_VELOCITY)) {
        [self leftAction:velocity];
    }else {
        //回到原点
        [UIView animateWithDuration:RESET_ANIMATION_TIME
                         animations:^{
                             self.center = self.originalCenter;
                             self.transform = CGAffineTransformMakeRotation(0);
                             self.yesButton.transform = CGAffineTransformMakeScale(1, 1);
                             self.noButton.transform  = CGAffineTransformMakeScale(1, 1);
                         }];
        self.liekBtn.hidden=YES;
        self.disLikeBtn.hidden=YES;
        [self.delegate moveBackCards];
    }
}
-(void)rightAction:(CGPoint)velocity {
    CGFloat distanceX=[[UIScreen mainScreen]bounds].size.width+CARD_WIDTH+self.originalCenter.x;//横向移动距离
    CGFloat distanceY=distanceX*yFromCenter/xFromCenter;//纵向移动距离
    CGPoint finishPoint = CGPointMake(self.originalCenter.x+distanceX, self.originalCenter.y+distanceY);//目标center点
    
    CGFloat vel=sqrtf(pow(velocity.x, 2)+pow(velocity.y, 2));//滑动手势横纵合速度
    CGFloat displace=sqrt(pow(distanceX-xFromCenter,2)+pow(distanceY-yFromCenter,2));//需要动画完成的剩下距离
    
    CGFloat duration=fabs(displace/vel);//动画时间
    
    if (duration>0.6) {
        duration=0.6;
    }else if(duration<0.3){
        duration=0.3;
    }
    
    [UIView animateWithDuration:duration
                     animations:^{
                         
                         self.yesButton.transform=CGAffineTransformMakeScale(1.5, 1.5);
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(ROTATION_ANGLE);
                     }completion:^(BOOL complete){
                         
                         self.yesButton.transform=CGAffineTransformMakeScale(1, 1);
                         [self.delegate swipCard:self Direction:YES];
                     }];
    [self.delegate adjustOtherCards];

}

-(void)leftAction:(CGPoint)velocity {
    //横向移动距离
    CGFloat distanceX = -CARD_WIDTH - self.originalPoint.x;
    //纵向移动距离
    CGFloat distanceY = distanceX*yFromCenter/xFromCenter;
    //目标center点
    CGPoint finishPoint = CGPointMake(self.originalPoint.x+distanceX, self.originalPoint.y+distanceY);
    
    CGFloat vel = sqrtf(pow(velocity.x, 2) + pow(velocity.y, 2));
    CGFloat displace = sqrtf(pow(distanceX - xFromCenter, 2) + pow(distanceY - yFromCenter, 2));
    
    CGFloat duration = fabs(displace/vel);
    if (duration>0.6) {
        duration = 0.6;
    }else if(duration < 0.3) {
        duration = 0.3;
    }
    [UIView animateWithDuration:duration
                     animations:^{
                         self.noButton.transform=CGAffineTransformMakeScale(1.5, 1.5);
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(-ROTATION_ANGLE);
                     } completion:^(BOOL finished) {
                         self.noButton.transform=CGAffineTransformMakeScale(1, 1);
                         [self.delegate swipCard:self Direction:NO];
                     }];
    
    [self.delegate adjustOtherCards];
}


-(void)rightButtonClickAction {
    if (!self.canPan) {
        return;
    }
    CGPoint finishPoint = CGPointMake([[UIScreen mainScreen]bounds].size.width+CARD_WIDTH*2/3, 2*PAN_DISTANCE+self.frame.origin.y);
    [UIView animateWithDuration:CLICK_ANIMATION_TIME
                     animations:^{
                         self.yesButton.transform = CGAffineTransformMakeScale(1.5, 1.5);
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(-ROTATION_ANGLE);
                     } completion:^(BOOL finished) {
                         self.yesButton.transform = CGAffineTransformMakeScale(1, 1);
                         [self.delegate swipCard:self Direction:YES];
                     }];
    [self.delegate adjustOtherCards];
}
-(void)leftButtonClickAction {
    if (!self.canPan) {
        return;
    }
    CGPoint finishPoint = CGPointMake(-CARD_WIDTH*2/3, 2*PAN_DISTANCE + self.frame.origin.y);
    [UIView animateWithDuration:CLICK_ANIMATION_TIME
                     animations:^{
                         self.noButton.transform = CGAffineTransformMakeScale(1.5, 1.5);
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(-ROTATION_ANGLE);
                   } completion:^(BOOL finished) {
                       self.noButton.transform = CGAffineTransformMakeScale(1, 1);
                       [self.delegate swipCard:self Direction:NO];
                   }];
    [self.delegate adjustOtherCards];
}

@end
