//
//  DZLocationCityViewController.m
//  qingqing
//
//  Created by Gavin on 2018/7/5.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZLocationCityViewController.h"
#import "DZLocationCityTableViewCell.h"
//定位
#import "SYCLLocation.h"

@interface DZLocationCityViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)NSString *locationS;
@end

@implementation DZLocationCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"位置";
    [self getLocation];
    [self.view addSubview:self.tableV];
}
-(void)getLocation{
    // 封装方法 开启定位
    dzWeakSelf(self);
    self.locationS=@"获取中...";
    [[SYCLLocation shareLocation] locationStart:^(CLLocation *location, CLPlacemark *placemark) {
        NSString *administrativeArea = placemark.administrativeArea;
        NSString *cityStr=placemark.locality;
        if (!administrativeArea) {
            administrativeArea=placemark.locality;
            cityStr=placemark.subLocality;
        }
        weakself.locationS=[NSString stringWithFormat:@"%@ %@ %@",placemark.country,administrativeArea,cityStr];
        [weakself.tableV reloadData];
    } faile:^(NSError *error) {
        weakself.locationS=@"获取失败";
        [weakself.tableV reloadData];
    }];
}
-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0,0, dzScreen_width, dzScreen_height)];
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.backgroundColor=DZColorFromRGB(0xF5F4F5);
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.delegate = self;
        _tableV.dataSource = self;
    }
    return _tableV;
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView=[[UIView alloc]init];
    bgView.frame=CGRectMake(0, 0, dzScreen_width, 30);
    bgView.backgroundColor=DZColorFromRGB(0xF5F4F5);
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(15, 0, dzScreen_width-30, bgView.height);
    label.font=dzFont(14);
    label.textColor=DZColorFromRGB(0x979797);
    label.text=@"我的当前位置";
    [bgView addSubview:label];
    return bgView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DZLocationCityTableViewCell *cell = [DZLocationCityTableViewCell cellWithTableView:tableView];
    cell.infopL.text=self.locationS;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
