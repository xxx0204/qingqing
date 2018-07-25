//
//  DZFriendHeadNullTableViewCell.h
//  qingqing
//
//  Created by Gavin on 2018/7/4.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZFriendHeadNullTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UIScrollView *headScrollV;
@property(nonatomic,assign)NSInteger type;
@end
