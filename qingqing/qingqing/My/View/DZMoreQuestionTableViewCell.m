//
//  DZMoreQuestionTableViewCell.m
//  qingqing
//
//  Created by Gavin on 2018/5/20.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZMoreQuestionTableViewCell.h"

@implementation DZMoreQuestionTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellName=@"MoreQuestion Cell";
    DZMoreQuestionTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell=[[DZMoreQuestionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *iconImageV=[[UIImageView alloc] init];
        iconImageV.image=dzImageNamed(@"add_question");
        [self.contentView addSubview:iconImageV];
        self.iconImageV=iconImageV;
        
        UILabel *titleL=[[UILabel alloc] init];
        titleL.font=dzFont(14);
        titleL.text=@"添加问题";
        [self.contentView addSubview:titleL];
        self.titleL=titleL;
        
        UIImageView *right_arrowImageV=[[UIImageView alloc]init];
        right_arrowImageV.image=dzImageNamed(@"right_arrow");
        [self.contentView addSubview:right_arrowImageV];
        self.right_arrowImageV=right_arrowImageV;
        
        UIView *lineV = [UIView new];
        lineV.backgroundColor = DZColorFromRGB(0xF3F3F3);
//        [self.contentView addSubview:lineV];
        self.lineV = lineV;
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.iconImageV.frame=CGRectMake(15,15, 18, 18);
    self.titleL.frame=CGRectMake(CGRectGetMaxX(self.iconImageV.frame)+10, 0, self.width-CGRectGetMaxX(self.iconImageV.frame)-25, self.height);
    self.right_arrowImageV.frame=CGRectMake(self.width-15-8, self.height*0.5-7, 8, 14);
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
