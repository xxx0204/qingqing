//
//  NSObject+DZLogicProcessing.m
//  qingqing
//
//  Created by Gavin on 2018/5/27.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "NSObject+DZLogicProcessing.h"

@implementation NSObject (DZLogicProcessing)
+(void)createLike{
    NSMutableDictionary *dict=[@{@"like":@[],@"unLike":@[]} mutableCopy];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:dict forKey:dzLike];
    [defaults synchronize];
}
+(BOOL)addIsLike:(BOOL)isLike andQqId:(NSInteger)qQid{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dict = [defaults objectForKey:dzLike];
    NSMutableArray *likeArray=[dict[@"like"] mutableCopy];
    NSMutableArray *unLikeArray=[dict[@"unLike"] mutableCopy];
    if ((likeArray.count+unLikeArray.count)<10) {
        if (isLike) {
            [likeArray addObject:@(qQid)];
        }else{
            [unLikeArray addObject:@(qQid)];
        }
        dict=[@{@"like":likeArray,@"unLike":unLikeArray} mutableCopy];
        [defaults setObject:dict forKey:dzLike];
        [defaults synchronize];
    }
    return YES;
}
+(NSDictionary *)readLike{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defaults objectForKey:dzLike];
    return dict;
}
+(NSDictionary *)upReadLike{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defaults objectForKey:dzLike];
    [defaults setObject:[@{@"like":@[],@"unLike":@[]} mutableCopy] forKey:dzLike];
    [defaults setObject:dict forKey:dztemporaryLike];
    [defaults synchronize];
    return dict;
}
+(BOOL)failureLike{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defaults objectForKey:dztemporaryLike];
    NSMutableDictionary *likeDict = [defaults objectForKey:dzLike];
    if ([dict[@"like"] count]!=0||[dict[@"unLike"] count]!=0) {
        NSMutableArray *likeArray=[likeDict[@"like"] mutableCopy];
        NSMutableArray *unLikeArray=[likeDict[@"unLike"] mutableCopy];
        [likeArray addObjectsFromArray:dict[@"like"]];
        [unLikeArray addObjectsFromArray:dict[@"unLike"]];
        likeDict=[@{@"like":likeArray,@"unLike":unLikeArray} mutableCopy];
        [defaults setObject:dict forKey:dzLike];
        [defaults synchronize];
        return YES;
    }
    return NO;
}
+(void)deleteLike{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[@{@"like":@[],@"unLike":@[]} mutableCopy] forKey:dztemporaryLike];
    [defaults synchronize];
}
+(BOOL)isWhetherData{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defaults objectForKey:dzLike];

    return ([dict[@"like"] count]!=0||[dict[@"unLike"] count]!=0);
}
@end
