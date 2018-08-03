//
//  DZHomeListViewController.m
//  qingqing
//
//  Created by Gavin on 2018/5/4.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZHomeListViewController.h"
#import "JLDragCardView.h"
#import "NSObject+DZLogicProcessing.h"
#import "DZInfoViewController.h"
//定位
#import "SYCLLocation.h"
#define CARD_NUM 5
#define MIN_INFO_NUM 10
#define CARD_SCALE 0.95

@interface DZHomeListViewController ()<JLDragCardDelegate>
@property (strong, nonatomic)  NSMutableArray *allCards;
@property (assign, nonatomic) CGPoint lastCardCenter;
@property (assign, nonatomic) CGAffineTransform lastCardTransform;
@property (strong, nonatomic) NSMutableArray *sourceObject;
@property (nonatomic, assign) CGFloat lat,lng;
@property (nonatomic, strong) UIButton *refreshBtn;
@end

@implementation DZHomeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationChange:) name:@"locationChange" object:nil];
    // Do any additional setup after loading the view.
    self.allCards = [NSMutableArray array];
    self.sourceObject = [NSMutableArray array];

    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点击刷新" forState:UIControlStateNormal];
    [btn setTitleColor:dzRgba(0, 0, 0, 0.3) forState:UIControlStateNormal];
    btn.frame=CGRectMake(0, 200, dzScreen_width, dzScreen_height-400);
    btn.titleLabel.font=dzFont(25);
    [btn addTarget:self action:@selector(btnRefresh) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.refreshBtn=btn;
//    self.refreshBtn.hidden=YES;
    
    [self addCards];
    [self getLocation];
}

- (void)locationChange:(NSNotification *)noti {
    CLLocation *location = (CLLocation *)noti.object;
    self.lat=location.coordinate.latitude;
    self.lng=location.coordinate.longitude;
    [self getData:YES];
}

