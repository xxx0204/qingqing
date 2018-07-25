//
//  DZSettingTableViewCell.m
//  qingqing
//
//  Created by Gavin on 2018/5/16.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZSettingTableViewCell.h"

@implementation DZSettingTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellName=@"Setting Cell";
    DZSettingTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell=[[DZSettingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *iconImageV=[[UIImageView alloc] init];
        [self.contentView addSubview:iconImageV];
        self.iconImageV=iconImageV;
        
        UILabel *titleL=[[UILabel alloc] init];
        titleL.font=dzFont(16);
        titleL.text=@"昵 称";
        [self.contentView addSubview:titleL];
        self.titleL=titleL;
        
        
        UILabel *describeL=[[UILabel alloc] init];
        describeL.font=dzFont(14);
        describeL.text=@"自我介绍：哈哈哈啦啦呵呵哈哈哈啦啦";
        describeL.textColor=DZColorFromRGB(0x979797);
        describeL.numberOfLines=2;
        [self.contentView addSubview:describeL];
        self.describeL=describeL;
        
        UIImageView *right_arrowImageV=[[UIImageView alloc]init];
        right_arrowImageV.image=dzImageNamed(@"right_arrow");
        [self.contentView addSubview:right_arrowImageV];
        self.right_arrowImageV=right_arrowImageV;
        
        UIView *lineV = [UIView new];
        [self.contentView addSubview:lineV];
        lineV.backgroundColor = DZColorFromRGB(0xF3F3F3);
        self.lineV = lineV;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.iconImageV.frame=CGRectMake(15, self.height*0.5-24-2, 24, 24);
    
    self.titleL.frame=CGRectMake(CGRectGetMaxX(self.iconImageV.frame)+10, self.iconImageV.top, dzScreen_width-CGRectGetMaxX(self.iconImageV.frame)-10-15-10, self.iconImageV.height);
    
    self.describeL.frame=CGRectMake(self.iconImageV.left, self.height*0.5, dzScreen_width-self.iconImageV.left*2-10, 25);
    self.right_arrowImageV.frame=CGRectMake(self.width-15-8, self.height*0.5-7, 8, 14);
    self.lineV.frame=CGRectMake(0, self.height-0.5, self.width, 0.5);
}
-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    self.iconImageV.image=dzImageNamed(dict[@"iconI"]);
    self.titleL.text=dict[@"title"];
    self.describeL.text=dict[@"description"];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
