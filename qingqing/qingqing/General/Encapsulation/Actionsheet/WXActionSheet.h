//
//  WXActionSheet.h
//  WXActionsheet
//
//  Created by apple on 16/6/6.
//  Copyright © 2016年 WangXu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WXActionSheet;

@protocol WXActionSheetDelegate <NSObject>
@optional
//如果点击的是空白处，那么index的值设为－1
- (void)actionSheet:(WXActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
//设计是点击cacel按钮会调用
- (void)actionSheetCancel:(WXActionSheet *)actionSheet;

- (void)willPresentActionSheet:(WXActionSheet *)actionSheet;

- (void)didPresentActionSheet:(WXActionSheet *)actionSheet;

- (void)actionSheet:(WXActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex;

- (void)actionSheet:(WXActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;

@end

@interface WXActionSheet : UIView<UITableViewDataSource,UITableViewDelegate>

- (UIView *)initWithTitle:(NSString *)title delegate:(id<WXActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:( NSString *)destructiveButtonTitle otherButtonTitles:( NSString *)otherButtonTitles, ...;

- (void)showInView:(UIView *)view;

@end
