//
//  DZCodeView.m
//  CodeInput
//
//  Created by Gavin on 2018/4/25.
//  Copyright © 2018年 Saborka. All rights reserved.
//

#import "DZCodeView.h"

#define MaxLength       4

@interface DZCodeView () <UITextViewDelegate>

@property (strong, nonatomic)UITextView *myTextView;
@property (strong, nonatomic)UIView *containerView;

@end

@implementation DZCodeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self uiConfig];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self uiConfig];
    }
    return self;
}

- (void)uiConfig{
    UITextView *myTextView=[[UITextView alloc] init];
    myTextView.keyboardType=UIKeyboardTypeNumberPad;
    [self addSubview:myTextView];
    self.myTextView=myTextView;
    UIView *containerView=[[UIView alloc] init];
    containerView.frame=CGRectMake(0, 0, self.width,self.height);
    for (int i=0; i<MaxLength;i++) {
        UILabel *label=[[UILabel alloc]init];
        label.frame=CGRectMake(i*(containerView.width-30)/4+i*10,0 , (containerView.width-30)/4, containerView.height);
//        label.backgroundColor=[UIColor yellowColor];
        label.textAlignment=NSTextAlignmentCenter;
        label.layer.borderWidth=2;
        label.layer.borderColor=DZColorFromRGB(0xFFEDED).CGColor;
        label.textColor=DZColorFromRGB(0xB0B0B0);
        label.font=dzFont(48);
        [containerView addSubview:label];
    }
    [self addSubview:containerView];
    self.containerView=containerView;
    self.myTextView.delegate = self;
}

-(void)beginEdit{
    [self.myTextView becomeFirstResponder];
}

-(void)endEdit{
    [self.myTextView resignFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView{
    NSString *str = textView.text;
    if (str.length > MaxLength) {  //大于的截取，反向赋值给textView，这样删除，才能立即删除.
        str = [str substringToIndex:MaxLength];
        textView.text = str;
    }else{  //不够的就补空格。
        long needSpaceCount = MaxLength - str.length;
        if (needSpaceCount > 0) {
            NSMutableString *spaceStr = [NSMutableString string];
            for (int i=0; i < needSpaceCount; i++) {
                [spaceStr appendString:@" "];
            }
            str = [NSString stringWithFormat:@"%@%@",str,spaceStr];
        }
        if (textView.text.length==MaxLength) {
            NSLog(@"%@",textView.text);
            if (self.finishBlock) {
                self.finishBlock(textView.text);
            }
        }
    }
    
    for (int i= 0; i < MaxLength; i++) { //每一次输入都对所有的label重新赋值，先取对应的字符，找到对应的label，给他。
        NSString *temp = [str substringWithRange:NSMakeRange(i, 1)];
        if (self.containerView.subviews.count > i) {
            UILabel *label = [self.containerView.subviews objectAtIndex:i];
            label.text = temp;
            if ([label.text isEqualToString:@" "]) {
                label.layer.borderColor=DZColorFromRGB(0xFFEDED).CGColor;
            }else{
                label.layer.borderColor=DZColorFromRGB(0xE0BBBB).CGColor;
            }
        }
    }
}

-(NSString *)getCode{
    return self.myTextView.text;
}
@end
