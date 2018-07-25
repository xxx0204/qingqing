//
//  DZFriendHeadTableViewCell.h
//  qingqing
//
//  Created by Gavin on 2018/5/15.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZFriendListModel.h"

@interface DZFriendHeadTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UIScrollView *headScrollV;
@property(nonatomic,strong)NSArray *array;
@property(nonatomic,assign)NSInteger countI;

@property (nonatomic,copy)  void(^headPortraitsBlock)(UIButton *btn);


@end
