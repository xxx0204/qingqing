//
//  DZAccountSafetyViewController.m
//  qingqing
//
//  Created by Gavin on 2018/7/6.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZAccountSafetyViewController.h"
#import "DZSexTableViewCell.h"
#import "DZSetNewPasswordViewController.h"

@interface DZAccountSafetyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableV;

@end

@implementation DZAccountSafetyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"账号和安全";
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
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
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
    label.text=@"账户详情";
    [bgView addSubview:label];
    return bgView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    DKWeakSelf(self);
    
        DZSexTableViewCell *cell = [DZSexTableViewCell cellWithTableView:tableView];
    if (indexPath.row==0) {
        cell.titleL.text=@"手机号码";
        if ([[NSString memberAccount] length]>7) {
            cell.describeL.text=[NSString stringWithFormat:@"+86 %@-%@-%@",[[NSString memberAccount] substringToIndex:3],[[NSString memberAccount] substringWithRange:NSMakeRange(3, 4)],[[NSString memberAccount] substringFromIndex:7]];
        }else{
            cell.describeL.text=[NSString stringWithFormat:@"+86 %@",[NSString memberAccount]];
        }
    }else{
        cell.titleL.text=@"修改密码";
        cell.describeL.text=@"";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==1) {
        DZSetNewPasswordViewController *dz_snp_vc=[DZSetNewPasswordViewController new];
        [self.navigationController pushViewController:dz_snp_vc animated:YES];
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
