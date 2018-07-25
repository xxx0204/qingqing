//
//  DZMyFAQsTableViewCell.h
//  qingqing
//
//  Created by Gavin on 2018/5/19.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZInfoModel.h"
@interface DZMyFAQsTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)UIImageView *right_arrowImageV;
@property(nonatomic,strong)UILabel *titleL,*describeL;
@property(nonatomic,strong)UIView *lineV;
@property(nonatomic,assign)BOOL isEdit;
@property(nonatomic,strong)NSDictionary *dict;
@property(nonatomic,strong)DZQaListModel *model;
+(CGFloat)hightModel:(DZQaListModel *)model;

@end
