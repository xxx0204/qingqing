//
//  DZAgeTableViewCell.h
//  qingqing
//
//  Created by Gavin on 2018/5/16.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TTRangeSlider.h>

@interface DZAgeTableViewCell : UITableViewCell <TTRangeSliderDelegate>
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)UILabel *titleL,*describeL;
@property(nonatomic,strong)TTRangeSlider *slider;
@property(nonatomic,strong)UIView *lineV;
@property(nonatomic,strong)NSDictionary *dict;
@property (nonatomic,copy)  void(^sliderBlock)(CGFloat min,CGFloat max);
@end
