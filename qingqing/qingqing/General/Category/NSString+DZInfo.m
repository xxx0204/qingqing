//
//  NSString+DZInfo.m
//  onebyone
//
//  Created by Gavin on 2018/1/23.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "NSString+DZInfo.h"

@implementation NSString (DZInfo)

+(void)addFirstStart{
    // 获取用户偏好设置对象
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"likeMe"];//绿色 （喜欢我的
    [defaults setBool:YES forKey:@"match"];//橙色 正常匹配
    [defaults setBool:YES forKey:@"matchNearExpire"];//红色等待聊天1小时以内显示
    [defaults setBool:YES forKey:@"matchExtension"];//粉色 延期
    [defaults setBool:YES forKey:@"matchExpire"];//灰色  过期
//    [defaults setBool:YES forKey:@""];//
//    [defaults setBool:YES forKey:@""];//
//    [defaults setBool:YES forKey:@""];//
//    [defaults setBool:YES forKey:@""];//
    [defaults synchronize];
}
+(BOOL)isStatus:(NSInteger)statusType{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    switch (statusType) {
        case 1:{
            return [defaults boolForKey:@"matchNearExpire"];
        }
            break;
        case 2:{
            return [defaults boolForKey:@"likeMe"];
        }
            break;
        case 3:{
            return [defaults boolForKey:@"match"];
        }
            break;
        case 4:{
            return [defaults boolForKey:@"matchExtension"];
        }
            break;
        case 5:{
            return [defaults boolForKey:@"matchExpire"];
        }
            break;
            
        default:
            return NO;
            break;
    }
}
+(void)changeStatus:(NSInteger)statusType{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    switch (statusType) {
        case 1:{
            [defaults setBool:NO forKey:@"matchNearExpire"];
        }
            break;
        case 2:{
            [defaults setBool:NO forKey:@"likeMe"];
        }
            break;
        case 3:{
            [defaults setBool:NO forKey:@"match"];
        }
            break;
        case 4:{
            [defaults setBool:NO forKey:@"matchExtension"];
        }
            break;
        case 5:{
            [defaults setBool:NO forKey:@"matchExpire"];
        }
            break;
        default:
            break;
    }
    [defaults synchronize];
}
//+(void)saveHuiHuaId:(BOOL)isHuiHua{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setBool:isHuiHua forKey:@"huihuaid"];
//    [defaults synchronize];
//}
//+(BOOL)readHuiHuaId{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults boolForKey:@"huihuaid"];
//}
/**
 保存会员信息
 
 @param meber 会员表信息
 */
+(void)saveMember:(DZMemberModel *)meber{
    NSLog(@"meber==>%@",meber);
    MemberInfo *memberInfo=[[MemberInfo alloc] init];
    memberInfo.rongCloudToken=[NSString getNullStr:meber.account.rongCloudToken];
    memberInfo.loginSessionId=[NSString getNullStr:meber.loginSessionId];
    memberInfo.headPicUrl=[NSString getNullStr:meber.account.headPicUrl];
    memberInfo.nickname=[NSString getNullStr:meber.account.nickname];
    memberInfo.sex=meber.account.sex;
    memberInfo.birthDate=[NSString getNullStr:meber.account.birthDate];
    memberInfo.password=[NSString getNullStr:meber.account.password];
    memberInfo.id=meber.account.id;
    memberInfo.mobileNumber=[NSString getNullStr:meber.account.mobileNumber];
    
    NSData *myMemberInfoObject = [NSKeyedArchiver archivedDataWithRootObject:memberInfo];
    // 获取用户偏好设置对象
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 保存用户偏好设置
    [defaults setObject:myMemberInfoObject forKey:dkMember];
    [defaults setBool:YES forKey:dkLogin];
    [defaults synchronize];
    [PPNetworkHelper initialize];
}
+(NSString *)sessionToken{
    return [self getNullStr:[self readMember].rongCloudToken];
}
+(NSString *)memberLoginSessionId{
    return [self getNullStr:[self readMember].loginSessionId];
}
+(NSString *)picUrlPath:(NSString *)path{
    if ([[self getNullStr:path] hasPrefix:@"http"]) {
        return path;
    }
    return [NSString stringWithFormat:@"%@/%@",http_java,path];
}

/**
 读取会员信息
 
 @return 会员表信息
 */
