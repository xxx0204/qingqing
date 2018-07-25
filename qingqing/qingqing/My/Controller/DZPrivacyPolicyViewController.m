//
//  DZPrivacyPolicyViewController.m
//  qingqing
//
//  Created by Gavin on 2018/7/5.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZPrivacyPolicyViewController.h"
#import "DZWhetherExpandScopeTableViewCell.h"
#import "LJContactManager.h"
#import "LJPerson.h"
#import <RongIMKit/RongIMKit.h>

@interface DZPrivacyPolicyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)NSMutableArray *dataArray,*addressBookArray;
@end

@implementation DZPrivacyPolicyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"隐私和通知";
    self.dataArray=[@[@{@"title":@"屏蔽手机联系人",@"isSelect":@(YES)},@{@"title":@"显示消息",@"isSelect":@(NO)},@{@"title":@"震动",@"isSelect":@(YES)}] mutableCopy];

    [self.view addSubview:self.tableV];
}
-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0,0, dzScreen_width, dzScreen_height)];
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.backgroundColor=[UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.delegate = self;
        _tableV.dataSource = self;
    }
    return _tableV;
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;//5;
    }
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
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
        label.text=@"联系人";
    }else{
        label.text=@"推送通知";
    }
    [bgView addSubview:label];
    return bgView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        DZWhetherExpandScopeTableViewCell *cell = [DZWhetherExpandScopeTableViewCell cellWithTableView:tableView];
    if (indexPath.section==0) {
        cell.titleL.text=self.dataArray[0][@"title"];
        cell.swich.on=self.isShieldAddressBook;
    }else{
        cell.titleL.text=self.dataArray[indexPath.row+1][@"title"];
        if (indexPath.row==0) {
            cell.swich.on=[[RCIM sharedRCIM] disableMessageNotificaiton];
        }else if (indexPath.row==1){
            cell.swich.on=[[RCIM sharedRCIM] disableMessageAlertSound];
        }else{
            cell.swich.on=NO;
        }
    }
    dzWeakSelf(self);
    cell.swichBlock = ^(UISwitch *swich) {
        if (indexPath.section==0&&indexPath.row==0) {
            [weakself getAddressBook:swich.on];
        }else if (indexPath.section==1){
            if (indexPath.row==0) {
                [[RCIM sharedRCIM] setDisableMessageNotificaiton:swich.on];
            }else if (indexPath.row==1){
                [[RCIM sharedRCIM] setDisableMessageAlertSound:swich.on];
            }
        }
        
    };
        return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)getAddressBook:(BOOL)isSelect{
    dzWeakSelf(self);
    if (isSelect) {
        self.addressBookArray=[[NSMutableArray alloc] init];
        [[LJContactManager sharedInstance] accessContactsComplection:^(BOOL succeed, NSArray *datas) {
            for (LJPerson *person in datas){
                for (LJPhone *model in person.phones){
                    [weakself.addressBookArray addObject:model.phone];
                }
            }
            NSLog(@"%@",weakself.addressBookArray);
            
            [DZNetwork post_ph:post_setShieldPhone np:@{@"phoneArray":weakself.addressBookArray} class:nil success:^(id data) {
                NSLog(@"%@",data);
                if ([data[@"resultCode"] integerValue]==0) {
                    if (weakself.isAddressBookBlock) {
                        weakself.isAddressBookBlock(YES);
                    }
                    [DZNetwork hintNetwork:@"设置成功"];
                    weakself.isShieldAddressBook=YES;
                    [weakself.tableV reloadData];
                }else{
                    [DZNetwork hintNetwork:data[@"desc"]];
                }
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
        }];
    }else{
        [DZNetwork post_ph:post_getEditorInfo np:@{@"account":@{@"shieldPhone":@(NO)}} class:nil success:^(id data) {
            if ([data[@"resultCode"] integerValue]==0) {
                if (weakself.isAddressBookBlock) {
                    weakself.isAddressBookBlock(NO);
                }
                [DZNetwork hintNetwork:@"设置成功"];
                weakself.isShieldAddressBook=NO;
                [weakself.tableV reloadData];
            }else{
                [DZNetwork hintNetwork:[NSString getNullStr:data[@"desc"]]];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
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
