//
//  DZGeneralLabelTableViewCell.m
//  qingqing
//
//  Created by Gavin on 2018/5/19.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZGeneralLabelTableViewCell.h"

@implementation DZGeneralLabelTableViewCell
{
    CGRect _bgViewFrame;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellName=@"GeneralLabel Cell";
    DZGeneralLabelTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell=[[DZGeneralLabelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *iconImageV=[[UIImageView alloc] init];
        [self.contentView addSubview:iconImageV];
        self.iconImageV=iconImageV;
        
        UIImageView *right_arrowImageV=[[UIImageView alloc]init];
        right_arrowImageV.image=dzImageNamed(@"right_arrow");
        [self.contentView addSubview:right_arrowImageV];
        self.right_arrowImageV=right_arrowImageV;
                
        UIView *bgView = [UIView new];
        bgView.frame=CGRectMake(49, 5, dzScreen_width-49, 100);
        [self.contentView addSubview:bgView];
        self.bgView = bgView;
        
        UIView *lineV = [UIView new];
        lineV.backgroundColor = DZColorFromRGB(0xF3F3F3);
        [self.contentView addSubview:lineV];
        self.lineV = lineV;
        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.iconImageV.frame=CGRectMake(15,11, 30, 30);
    self.right_arrowImageV.frame=CGRectMake(self.width-15-8, self.height*0.5-7, 8, 14);
    self.bgView.frame=CGRectMake(CGRectGetMaxX(self.iconImageV.frame)+10, self.iconImageV.top, self.right_arrowImageV.left-45-15, CGRectGetMaxY(_bgViewFrame));
    self.lineV.frame=CGRectMake(0, self.height-0.5, self.width, 0.5);
}
-(void)setIndexP:(NSIndexPath *)indexP{
    _indexP=indexP;
}
-(void)setArray:(NSArray *)array{
    _array=array;
    if (_array.count!=0) {
        if (_indexP.section==2) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type == %@",@(1)];
            NSArray *filteredArray = [_array filteredArrayUsingPredicate:predicate];
            NSLog(@"%@",filteredArray);
            if (filteredArray.count>0) {
                self.dict=filteredArray[0];
            }else{
                self.dict=@{@"type":@(1)};
            }
        }else{
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type == %@",@(_indexP.row+2)];
            NSArray *filteredArray = [_array filteredArrayUsingPredicate:predicate];
            NSLog(@"%@",filteredArray);
            if (filteredArray.count>0) {
                self.dict=filteredArray[0];
            }else{
                self.dict=@{@"type":@(_indexP.row+2)};
            }
        }
    }else{
        if (_indexP.section==2) {
            self.dict=@{@"type":@(1)};
        }else{
        self.dict=@{@"type":@(_indexP.row+2)};
        }
    }
}
-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    if ([dict[@"type"] integerValue]==1) {
        self.iconImageV.image=dzImageNamed(@"icon_label");
    }else if ([dict[@"type"] integerValue]==2) {
        self.iconImageV.image=dzImageNamed(@"icon_interest_travel");
    }else if ([dict[@"type"] integerValue]==3) {
        self.iconImageV.image=dzImageNamed(@"icon_interest_movie");
    }else if ([dict[@"type"] integerValue]==4){
        self.iconImageV.image=dzImageNamed(@"icon_interest_music");
    }else if ([dict[@"type"] integerValue]==5){
        self.iconImageV.image=dzImageNamed(@"icon_interest_sport");
    }else{
        self.iconImageV.image=dzImageNamed(@"icon_interest_food");
    }
    [self.bgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    CGRect maxframe=CGRectZero;
    if ([dict[@"label"] count]==0) {
        UILabel *label=[[UILabel alloc] init];
        label.frame=CGRectMake(0, 0, dzScreen_width-49,30);
        label.text=@"暂时还没有标签哦";
        label.font=dzFont(16);
        label.textColor=dzRgba(0, 0, 0, 0.6);
        [self.bgView addSubview:label];
    }else{
    for (int i=0; i<[dict[@"label"] count]; i++) {
        UILabel *label=[[UILabel alloc] init];
        label.frame=CGRectMake(0, 0, dzScreen_width-49, 100);
        label.text=dict[@"label"][i];
        label.textAlignment=NSTextAlignmentCenter;
        
        if ([dict[@"type"] integerValue]==1) {
            label.backgroundColor=DZColorFromRGB(0xDADCE6);
            label.textColor=DZColorFromRGB(0x5B6894);
        }else if ([dict[@"type"] integerValue]==2) {
            label.backgroundColor=DZColorFromRGB(0xE0F1F8);
            label.textColor=DZColorFromRGB(0x3995B8);
        }else if ([dict[@"type"] integerValue]==3) {
            label.backgroundColor=DZColorFromRGB(0xF1E6D5);
            label.textColor=DZColorFromRGB(0x9F7227);
        }else {
            label.backgroundColor=DZColorFromRGB(0xFFEAF1);
            label.textColor=DZColorFromRGB(0xBD0061);
        }
        
        label.font=dzFont(14);
        [self.bgView addSubview:label];
        [label sizeToFit];
        if (i==0) {
            label.frame=CGRectMake(CGRectGetMaxX(maxframe), maxframe.origin.y, label.width+20, 30);
        }else{
            if (CGRectGetMaxX(maxframe)+5+label.width+20<dzScreen_width-15-8-45-15) {
                label.frame=CGRectMake(CGRectGetMaxX(maxframe)+5, maxframe.origin.y, label.width+20, 30);
            }else{
                label.frame=CGRectMake(0,CGRectGetMaxY(maxframe)+5, label.width+20, 30);
            }
        }
        label.layer.cornerRadius=8;
        label.clipsToBounds=YES;
        maxframe=label.frame;
    }
        
    }
    _bgViewFrame=maxframe;
}
-(void)setIsEdit:(BOOL)isEdit{
    _isEdit=isEdit;
    self.right_arrowImageV.hidden=!isEdit;
}
+(CGFloat)hightArray:(NSArray *)array indexP:(NSIndexPath *)indexP{
    NSDictionary *dict=[[NSDictionary alloc]init];
    if (array.count!=0) {
        if (indexP.section==2) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type == %@",@(1)];
            NSArray *filteredArray = [array filteredArrayUsingPredicate:predicate];
            NSLog(@"%@",filteredArray);
            if (filteredArray.count>0) {
                dict=filteredArray[0];
            }else{
                dict=@{@"type":@(1)};
            }
        }else{
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type == %@",@(indexP.row+2)];
            NSArray *filteredArray = [array filteredArrayUsingPredicate:predicate];
            NSLog(@"%@",filteredArray);
            if (filteredArray.count>0) {
                dict=filteredArray[0];
            }else{
                dict=@{@"type":@(indexP.row+2)};
            }
        }
    }else{
        if (indexP.section==2) {
            dict=@{@"type":@(1)};
        }else{
            dict=@{@"type":@(indexP.row+2)};
        }
    }
    return [self hightDic:dict];
}
+(CGFloat)hightDic:(NSDictionary *)dict{
    CGRect maxframe=CGRectZero;
    if ([dict[@"label"] count]==0) {
        maxframe=CGRectMake(0, 0, 0, 30);
    }else{
    for (int i=0; i<[dict[@"label"] count]; i++) {
        UILabel *label=[[UILabel alloc] init];
        label.frame=CGRectMake(0, 0, dzScreen_width-49, 100);
        label.text=dict[@"label"][i];
        label.font=dzFont(14);
        [label sizeToFit];
        if (i==0) {
            label.frame=CGRectMake(CGRectGetMaxX(maxframe), maxframe.origin.y, label.width+20, 30);
        }else{
            if (CGRectGetMaxX(maxframe)+5+label.width+20<dzScreen_width-15-8-45-15) {
                label.frame=CGRectMake(CGRectGetMaxX(maxframe)+5, maxframe.origin.y, label.width+20, 30);
            }else{
                label.frame=CGRectMake(0,CGRectGetMaxY(maxframe)+5, label.width+20, 30);
            }
        }
        maxframe=label.frame;
    }
    }
    return CGRectGetMaxY(maxframe)+22;
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