-(void)btnRefresh{
    [self getData:YES];
}
-(void)getLocation{
    // 封装方法 开启定位
    dzWeakSelf(self);
    [[SYCLLocation shareLocation] locationStart:^(CLLocation *location, CLPlacemark *placemark) {
        weakself.lat=location.coordinate.latitude;
        weakself.lng=location.coordinate.longitude;
        [weakself getData:YES];

        /*
        NSString *name = placemark.name;
        NSString *thoroughfare = placemark.thoroughfare;
        NSString *subThoroughfare = placemark.subThoroughfare;
        NSString *subLocality = placemark.subLocality;
        NSString *administrativeArea = placemark.administrativeArea;
        NSString *subAdministrativeArea = placemark.subAdministrativeArea;
        NSString *postalCode = placemark.postalCode;
        NSString *ISOcountryCode = placemark.ISOcountryCode;
        NSString *country = placemark.country;
        NSString *inlandWater = placemark.inlandWater;
        NSString *ocean = placemark.ocean;
        NSArray *areasOfInterest = placemark.areasOfInterest;
        // 获取城市
        NSString *city = placemark.locality;
        if (!city){
            // 四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
            city = placemark.administrativeArea;
        }
        
        NSMutableString *text = [[NSMutableString alloc] initWithFormat:@"纬度=%f，经度=%f\n", location.coordinate.latitude, location.coordinate.longitude];
        [text appendFormat:@"city=%@\n", city];
        [text appendFormat:@"name=%@\n", name];
        [text appendFormat:@"thoroughfare=%@\n", thoroughfare];
        [text appendFormat:@"subThoroughfare=%@\n", subThoroughfare];
        [text appendFormat:@"subLocality=%@\n", subLocality];
        [text appendFormat:@"administrativeArea=%@\n", administrativeArea];
        [text appendFormat:@"subAdministrativeArea=%@\n", subAdministrativeArea];
        [text appendFormat:@"postalCode=%@\n", postalCode];
        [text appendFormat:@"ISOcountryCode=%@\n", ISOcountryCode];
        [text appendFormat:@"country=%@\n", country];
        [text appendFormat:@"inlandWater=%@\n", inlandWater];
        [text appendFormat:@"inlandWater=%@\n", inlandWater];
        [text appendFormat:@"ocean=%@\n", ocean];
        [text appendFormat:@"areasOfInterest=%@\n", areasOfInterest];
        NSLog(@"%@",text);
         */
    } faile:^(NSError *error) {
        weakself.lat=0;
        weakself.lng=0;
        [weakself getData:YES];
    }];
}
-(void)getData:(BOOL)isLoading{
    dzWeakSelf(self);
    [DZNetwork post_ph:post_recommendList np:@{@"accountId":@([NSString accountId]),@"startIndex":@(0),@"count":@(100),@"longitude":@(self.lng),@"latitude":@(self.lat)} class:[DZHomeListModel class] success:^(DZHomeListModel *data) {
        NSLog(@"%@",data);
        if (data.resultCode==0) {
            [weakself.sourceObject addObjectsFromArray:data.list];
            [self requestSourceData:isLoading];
        }else{
            [DZNetwork hintNetwork:data.desc];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 首次添加卡片
-(void)addCards{
    CGFloat crfd_h=dzScreen_height-dzNavigationBarH-30;
    
    CGFloat width;
    CGFloat height;
    if ((self.view.frame.size.width-10)*1.5+120<=crfd_h) {
//        width=(self.view.frame.size.width-10);
        height=(self.view.frame.size.width-10)*1.5+120;
    }else{
//        width=(crfd_h-100)/1.5;
        height=crfd_h;
    }
    width = dzScreen_width - 20;
    
    for (int i = 0; i<CARD_NUM; i++) {
        JLDragCardView *draggableView = [[JLDragCardView alloc]initWithFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width+CARD_WIDTH, 10, width, height)];
        draggableView.backgroundColor=[UIColor clearColor];
        if (i>0&&i<CARD_NUM-1) {
            draggableView.transform=CGAffineTransformScale(draggableView.transform, pow(CARD_SCALE, i), pow(CARD_SCALE, i));
        }else if(i==CARD_NUM-1){
            draggableView.transform=CGAffineTransformScale(draggableView.transform, pow(CARD_SCALE, i-1), pow(CARD_SCALE, i-1));
        }
        draggableView.transform = CGAffineTransformMakeRotation(ROTATION_ANGLE);
        draggableView.delegate = self;
        
        [_allCards addObject:draggableView];
        if (i==0) {
            draggableView.canPan=YES;
        }else{
            draggableView.canPan=NO;
        }
    }
    for (int i=(int)CARD_NUM-1; i>=0; i--){
        [self.view addSubview:_allCards[i]];
    }
}
#pragma mark - 滑动后续操作
-(void)swipCard:(JLDragCardView *)cardView Direction:(BOOL)isRight {
    if (isRight) {
//        [self like:cardView.infoDict];
        [self like:cardView.homeListM];
    }else{
//        [self unlike:cardView.infoDict];
        [self unlike:cardView.homeListM];
    }
    [_allCards removeObject:cardView];
    cardView.transform = self.lastCardTransform;
    cardView.center = self.lastCardCenter;
    cardView.canPan=NO;
    [self.view insertSubview:cardView belowSubview:[_allCards lastObject]];
    [_allCards addObject:cardView];
    
    if ([self.sourceObject firstObject]!=nil) {
        cardView.homeListM=[self.sourceObject firstObject];

//        cardView.infoDict=[self.sourceObject firstObject];
        [self.sourceObject removeObjectAtIndex:0];
        [cardView layoutSubviews];
        if (self.sourceObject.count<MIN_INFO_NUM) {
//            [self requestSourceData:NO];
            [self getData:NO];
        }
    }else{
        cardView.hidden=YES;//如果没有数据则隐藏卡片
        for (UIView *vi in self.view.subviews) {
            if ([vi isKindOfClass:[JLDragCardView class]]) {
                [vi removeFromSuperview];
            }
        }
        [self.view layoutSubviews];
    }
    for (int i = 0; i<CARD_NUM; i++) {
        JLDragCardView*draggableView=[_allCards objectAtIndex:i];
        draggableView.originalCenter=draggableView.center;
        draggableView.originalTransform=draggableView.transform;
        if (i==0) {
            draggableView.canPan=YES;
        }
    }
}
#pragma mark - 滑动中更改其他卡片位置
-(void)moveCards:(CGFloat)distance{
    
    if (fabs(distance)<=PAN_DISTANCE) {
        for (int i = 1; i<CARD_NUM-1; i++) {
            JLDragCardView *draggableView=_allCards[i];
            JLDragCardView *preDraggableView=[_allCards objectAtIndex:i-1];
            
            draggableView.transform=CGAffineTransformScale(draggableView.originalTransform, 1+(1/CARD_SCALE-1)*fabs(distance/PAN_DISTANCE)*0.6, 1+(1/CARD_SCALE-1)*fabs(distance/PAN_DISTANCE)*0.6);//0.6为缩减因数，使放大速度始终小于卡片移动速度
            
            CGPoint center=draggableView.center;
            center.y=draggableView.originalCenter.y-(draggableView.originalCenter.y-preDraggableView.originalCenter.y)*fabs(distance/PAN_DISTANCE)*0.6;//此处的0.6同上
            draggableView.center=center;
        }
    }
}

#pragma mark - 滑动终止后复原其他卡片
-(void)moveBackCards{
    for (int i = 1; i<CARD_NUM-1; i++) {
        JLDragCardView *draggableView=_allCards[i];
        [UIView animateWithDuration:RESET_ANIMATION_TIME
                         animations:^{
                             draggableView.transform=draggableView.originalTransform;
                             draggableView.center=draggableView.originalCenter;
                         }];
    }
}

#pragma mark - 滑动后调整其他卡片位置
-(void)adjustOtherCards{
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         for (int i = 1; i<CARD_NUM-1; i++) {
                             JLDragCardView *draggableView=_allCards[i];
                             JLDragCardView *preDraggableView=[_allCards objectAtIndex:i-1];
                             draggableView.transform=preDraggableView.originalTransform;
                             draggableView.center=preDraggableView.originalCenter;
                         }
                     }completion:^(BOOL complete){
                     }];
    
}
#pragma mark - 点击进入详情
-(void)clickImage:(NSInteger)imageId{
    DZInfoViewController *dz_I_VC=[DZInfoViewController new];
    dz_I_VC.isEdit=NO;
    dz_I_VC.userId=imageId;
    [self.navigationController pushViewController:dz_I_VC animated:YES];
}
#pragma mark - 喜欢
-(void)like:(DZHomeList*)userInfo{
//-(void)like:(NSDictionary*)userInfo{
    /*
     在此添加“喜欢”的后续操作
     */
    NSLog(@"like:%ld",(long)userInfo.id);
    NSLog(@"%d",[NSObject addIsLike:YES andQqId:(long)userInfo.id]);
//    NSLog(@"like:%@",userInfo[@"number"]);
}

#pragma mark - 不喜欢
-(void)unlike:(DZHomeList*)userInfo{

//-(void)unlike:(NSDictionary*)userInfo{
    
    /*
     在此添加“不喜欢”的后续操作
     */
    NSLog(@"unlike:%ld",(long)userInfo.id);
    NSLog(@"%d",[NSObject addIsLike:NO andQqId:(long)userInfo.id]);
//    NSLog(@"unlike:%@",userInfo[@"number"]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 请求数据
-(void)requestSourceData:(BOOL)needLoad{
    
    /*
     在此添加网络数据请求代码
     */
    
//    NSMutableArray *objectArray = [@[] mutableCopy];
//    for (int i = 1; i<=10; i++) {
//        [objectArray addObject:@{@"number":[NSString stringWithFormat:@"%d",i],@"image":[NSString stringWithFormat:@"%d.jpeg",i]}];
//    }
//
//    [self.sourceObject addObjectsFromArray:objectArray];
    //    self.page++;
    
    //如果只是补充数据则不需要重新load卡片，而若是刷新卡片组则需要重新load
    if (needLoad) {
        [self loadAllCards];
    }
    
}

#pragma mark - 重新加载卡片
-(void)loadAllCards{
    for (int i=0; i<self.allCards.count; i++) {
        JLDragCardView *draggableView=self.allCards[i];
        if ([self.sourceObject firstObject]) {
            draggableView.homeListM=[self.sourceObject firstObject];
//            draggableView.infoDict=[self.sourceObject firstObject];
            [self.sourceObject removeObjectAtIndex:0];
            [draggableView layoutSubviews];
            draggableView.hidden=NO;
        }else{
            draggableView.hidden=YES;//如果没有数据则隐藏卡片
        }
    }
    CGFloat crfd_h=dzScreen_height-dzNavigationBarH-20;

    for (int i=0; i<_allCards.count ;i++) {
        
        JLDragCardView *draggableView=self.allCards[i];
        
        CGPoint finishPoint = CGPointMake(self.view.center.x, crfd_h/2 + dzNavigationBarH+10);
        
        [UIView animateKeyframesWithDuration:0.5 delay:0.06*i options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            
            draggableView.center = finishPoint;
            draggableView.transform = CGAffineTransformMakeRotation(0);
            
            if (i>0&&i<CARD_NUM-1) {
                JLDragCardView *preDraggableView=[_allCards objectAtIndex:i-1];
                draggableView.transform=CGAffineTransformScale(draggableView.transform, pow(CARD_SCALE, i), pow(CARD_SCALE, i));
                /************删除************/
                CGRect frame=draggableView.frame;
                frame.origin.y=preDraggableView.frame.origin.y+(preDraggableView.frame.size.height-frame.size.height);//+10*pow(0.7,i);
                draggableView.frame=frame;
                /************************/
            }else if (i==CARD_NUM-1) {
                JLDragCardView *preDraggableView=[_allCards objectAtIndex:i-1];
                draggableView.transform=preDraggableView.transform;
                draggableView.frame=preDraggableView.frame;
            }
        } completion:^(BOOL finished) {
            
        }];
        
        draggableView.originalCenter=draggableView.center;
        draggableView.originalTransform=draggableView.transform;
        
        if (i==CARD_NUM-1) {
            self.lastCardCenter=draggableView.center;
            self.lastCardTransform=draggableView.transform;
        }
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
