//
//  DZFriendHeadNullTableViewCell.m
//  qingqing
//
//  Created by Gavin on 2018/7/4.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZFriendHeadNullTableViewCell.h"

@implementation DZFriendHeadNullTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellName=@"DZFriendHeadNull Cell";
    DZFriendHeadNullTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell=[[DZFriendHeadNullTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIScrollView *headScrollV=[[UIScrollView alloc]init];
        headScrollV.backgroundColor=[UIColor whiteColor];
        headScrollV.showsHorizontalScrollIndicator=NO;
        [self.contentView addSubview:headScrollV];
        self.headScrollV=headScrollV;
    }
    return self;
}
-(void)setType:(NSInteger)type{
    _type=type;
    [self.headScrollV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i=0; i<5; i++) {
        UIImageView *imageV=[[UIImageView alloc] init];
        imageV.frame=CGRectMake(15+i*((dzScreen_width-55)/9*2+10), 15, (dzScreen_width-55)/9*2, (dzScreen_width-55)/9*2);
        imageV.image=dzImageNamed(@"friend_head_null");
        [self.headScrollV addSubview:imageV];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.headScrollV.contentSize=CGSizeMake(dzScreen_width, self.height);
    self.headScrollV.frame=CGRectMake(0, 0, dzScreen_width, self.height);
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
