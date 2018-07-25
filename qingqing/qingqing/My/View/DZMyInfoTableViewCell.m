//
//  DZMyInfoTableViewCell.m
//  qingqing
//
//  Created by Gavin on 2018/5/17.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZMyInfoTableViewCell.h"

@implementation DZMyInfoTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellName=@"MyInfo Cell";
    DZMyInfoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell=[[DZMyInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
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
        titleL.text=@"星座";
        titleL.textColor=DZColorFromRGB(0x979797);
        [self.contentView addSubview:titleL];
        self.titleL=titleL;
        
        
        UILabel *describeL=[[UILabel alloc] init];
        describeL.font=dzFont(14);
        describeL.text=@"处女座";
        describeL.numberOfLines=2;
        describeL.textColor=DZColorFromRGB(0x000000);
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
-(void)setIndexP:(NSIndexPath *)indexP{
    _indexP=indexP;
}
+(NSDictionary *)addDescription:(NSIndexPath *)indexP array:(NSArray *)array{
    NSString *titleS;
    NSString *descriptionS;
    switch (indexP.row) {
        case 0:{
            titleS=@"行业";
        }
            break;
        case 1:{
            titleS=@"工作领域";
        }
            break;
        case 2:{
            titleS=@"来自";
        }
            break;
        case 3:{
            titleS=@"经常出没";
        }
            break;
        default:{
            titleS=@"个性签名";
        }
            break;
    }
    
    if (array.count!=0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title == %@", titleS];
        NSArray *filteredArray = [array filteredArrayUsingPredicate:predicate];
        NSLog(@"%@",filteredArray);
        if (filteredArray.count>0) {
            descriptionS=filteredArray[0][@"description"];
            if (descriptionS.length==0) {
                descriptionS=@"未填写";
            }
        }else{
            descriptionS=@"未填写";
        }
    }else{
        descriptionS=@"未填写";
    }
    return @{@"title":[NSString getNullStr:titleS],@"des":[NSString getNullStr:descriptionS]};
}

-(void)setArray:(NSArray *)array{
    _array=array;
//    for (NSDictionary *dict in array) {
    
       NSDictionary *dic=[DZMyInfoTableViewCell addDescription:_indexP array:array];
    self.titleL.text=dic[@"title"];
    self.describeL.text=dic[@"des"];
}
-(void)setIsEdit:(BOOL)isEdit{
    _isEdit=isEdit;
    self.right_arrowImageV.hidden=!isEdit;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleL.frame=CGRectMake(15, 0, dzScreen_width-30,self.height);
    [self.titleL sizeToFit];
    self.titleL.frame=CGRectMake(15, 0, self.titleL.width, self.height);
    self.describeL.frame=CGRectMake(self.titleL.right+10,0, dzScreen_width-self.titleL.right-15-8-5-10, 1000);

    [self.describeL sizeToFit];
    
    self.describeL.frame=CGRectMake(CGRectGetMaxX(self.titleL.frame)+10,0, self.describeL.width, self.height);
    
    self.right_arrowImageV.frame=CGRectMake(self.width-15-8, self.height*0.5-7, 8, 14);
    self.lineV.frame=CGRectMake(0, self.height-0.5, self.width, 0.5);
}
-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    self.titleL.text=dict[@"title"];
    self.describeL.text=dict[@"description"];
    if (self.describeL.text.length==0) {
        self.describeL.text=@"未知";
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
