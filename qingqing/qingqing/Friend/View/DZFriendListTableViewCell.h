//
//  DZFriendListTableViewCell.h
//  qingqing
//
//  Created by Gavin on 2018/5/15.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZFriendListModel.h"
#import <RongIMLib/RongIMLib.h>

@interface DZFriendListTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)UIImageView *iconImageV;
@property(nonatomic,strong)UILabel *titleL,*describeL,*infopL;
@property(nonatomic,strong)UIView *lineV;
@property(nonatomic,strong)DZGMModel *model;
@property(nonatomic,strong)RCConversation *rcconVerMode;
@end
