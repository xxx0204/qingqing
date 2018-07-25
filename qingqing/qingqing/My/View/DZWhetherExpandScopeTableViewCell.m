//
//  DZWhetherExpandScopeTableViewCell.m
//  qingqing
//
//  Created by Gavin on 2018/5/16.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZWhetherExpandScopeTableViewCell.h"

@implementation DZWhetherExpandScopeTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellName=@"WhetherExpandScope Cell";
    DZWhetherExpandScopeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell=[[DZWhetherExpandScopeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
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
        titleL.text=@"";
        [self.contentView addSubview:titleL];
        self.titleL=titleL;
        
        
//        UILabel *describeL=[[UILabel alloc] init];
//        describeL.font=dzFont(14);
//        describeL.text=@"如果用户较少，自动适量扩大范围";
//        describeL.textColor=DZColorFromRGB(0x979797);
//        describeL.numberOfLines=2;
//        [self.contentView addSubview:describeL];
//        self.describeL=describeL;
        
        UISwitch *swich = [[UISwitch alloc]init];
        swich.onTintColor = DZColorFromRGB(0xFF93A0);
        [swich addTarget:self action:@selector(swichClick:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:swich];
        self.swich=swich;
        
        UIView *lineV = [UIView new];
        [self.contentView addSubview:lineV];
        lineV.backgroundColor = DZColorFromRGB(0xF3F3F3);
        self.lineV = lineV;
    }
    return self;
}
- (void)swichClick:(UISwitch *)swich{
    if (self.swichBlock) {
        self.swichBlock(swich);
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleL.frame=CGRectMake(15, 0, 250, self.height);
    
//    self.describeL.frame=CGRectMake(self.titleL.left, CGRectGetMaxY(self.titleL.frame), dzScreen_width-15-50-10, 20);
    self.swich.frame = CGRectMake(dzScreen_width-50-15, self.height*0.5-15, 50, 30);

    self.lineV.frame=CGRectMake(0, self.height-0.5, self.width, 0.5);
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
