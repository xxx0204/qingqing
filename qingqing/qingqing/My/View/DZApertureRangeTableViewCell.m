//
//  DZApertureRangeTableViewCell.m
//  qingqing
//
//  Created by Gavin on 2018/5/16.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZApertureRangeTableViewCell.h"

@implementation DZApertureRangeTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellName=@"ApertureRange Cell";
    DZApertureRangeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell=[[DZApertureRangeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *titleL=[[UILabel alloc] init];
        titleL.frame=CGRectMake(15, 10, 50, 25);
        titleL.font=dzFont(16);
        titleL.text=@"范围";
        [self.contentView addSubview:titleL];
        self.titleL=titleL;
        
        
        UILabel *describeL=[[UILabel alloc] init];
        describeL.frame=CGRectMake(dzScreen_width-20-100, 10, 100, 20);
        describeL.font=dzFont(14);
        describeL.textAlignment=NSTextAlignmentRight;
        describeL.text=@"1km";
        describeL.textColor=DZColorFromRGB(0x979797);
        describeL.numberOfLines=2;
        [self.contentView addSubview:describeL];
        self.describeL=describeL;
        
        TTRangeSlider *slider=[[TTRangeSlider alloc] init];
        slider.tintColor = DZColorFromRGB(0xF2F2F2);
        slider.frame = CGRectMake(30, CGRectGetMaxY(titleL.frame), dzScreen_width-60, 31);
        slider.delegate = self;
        slider.minValue = 1;
        slider.maxValue = 1000;
        slider.enableStep=NO;
        slider.hideLabels=YES;
        slider.disableRange=YES;
        slider.selectedMinimum=1;
        slider.selectedMaximum=1;
        slider.step=1;
        slider.minLabelColour=DZColorFromRGB(0xF2F2F2);
        slider.maxLabelColour=DZColorFromRGB(0xF2F2F2);
        slider.tintColorBetweenHandles=DZColorFromRGB(0xFF93A0);
        slider.lineHeight = 2;
        slider.handleImage = dzImageNamed(@"slide");
        slider.selectedHandleDiameterMultiplier = 1;
        [self.contentView addSubview:slider];
        self.slider = slider;
        
        UIView *lineV = [UIView new];
        [self.contentView addSubview:lineV];
        lineV.backgroundColor = DZColorFromRGB(0xF3F3F3);
        self.lineV = lineV;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.lineV.frame=CGRectMake(0, self.height-0.5, self.width, 0.5);
}
-(void)setMaxDistance:(NSInteger)maxDistance{
    _maxDistance=maxDistance;
    self.slider.selectedMaximum=maxDistance;
    self.describeL.text=[NSString stringWithFormat:@"%ldkm",(long)maxDistance];
}
-(void)rangeSlider:(TTRangeSlider *)sender didChangeSelectedMinimumValue:(float)selectedMinimum andMaximumValue:(float)selectedMaximum{
    NSLog(@"%lf----%lf",selectedMaximum,selectedMinimum);
    self.describeL.text=[NSString stringWithFormat:@"%.fkm",selectedMaximum];
    if (self.maxDistanceBlock) {
        self.maxDistanceBlock(selectedMaximum);
    }
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
