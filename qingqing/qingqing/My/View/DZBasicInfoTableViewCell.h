//
//  DZBasicInfoTableViewCell.h
//  qingqing
//
//  Created by Gavin on 2018/5/19.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZInfoModel.h"

@interface DZBasicInfoTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)UIImageView *iconImageV,*right_arrowImageV;
@property(nonatomic,strong)UILabel *titleL,*constellationL,*ageL,*activenessL,*likeL;
@property(nonatomic,strong)UIButton *sexBtn,*likeBtn;
@property(nonatomic,assign)BOOL isEdit;
@property(nonatomic,strong)UIView *lineV;
//@property(nonatomic,strong)NSDictionary *dict;
@property(nonatomic,strong)DZOtherAccounModel *infoM;
@end
