//
//  DZFAQsViewController.m
//  qingqing
//
//  Created by Gavin on 2018/6/24.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZFAQsViewController.h"
#import "DZInfoEditOneTableViewCell.h"
#import "DZFAQsTwoViewController.h"
#import "DZInfoModel.h"

@interface DZFAQsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation DZFAQsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"选择一个问题";
    [self getInfoList:10];
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
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        DZInfoEditOneTableViewCell *cell = [DZInfoEditOneTableViewCell cellWithTableView:tableView];
        cell.infoModel=self.dataArray[indexPath.row];
        return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    dzWeakSelf(self);
    DZInfoOptionlistModel *model=self.dataArray[indexPath.row];
    DZFAQsTwoViewController *dz_QT_VC=[[DZFAQsTwoViewController alloc] init];
    dz_QT_VC.lengthS=60;
    dz_QT_VC.questionS=model.content;
    dz_QT_VC.questionCodeS=model.id;
    dz_QT_VC.FAQsBlock = ^(NSString *questionS, NSString *answer, NSInteger questionCodeS) {
        if (weakself.FAQsBlock) {
            weakself.FAQsBlock(questionS, answer, questionCodeS);
        }
    };
    [self.navigationController pushViewController:dz_QT_VC animated:YES];
}
-(void)getInfoList:(NSInteger)tag{
    dzWeakSelf(self);
    [DZNetwork post_ph:post_getInfoList np:@{@"optionType":@(tag)} class:[DZInfoListModel class] success:^(DZInfoListModel *data) {
        if (data.resultCode==0) {
            weakself.dataArray=[NSMutableArray arrayWithArray:data.optionList];
            for (int i=0; i<weakself.dataArray.count; i++) {
                DZInfoOptionlistModel *model=weakself.dataArray[i];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"questionCode == %@",@(model.id)];
                NSArray *filteredArray = [weakself.currentArray filteredArrayUsingPredicate:predicate];
                NSLog(@"%@",filteredArray);
                if (filteredArray.count>0) {
                    [weakself.dataArray removeObjectAtIndex:i];
                }
            }
            [weakself.tableV reloadData];
        }else{
            [DZNetwork hintNetwork:data.desc];
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
