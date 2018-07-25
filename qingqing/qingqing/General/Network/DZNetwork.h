//
//  DZNetwork.h
//  onebyone
//
//  Created by Gavin on 2018/1/24.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZNetworkHelper.h"
#import "MJExtension.h"

//#define http_java @"http://10.2.4.234:8080/appapi"
//#define http_java @"http://114.115.204.243:8080/appapi"
#define http_java @"http://qingqingapp.cn:8080/appapi"
#define post_verifyRegister @"checkRegister"//验证注册
#define post_sendVerifyCode @"sendMobileVerifyCode"//发送验证码
#define post_checkVerifyCode @"checkMobileVerifyCode"//检查验证是否正确
#define post_login @"login"//登陆
#define post_setPassword @"setPassword"//设置密码
#define post_register @"register"//注册
#define post_recommendList @"getRecommendList"//获取推荐列表
#define post_uploadPicture @"uploadPicture"//上传照片
#define post_upLikeAndUnLike @"markOpinionForPerson"//上传喜欢或者不喜欢的用户
#define post_friendsList @"getRelationList"//好友列表
#define post_firstMessage @"sendFirstChat"//与好友首次聊天通知后台接口
#define post_likeMeList @"getOtherAccount"//获取列表
#define post_getSelfInfo @"getSelfAccount"//获取个人信息
#define post_getInfoList @"getUserAppendOption"//获取信息标签
#define post_getEditorInfo @"setAccountAttribute"//编辑个人资料
#define post_editorLabel @"setAccountFlag"//编辑标签
#define post_saveFAQs @"setQuestionAndAnswer"//保存问答
#define post_applyExtension @"applyExtension"//延长等待时间
#define post_submitFeedback @"submitFeedback"//提交意见反馈
#define post_setShieldPhone @"setShieldPhone"//设置屏蔽通讯录
#define post_deletePicture @"deletePicture"//删除图片
/** 请求成功的Block */
typedef void(^RequestSuccess)(id data);

/** 请求失败的Block */
typedef void(^RequestFailed)(NSError *error);

/** 文件上传进度Block */
typedef void(^UpProgress)(NSProgress *progress);

@interface DZNetwork : NSObject
/**
 java post通用请求
 
 @param ph 接口地址（ph==>path）
 @param np 不需要加密的参数（np==>normalParams）
 @param mc 数据模型（mc==>modelClass）
 @param success block 成功数据
 @param failure block 接口访问失败数据
 */
+(void)post_ph:(NSString *)ph np:(id)np class:(__unsafe_unretained Class)mc success:(RequestSuccess)success failure:(RequestFailed)failure;
/**
 java get通用请求

 @param ph 接口地址 （ph==>path）
 @param np 不需要加密的参数（np==>normalParams）
 @param mc 数据模型（mc==>modelClass）
 @param success block 成功数据
 @param failure 接口访问失败数据
 */
+(void)get_ph:(NSString *)ph np:(NSString *)np class:(__unsafe_unretained Class)mc success:(RequestSuccess)success failure:(RequestFailed)failure;
/**
 java 上传图片
 
 @param ph 接口地址（ph==>path）
 @param np 不需要加密的参数（np==>normalParams）
 @param im 需要上传的图片 单张 （im==>image）
 @param pro block 上传进度
 @param success block 成功数据
 @param failure block 接口访问失败数据
 */
+(void)up_ph:(NSString *)ph np:(id)np im:(UIImage *)im progress:(UpProgress)pro success:(RequestSuccess)success failure:(RequestFailed)failure;
/**
 网络加载提示

 @param hintText 提示内容
 */
+(void)hintNetwork:(NSString *)hintText;
/**
 网络加载提醒  临时，后期去掉

 @param hintText 提示内容
 */
+(void)temporaryHintNetwork:(NSString *)hintText;
@end

