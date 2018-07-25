//
//Created by ESJsonFormatForMac on 18/02/27.
//

#import <Foundation/Foundation.h>

@class AccountData;
@interface DZMemberModel : NSObject

@property (nonatomic, copy) NSString *loginSessionId;

@property (nonatomic, strong) AccountData *account;

@property (nonatomic, assign) NSInteger resultCode;

@property (nonatomic, copy) NSString *desc;

@end
@interface AccountData : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *birthDate;

@property (nonatomic, assign) NSInteger sex;

@property (nonatomic, copy) NSString *rongCloudToken;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *headPicUrl;

@property (nonatomic, copy) NSString *mobileNumber;
//friendSerial
//mobileNumber
//longitude
//blackAccountIdSerial
//latitude
//ilikeList
//browseSerial
//createTime
//likeMeList
//ilikeSerial
//likeMeSerial
//browseList

//@property (nonatomic, assign) NSInteger activityLevel;
//
//@property (nonatomic, copy) NSString *loginName;
//
//@property (nonatomic, assign) NSInteger areaType;
//
//@property (nonatomic, assign) long long lastChatTime;
//
//@property (nonatomic, copy) NSString *selfIntro;
//
//@property (nonatomic, assign) NSInteger friendTypeSetting;
//
//@property (nonatomic, assign) NSInteger currentFriendId;
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

