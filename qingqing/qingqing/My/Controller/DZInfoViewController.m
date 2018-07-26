//
//  DZInfoViewController.m
//  qingqing
//
//  Created by Gavin on 2018/5/16.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZInfoViewController.h"
#import "DZBasicInfoTableViewCell.h"
#import "DZMyInfoTableViewCell.h"
#import "DZGeneralLabelTableViewCell.h"
#import "DZMyFAQsTableViewCell.h"
#import "DZMoreQuestionTableViewCell.h"
#import "DZInfoEditOneViewController.h"
#import "DZInfoEditTwoViewController.h"
#import "DZEditBasicInfoViewController.h"
#import "DZFAQsViewController.h"
#import "DZFAQsTwoViewController.h"
#import "AliImageReshapeController.h"
#import <SDCycleScrollView.h>
//定位
#import "SYCLLocation.h"
#import "CityListViewController.h"

@interface DZInfoViewController ()<UITableViewDelegate,UITableViewDataSource,ALiImageReshapeDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,SDCycleScrollViewDelegate,CityListViewDelegate>
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)NSMutableArray *infoArray, *labelArray,*interestArray,*FAQsArray;
@property(nonatomic,strong)DZOtherAccounModel *accounModel;
@property(nonatomic,assign)NSInteger headType;
@property(nonatomic,strong)SDCycleScrollView *headScrollView;
@property (nonatomic, assign) CGFloat lat,lng;
@property(nonatomic,strong)NSString *locationS;
@end

