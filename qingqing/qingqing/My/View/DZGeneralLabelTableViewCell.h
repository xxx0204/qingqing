//
//  DZGeneralLabelTableViewCell.h
//  qingqing
//
//  Created by Gavin on 2018/5/19.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZGeneralLabelTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)UIImageView *iconImageV,*right_arrowImageV;
@property(nonatomic,strong)UIView *bgView,*lineV;
@property(nonatomic,assign)BOOL isEdit;

@property(nonatomic,strong)NSIndexPath *indexP;
@property(nonatomic,strong)NSArray *array;

@property(nonatomic,strong)NSDictionary *dict;
+(CGFloat)hightDic:(NSDictionary *)dict;

+(CGFloat)hightArray:(NSArray *)array indexP:(NSIndexPath *)indexP;
@end
