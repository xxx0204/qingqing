//
//  DZFriendListTableViewCell.m
//  qingqing
//
//  Created by Gavin on 2018/5/15.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZFriendListTableViewCell.h"

@implementation DZFriendListTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellName=@"FriendList Cell";
    DZFriendListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell=[[DZFriendListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *iconImageV=[[UIImageView alloc] init];
        iconImageV.layer.cornerRadius=35;
        iconImageV.clipsToBounds=YES;
        iconImageV.contentMode=UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:iconImageV];
        self.iconImageV=iconImageV;
        
        UILabel *titleL=[[UILabel alloc] init];
        titleL.font=dzFont(16);
        titleL.text=@"昵 称";
        [self.contentView addSubview:titleL];
        self.titleL=titleL;
        
        
        UILabel *describeL=[[UILabel alloc] init];
        describeL.font=dzFont(16);
//        describeL.text=@"暂无新消息";
        //        addressL.textColor=dkText_grayColor;
        describeL.numberOfLines=2;
        [self.contentView addSubview:describeL];
        self.describeL=describeL;
        
        
        UILabel *infopL=[[UILabel alloc] init];
        infopL.font=dzFont(13);
        infopL.textColor=DZColorFromRGB(0x979797);
        [self.contentView addSubview:infopL];
        self.infopL=infopL;
        
        UIView *lineV = [UIView new];
        [self.contentView addSubview:lineV];
        lineV.backgroundColor = DZColorFromRGB(0xF3F3F3);
        self.lineV = lineV;
        
        UILabel *unReadNumLabel = [UILabel new];
        [self.contentView addSubview:unReadNumLabel];
        unReadNumLabel.backgroundColor = DZColorFromRGB(0xEB5A68);
        unReadNumLabel.font=dzFont(13);
        unReadNumLabel.textColor=[UIColor whiteColor];
        unReadNumLabel.textAlignment = NSTextAlignmentCenter;
        unReadNumLabel.layer.cornerRadius = 7.5f;
        unReadNumLabel.clipsToBounds = YES;
        self.unReadNumLabel = unReadNumLabel;
    }
    return self;
}
-(void)setRcconVerMode:(RCConversation *)rcconVerMode{
    _rcconVerMode=rcconVerMode;
}
-(void)setModel:(DZGMModel *)model{
    _model=model;
    [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:[NSString picUrlPath:model.headPicUrl]] placeholderImage:dzImageNamed(@"default_head")];
    self.titleL.text=[NSString getNullStr:model.nickname];
    if ([self.rcconVerMode.objectName isEqualToString:@"RC:TxtMsg"]){
        RCTextMessage *testMessage = (RCTextMessage *)self.rcconVerMode.lastestMessage;
        self.describeL.text=[NSString getNullStr:testMessage.content];
    }else if([self.rcconVerMode.objectName isEqualToString:@"RC:ImgMsg"]){
        self.describeL.text=@"您有一个图片消息";
    }else if([self.rcconVerMode.objectName isEqualToString:@"RC:VcMsg"]){
        self.describeL.text=@"您有一条语音消息";
    }else if ([self.rcconVerMode.objectName isEqualToString:@"RC:LBSMsg"]){
        self.describeL.text=@"您有一条位置信息";
    }else{
        self.describeL.text=@"";
    }
    if (model.relationStatus==2) {
        if ([[NSString getHour:model.buildTime] integerValue]>0) {
            self.infopL.text=[NSString stringWithFormat:@"对话将在%@小时后失效",[NSString getHour:model.buildTime]];
        }else{
            self.infopL.text=@"";
        }
    }else{
        self.infopL.text=@"";
    }
    if (self.rcconVerMode.unreadMessageCount > 0) {
        self.unReadNumLabel.hidden = NO;
        self.unReadNumLabel.text = [NSString stringWithFormat:@"%ld", (long)self.rcconVerMode.unreadMessageCount];
    } else {
        self.unReadNumLabel.hidden = YES;
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.infopL.text.length!=0) {
        NSMutableAttributedString *infoString = [[NSMutableAttributedString alloc]initWithString:self.infopL.text];
        [infoString addAttribute:NSForegroundColorAttributeName value:DZColorFromRGB(0xEB5A68) range:NSMakeRange(4,4)];
        self.infopL.attributedText = infoString;
    }
    self.iconImageV.frame=CGRectMake(15, 10, 70, 70);
    self.titleL.frame=CGRectMake(CGRectGetMaxX(self.iconImageV.frame)+10, 0, dzScreen_width-CGRectGetMaxX(self.iconImageV.frame)-10-15, 30);
    self.describeL.frame=CGRectMake(self.titleL.left, CGRectGetMaxY(self.titleL.frame)+5, self.titleL.width, 40);
    self.infopL.frame=CGRectMake(self.titleL.left, CGRectGetMaxY(self.describeL.frame)+7.5, self.titleL.width, 25);

    [self.titleL sizeToFit];
    [self.describeL sizeToFit];
    [self.infopL sizeToFit];
    
    CGFloat totalHeight;
    CGFloat describeLHeight;
    if (self.describeL.text.length==0) {
        describeLHeight=25;
    }else{
        describeLHeight=self.describeL.height;
    }
    if ([self.infopL.text isEqualToString:@""]) {
        totalHeight=self.titleL.height+describeLHeight+2.5;
    }else{
        totalHeight=self.titleL.height+describeLHeight+self.infopL.height+5;
    }
//    if (self.infopL.hidden) {
//        totalHeight=self.titleL.height+self.describeL.height+2.5;
//    }else{
//        totalHeight=self.titleL.height+self.describeL.height+self.infopL.height+5;
//    }
    self.titleL.frame=CGRectMake(self.titleL.left,(self.height-totalHeight)*0.5, self.titleL.width, self.titleL.height);
    
    self.describeL.frame=CGRectMake(self.describeL.left, CGRectGetMaxY(self.titleL.frame)+5, self.describeL.width, describeLHeight);
    
    self.infopL.frame=CGRectMake(self.infopL.left, CGRectGetMaxY(self.describeL.frame)+2.5,self.infopL.width, self.infopL.height);
    
    self.lineV.frame=CGRectMake(15, self.height-0.5, self.width-30, 0.5);
    
    self.unReadNumLabel.frame = CGRectMake(0 + self.width - 40, 20, 20, 15);
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
