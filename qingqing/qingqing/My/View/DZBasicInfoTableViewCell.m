//
//  DZBasicInfoTableViewCell.m
//  qingqing
//
//  Created by Gavin on 2018/5/19.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZBasicInfoTableViewCell.h"

@implementation DZBasicInfoTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellName=@"BasicInfo Cell";
    DZBasicInfoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell=[[DZBasicInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /*
         @property(nonatomic,strong)UILabel *titleL,*constellationL,*ageL,*activenessL,*likeL;
         @property(nonatomic,strong)UIButton *sexBtn,*likeBtn;
         */
        UIImageView *iconImageV=[[UIImageView alloc] init];
//        [self.contentView addSubview:iconImageV];
        self.iconImageV=iconImageV;
        
        UILabel *titleL=[[UILabel alloc] init];
        titleL.font=dzFont(17);
        titleL.text=@"汤阿姨";
        [self.contentView addSubview:titleL];
        self.titleL=titleL;
        
        
        UIButton *sexBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        sexBtn.titleLabel.font=dzFont(11);
        [self.contentView addSubview:sexBtn];
        self.sexBtn=sexBtn;
        
        UILabel *constellationL=[[UILabel alloc] init];
        constellationL.font=dzFont(11);
        constellationL.text=@"处女座";
        constellationL.layer.cornerRadius=10;
        constellationL.textAlignment=NSTextAlignmentCenter;
        constellationL.clipsToBounds=YES;
        constellationL.textColor=[UIColor whiteColor];
        constellationL.backgroundColor=DZColorFromRGB(0xFF93A0);
        [self.contentView addSubview:constellationL];
        self.constellationL=constellationL;
        
        UILabel *activenessL=[[UILabel alloc] init];
        activenessL.font=dzFont(12);
        activenessL.text=@"500m 现在活跃";
        activenessL.textColor=DZColorFromRGB(0x979797);
        [self.contentView addSubview:activenessL];
        self.activenessL=activenessL;
        
        UIButton *likeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:likeBtn];
        self.likeBtn=likeBtn;
        
        UILabel *likeL=[[UILabel alloc] init];
        likeL.font=dzFont(14);
        likeL.text=@"有17280人喜欢了Ta";
        likeL.textColor=DZColorFromRGB(0x979797);
        [self.contentView addSubview:likeL];
        self.likeL=likeL;
        
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
    self.titleL.frame=CGRectMake(15, 10, dzScreen_width-30, 24);
    [self.titleL sizeToFit];
    self.titleL.frame=CGRectMake(15, 10, self.titleL.width, 24);
    self.sexBtn.frame=CGRectMake(15, CGRectGetMaxY(self.titleL.frame)+5, 100, 20);
    [self.sexBtn sizeToFit];
//    if (self.isEdit) {
//        self.sexBtn.frame=CGRectMake(CGRectGetMaxX(self.titleL.frame)+10, self.titleL.top+2, self.sexBtn.width+15, 20);
//    }else{
        self.sexBtn.frame=CGRectMake(15, CGRectGetMaxY(self.titleL.frame)+5, self.sexBtn.width+15, 20);
//    }
    self.constellationL.frame=CGRectMake(CGRectGetMaxX(self.sexBtn.frame)+5, self.sexBtn.top, 200, 20);
    [self.constellationL sizeToFit];
    self.constellationL.frame=CGRectMake(CGRectGetMaxX(self.sexBtn.frame)+5, self.sexBtn.top, self.constellationL.width+15, 20);
    self.activenessL.frame=CGRectMake(self.constellationL.right+10, self.constellationL.top, dzScreen_width-self.constellationL.right-10-15, self.constellationL.height);
//    self.likeBtn.frame=CGRectMake(15, CGRectGetMaxY(self.activenessL.frame)+15, 20, 20);
//    self.likeL.frame=CGRectMake(CGRectGetMaxX(self.likeBtn.frame)+15, self.likeBtn.top, dzScreen_width-CGRectGetMaxX(self.likeBtn.frame)-45, 20);
    
    self.right_arrowImageV.frame=CGRectMake(self.width-15-8, self.height*0.5-7, 8, 14);
    self.lineV.frame=CGRectMake(0, self.height-0.5, self.width, 0.5);
}
-(void)setIsEdit:(BOOL)isEdit{
    _isEdit=isEdit;
//    self.right_arrowImageV.hidden=!isEdit;
//    if (isEdit) {
//        self.likeBtn.hidden=YES;
//        self.likeL.hidden=YES;
//        self.constellationL.hidden=YES;
//        [self.sexBtn setTitle:@"" forState:UIControlStateNormal];
//        self.sexBtn.layer.cornerRadius=5;
//        self.activenessL.text=@"点击编辑个人信息（如姓名、年龄）";
//    }else{
        self.likeBtn.hidden=YES;
        self.likeL.hidden=YES;
    if (self.infoM.constellation.length==0) {
        self.constellationL.hidden=YES;
    }else{
        self.constellationL.hidden=NO;
    }
        self.sexBtn.layer.cornerRadius=10;
//    }
    if (isEdit) {
        self.activenessL.hidden=YES;
        self.right_arrowImageV.hidden=NO;
    }else{
        self.activenessL.hidden=NO;
        self.right_arrowImageV.hidden=YES;
    }
}
-(void)setInfoM:(DZOtherAccounModel *)infoM{
    _infoM=infoM;
    self.titleL.text=[NSString getNullStr:infoM.nickname];
    self.constellationL.text=[NSString getNullStr:infoM.constellation];
    
    if (infoM.sex==1) {
        [self.sexBtn setImage:dzImageNamed(@"man_bg_clear") forState:UIControlStateNormal];
        self.sexBtn.backgroundColor=DZColorFromRGB(0x83CEE3);
    }else{
        [self.sexBtn setImage:dzImageNamed(@"woman_bg_clear") forState:UIControlStateNormal];
        self.sexBtn.backgroundColor=DZColorFromRGB(0xFF9EC3);
    }
    [self.sexBtn setTitle:[NSString stringWithFormat:@" %ld",(long)infoM.age] forState:UIControlStateNormal];
    [self.likeBtn setImage:dzImageNamed(@"like") forState:UIControlStateNormal];
    self.activenessL.text=[NSString stringWithFormat:@"%@ %@",[NSString getNullStr:infoM.distance],[NSString getNullStr:infoM.lastActiveTime]];
//    self.likeL.text=@"有17280人喜欢了Ta";
    
    NSMutableAttributedString *likeString = [[NSMutableAttributedString alloc]initWithString:self.likeL.text];
    [likeString addAttribute:NSForegroundColorAttributeName value:DZColorFromRGB(0xEB5A68) range:NSMakeRange(1,5)];
    //    [nameString addAttribute:NSFontAttributeName value:dkFont(12) range:NSMakeRange(4,titleL.text.length-4)];
    self.likeL.attributedText = likeString;
}
//-(void)setDict:(NSDictionary *)dict{
//    _dict=dict;
//    [self.sexBtn setImage:dzImageNamed(@"woman_bg_clear") forState:UIControlStateNormal];
//    [self.sexBtn setTitle:@" 28" forState:UIControlStateNormal];
//    [self.likeBtn setImage:dzImageNamed(@"like") forState:UIControlStateNormal];
//    self.activenessL.text=@"500m 现在活跃";
//
//    NSMutableAttributedString *likeString = [[NSMutableAttributedString alloc]initWithString:self.likeL.text];
//    [likeString addAttribute:NSForegroundColorAttributeName value:DZColorFromRGB(0xEB5A68) range:NSMakeRange(0,5)];
////    [nameString addAttribute:NSFontAttributeName value:dkFont(12) range:NSMakeRange(4,titleL.text.length-4)];
//    self.likeL.attributedText = likeString;
//    
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
