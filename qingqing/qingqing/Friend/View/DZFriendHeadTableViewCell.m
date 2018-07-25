//
//  DZFriendHeadTableViewCell.m
//  qingqing
//
//  Created by Gavin on 2018/5/15.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZFriendHeadTableViewCell.h"

@implementation DZFriendHeadTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellName=@"FriendHead Cell";
    DZFriendHeadTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell=[[DZFriendHeadTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
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
-(void)setCountI:(NSInteger)countI{
    _countI=countI;
}
-(void)setArray:(NSArray *)array{
    CGRect viewFrame=CGRectMake(15, 10, 90, 90);
     [self.headScrollV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i=0; i<array.count; i++) {
        DZGMModel *dz_GM_M=array[i];
        UIView *bgView=[[UIView alloc] init];
        bgView.frame=viewFrame;
        bgView.layer.cornerRadius=viewFrame.size.height*0.5;
        if (dz_GM_M.type==1) {
            bgView.backgroundColor=[UIColor redColor];
        }else if (dz_GM_M.type==2){
            bgView.backgroundColor=[UIColor greenColor];
        }else if (dz_GM_M.type==3){
            bgView.backgroundColor=[UIColor orangeColor];
        }else if (dz_GM_M.type==4){
            bgView.backgroundColor=DZColorFromRGB(0xFFB1CC);
        }else{
            bgView.backgroundColor=[UIColor grayColor];
        }
//        bgView.backgroundColor=DZColorFromRGB(0xFFB1CC);
        [self.headScrollV addSubview:bgView];
        viewFrame=CGRectMake(CGRectGetMaxX(bgView.frame)+20,bgView.top, bgView.width, bgView.height);
        
        UIButton *imageBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        imageBtn.frame=CGRectMake(0, 0, bgView.width-6, bgView.height-6);
        imageBtn.center=CGPointMake(bgView.width*0.5, bgView.height*0.5);
        imageBtn.tag=i;//dz_GM_M.type;
//        imageV.image=iconImage;
        imageBtn.backgroundColor=[UIColor whiteColor];
        imageBtn.layer.cornerRadius= bgView.height*0.5-3;
        imageBtn.clipsToBounds=YES;
        imageBtn.imageView.contentMode=UIViewContentModeScaleAspectFill;
        [imageBtn sd_setImageWithURL:[NSURL URLWithString:[NSString picUrlPath:dz_GM_M.headPicUrl]] forState:UIControlStateNormal placeholderImage:dzImageNamed(@"default_head")];
//        if (dz_GM_M.headPicUrl.length==0) {
//            [imageBtn setImage:dzImageNamed(@"default_head") forState:UIControlStateNormal];
//        }
        [imageBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:imageBtn];
        
        if (dz_GM_M.type==1) {
            UIImageView *imageV=[[UIImageView alloc] init];
            imageV.image=dzImageNamed(@"timeRemind");
            imageV.frame=CGRectMake(CGRectGetMaxX(bgView.frame)-25, CGRectGetMaxY(bgView.frame)-25, 25, 25);
            [self.headScrollV addSubview:imageV];

            UILabel *timeL=[[UILabel alloc] init];
            timeL.frame=CGRectMake(0, 0, imageV.width, imageV.height);
            timeL.text=[NSString getMinutes:dz_GM_M.buildTime];
            timeL.font=dzFont(14);
            timeL.textAlignment=NSTextAlignmentCenter;
            timeL.textColor=[UIColor whiteColor];
            [imageV addSubview:timeL];
        }else if (dz_GM_M.type==2){
            UILabel *numberL=[[UILabel alloc] init];
            numberL.frame=CGRectMake(0, 0, imageBtn.width, imageBtn.height);
            numberL.text=[NSString stringWithFormat:@"%ld+",(long)self.countI];
            numberL.font=dzHelvetica_bold(20);
            numberL.backgroundColor=dzRgba(0, 0, 0, 0.5);
            numberL.textAlignment=NSTextAlignmentCenter;
            numberL.textColor=[UIColor whiteColor];
            [imageBtn addSubview:numberL];
        }
    }
    
    self.headScrollV.contentSize=CGSizeMake(CGRectGetMaxX(viewFrame)-20-viewFrame.size.width+15, self.height);
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.headScrollV.frame=CGRectMake(0, 0, dzScreen_width, self.height);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)btnClick:(UIButton *)btn{
    NSLog(@"%ld",(long)btn.tag);
    if (self.headPortraitsBlock) {
        self.headPortraitsBlock(btn);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
