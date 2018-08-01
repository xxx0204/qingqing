//
//  DZEditBasicInfoViewController.m
//  qingqing
//
//  Created by Gavin on 2018/6/24.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZEditBasicInfoViewController.h"
#import <TPKeyboardAvoidingTableView.h>
#import "DZEditBasicInfoTableViewCell.h"
#import "GEBirthdaySelectViewController.h"
#define NICK_NAME_LENGTH 11
@interface DZEditBasicInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)TPKeyboardAvoidingTableView *tableV;
@property(nonatomic,strong)NSString *showBirthdayS;
@end

@implementation DZEditBasicInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"个人信息";
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -20;
    
    UIButton *rightBtn = [[UIButton alloc] init];
    rightBtn.tag=1;
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:DZColorFromRGB(0x979797) forState:UIControlStateNormal];
    // 设置按钮的尺寸为背景图片的尺寸
    rightBtn.frame = CGRectMake(0, 0, 50, 44);
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    //    self.navigationItem.rightBarButtonItem = backButton;
    self.navigationItem.rightBarButtonItems=@[negativeSpacer,rightButton];
    if ([self.birthdayS rangeOfString:@"-"].location!=NSNotFound) {
    }else{
        self.birthdayS=[NSString getTimestamp:[self.birthdayS doubleValue]];
    }
    self.showBirthdayS=[NSString timeIntoTimeOne:self.birthdayS];
    
    [self.view addSubview:self.tableV];
}
-(void)moreBtnClick{
    if (self.nicknameS.length!=0&&self.birthdayS!=0&&self.sexS.length!=0) {
        dzWeakSelf(self);
        [DZNetwork post_ph:post_getEditorInfo np:@{@"account":@{@"birthDate":self.birthdayS,@"sex":[self.sexS isEqualToString:@"男"] ? @(1):@(2),@"nickname":self.nicknameS}} class:nil success:^(id data) {
            if ([data[@"resultCode"] integerValue]==0) {
                if (weakself.editBasicInfoBlock) {
                    weakself.editBasicInfoBlock(weakself.nicknameS, weakself.birthdayS, weakself.sexS);
                }
                [weakself.navigationController popViewControllerAnimated:YES];
            }else{
                [DZNetwork hintNetwork:[NSString getNullStr:data[@"desc"]]];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}
-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectMake(0,0, dzScreen_width, dzScreen_height)];
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
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        DZEditBasicInfoTableViewCell *cell = [DZEditBasicInfoTableViewCell cellWithTableView:tableView];
    if (indexPath.row==1) {
        cell.nicknameTF.text=self.nicknameS;
        cell.nicknameTF.hidden=NO;
        cell.desL.hidden=YES;
        cell.titleL.text=@"昵称";
    }else{
        if (indexPath.row==0) {
            cell.titleL.text=@"性别";
        }else{
            cell.titleL.text=@"生日";
        }
        cell.nicknameTF.text=@"";
        cell.nicknameTF.hidden=YES;
        cell.desL.hidden=NO;
        if (indexPath.row==0) {
            cell.desL.text=self.sexS;
            if (cell.desL.text.length==0) {
                cell.desL.text=@"未填写";
            }
        }else{
            cell.desL.text=self.showBirthdayS;
            if (cell.desL.text.length==0) {
                cell.desL.text=@"00/00/0000";
            }
        }
    }
    dzWeakSelf(self);
    cell.nicknameBlock = ^(NSString *desS) {
        if (!(desS.length > NICK_NAME_LENGTH)) {
            weakself.nicknameS=desS;
        } else {
            weakself.nicknameS=[desS substringToIndex:NICK_NAME_LENGTH];
            [tableView reloadData];
            [EasyTextView showText:[NSString stringWithFormat:@"昵称长度不能超过%ld个字符", NICK_NAME_LENGTH] config:^EasyTextConfig *{
                EasyTextConfig *config = [EasyTextConfig shared];
                config.bgColor = [UIColor lightGrayColor];
                config.shadowColor = [UIColor clearColor];
                config.animationType = TextAnimationTypeFade;
                config.statusType = TextStatusTypeMidden;
                return config;
            }];
        }
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"选择性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        dzWeakSelf(self);
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakself.sexS=@"男";
            [weakself.tableV reloadData];
        }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakself.sexS=@"女";
            [weakself.tableV reloadData];
            
        }];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        //把action添加到actionSheet里
        [actionSheet addAction:action1];
        [actionSheet addAction:action2];
        [actionSheet addAction:action3];
        
        //相当于之前的[actionSheet show];
        //性别不可编辑
//        [self presentViewController:actionSheet animated:YES completion:nil];
    }
    if (indexPath.row==2) {
        dzWeakSelf(self);
        GEBirthdaySelectViewController *geBSVC=[GEBirthdaySelectViewController new];
        geBSVC.selectBlock = ^(BOOL isSelect, NSString *valueStr) {
            if (isSelect) {
                //调接口
                weakself.birthdayS=valueStr;
                weakself.showBirthdayS=[NSString timeIntoTimeOne:valueStr];
                [weakself.tableV reloadData];
            }
        };
        [geBSVC showPullDownVC];
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
