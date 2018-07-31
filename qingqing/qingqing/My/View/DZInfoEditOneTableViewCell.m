//
//  DZInfoEditOneTableViewCell.m
//  qingqing
//
//  Created by Gavin on 2018/6/23.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZInfoEditOneTableViewCell.h"

@implementation DZInfoEditOneTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellName=@"DZInfoEditOne Cell";
    DZInfoEditOneTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell=[[DZInfoEditOneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
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
        titleL.text=@"";
        titleL.textColor=DZColorFromRGB(0x979797);
        [self.contentView addSubview:titleL];
        self.titleL=titleL;
        
        UIImageView *right_arrowImageV=[[UIImageView alloc]init];
        right_arrowImageV.image=dzImageNamed(@"choose_color_tick");
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
    self.titleL.frame=CGRectMake(15, 0, dzScreen_width-50,self.height);
    self.right_arrowImageV.frame=CGRectMake(self.width-15-18, self.height*0.5-6, 18, 12);
    self.lineV.frame=CGRectMake(15, self.height-0.5, self.width-15, 0.5);
}
-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    self.titleL.text=dict[@"title"];
}
-(void)setSelectedArray:(NSMutableArray *)selectedArray{
    _selectedArray=selectedArray;
}
-(void)setInfoModel:(DZInfoOptionlistModel *)infoModel{
    _infoModel=infoModel;
    self.titleL.text=[NSString getNullStr:infoModel.content];
    BOOL isbool = [self.selectedArray containsObject:self.titleL.text];
    self.right_arrowImageV.hidden=!isbool;
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
