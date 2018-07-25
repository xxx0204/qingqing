//
//  DZSetHeadPortraitsViewController.h
//  qingqing
//
//  Created by Gavin on 2018/5/9.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZMemberViewController.h"

@interface DZSetHeadPortraitsViewController : DZMemberViewController
@property(nonatomic,assign)NSInteger frameTypeI;//1来自审核失败
@property(nonatomic,assign)NSInteger sexS;
@property(nonatomic,strong) NSString *phoneNumS,*passwordS,*nicknameS,*birthDateS,*mobileCodeS;
@end