+(MemberInfo *)readMember{
    //获取用户偏好设置对象
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *myMemberInfoObject = [defaults objectForKey:dkMember];
    MemberInfo *memberInfo = (MemberInfo *)[NSKeyedUnarchiver unarchiveObjectWithData:myMemberInfoObject];
    return memberInfo;
}
+(BOOL)modifyMember:(MemberInfo *)memberInfo{
    NSData *modifyMemberInfoObject = [NSKeyedArchiver archivedDataWithRootObject:memberInfo];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:modifyMemberInfoObject forKey:dkMember];
    [defaults synchronize];
    return YES;
}
+(BOOL)modifyMemberType:(NSInteger)type value:(NSString *)value{
//    @param type 修改类型 1：修改昵称  2：修改性别 3：修改头像 4：修改生日

    MemberInfo *memberInfo=[self readMember];
    switch (type) {
        case 1:
            memberInfo.nickname=value;
        break;
        case 2:
            memberInfo.sex=[value isEqualToString:@"男"] ? 1:2;
            break;
        case 3:
            memberInfo.headPicUrl=value;
            break;
        case 4:
//            memberInfo.birthDate=value;
            break;
            
        default:
            break;
    }
    NSData *myMemberInfoObject = [NSKeyedArchiver archivedDataWithRootObject:memberInfo];
    // 获取用户偏好设置对象
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 保存用户偏好设置
    [defaults setObject:myMemberInfoObject forKey:dkMember];
    [defaults synchronize];
    
    return YES;
}
/**
 判断是否登录 不带提示
 
 @return YES：登录，NO：未登录；默认 NO（0）;
 */
+(BOOL)isLogin{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:dkLogin];//0  NO
}
/**
 判断是否登录 自带提示
 
 @return YES：登录，NO：未登录；默认 NO（0）；
 */
+(BOOL)isLoginHint{
    if (![self isLogin]) {
        //        [NSObject showHUDType:TypeText text:gstLocal(@"gst_01004")];
    }
    return [self isLogin];
}
/**
 判断是否登录 登录后可处理后续操作
 
 @param controller 当前控制器
 @param block 登录结果判断
 */
+(void)isLoginGoNo:(UIViewController *)controller block:(isLoginBlock)block{
    if (![self isLogin]) {
        //        GELoginViewController *geLvc=[GELoginViewController new];
        //        geLvc.source=1;
        //        geLvc.isLoginBlock = ^(BOOL isLogin) {
        //            block(isLogin);
        //        };
        //        [DKGeneralMethod preJump:controller nextLevel:geLvc];
    }else{
        block(YES);
    }
}

/**
 删除会员信息
 */
+(void)deleteMember{
    // 获取用户偏好设置对象
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 保存用户偏好设置
    [defaults setObject:nil forKey:dkMember];
    [defaults setBool:NO forKey:dkLogin];
    [defaults synchronize];
}

+(NSString *)memberFace{
    return [self getNullStr:[self readMember].headPicUrl];
}
+(NSString *)memberSex{
    return [self readMember].sex==1 ? @"男":@"女";
}
+(NSString *)memberId{
    return [NSString stringWithFormat:@"%ld",(long)[self readMember].id];
//    return [self getNullStr:[[NSUserDefaults standardUserDefaults] objectForKey:dkMember][@"cuId"]];
}
+(NSInteger)accountId{
    return [self readMember].id;
}
//+(NSInteger)memberFriendId{
//    return [self readMember].currentFriendId;
//}
//会员账户（手机号）
+(NSString *)memberAccount{
    return [self getNullStr:[self readMember].mobileNumber];
}

/**
 获取会员昵称
 
 @return 会员昵称
 */
+(NSString *)memberNickName{
    return [self getNullStr:[self readMember].nickname];
}

