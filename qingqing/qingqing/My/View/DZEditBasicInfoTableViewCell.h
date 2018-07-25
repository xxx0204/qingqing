//
//  DZEditBasicInfoTableViewCell.h
//  qingqing
//
//  Created by Gavin on 2018/6/24.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZEditBasicInfoTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)UILabel *titleL,*desL;
@property(nonatomic,strong)UIView *lineV;
@property(nonatomic,strong)UITextField *nicknameTF;
@property (nonatomic,copy)  void(^nicknameBlock)(NSString *desS);
@end