@implementation DZInfoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我的";
    
    [self getLocation];
    
    [self.view addSubview:self.tableV];
}
-(void)getLocation{
    // 封装方法 开启定位
    dzWeakSelf(self);
    self.locationS=@"获取失败";
    [[SYCLLocation shareLocation] locationStart:^(CLLocation *location, CLPlacemark *placemark) {
        weakself.lat=location.coordinate.latitude;
        weakself.lng=location.coordinate.longitude;
        weakself.locationS=[NSString getNullStr:placemark.locality];
        [weakself getData];
    } faile:^(NSError *error) {
        weakself.lat=0;
        weakself.lng=0;
        weakself.locationS=@"获取失败";
        [weakself getData];
    }];
}
-(void)getData{
    dzWeakSelf(self);
    [EasyLodingView showLoding];
    if (self.isEdit) {
        [DZNetwork post_ph:post_getSelfInfo np:@{@"isLoadFlag":@(YES),@"isLoadPicture":@(YES),@"longitude":@(self.lng),@"latitude":@(self.lat)} class:nil success:^(id data) {
            [EasyLodingView hidenLoding];
            if ([data[@"resultCode"] integerValue]==0) {
                weakself.accounModel = [DZOtherAccounModel mj_objectWithKeyValues:data[@"account"]];
                weakself.FAQsArray=[NSMutableArray array];
                [weakself.FAQsArray addObjectsFromArray:weakself.accounModel.qaList];
                weakself.infoArray=[NSMutableArray array];
                if (weakself.accounModel.industry.length!=0) {
                    [weakself.infoArray addObject:@{@"title":@"行业",@"description":[NSString getNullStr:weakself.accounModel.industry]}];
                }
                if (weakself.accounModel.profession.length!=0) {
                    [weakself.infoArray addObject:@{@"title":@"工作领域",@"description":[NSString getNullStr:weakself.accounModel.profession]}];
                }
                if (weakself.accounModel.city.length!=0) {
                    [weakself.infoArray addObject:@{@"title":@"来自",@"description":[NSString getNullStr:weakself.accounModel.city]}];
                }
                
                if (weakself.accounModel.oftenIn.length!=0) {
                    [weakself.infoArray addObject:@{@"title":@"经常出没",@"description":[NSString getNullStr:weakself.accounModel.oftenIn]}];
                }
                if (weakself.accounModel.signature.length!=0) {
                    [weakself.infoArray addObject:@{@"title":@"个性签名",@"description":[NSString getNullStr:weakself.accounModel.signature]}];
                }
                weakself.labelArray=[NSMutableArray array];
                weakself.interestArray=[NSMutableArray array];
                for (DZFlagModel *flagM in weakself.accounModel.flagList) {
                    NSMutableArray *typeArr=[[flagM.flagContent componentsSeparatedByString:@" "] mutableCopy];
                    [typeArr removeObject:@""];
                    if (flagM.flagType == 1) {
                        if (typeArr.count!=0) {
                            [weakself.labelArray addObject:@{@"type":@(flagM.flagType),@"label":typeArr}];
                        }
                    }else{
                    if (typeArr.count!=0) {
                        [weakself.interestArray addObject:@{@"type":@(flagM.flagType),@"label":typeArr}];
                    }
                    }
                }
                [weakself refreshViewIsEdit:self.isEdit];

                [weakself.tableV reloadData];
                
            }else{
                [DZNetwork hintNetwork:data[@"desc"]];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            [EasyLodingView hidenLoding];
        }];
    }else{
        [DZNetwork post_ph:post_likeMeList np:@{@"otherAccountIds":@[@(self.userId)],@"longitude":@(self.lng),@"latitude":@(self.lat)} class:[DZInfoModel class] success:^(DZInfoModel *data) {
            [EasyLodingView hidenLoding];
            if (data.resultCode==0) {
                if (data.otherAccountList.count>0) {
                    weakself.accounModel=data.otherAccountList[0];
                    weakself.infoArray=[NSMutableArray array];
                    if (weakself.accounModel.industry.length!=0) {
                        [weakself.infoArray addObject:@{@"title":@"行业",@"description":[NSString getNullStr:weakself.accounModel.industry]}];
                    }
                    if (weakself.accounModel.profession.length!=0) {
                        [weakself.infoArray addObject:@{@"title":@"工作领域",@"description":[NSString getNullStr:weakself.accounModel.profession]}];
                    }
                    if (weakself.accounModel.city.length!=0) {
                        [weakself.infoArray addObject:@{@"title":@"来自",@"description":[NSString getNullStr:weakself.accounModel.city]}];
                    }
                    
                    if (weakself.accounModel.oftenIn.length!=0) {
                        [weakself.infoArray addObject:@{@"title":@"经常出没",@"description":[NSString getNullStr:weakself.accounModel.oftenIn]}];
                    }
                    if (weakself.accounModel.signature.length!=0) {
                        [weakself.infoArray addObject:@{@"title":@"个性签名",@"description":[NSString getNullStr:weakself.accounModel.signature]}];
                    }
                    weakself.labelArray=[NSMutableArray array];
                    weakself.interestArray=[NSMutableArray array];
                    for (DZFlagModel *flagM in weakself.accounModel.flagList) {
                        NSMutableArray *typeArr=[[flagM.flagContent componentsSeparatedByString:@" "] mutableCopy];
                        [typeArr removeObject:@""];
                        if (flagM.flagType == 1) {
                            if (typeArr.count!=0) {
                                [weakself.labelArray addObject:@{@"type":@(flagM.flagType),@"label":typeArr}];
                            }
                        }else{
                            if (typeArr.count!=0) {
                                [weakself.interestArray addObject:@{@"type":@(flagM.flagType),@"label":typeArr}];
                            }
                        }
                    }
                    [weakself refreshViewIsEdit:self.isEdit];
                    [weakself.tableV reloadData];
                }
            }else{
                [DZNetwork hintNetwork:data.desc];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            [EasyLodingView hidenLoding];
        }];
    }
    
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
    if (_isEdit) {
        return 6;
    }
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isEdit) {
        if (section==1) {
            return 5;
        }
        if (section==2) {
            return 1;
        }
        if (section==3) {
            return 5;
        }
    }
    if (section==1) {
        return self.infoArray.count;
    }
    if (section==2) {
        return self.labelArray.count;
    }
    if (section==3) {
        return self.interestArray.count;
    }
    if (section==4) {
        return self.FAQsArray.count;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0||section==5) {
        return 0;
    }
    if (!_isEdit) {
        if (section==1) {
            if (self.infoArray.count==0) {
                return 0;
            }
        }
        if (section==2) {
            if (self.labelArray.count==0) {
                return 0;
            }
        }
        if (section==3) {
            if (self.interestArray.count == 0) {
                return 0;
            }
        }
        if (section==4) {
            if (self.FAQsArray.count == 0) {
                return 0;
            }
        }
    }
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
    if (section==1) {
        label.text=@"我的信息";
    }else if (section==2) {
        label.text=@"我的标签";
    }else if (section==3) {
        label.text=@"我的兴趣";
    }else if (section==4) {
        label.text=@"我的问答";
    }
    [bgView addSubview:label];
    return bgView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        DZBasicInfoTableViewCell *cell = [DZBasicInfoTableViewCell cellWithTableView:tableView];
//        cell.dict=self.infoArray[indexPath.row];
        cell.infoM=self.accounModel;
        cell.isEdit=_isEdit;
        return cell;
    }
    if (indexPath.section==1) {
        DZMyInfoTableViewCell *cell = [DZMyInfoTableViewCell cellWithTableView:tableView];
        cell.isEdit=_isEdit;
        if (_isEdit) {
            cell.indexP=indexPath;
            cell.array=self.infoArray;
        }else{
            cell.dict=self.infoArray[indexPath.row];
        }
        return cell;
    }
    if (indexPath.section==2||indexPath.section==3) {
        DZGeneralLabelTableViewCell *cell = [DZGeneralLabelTableViewCell cellWithTableView:tableView];
        cell.isEdit=_isEdit;
        if (_isEdit) {
            cell.indexP=indexPath;
            if (indexPath.section==2) {
                cell.array=self.labelArray;
            }else{
                cell.array=self.interestArray;
            }
        }else{
        if (indexPath.section==2) {
            cell.dict=self.labelArray[indexPath.row];
        }else{
            cell.dict=self.interestArray[indexPath.row];
        }
        }
        return cell;
    }
    if (indexPath.section==4) {
        DZMyFAQsTableViewCell *cell = [DZMyFAQsTableViewCell cellWithTableView:tableView];
        cell.isEdit=_isEdit;
        cell.model=self.FAQsArray[indexPath.row];
//        cell.dict=self.infoArray[indexPath.row];
        return cell;
    }
    DZMoreQuestionTableViewCell *cell = [DZMoreQuestionTableViewCell cellWithTableView:tableView];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
//        if (_isEdit) {
            return 69;
//        }
//        return 126;
    }
    if (indexPath.section==1) {
        return 44;
    }
    if (indexPath.section==2||indexPath.section==3) {
        if (_isEdit) {
            if (indexPath.section==2) {
                return [DZGeneralLabelTableViewCell hightArray:self.labelArray indexP:indexPath];
            }else{
                return [DZGeneralLabelTableViewCell hightArray:self.interestArray indexP:indexPath];
        }
        }else{
        if (indexPath.section==2) {
            return [DZGeneralLabelTableViewCell hightDic:self.labelArray[indexPath.row]];
        }else{
            return [DZGeneralLabelTableViewCell hightDic:self.interestArray[indexPath.row]];
        }
        }
    }
    if (indexPath.section==4) {
        return [DZMyFAQsTableViewCell hightModel:self.FAQsArray[indexPath.row]];
    }
    return 48;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.isEdit) {
        dzWeakSelf(self);
        if (indexPath.section==0) {
            DZEditBasicInfoViewController *dz_EBI_VC=[[DZEditBasicInfoViewController alloc] init];
            dz_EBI_VC.nicknameS=self.accounModel.nickname;
            dz_EBI_VC.birthdayS=self.accounModel.birthDate;
            dz_EBI_VC.sexS=self.accounModel.sex==1 ? @"男":@"女";
            dz_EBI_VC.editBasicInfoBlock = ^(NSString *nicknameS, NSString *birthdayS, NSString *sexS) {
                weakself.accounModel.nickname=nicknameS;
                weakself.accounModel.birthDate=birthdayS;
                weakself.accounModel.sex=[sexS isEqualToString:@"男"] ? 1:2;
                [weakself.tableV reloadData];
            };
            [self.navigationController pushViewController:dz_EBI_VC animated:YES];
        }
        if (indexPath.section==1) {
            if (indexPath.row<2) {
                NSDictionary *dic=[DZMyInfoTableViewCell addDescription:indexPath array:self.infoArray];
                DZInfoEditOneViewController *dz_IEO_VC=[[DZInfoEditOneViewController alloc] init];
                dz_IEO_VC.type=1;
                dz_IEO_VC.row=indexPath.row;
                dz_IEO_VC.selectedArray=[@[dic[@"des"]] mutableCopy];
                dz_IEO_VC.type1Block = ^(NSString *titleS, NSString *desS) {
                    if (weakself.infoArray.count==0) {
                        [weakself.infoArray addObject:@{@"title":titleS,@"description":desS}];
                        [weakself.tableV reloadData];
                        return;
                    }
                    for (int i=0; i<weakself.infoArray.count; i++) {
                        NSDictionary *dic=weakself.infoArray[i];
                        if ([dic[@"title"] isEqualToString:titleS]) {
                            [weakself.infoArray replaceObjectAtIndex:i withObject:@{@"title":titleS,@"description":desS}];
                            [weakself.tableV reloadData];
                            break;
                        }
                        if (i==weakself.infoArray.count-1) {
                            [weakself.infoArray addObject:@{@"title":titleS,@"description":desS}];
                            [weakself.tableV reloadData];
                        }
                    }
                };
                [self.navigationController pushViewController:dz_IEO_VC animated:YES];
            }else if (indexPath.row==2){
                CityListViewController *cityListView = [[CityListViewController alloc]init];
                cityListView.delegate = self;
                //定位城市列表
                cityListView.arrayLocatingCity   = [NSMutableArray arrayWithObjects:self.locationS, nil];
                [self.navigationController pushViewController:cityListView animated:YES];
            } else{
                //找到对应的cell
                DZMyInfoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                DZInfoEditTwoViewController *dz_IEO_VC=[[DZInfoEditTwoViewController alloc] init];
                dz_IEO_VC.type=1;
                dz_IEO_VC.row=indexPath.row;
                dz_IEO_VC.lengthS=30;
                if (![cell.describeL.text isEqualToString:@"未填写"]) {
                    dz_IEO_VC.textS=cell.describeL.text;
                }
                dz_IEO_VC.type1Block = ^(NSString *titleS, NSString *desS) {
                    if (weakself.infoArray.count==0) {
                        [weakself.infoArray addObject:@{@"title":titleS,@"description":desS}];
                        [weakself.tableV reloadData];
                        return ;
                    }
                    for (int i=0; i<weakself.infoArray.count; i++) {
                        NSDictionary *dic=weakself.infoArray[i];
                        if ([dic[@"title"] isEqualToString:titleS]) {
                            [weakself.infoArray replaceObjectAtIndex:i withObject:@{@"title":titleS,@"description":desS}];
                            [weakself.tableV reloadData];
                            break;
                        }
                        if (i==weakself.infoArray.count-1) {
                            [weakself.infoArray addObject:@{@"title":titleS,@"description":desS}];
                            [weakself.tableV reloadData];
                        }
                    }
                };
                [self.navigationController pushViewController:dz_IEO_VC animated:YES];
            }
        }else if (indexPath.section==2||indexPath.section==3){
            DZInfoEditOneViewController *dz_IEO_VC=[[DZInfoEditOneViewController alloc] init];
            dz_IEO_VC.type=2;
            if (indexPath.section==2) {
                dz_IEO_VC.row=1;
            }else{
                dz_IEO_VC.row=indexPath.row+2;
            }
            NSArray *array=[[NSArray alloc] init];
            if (indexPath.section==2) {
                array=self.labelArray;
            }else{
                array=self.interestArray;
            }
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type == %@",@(dz_IEO_VC.row)];
            NSArray *filteredArray = [array filteredArrayUsingPredicate:predicate];
            NSLog(@"%@",filteredArray);
            if (filteredArray.count>0) {
                dz_IEO_VC.selectedArray=[filteredArray[0][@"label"] mutableCopy];
            }else{
                dz_IEO_VC.selectedArray=[@[] mutableCopy];
            }
            dz_IEO_VC.type2Block = ^(NSInteger row, NSString *desS) {
                NSMutableArray *typeArr=[[desS componentsSeparatedByString:@" "] mutableCopy];
                [typeArr removeObject:@""];
                if (indexPath.section==2) {
                    weakself.labelArray=[NSMutableArray array];
                        if (typeArr.count!=0) {
                            [weakself.labelArray addObject:@{@"type":@(1),@"label":typeArr}];
                        }
                    }else{
                        BOOL isExist=NO;
                        for (int i=0; i<weakself.interestArray.count; i++) {
                            if ([weakself.interestArray[i][@"type"] integerValue]==row) {
                                [weakself.interestArray removeObjectAtIndex:i];
                                if (typeArr.count!=0) {
                                    [weakself.interestArray addObject:@{@"type":@(row),@"label":typeArr}];
                                }
                                isExist=YES;
                                break;
                            }
                        }
                        if (!isExist) {
                            if (typeArr.count!=0) {
                                [weakself.interestArray addObject:@{@"type":@(row),@"label":typeArr}];
                            }
                        }
                }
                [weakself.tableV reloadData];
            };
            [self.navigationController pushViewController:dz_IEO_VC animated:YES];
        }else if (indexPath.section==4){
            DZQaListModel *model=weakself.FAQsArray[indexPath.row];
            DZFAQsTwoViewController *dz_QT_VC=[[DZFAQsTwoViewController alloc] init];
            dz_QT_VC.source=1;
            dz_QT_VC.lengthS=60;
            dz_QT_VC.questionS=model.question;
            dz_QT_VC.textS=model.answer;
            dz_QT_VC.questionCodeS=model.questionCode;
            dz_QT_VC.FAQsBlock = ^(NSString *questionS, NSString *answer, NSInteger questionCodeS) {
                if (answer.length==0) {
                    [weakself.FAQsArray removeObjectAtIndex:indexPath.row];
                }else{
                    DZQaListModel *newModel=[[DZQaListModel alloc] init];
                    newModel.question=questionS;
                    newModel.answer=answer;
                    newModel.questionCode=questionCodeS;
                    [weakself.FAQsArray replaceObjectAtIndex:indexPath.row withObject:newModel];
                }
                [weakself.tableV reloadData];
            };
            [self.navigationController pushViewController:dz_QT_VC animated:YES];
        }else if (indexPath.section==5){
            DZFAQsViewController *dz_IEO_VC=[[DZFAQsViewController alloc] init];
            dz_IEO_VC.currentArray=self.FAQsArray;
            dz_IEO_VC.FAQsBlock = ^(NSString *questionS, NSString *answer, NSInteger questionCodeS) {
                DZQaListModel *newModel=[[DZQaListModel alloc] init];
                newModel.question=questionS;
                newModel.answer=answer;
                newModel.questionCode=questionCodeS;
                for (int i=0; i<weakself.FAQsArray.count; i++) {
                    DZQaListModel *model=weakself.FAQsArray[i];
                    if (model.questionCode==questionCodeS) {
                        [weakself.FAQsArray replaceObjectAtIndex:i withObject:newModel];
                        [weakself.tableV reloadData];
                        break;
                    }
                    if (i==weakself.FAQsArray.count-1) {
                        [weakself.FAQsArray addObject:newModel];
                        [weakself.tableV reloadData];
                    }
                }
                if (weakself.FAQsArray.count==0) {
                    [weakself.FAQsArray addObject:newModel];
                    [weakself.tableV reloadData];
                }
            };
//            dz_IEO_VC.type1Block = ^(NSString *titleS, NSString *desS) {
//                for (int i=0; i<weakself.infoArray.count; i++) {
//                    NSDictionary *dic=weakself.infoArray[i];
//                    if ([dic[@"title"] isEqualToString:titleS]) {
//                        [weakself.infoArray replaceObjectAtIndex:i withObject:@{@"title":titleS,@"description":desS}];
//                        [weakself.tableV reloadData];
//                        break;
//                    }
//                    if (i==weakself.infoArray.count-1) {
//                        [weakself.infoArray addObject:@{@"title":titleS,@"description":desS}];
//                    }
//                }
//            };
            [self.navigationController pushViewController:dz_IEO_VC animated:YES];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(void)moreBtnClick:(UIButton *)btn{
//    if (btn.tag==0) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }else{
//        _isEdit=YES;
//        [self refreshViewIsEdit:_isEdit];
//        [self isEditBtn:YES];
//    }
//}
//-(void)editSate:(UIButton *)btn{
//    NSLog(@"%ld",(long)btn.tag);
//    _isEdit=NO;
//    [self refreshViewIsEdit:_isEdit];
//    [self isEditBtn:NO];
//}
//-(void)isEditBtn:(BOOL)isEdit{
//
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    negativeSpacer.width = -20;
//
//    UIButton *leftBtn = [[UIButton alloc] init];
//    leftBtn.tag=0;
////    if (isEdit) {
////        [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
////        [leftBtn setTitleColor:DZColorFromRGB(0x979797) forState:UIControlStateNormal];
////        leftBtn.frame = CGRectMake(0, 0, 50, 44);
////        [leftBtn addTarget:self action:@selector(editSate:) forControlEvents:UIControlEventTouchUpInside];
////    }else{
//        // 设置按钮的背景图片
//        [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//        [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
//        leftBtn.frame = CGRectMake(0, 0, 26, 44);
//        [leftBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
////    }
//    //设置导航栏的按钮
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
//    //    self.navigationItem.rightBarButtonItem = backButton;
//    self.navigationItem.leftBarButtonItems=@[negativeSpacer,leftButton];
//
//    UIButton *rightBtn = [[UIButton alloc] init];
//    rightBtn.tag=1;
//    if (isEdit) {
//        [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
//        [rightBtn addTarget:self action:@selector(editSate:) forControlEvents:UIControlEventTouchUpInside];
//    }else{
//        [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
//        [rightBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    [rightBtn setTitleColor:DZColorFromRGB(0x979797) forState:UIControlStateNormal];
//    // 设置按钮的尺寸为背景图片的尺寸
//    rightBtn.frame = CGRectMake(0, 0, 50, 44);
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//    //    self.navigationItem.rightBarButtonItem = backButton;
//    self.navigationItem.rightBarButtonItems=@[negativeSpacer,rightButton];
//}

-(void)refreshViewIsEdit:(BOOL)isEdit{
    UIView *headV=[[UIView alloc] init];
    headV.backgroundColor=[UIColor whiteColor];
    headV.frame=CGRectMake(0, 0, dzScreen_width, dzScreen_width);
    self.tableV.tableHeaderView=headV;
    if (isEdit) {
        for (int i=0; i<6; i++) {
            UIButton *imageBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            imageBtn.backgroundColor=DZColorFromRGB(0xEBEBEB);
            imageBtn.tag=2000+i;
            [imageBtn addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            imageBtn.imageView.contentMode=UIViewContentModeScaleAspectFill;
            if (i==0) {
                imageBtn.frame=CGRectMake(0, 0, headV.width*2/3-2, headV.height*2/3-2);
            }else if (i<3){
                imageBtn.frame=CGRectMake(headV.width*2/3, (i-1)*headV.width*1/3, headV.width*1/3, headV.height*1/3-2);
            }else if (i<5){
                imageBtn.frame=CGRectMake((i-3)*headV.width*1/3,headV.height*2/3, headV.width*1/3-2, headV.height*1/3);
            }else{
                imageBtn.frame=CGRectMake((i-3)*headV.width*1/3,headV.height*2/3, headV.width*1/3, headV.height*1/3);
            }
            if (self.accounModel.pictureUrlList.count>=i+1) {
                [imageBtn sd_setImageWithURL:[NSURL URLWithString:[NSString picUrlPath:self.accounModel.pictureUrlList[i]]] forState:UIControlStateNormal placeholderImage:dzImageNamed(@"default_head")];
            }else{
                [imageBtn setImage:dzImageNamed(@"btn_add") forState:UIControlStateNormal];
            }
            [headV addSubview:imageBtn];
            if (i<self.accounModel.pictureUrlList.count) {
                UIButton *deleteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
                deleteBtn.frame=CGRectMake(imageBtn.width-30, 0, 30, 30);
                [deleteBtn setTitle:@"-" forState:UIControlStateNormal];
                deleteBtn.backgroundColor=[UIColor whiteColor];
                deleteBtn.layer.cornerRadius=30*0.5;
                deleteBtn.tag=i;
                [deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [deleteBtn addTarget:self action:@selector(deleteClickBtn:) forControlEvents:UIControlEventTouchUpInside];
                [imageBtn addSubview:deleteBtn];
            }
        }
    }else{
        [headV addSubview:self.headScrollView];
    }
    [self.tableV reloadData];
}
-(void)deleteClickBtn:(UIButton *)btn{
    dzWeakSelf(self);
    [DZNetwork post_ph:post_deletePicture np:@{@"url":[NSString getNullStr:self.accounModel.pictureUrlList[btn.tag]]} class:nil success:^(id data) {
        if ([data[@"resultCode"] integerValue]==0) {
            [weakself.accounModel.pictureUrlList removeObjectAtIndex:btn.tag];
            [weakself refreshViewIsEdit:weakself.isEdit];
            if (weakself.accounModel.pictureUrlList.count==1) {
                [NSString modifyMemberType:3 value:[NSString getNullStr:weakself.accounModel.pictureUrlList[0]]];
            }
        }else{
            [DZNetwork hintNetwork:data[@"desc"]];
            if (weakself.accounModel.pictureUrlList.count==1) {
                [NSString modifyMemberType:3 value:[NSString getNullStr:weakself.accounModel.pictureUrlList[0]]];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(SDCycleScrollView *)headScrollView{
    if (!_headScrollView) {
        _headScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, dzScreen_width,dzScreen_width) delegate:self placeholderImage:dzImageNamed(@"banner_default")];
        _headScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _headScrollView.backgroundColor=[UIColor whiteColor];
        _headScrollView.bannerImageViewContentMode=UIViewContentModeScaleToFill;
        _headScrollView.imageURLStringsGroup =self.accounModel.pictureUrlList; //@[@"",@"",@"",@""];
    }
    return _headScrollView;
}
-(void)headBtnClick:(UIButton *)btn{
    self.headType=btn.tag-2000;
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"上传照片" message:@"第一张默认为个人头像" preferredStyle:UIAlertControllerStyleActionSheet];
    /*
     typedef NS_ENUM(NSInteger, UIAlertActionStyle) {
     UIAlertActionStyleDefault = 0,
     UIAlertActionStyleCancel,         取消按钮
     UIAlertActionStyleDestructive     破坏性按钮，比如：“删除”，字体颜色是红色的
     } NS_ENUM_AVAILABLE_IOS(8_0);
     
     */
    // 创建action，这里action1只是方便编写，以后再编程的过程中还是以命名规范为主
    dzWeakSelf(self);
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        [weakself presentViewController:imagePickerController animated:YES completion:nil];
        //设置是否允许用户自己编辑图片
        imagePickerController.allowsEditing = NO;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            NSLog(@"没有找到摄像头");
            
        }else{
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
                picker.modalPresentationStyle = UIModalPresentationCurrentContext;
            }
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.allowsEditing = NO;
            //            imagePickerController = picker;
            [weakself presentViewController:picker animated:YES completion:nil];
        }
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    //把action添加到actionSheet里
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [actionSheet addAction:action3];
    
    //相当于之前的[actionSheet show];
    [self presentViewController:actionSheet animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    //设置状态条为白色1.设置状态风格 2.修改系统plist文件
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
    CGFloat width;
    CGFloat height;
    if ((self.view.width-30)*1.5<=self.view.height-100) {
        width=self.view.frame.size.width-30;
        height=(self.view.frame.size.width-30)*1.5;
    }else{
        width=(self.view.height-100)/1.5;
        height=self.view.height-100;
    }
    AliImageReshapeController *vc = [[AliImageReshapeController alloc] init];
    vc.sourceImage = image;
    vc.reshapeScaleF=CGRectMake((self.view.width-width)*0.5, 0,width,height);
    vc.delegate = self;
    [picker pushViewController:vc animated:YES];
}

#pragma mark - ALiImageReshapeDelegate

- (void)imageReshaperController:(AliImageReshapeController *)reshaper didFinishPickingMediaWithInfo:(UIImage *)image
{
    [self UploadTheBackgroundImage:image];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)UploadTheBackgroundImage:(UIImage *)image{
    dzWeakSelf(self);
    [DZNetwork up_ph:post_uploadPicture np:@{@"upPic":[NSString convertToJSONData:@{@"orderNumber":@(self.headType+1)}]} im:image progress:^(NSProgress *progress) {
        NSLog(@"%@",progress);
    } success:^(id data) {
        if ([data[@"resultCode"] integerValue]==0) {
            if (weakself.headType+1==1) {
                [NSString modifyMemberType:3 value:[NSString getNullStr:data[@"desc"]]];
            }
            if (weakself.accounModel.pictureUrlList.count>=weakself.headType+1) {
                [weakself.accounModel.pictureUrlList replaceObjectAtIndex:weakself.headType withObject:[NSString getNullStr:data[@"desc"]]];
            }else{
                [weakself.accounModel.pictureUrlList addObject:[NSString getNullStr:data[@"desc"]]];
            }
            [weakself refreshViewIsEdit:weakself.isEdit];
        }else{
            [DZNetwork hintNetwork:data[@"desc"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)imageReshaperControllerDidCancel:(AliImageReshapeController *)reshaper
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
#pragma mark - UIImagePickerControllerDelegate
//用户选择取消
- (void) imagePickerControllerDidCancel: (UIImagePickerController *)picker{
    //设置状态条为白色1.设置状态风格 2.修改系统plist文件
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"--%ld--",(long)index);

}
- (void)didClickedWithCityName:(NSString*)cityName{
    NSLog(@"%@",cityName);
    if (self.infoArray.count==0) {
        [self.infoArray addObject:@{@"title":@"来自",@"description":cityName}];
        [self.tableV reloadData];
        return;
    }
    for (int i=0; i<self.infoArray.count; i++) {
        NSDictionary *dic=self.infoArray[i];
        if ([dic[@"title"] isEqualToString:@"来自"]) {
            [self.infoArray replaceObjectAtIndex:i withObject:@{@"title":@"来自",@"description":cityName}];
            [self.tableV reloadData];
            break;
        }
        if (i==self.infoArray.count-1) {
            [self.infoArray addObject:@{@"title":@"来自",@"description":cityName}];
            [self.tableV reloadData];
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
