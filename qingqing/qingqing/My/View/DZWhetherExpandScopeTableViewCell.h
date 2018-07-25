//
//  DZWhetherExpandScopeTableViewCell.h
//  qingqing
//
//  Created by Gavin on 2018/5/16.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZWhetherExpandScopeTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)UISwitch *swich;
@property(nonatomic,strong)UILabel *titleL,*describeL,*infopL;
@property(nonatomic,strong)UIView *lineV;
@property(nonatomic,strong)NSDictionary *dict;

@property (nonatomic,copy)  void(^swichBlock)(UISwitch *swich);
@end
