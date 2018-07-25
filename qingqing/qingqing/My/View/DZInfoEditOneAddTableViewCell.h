//
//  DZInfoEditOneAddTableViewCell.h
//  qingqing
//
//  Created by Gavin on 2018/6/23.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZInfoEditOneAddTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)UIImageView *addImageV,*right_arrowImageV;
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UIView *lineV;
@property(nonatomic,strong)NSDictionary *dict;

@end
