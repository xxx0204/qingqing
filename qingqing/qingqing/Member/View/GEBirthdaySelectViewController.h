//
//  GEBirthdaySelectViewController.h
//  gocen
//
//  Created by Gavin on 2017/9/14.
//  Copyright © 2017年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GEBirthdaySelectViewController : UIViewController
@property (nonatomic,copy)  void(^selectBlock)(BOOL isSelect,NSString *valueStr);
- (void)showPullDownVC;
@end
