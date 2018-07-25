//
//  DZPositionTableViewCell.m
//  qingqing
//
//  Created by Gavin on 2018/5/16.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZPositionTableViewCell.h"

@implementation DZPositionTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellName=@"Position Cell";
    DZPositionTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell=[[DZPositionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *titleL=[[UILabel alloc] init];
        titleL.font=dzFont(16);
        titleL.text=@"位置";
        [self.contentView addSubview:titleL];
        self.titleL=titleL;
        
        
        UILabel *describeL=[[UILabel alloc] init];
        describeL.font=dzFont(16);
        describeL.text=@"我的当前定位";
        describeL.numberOfLines=2;
        [self.contentView addSubview:describeL];
        self.describeL=describeL;
        
        UILabel *infopL=[[UILabel alloc] init];
        infopL.font=dzFont(14);
        infopL.textColor=DZColorFromRGB(0x979797);
        infopL.numberOfLines=2;
        [self.contentView addSubview:infopL];
        self.infopL=infopL;
        
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
        
    self.titleL.frame=CGRectMake(15, 0, 50, self.height);
    self.right_arrowImageV.frame=CGRectMake(self.width-15-8, self.height*0.5-7, 8, 14);

    self.describeL.frame=CGRectMake(CGRectGetMaxX(self.titleL.frame)+10, 0, dzScreen_width-CGRectGetMaxX(self.titleL.frame)-10-15-10, 30);
    self.infopL.frame=CGRectMake(self.describeL.top, CGRectGetMaxY(self.describeL.frame)+5, self.describeL.width, 25);
    [self.describeL sizeToFit];
    [self.infopL sizeToFit];
    self.describeL.frame=CGRectMake(self.right_arrowImageV.left-10-self.describeL.width, self.height*0.5-self.describeL.height-2, self.describeL.width, self.describeL.height);
    self.infopL.frame=CGRectMake(self.right_arrowImageV.left-10-self.infopL.width, self.height*0.5+2, self.infopL.width, self.infopL.height);
    
    self.lineV.frame=CGRectMake(0, self.height-0.5, self.width, 0.5);
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
