//
//  DZMoreQuestionTableViewCell.h
//  qingqing
//
//  Created by Gavin on 2018/5/20.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZMoreQuestionTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)UIImageView *iconImageV,*right_arrowImageV;
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UIView *lineV;
@end
