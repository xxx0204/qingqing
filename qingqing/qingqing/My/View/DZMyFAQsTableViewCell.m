//
//  DZMyFAQsTableViewCell.m
//  qingqing
//
//  Created by Gavin on 2018/5/19.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZMyFAQsTableViewCell.h"

@implementation DZMyFAQsTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellName=@"MyFAQs Cell";
    DZMyFAQsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell=[[DZMyFAQsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *titleL=[[UILabel alloc] init];
        titleL.font=dzFont(14);
        titleL.text=@"让你后悔的一瞬间是？";
        [self.contentView addSubview:titleL];
        self.titleL=titleL;
        
        
        UILabel *describeL=[[UILabel alloc] init];
        describeL.font=dzFont(14);
        describeL.text=@"我梅有";
        describeL.numberOfLines=0;
        describeL.textColor=DZColorFromRGB(0x979797);
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
-(void)setIsEdit:(BOOL)isEdit{
    _isEdit=isEdit;
    self.right_arrowImageV.hidden=!isEdit;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleL.frame=CGRectMake(15, 20, dzScreen_width-30,self.height);
    self.describeL.frame=CGRectMake(self.titleL.left,CGRectGetMaxY(self.titleL.frame)+5, dzScreen_width-30, 1000);
    
    [self.titleL sizeToFit];
    [self.describeL sizeToFit];
    
    self.titleL.frame=CGRectMake(15, 20, self.titleL.width, self.titleL.height);
    self.describeL.frame=CGRectMake(self.titleL.left,CGRectGetMaxY(self.titleL.frame)+5, self.describeL.width, self.describeL.height);
    
    self.right_arrowImageV.frame=CGRectMake(self.width-15-8, self.height*0.5-7, 8, 14);
    self.lineV.frame=CGRectMake(0, self.height-0.5, self.width, 0.5);
}
-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
}
-(void)setModel:(DZQaListModel *)model{
    _model=model;
    self.titleL.text=[NSString getNullStr:model.question];
    self.describeL.text=[NSString getNullStr:model.answer];
}
+(CGFloat)hightModel:(DZQaListModel *)model{
    UILabel *titleL=[[UILabel alloc] init];
    titleL.font=dzFont(14);
    titleL.text=[NSString getNullStr:model.question];//@"让你后悔的一瞬间是？";
    
    
    UILabel *describeL=[[UILabel alloc] init];
    describeL.font=dzFont(14);
    describeL.text=[NSString getNullStr:model.answer];//@"我梅有";
    describeL.numberOfLines=0;
    describeL.textColor=DZColorFromRGB(0x979797);
    
    titleL.frame=CGRectMake(15, 20, dzScreen_width-30,100);
    describeL.frame=CGRectMake(titleL.left,CGRectGetMaxY(titleL.frame)+5, dzScreen_width-30, 1000);
    
    [titleL sizeToFit];
    [describeL sizeToFit];
    
    return 20+titleL.height+5+describeL.height+10;
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
