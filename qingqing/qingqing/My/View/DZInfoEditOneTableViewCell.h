//
//  DZInfoEditOneTableViewCell.h
//  qingqing
//
//  Created by Gavin on 2018/6/23.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZInfoListModel.h"

@interface DZInfoEditOneTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)UIImageView *right_arrowImageV;
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UIView *lineV;
@property(nonatomic,strong)NSDictionary *dict;
@property(nonatomic,strong)NSMutableArray *selectedArray;
@property(nonatomic,strong)DZInfoOptionlistModel *infoModel;
@end
