//
//Created by ESJsonFormatForMac on 18/05/24.
//

#import <Foundation/Foundation.h>

@class DZHomeList;
@interface DZHomeListModel : NSObject

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) NSInteger resultCode;

@property (nonatomic, strong) NSArray<DZHomeList *> *list;

@end
@interface DZHomeList : NSObject

@property (nonatomic, copy) NSString *number;

@property (nonatomic, assign) NSInteger longitude;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *birthDate;

@property (nonatomic, copy) NSString *headPicUrl;

@property (nonatomic, assign) NSInteger latitude;

@property (nonatomic, copy) NSString *profession;

@property (nonatomic, assign) NSInteger sex;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *constellation;

@property (nonatomic, strong) NSArray *pictureUrlList;

@property (nonatomic, assign) long long createTime;

@property (nonatomic, assign) NSInteger picCount;

@end

