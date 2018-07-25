//
//  DZEditBasicInfoTableViewCell.m
//  qingqing
//
//  Created by Gavin on 2018/6/24.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZEditBasicInfoTableViewCell.h"

@implementation DZEditBasicInfoTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellName=@"DZEditBasicInfo Cell";
    DZEditBasicInfoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell=[[DZEditBasicInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
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
        titleL.text=@"性别";
        [self.contentView addSubview:titleL];
        self.titleL=titleL;
        
        UILabel *desL=[[UILabel alloc] init];
        desL.font=dzFont(14);
        desL.text=@"男";
        desL.textAlignment=NSTextAlignmentRight;
        desL.textColor=DZColorFromRGB(0x979797);
        [self.contentView addSubview:desL];
        self.desL=desL;
        
        //上方的手机号码输入框
        UITextField *nicknameTF = [[UITextField alloc]init];
        nicknameTF.placeholder =@"请输入昵称";
        nicknameTF.font = dzFont(16);
        nicknameTF.textAlignment=NSTextAlignmentRight;
        //实时更新输入框内容
        [nicknameTF addTarget:self action:@selector(phoneNum_tfChange:) forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:nicknameTF];
        self.nicknameTF=nicknameTF;
        
        UIView *lineV = [UIView new];
        [self.contentView addSubview:lineV];
        lineV.backgroundColor = DZColorFromRGB(0xF3F3F3);
        self.lineV = lineV;
    }
    return self;
}
#pragma mark - 实时更新输入框
- (void)phoneNum_tfChange:(UITextField *)textField{
    if (self.nicknameBlock) {
        self.nicknameBlock(textField.text);
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleL.frame=CGRectMake(15, 0, 80,self.height);
    self.desL.frame=CGRectMake(self.titleL.right, 0, self.width-self.titleL.right-15, self.height);
    self.nicknameTF.frame=self.desL.frame;
    self.lineV.frame=CGRectMake(15, self.height-0.5, self.width-15, 0.5);
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
