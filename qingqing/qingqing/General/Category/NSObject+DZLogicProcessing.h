//
//  NSObject+DZLogicProcessing.h
//  qingqing
//
//  Created by Gavin on 2018/5/27.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#define dzLike @"like"
#define dztemporaryLike @"temporaryLike"


@interface NSObject (DZLogicProcessing)
+(void)createLike;
+(BOOL)addIsLike:(BOOL)isLike andQqId:(NSInteger)qQid;
+(NSDictionary *)readLike;
+(BOOL)isWhetherData;
+(void)deleteLike;
+(BOOL)failureLike;
+(NSDictionary *)upReadLike;
@end
