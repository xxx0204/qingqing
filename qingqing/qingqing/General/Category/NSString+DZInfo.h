//
//  NSString+DZInfo.h
//  onebyone
//
//  Created by Gavin on 2018/1/23.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZMemberModel.h"

#define dkMember @"meber"
#define dkLogin @"login"

@interface MemberInfo : NSObject
/**
 登录会话ID
 */
@property (nonatomic, copy) NSString *loginSessionId;
/**
 会员id
 */
@property (nonatomic, assign)NSInteger id;
/**
 出生日期（xxxx-xx-xx）
 */
@property (nonatomic, copy) NSString *birthDate;
/**
 性别 （1、男；2、女）
 */
@property (nonatomic, assign) NSInteger sex;
/**
 会话token
 */
@property (nonatomic, copy) NSString *rongCloudToken;

@property (nonatomic, copy) NSString *password;
/**
 会员昵称
 */
@property (nonatomic, copy) NSString *nickname;
/**
 会员头像
 */
@property (nonatomic, copy) NSString *headPicUrl;

/**
 会员账号（手机号）
 */
@property (nonatomic, copy) NSString *mobileNumber;


///**
// 会员好友id
// */
//@property (nonatomic, assign) NSInteger currentFriendId;
//
///**
// 自我介绍
// */
//@property (nonatomic, copy) NSString *selfIntro;
//
//@property (nonatomic, assign) NSInteger activityLevel;
//
//@property (nonatomic, copy) NSString *loginName;
//
//@property (nonatomic, assign) NSInteger areaType;
//
//@property (nonatomic, assign) long long lastChatTime;
//
//@property (nonatomic, assign) NSInteger friendTypeSetting;
//
//
//@property (nonatomic, assign) NSInteger friendType;
//
//@property (nonatomic, assign) NSInteger initStatus;
//
//@property (nonatomic, copy) NSString *relationTime;
//
//@property (nonatomic, assign) long long lastRelationEndTime;
//
//@property (nonatomic, assign) NSInteger cityId;

@end


typedef void(^isLoginBlock)(BOOL isLogin);

@interface NSString (DZInfo)

//+(void)saveHuiHuaId:(BOOL)isHuiHua;
//+(BOOL)readHuiHuaId;
/**
 保存会员信息
 
 @param meber 会员表信息
 */
+(void)saveMember:(DZMemberModel *)meber;
/**
 读取会员信息
 
 @return 会员表信息
 */
+(MemberInfo *)readMember;
/**
 判断是否登录 不带提示
 
 @return YES：登录，NO：未登录；默认 NO（0）;
 */
+(BOOL)isLogin;
/**
 判断是否登录 自带提示
 
 @return YES：登录，NO：未登录；默认 NO（0）；
 */
+(BOOL)isLoginHint;
/**
 判断是否登录 登录后可处理后续操作
 
 @param controller 当前控制器
 @param block 登录结果判断
 */
+(void)isLoginGoNo:(UIViewController *)controller block:(isLoginBlock)block;

/**
 删除会员信息
 */
+(void)deleteMember;
/**
 获取会员头像
 
 @return 会员头像
 */
+(NSString *)memberFace;
/**
 获取融云会话token

 @return 融云会话token
 */
+(NSString *)sessionToken;
/**
 获取会员id
 
 @return 会员id
 */

+(NSString *)memberId;/*旧方法*/
+(NSInteger)accountId;/*新方法*/
/**
 性别

 @return 性别
 */
+(NSString *)memberSex;

/**
 会员好友id

 @return 会员好友id
 */
//+(NSInteger)memberFriendId;
/**
 会员会话id

 @return 会员会话id
 */
+(NSString *)memberLoginSessionId;

//会员账户（手机号）
+(NSString *)memberAccount;

/**
 获取会员昵称
 
 @return 会员昵称
 */
+(NSString *)memberNickName;
/**
 修改个人资料

 @param memberInfo 修改后的个人资料
 @return 修改结果（YES 修改成功  NO 修改失败）
 */
+(BOOL)modifyMember:(MemberInfo *)memberInfo;
/**
 修改指定用户信息

 @param type 修改类型 1：修改昵称  2：修改性别 3：修改头像 4：修改生日
 @param value 修改后的值
 @return 修改结果  YES 成功  NO  失败
 */
+(BOOL)modifyMemberType:(NSInteger)type value:(NSString *)value;
/**
 字符串空处理
 
 @param str 需要处理的字符串
 @return 处理后的字符串
 */
+(NSString *)getNullStr:(NSString *)str;
+(NSString*)convertToJSONData:(id)infoDict;
+(NSString *)timeIntoTimeOne:(NSString *)timeStr;
/**
 首次安装添加
 */
+(void)addFirstStart;
/**
 获取判断是否第一次使用该功能状态

 @param statusType 类型
 @return BOOL 返回判断结果
 */
+(BOOL)isStatus:(NSInteger)statusType;
/**
 更改首次使用提醒界面

 @param statusType 类型
 */
+(void)changeStatus:(NSInteger)statusType;
/**
 给图片添加路径

 @param path 图片地址
 @return 返回正确的路径
 */
+(NSString *)picUrlPath:(NSString *)path;
+(NSString *)timeStr:(NSString *)timestamp timeFormat:(NSString *)timeFormat;
+(double)remainTimestamp:(double)timestamp;
+(NSString *)getMinutes:(double)timestamp;
+(NSString *)getHour:(double)timestamp;
+(NSString *)getTimestamp:(double)timestamp;
@end
