//
//  DZSettingViewController.m
//  qingqing
//
//  Created by Gavin on 2018/5/16.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZSettingViewController.h"
#import "DZSettingTableViewCell.h"
#import "DZPositionTableViewCell.h"
#import "DZApertureRangeTableViewCell.h"
#import "DZAgeTableViewCell.h"
#import "DZLocationCityViewController.h"
#import "DZPrivacyPolicyViewController.h"
#import "DZInfoEditTwoViewController.h"
#import "DZAccountSafetyViewController.h"
#import "DZInfoModel.h"
#import "DZAppDelegate.h"
//定位
#import "SYCLLocation.h"

@interface DZSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)NSArray *iconArray;
@property(nonatomic,strong)NSString *sexS,*locationS;
@property(nonatomic,strong)DZOtherAccounModel *accounModel;
@end

@implementation DZSettingViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [DZNetwork post_ph:post_getEditorInfo np:@{@"account":@{@"maxRecommendRadius":@(self.accounModel.maxRecommendRadius),@"maxRecommendAge":@(self.accounModel.maxRecommendAge),@"minRecommendAge":@(self.accounModel.minRecommendAge)}} class:nil success:^(id data) {
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"设置";
    [self getLocation];
    [self.view addSubview:self.tableV];
    [self getSelfInfo];
    [self getLocation];
//    self.iconArray=@[@{@"title":@"个人信息",@"iconI":@"icon_personage",@"description":@"编辑姓名等"},@{@"title":@"隐私和通知",@"iconI":@"icon_privacy",@"description":@"联系人、我的相册、朋友圈和通知设置"},@{@"title":@"数据和缓存",@"iconI":@"icon_data",@"description":@"数据和缓存设置"},@{@"title":@"账号和安全",@"iconI":@"icon_account",@"description":@"修改手机号和密码"},@{@"title":@"意见和反馈",@"iconI":@"icon_feedback",@"description":@"感谢您提出的宝贵意见"}];
    self.iconArray=@[@{@"title":@"隐私和通知",@"iconI":@"icon_privacy",@"description":@"联系人、我的相册、朋友圈和通知设置"},@{@"title":@"账号和安全",@"iconI":@"icon_account",@"description":@"修改手机号和密码"},@{@"title":@"意见和反馈",@"iconI":@"icon_feedback",@"description":@"感谢您提出的宝贵意见"}];

}
-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0,0, dzScreen_width, dzScreen_height)];
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.backgroundColor=[UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.tableFooterView=[self footerV];
    }
    return _tableV;
}
-(UIView *)footerV{
    UIView *bgView=[[UIView alloc]init];
    bgView.frame=CGRectMake(0, 0, dzScreen_width, 170);
    bgView.backgroundColor=DZColorFromRGB(0xF5F4F5);
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(20, 50, dzScreen_width-40, 60);
    btn.layer.cornerRadius=30;
    btn.layer.borderWidth=2;
    btn.layer.borderColor=DZColorFromRGB(0xFF7388).CGColor;
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    [btn setTitleColor:DZColorFromRGB(0xFF758A) forState:UIControlStateNormal];
    btn.titleLabel.font=dzFont(16);
    [btn addTarget:self action:@selector(quitClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn];
    return bgView;
}
-(void)quitClick{
    [NSString deleteMember];
    DZAppDelegate *appDelegate = (DZAppDelegate *) [[UIApplication sharedApplication] delegate];
    [appDelegate gotoLogin:NO];
}
#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;//5;
    }
    return self.iconArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 60;
        }
//        if (indexPath.row==2) {
//            return 40;
//        }
        return 70;
    }
    return 70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView=[[UIView alloc]init];
    bgView.frame=CGRectMake(0, 0, dzScreen_width, 30);
    bgView.backgroundColor=dzRgba(0.98, 0.98, 0.98, 1);
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(15, 0, dzScreen_width-30, bgView.height);
    label.font=dzFont(14);
    label.textColor=DZColorFromRGB(0x979797);
    if (section==0) {
        label.text=@"向我显示";
    }else{
        label.text=@"应用设置";
    }
    [bgView addSubview:label];
    return bgView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    DKWeakSelf(self);
    dzWeakSelf(self);
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            DZPositionTableViewCell *cell = [DZPositionTableViewCell cellWithTableView:tableView];
            cell.infopL.text=self.locationS;
            return cell;
        }
        if (indexPath.row==1) {
            DZApertureRangeTableViewCell *cell = [DZApertureRangeTableViewCell cellWithTableView:tableView];
            cell.maxDistance=self.accounModel.maxRecommendRadius;
            cell.maxDistanceBlock = ^(CGFloat maxDistance) {
                weakself.accounModel.maxRecommendRadius=maxDistance;
            };
            return cell;
        }
        DZAgeTableViewCell *cell = [DZAgeTableViewCell cellWithTableView:tableView];
        NSInteger minI=self.accounModel.minRecommendAge;
        NSInteger maxI=self.accounModel.maxRecommendAge;
        if (minI==0) {
            minI=18;
        }
        if (maxI==0) {
            maxI=60;
        }
        cell.dict=@{@"min":@(minI),@"max":@(maxI)};
        cell.sliderBlock = ^(CGFloat min, CGFloat max) {
            weakself.accounModel.minRecommendAge=min;
            weakself.accounModel.maxRecommendAge=max;
        };
        return cell;
    }else{
        DZSettingTableViewCell *cell = [DZSettingTableViewCell cellWithTableView:tableView];
        cell.dict=self.iconArray[indexPath.row];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            [self.navigationController pushViewController:[DZLocationCityViewController new] animated:YES];
        }
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            dzWeakSelf(self);
           DZPrivacyPolicyViewController *dz_pp_vc=[DZPrivacyPolicyViewController new];
            dz_pp_vc.isShieldAddressBook=weakself.accounModel.shieldPhone;
            dz_pp_vc.isAddressBookBlock = ^(BOOL isAddressBook) {
                weakself.accounModel.shieldPhone=isAddressBook;
            };
            [self.navigationController pushViewController:dz_pp_vc animated:YES];
        }else if (indexPath.row==1){
            DZAccountSafetyViewController *dz_as_vc=[DZAccountSafetyViewController new];
            [self.navigationController pushViewController:dz_as_vc animated:YES];
        } else if (indexPath.row==2){
            DZInfoEditTwoViewController *dz_IEO_VC=[[DZInfoEditTwoViewController alloc] init];
            dz_IEO_VC.type=3;
            dz_IEO_VC.lengthS=160;
            dz_IEO_VC.type1Block = ^(NSString *titleS, NSString *desS) {
                
            };
            [self.navigationController pushViewController:dz_IEO_VC animated:YES];
        }
    }
}
-(void)getSelfInfo{
    dzWeakSelf(self);
    [DZNetwork post_ph:post_getSelfInfo np:@{@"isLoadFlag":@(NO),@"isLoadPicture":@(NO)} class:nil success:^(id data) {
        if ([data[@"resultCode"] integerValue]==0) {
            weakself.accounModel = [DZOtherAccounModel mj_objectWithKeyValues:data[@"account"]];
            [weakself.tableV reloadData];
        }else{
            [DZNetwork hintNetwork:data[@"desc"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
