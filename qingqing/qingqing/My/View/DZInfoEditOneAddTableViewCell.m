//
//  DZInfoEditOneAddTableViewCell.m
//  qingqing
//
//  Created by Gavin on 2018/6/23.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZInfoEditOneAddTableViewCell.h"

@implementation DZInfoEditOneAddTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellName=@"DZInfoEditOneAdd Cell";
    DZInfoEditOneAddTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell=[[DZInfoEditOneAddTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *addImageV=[[UIImageView alloc]init];
        addImageV.image=dzImageNamed(@"add_question");
        [self.contentView addSubview:addImageV];
        self.addImageV=addImageV;
        
        
        UILabel *titleL=[[UILabel alloc] init];
        titleL.font=dzFont(14);
        titleL.text=@"创建我自己的标签";
        titleL.textColor=DZColorFromRGB(0x979797);
        [self.contentView addSubview:titleL];
        self.titleL=titleL;
        
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
    self.addImageV.frame=CGRectMake(15, self.height*0.5-9, 18, 18);
    self.titleL.frame=CGRectMake(self.addImageV.right+10, 0, dzScreen_width-100,self.height);
    self.right_arrowImageV.frame=CGRectMake(self.width-15-8, self.height*0.5-7, 8, 14);
    self.lineV.frame=CGRectMake(15, self.height-0.5, self.width-15, 0.5);
}
-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    
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
