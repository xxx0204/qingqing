//
//  DZCodeView.h
//  CodeInput
//
//  Created by Gavin on 2018/4/25.
//  Copyright © 2018年 Saborka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZCodeView : UIView

@property (nonatomic,copy)  void(^finishBlock)(NSString *codeS);

- (void)beginEdit;

- (void)endEdit;

- (NSString *)getCode;

@end