+(NSString *)getNullStr:(NSString *)str{
    NSString *strr=[NSString stringWithFormat:@"%@",str];
    if (strr.length==0||strr==nil||[strr isEqualToString:@"<null>"]||[strr isEqualToString:@"(null)"]){
        str=@"";
    }
    return str;
}
+(NSString*)convertToJSONData:(id)infoDict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:infoDict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    NSString *jsonString = @"";
    
    if (! jsonData)
    {
        NSLog(@"Got an error: %@", error);
    }else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return jsonString;
}
+(NSString *)timeStr:(NSString *)timestamp timeFormat:(NSString *)timeFormat{
    // timeStampString 是服务器返回的13位时间戳
    NSString *timeStampString  = @"1495453213000";
//    NSString *timeStampString  = timestamp;
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[timeStampString doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:timeFormat];//@"yyyy-MM-dd HH:mm:ss"
    NSString *dateString       = [formatter stringFromDate: date];
    NSLog(@"服务器返回的时间戳对应的时间是:%@",dateString);
    return dateString;
}
+(NSString *)timeIntoTimeOne:(NSString *)timeStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    /* 设置时区 */
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [dateFormatter setTimeZone:timeZone];
    
    NSDate* date = [dateFormatter dateFromString:timeStr];//将源时间字符串转化为NSDate
    NSDateFormatter* toformatter = [[NSDateFormatter alloc] init];
    [toformatter setDateStyle:NSDateFormatterMediumStyle];
    [toformatter setTimeStyle:NSDateFormatterShortStyle];
    [toformatter setDateFormat:@"yyyy/MM/dd"];//设置目标时间字符串的格式
    NSString *targetTime = [toformatter stringFromDate:date];
    return  [NSString getNullStr:targetTime];
}
+(NSString *)getTimestamp:(double)timestamp{
    //获取当前时间戳
    //将服务器返回的毫秒时间戳转换成秒
    NSTimeInterval interval=timestamp/1000;
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:interval];//[NSDatedateWithTimeIntervalSince1970:interval];
    //设置时间格式
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    //将时间转换为字符串
    NSString *timeStr=[formatter stringFromDate:myDate];
    return timeStr;
}
+(double)remainTimestamp:(double)timestamp{
    NSDate *senddate = [NSDate date];
    //获取当前时间戳
    NSString *dateStr =[NSString stringWithFormat:@"%ld",(long)[senddate timeIntervalSince1970]];
    //将服务器返回的毫秒时间戳转换成秒
    NSTimeInterval interval=(timestamp/1000)+86400;//doubleValue
    NSTimeInterval dateInterval=[dateStr doubleValue];
    NSLog(@"%f=%f",interval,dateInterval);
    return interval-dateInterval;
//    if (interval-dateInterval<-86400) {
//        return 0;//过期24小时，不显示
//    }else if (interval-dateInterval<0) {
//        return 1;//灰色 过期
//    }else if (interval-dateInterval<3600) {
//        return 2;//红色  倒计时（分钟）
//    }else{
//        return 3;//橙色  正常等待
//    }
}
+(NSString *)getMinutes:(double)timestamp{
    NSTimeInterval interval=[self remainTimestamp:timestamp];
    return [NSString stringWithFormat:@"%.f",interval/60];
}
+(NSString *)getHour:(double)timestamp{
    NSTimeInterval interval=[self remainTimestamp:timestamp];
    return [NSString stringWithFormat:@"%.f",interval/3600];
}
@end

@implementation MemberInfo
-(void)encodeWithCoder:(NSCoder *)encoder{
    encodeRuntime(MemberInfo)
//    [encoder encodeObject:self.rongCloudToken forKey:@"rongCloudToken"];
//    [encoder encodeObject:self.loginSessionId forKey:@"loginSessionId"];
//    [encoder encodeObject:self.headPicUrl forKey:@"headPicUrl"];
//    [encoder encodeObject:self.nickname forKey:@"nickname"];
//    [encoder encodeObject:@(self.sex) forKey:@"sex"];
//    [encoder encodeObject:self.birthDate forKey:@"birthDate"];
//    [encoder encodeObject:self.password forKey:@"password"];
//    [encoder encodeObject:@(self.id) forKey:@"id"];
}
-(id)initWithCoder:(NSCoder *)decoder{
    initCoderRuntime(MemberInfo)
//    if(self = [super init]){
//        self.rongCloudToken = [decoder decodeObjectForKey:@"rongCloudToken"];
//        self.loginSessionId = [decoder decodeObjectForKey:@"loginSessionId"];
//        self.headPicUrl = [decoder decodeObjectForKey:@"headPicUrl"];
//        self.nickname = [decoder decodeObjectForKey:@"nickname"];
//        self.sex = [[decoder decodeObjectForKey:@"sex"] integerValue];
//        self.birthDate = [decoder decodeObjectForKey:@"birthDate"];
//        self.password = [decoder decodeObjectForKey:@"password"];
//        self.id = [[decoder decodeObjectForKey:@"id"] integerValue];
//    }
//    return  self;
}
@end
