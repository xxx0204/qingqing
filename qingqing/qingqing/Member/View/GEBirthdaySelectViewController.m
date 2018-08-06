//
//  GEBirthdaySelectViewController.m
//  gocen
//
//  Created by Gavin on 2017/9/14.
//  Copyright © 2017年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "GEBirthdaySelectViewController.h"

@interface GEBirthdaySelectViewController ()
@property(nonatomic,strong)UIDatePicker *datePicker;
@property(nonatomic,strong)UIView *pickerBgView;
@property(nonatomic,copy)NSString *birthdayStr;
@end

@implementation GEBirthdaySelectViewController

- (void)showPullDownVC{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window.rootViewController addChildViewController:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=dzRGBA(139, 139, 139,0.5);
    
    self.pickerBgView=[[UIView alloc]init];
    self.pickerBgView.frame=CGRectMake(0, dzScreen_height, dzScreen_width, 260);
    self.pickerBgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.pickerBgView];
    [UIView animateWithDuration:0.25 animations:^{
        self.pickerBgView.frame=CGRectMake(0, dzScreen_height-260, dzScreen_width, self.pickerBgView.height);
    }];
    [self initPicker];
}
-(void)initPicker{
    UIToolbar *actionToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, dzScreen_width, 44)];
    [actionToolbar sizeToFit];
    UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc]initWithTitle:@"  取消" style:UIBarButtonItemStylePlain target:self action:@selector(pickerCancelClicked:)];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"确定  " style:UIBarButtonItemStylePlain target:self action:@selector(pickerDoneClicked:)];
    [actionToolbar setItems:[NSArray arrayWithObjects:cancelButton,flexSpace,doneBtn, nil] animated:YES];
//    [self.pickerBgView addSubview:self.datePicker];
    [self.pickerBgView addSubview:actionToolbar];
    
    UILabel *titleL=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,dzScreen_width,44)];
    titleL.textAlignment=NSTextAlignmentCenter;
    titleL.text=@"选择出生日期";
    [actionToolbar addSubview:titleL];
    
    
    //UIDatePicker初始化
    self.datePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0,44, dzScreen_width, 216)];
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];//选择date的显示模式
    [self.datePicker setMaximumDate:[NSDate date]];//设置最大日期值
    //设置最小日期值
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSTimeInterval  oneDay = 24*60*60*(365*18+5);  //至今满18岁的日期 +5为闰年数
    NSDate*nowDate = [NSDate date];
    NSDate* maxDate = [nowDate initWithTimeIntervalSinceNow:-oneDay];
    
    NSDate *minDate = [dateFormatter dateFromString:@"1900-01-01"];
    [self.datePicker setMinimumDate:minDate];
    [self.datePicker setMaximumDate:maxDate];
    //设置时区
//    NSLocale *locale=[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
//    [self.datePicker setLocale:locale];
    ////当值发生改变的时候调用的方法
    [self.datePicker addTarget:self action:@selector(datePickerDateChanged:) forControlEvents:UIControlEventValueChanged];
    [self.pickerBgView addSubview:self.datePicker];
    
    [self getBirthday];

}
//date改变的代理事件
- (void) datePickerDateChanged:(UIDatePicker *)paramDatePicker{
    if ([paramDatePicker isEqual:self.datePicker]){
        [self getBirthday];
    }
}
-(void)getBirthday{
    NSDate *selected = [self.datePicker date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    self.birthdayStr=[dateFormat stringFromDate:selected];
    //计算年龄
    //        NSTimeInterval dateDiff = [selected timeIntervalSinceNow];
    //        int age=-1 * trunc(dateDiff/(60*60*24))/365;
}
-(void)pickerCancelClicked:(UIBarButtonItem*)barButton
{
    [self deleteIscelect:NO];
}
-(void)pickerDoneClicked:(UIBarButtonItem*)barButton{
    [self deleteIscelect:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self deleteIscelect:NO];
}
-(void)deleteIscelect:(BOOL)isCelect{
    if (self.selectBlock) {
        self.selectBlock(isCelect,self.birthdayStr);
    }
    [UIView animateWithDuration:0.25 animations:^{
        //480 是屏幕尺寸
        self.pickerBgView.frame=CGRectMake(0, dzScreen_height, dzScreen_width, self.pickerBgView.height);
    } completion:^(BOOL finished) {
        [self.pickerBgView removeFromSuperview];
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
