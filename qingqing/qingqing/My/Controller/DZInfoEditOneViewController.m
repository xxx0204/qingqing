//
//  DZInfoEditOneViewController.m
//  qingqing
//
//  Created by Gavin on 2018/6/23.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZInfoEditOneViewController.h"
#import "DZInfoEditOneTableViewCell.h"
#import "DZInfoEditOneAddTableViewCell.h"
#import "DZInfoEditTwoViewController.h"

@interface DZInfoEditOneViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation DZInfoEditOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.type==1) {
        switch (self.row) {
            case 0:{
                self.title=@"行业";
                [self getInfoList:11];
            }
                break;
            case 1:{
                self.title=@"工作领域";
                [self getInfoList:12];
            }
                break;
            case 2:{
                self.title=@"来自";
            }
                break;
            default:
                break;
        }
    }else if (self.type==2){
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
        
        [self getInfoList:self.row];
        switch (self.row) {
            case 1:{
                self.title=@"标签";
            }
                break;
            case 2:{
                self.title=@"旅行";
            }
                break;
            case 3:{
                self.title=@"电影";
            }
                break;
            case 4:{
                self.title=@"音乐";
            }
                break;
            case 5:{
                self.title=@"运动";
            }
                break;
            case 6:{
                self.title=@"食物";
            }
                break;
            default:
                break;
        }
    }
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
    return self.dataArray.count+1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        DZInfoEditOneAddTableViewCell *cell = [DZInfoEditOneAddTableViewCell cellWithTableView:tableView];
        return cell;
    }else{
        DZInfoEditOneTableViewCell *cell = [DZInfoEditOneTableViewCell cellWithTableView:tableView];
        cell.selectedArray=self.selectedArray;
        cell.infoModel=self.dataArray[indexPath.row-1];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        DZInfoEditTwoViewController *dz_IEO_VC=[[DZInfoEditTwoViewController alloc] init];
        dz_IEO_VC.type=self.type;
        dz_IEO_VC.row=self.row;
        dz_IEO_VC.lengthS=15;
        dzWeakSelf(self);
        dz_IEO_VC.type1Block = ^(NSString *titleS, NSString *desS) {
            if (weakself.type1Block) {
                weakself.type1Block(titleS, desS);
            }
        };
        dz_IEO_VC.type2Block = ^(NSString *desS) {
            BOOL isbool = NO;
            for (int i=0; i<self.dataArray.count; i++) {
                DZInfoOptionlistModel *listModel=self.dataArray[i];
                if ([listModel.content isEqualToString:desS]) {
                    isbool=YES;
                    if (![self.selectedArray containsObject:desS]) {
                        [self.selectedArray addObject:desS];
                    }
                    break;
                }
            }
            if (!isbool) {
                DZInfoOptionlistModel *model=[[DZInfoOptionlistModel alloc] init];
                model.content=desS;
                [self.dataArray addObject:model];
                [self.selectedArray addObject:desS];
            }
            [self.tableV reloadData];
        };
        [self.navigationController pushViewController:dz_IEO_VC animated:YES];
    }else{
        if (self.type==1) {
            [self editorInfo:indexPath.row];
        }else if (self.type==2){
            DZInfoOptionlistModel *model=self.dataArray[indexPath.row-1];
            BOOL isbool = [self.selectedArray containsObject:model.content];
            if (isbool) {
                [self.selectedArray removeObject:model.content];
            }else{
                [self.selectedArray addObject:model.content];
            }
            [self.tableV reloadData];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)moreBtnClick{
    NSLog(@"%@",self.selectedArray);
    dzWeakSelf(self);
    NSString *string = [self.selectedArray componentsJoinedByString:@" "];
    [DZNetwork post_ph:post_editorLabel np:@{@"flag":@{@"flagType":@(self.row),@"flagContent":[NSString getNullStr:string]}} class:nil success:^(id data) {
        if ([data[@"resultCode"] integerValue]==0) {
            if (weakself.type2Block) {
                weakself.type2Block(weakself.row, string);
            }
            [weakself.navigationController popViewControllerAnimated:YES];
        }else{
            [DZNetwork hintNetwork:data[@"desc"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)getInfoList:(NSInteger)tag{
    dzWeakSelf(self);
    [DZNetwork post_ph:post_getInfoList np:@{@"optionType":@(tag)} class:[DZInfoListModel class] success:^(DZInfoListModel *data) {
        if (data.resultCode==0) {
            weakself.dataArray=[NSMutableArray arrayWithArray:data.optionList];
            for (int i=0; i<weakself.dataArray.count; i++) {
                DZInfoOptionlistModel *mode=weakself.dataArray[i];
                if ( [mode.content isEqualToString:@""]) {
                    [weakself.dataArray removeObject:mode];
                };
            }
            [weakself.tableV reloadData];
//            [weakself.tableV reloadData];
        }else{
            [DZNetwork hintNetwork:data.desc];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)editorInfo:(NSInteger)tag{
    dzWeakSelf(self);
    NSDictionary *dic=@{};
    DZInfoOptionlistModel *model=self.dataArray[tag-1];
    NSString *titleS=@"";
    if (self.type==1) {
        switch (self.row) {
            case 0:{
                titleS=@"行业";
                dic=@{@"industry":model.content};
            }
                break;
            case 1:{
                titleS=@"工作领域";
                dic=@{@"profession":model.content};
            }
                break;
            case 2:{
                titleS=@"来自";
                dic=@{@"city":model.content};
            }
                break;
            default:
                break;
        }
    }
    [DZNetwork post_ph:post_getEditorInfo np:@{@"account":dic} class:nil success:^(id data) {
        if ([data[@"resultCode"] integerValue]==0) {
            if (weakself.type1Block) {
                weakself.type1Block(titleS, model.content);
            }
            [weakself.navigationController popViewControllerAnimated:YES];
        }else{
            [DZNetwork hintNetwork:[NSString getNullStr:data[@"desc"]]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
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
