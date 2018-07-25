//
//Created by ESJsonFormatForMac on 18/06/11.
//

#import <Foundation/Foundation.h>

@class DZOtherAccounModel,DZFlagModel,DZQaListModel;
@interface DZInfoModel : NSObject

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) NSInteger resultCode;

@property (nonatomic, strong) NSArray<DZOtherAccounModel *> *otherAccountList;

@end
@interface DZOtherAccounModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy)NSString *birthDate;

@property (nonatomic, assign) NSInteger sex;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, assign) CGFloat longitude;

@property (nonatomic, assign) CGFloat latitude;

@property (nonatomic, strong) NSArray<DZFlagModel *> *flagList;

@property (nonatomic, strong) NSArray<DZQaListModel *> *qaList;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *number;

@property (nonatomic, copy) NSString *constellation;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, strong) NSMutableArray *pictureUrlList;

@property (nonatomic, copy) NSString *profession;

@property (nonatomic, copy) NSString *headPicUrl;

@property (nonatomic, copy) NSString *industry;

@property (nonatomic, copy) NSString *oftenIn;

@property (nonatomic, copy) NSString *signature;

@property (nonatomic, assign) NSInteger maxRecommendRadius;

@property (nonatomic, assign) NSInteger minRecommendAge;

@property (nonatomic, assign) NSInteger maxRecommendAge;

@property (nonatomic, assign) BOOL shieldPhone;

@property (nonatomic, copy) NSString *distance;

@property (nonatomic, copy) NSString *lastActiveTime;

@end
@interface DZFlagModel : NSObject
@property (nonatomic, copy) NSString *flagContent;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger accountId;
@property (nonatomic, assign) NSInteger flagType;
@end
@interface DZQaListModel : NSObject
@property (nonatomic, copy) NSString *question;
@property (nonatomic, copy) NSString *answer;
@property (nonatomic, assign) NSInteger questionCode;
@property (nonatomic, assign) NSInteger accountId;
@end
