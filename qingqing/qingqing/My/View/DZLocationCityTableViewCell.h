//
//  DZLocationCityTableViewCell.h
//  qingqing
//
//  Created by Gavin on 2018/7/5.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZLocationCityTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)UIImageView *right_arrowImageV;
@property(nonatomic,strong)UILabel *describeL,*infopL;
@property(nonatomic,strong)UIView *lineV;
@end
