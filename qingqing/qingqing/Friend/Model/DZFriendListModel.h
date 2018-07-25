//
//Created by ESJsonFormatForMac on 18/05/27.
//

#import <Foundation/Foundation.h>

@class DZGMModel;
@interface DZFriendListModel : NSObject

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) NSInteger resultCode;

@property (nonatomic, strong) NSArray<DZGMModel *> *matchList;//正常
@property (nonatomic, strong) NSArray<DZGMModel *> *matchNearExpireList;//1小时过期
@property (nonatomic, strong) NSArray<DZGMModel *> *matchExpireList;//过期
@property (nonatomic, strong) NSArray<DZGMModel *> *matchExtensionList;//延期
@property (nonatomic, strong) NSMutableArray<DZGMModel *> *likeMeList;//绿色 （中间显示数字）
@property (nonatomic, strong) NSArray<DZGMModel *> *friendList;//好友列表
@end

@interface DZGMModel : NSObject

@property (nonatomic, assign) NSInteger accountId;

@property (nonatomic, copy) NSString *headPicUrl;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger relationStatus;
/**
1、红色排在前面
2、绿色 （喜欢我的）
3、橙色 正常匹配
4、粉色 延期
5、灰色  过期
 */
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) long long buildTime;

@end

