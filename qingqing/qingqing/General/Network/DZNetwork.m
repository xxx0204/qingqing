//
//  DZNetwork.m
//  onebyone
//
//  Created by Gavin on 2018/1/24.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZNetwork.h"
#import "DZAppDelegate.h"

@implementation DZNetwork

+(void)post_ph:(NSString *)ph np:(id)np class:(__unsafe_unretained Class)mc success:(RequestSuccess)success failure:(RequestFailed)failure{
    [DZNetworkHelper POST:[NSString stringWithFormat:@"%@/%@",http_java,[NSString getNullStr:ph]] parameters:np success:^(id responseObject) {
        NSLog(@"nb == %@",[self jsonToString:responseObject]);
        if (mc!=nil) {
            id class = [mc mj_objectWithKeyValues:responseObject];
            success(class);
        }else{
            success(responseObject);
        }
        if ([responseObject[@"resultCode"] integerValue]==1001) {
            [NSString deleteMember];
            DZAppDelegate *appDelegate = (DZAppDelegate *) [[UIApplication sharedApplication] delegate];
            [appDelegate gotoLogin:YES];
        }
    } failure:^(NSError *error) {
        failure(error);
        [self hintNetwork:error.localizedDescription];
    }];
}
+(void)get_ph:(NSString *)ph np:(NSString *)np class:(__unsafe_unretained Class)mc success:(RequestSuccess)success failure:(RequestFailed)failure{
    [DZNetworkHelper GET:[NSString stringWithFormat:@"%@/%@/%@",http_java,ph,np] parameters:nil success:^(id responseObject) {
        NSLog(@"nb == %@",responseObject);
        if (mc!=nil) {
            id class = [mc mj_objectWithKeyValues:responseObject];
            success(class);
        }else{
            success(responseObject);
        }
    } failure:^(NSError *error) {
        failure(error);
        [self hintNetwork:error.localizedDescription];
    }];
}
+(void)up_ph:(NSString *)ph np:(id)np im:(UIImage *)im progress:(UpProgress)pro success:(RequestSuccess)success failure:(RequestFailed)failure{
    if (im==nil) {
        [self hintNetwork:@"请选择图片"];
        failure(nil);
    }else{
        [DZNetworkHelper uploadImagesWithURL:[NSString stringWithFormat:@"%@/%@",http_java,[NSString getNullStr:ph]] parameters:np name:@"picture" images:@[im] fileNames:@[@"filename"] imageScale:0.2 imageType:nil progress:^(NSProgress *progress) {
            pro(progress);
        } success:^(id responseObject) {
            success(responseObject);
        } failure:^(NSError *error) {
            failure(error);
            [self hintNetwork:error.localizedDescription];
        }];
    }
}

+ (NSString *)jsonToString:(id)data {
    if(data == nil) { return nil; }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
+(void)hintNetwork:(NSString *)hintText{
    [EasyTextView showText:[NSString getNullStr:hintText] config:^EasyTextConfig *{
        EasyTextConfig *config = [EasyTextConfig shared];
        config.bgColor = [UIColor lightGrayColor] ;
        config.shadowColor = [UIColor clearColor] ;
        config.animationType = TextAnimationTypeFade;
        config.statusType = TextStatusTypeBottom ;
        return config ;
    }];
}
+(void)temporaryHintNetwork:(NSString *)hintText{
    [EasyTextView showText:[NSString getNullStr:hintText] config:^EasyTextConfig *{
        EasyTextConfig *config = [EasyTextConfig shared];
        config.bgColor = [UIColor lightGrayColor] ;
        config.shadowColor = [UIColor clearColor] ;
        config.animationType = TextAnimationTypeFade;
        config.statusType = TextStatusTypeMidden ;
        return config ;
    }];
}

/***********图片处理****************/
#pragma mark - 图片处理
+(NSData *)PictureWithImage:(UIImage *)tempImage newSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [tempImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImageJPEGRepresentation(newImage, 0.2);
}
+(NSData *)PictureWithImage:(UIImage *)tempImage{
    NSData* imageData = [self PictureWithImage:tempImage newSize:tempImage.size];
    return imageData;
}
@end
